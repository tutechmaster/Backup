//
//  ViewController.swift
//  Led
//
//  Created by Nhật Minh on 11/18/16.
//  Copyright © 2016 Nhật Minh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var hienthi_len: UIButton!
    @IBOutlet weak var hienthi_trai: UIButton!
    @IBOutlet weak var hienthi_xuong: UIButton!
    @IBOutlet weak var hienthi_phai: UIButton!
    @IBOutlet weak var hienthi_restart: UIButton!
    
    @IBOutlet weak var hienthi_draw: UIButton!
    @IBOutlet weak var hienthi_run: UIButton!
    @IBOutlet weak var tf_ball: UITextField!
    var balls = [Int]()
    
    var random = Int(arc4random_uniform((98)))
    
    var timer = Timer()
    
    var lastOnLed = -1
    
    var margin: CGFloat = 50
    
    var mep: CGFloat = 80
    
    var right : Bool = true
    var n = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hienthi_run.isEnabled = false
        hienthi_restart.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func restart_btn(_ sender: UIButton) {
        makeredball()
        timer.invalidate()
        hienthi_len.isEnabled = true
        hienthi_xuong.isEnabled = true
        hienthi_trai.isEnabled = true
        hienthi_phai.isEnabled = true
        hienthi_restart.isEnabled = false
        
    }
    
    
    
    
    
    @IBAction func draw_btn(_ sender: UIButton) {
        n = Int(tf_ball.text!)!
        for view in self.view.subviews
        {
            if view is UIImageView {
                view.removeFromSuperview()
            }
            
        }
        drawRowOfBall()
        makeredball()
        hienthi_draw.isEnabled = false
    }
    @IBAction func run_btn(_ sender: UIButton) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changedirection), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func action_len(_ sender: UIButton) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.375, target: self, selector: #selector(moveup), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func action_trai(_ sender: UIButton) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.375, target: self, selector: #selector(moveleft), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func action_xuong(_ sender: UIButton) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.375, target: self, selector: #selector(movedown), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func action_phai(_ sender: UIButton) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.375, target: self, selector: #selector(moveright), userInfo: nil, repeats: true)
    }
    
    
    
    func moveleft()
    {
        turnOffLed()
        
        if (lastOnLed + 1 ) % n == 1
        {
            timer.invalidate()
            khoaphim()
            lastOnLed = 0
            turnOnLed()
        }
        else
        {
            lastOnLed = lastOnLed - 1
            turnOnLed()
        }
        
    }
    
    func moveright()
    {
        turnOffLed()
        let n = Int(tf_ball.text!)!
        if (lastOnLed - (n - 2)) % n == 1
        {
            timer.invalidate()
            khoaphim()
            lastOnLed = 0
            turnOnLed()
        }
        else
        {
            lastOnLed = lastOnLed + 1
            turnOnLed()
        }
        
    }
    
    func moveup()
    {
        turnOffLed()
        let n = Int(tf_ball.text!)!
        
        if lastOnLed + 10 <= n
        {
            timer.invalidate()
            khoaphim()
            lastOnLed = 0
            turnOnLed()
        }
        else
        {
            lastOnLed = lastOnLed - 10
            turnOnLed()
        }
    }
    
    func movedown()
    {
        turnOffLed()
        let n = Int(tf_ball.text!)!
        
        if lastOnLed <= 10*n - 1
        {
            lastOnLed = lastOnLed + 10
            turnOnLed()
        }
        else
        {
            timer.invalidate()
            khoaphim()
            lastOnLed = 0
            turnOnLed()
        }
    }
    
    func makeredball()
    {
        
        if let ball = self.view.viewWithTag(100 + random)
            as? UIImageView
        {
            ball.image = UIImage(named: "red")
        }
    }
    
    func khoaphim()
    {
        hienthi_len.isEnabled = false
        hienthi_xuong.isEnabled = false
        hienthi_trai.isEnabled = false
        hienthi_phai.isEnabled = false
        hienthi_run.isEnabled = false
        hienthi_restart.isEnabled = true
    }
    
    
    func changedirection()
    {
        if right
        {
            runningLed()
        }
        else
        {
            Ledrunning()
        }
    }
    func Ledrunning()
    {
        let n = Int(tf_ball.text!)!
        if lastOnLed != -1
        {
            turnOffLed()
        }
        if lastOnLed != n - 1
        {
            lastOnLed = lastOnLed - 1
        }
        if lastOnLed == 0
        {
            right = true
        }
        turnOnLed()
    }
    
    func runningLed()
    {
        let n = Int(tf_ball.text!)!
        if lastOnLed != -1
        {
            turnOffLed()
        }
        if lastOnLed != n - 1
        {
            lastOnLed = lastOnLed + 1
        }
        else
        {
            lastOnLed = lastOnLed - 1
            right = false
        }
        turnOnLed()
    }
    
    func turnOnLed()
    {
        if let ball = self.view.viewWithTag(100 + lastOnLed)
        as? UIImageView
        {
            ball.image = UIImage(named: "green")
        
        }
    }
    func turnOffLed()
    {
        if let ball = self.view.viewWithTag(100 + lastOnLed)
            as? UIImageView
        {
            ball.image = UIImage(named: "grey")
        }
    }

    func drawRowOfBall()
    {
        let n = Int(tf_ball.text!)!
        if n == 1
        {
            let image = UIImage(named: "green")
            let ball = UIImageView(image: image)
            ball.center = CGPoint(x: 50, y: 80)
            self.view.addSubview(ball)
        }
        else
        {
        for indexHang in 0..<n
    {
        for indexCot in 0..<n
        {
            let image = UIImage(named: "grey")
            let ball = UIImageView(image: image)
            ball.center = CGPoint(x: margin + CGFloat(indexHang) * widthAction(), y: mep + CGFloat(indexCot) * heightAction())
            ball.tag = indexCot * 10 + indexHang + 100
            self.view.addSubview(ball)
        }
    }
        }
    }
    
    
    
    func widthAction() -> CGFloat
    {
        let n = Int(tf_ball.text!)!
        let width = ((self.view.bounds.size.width - 2*margin)/CGFloat(n - 1))
        return width
    }
    
    func heightAction() -> CGFloat
    {
        let n = Int(tf_ball.text!)!
        let height = ((self.view.bounds.size.height - 2*mep)/CGFloat(n-1))
        return height
    }
}

