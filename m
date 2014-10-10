From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: msysgit works on wine
Date: Fri, 10 Oct 2014 19:04:52 +0700
Message-ID: <CACsJy8DJ6SwHujLNx9fj2WazJk2E6HOhfpL60AY3QtMDx7200A@mail.gmail.com>
References: <CACsJy8BAv9Bv_jFgW3L3+WYQMUOwRCFQ0sdAxWWwC_TnzesBBQ@mail.gmail.com>
 <5437CAEC.1020902@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: msysgit+bncBC2ZN5PHQUMBBAUX36QQKGQEK54MVBI@googlegroups.com Fri Oct 10 14:05:25 2014
Return-path: <msysgit+bncBC2ZN5PHQUMBBAUX36QQKGQEK54MVBI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yk0-f186.google.com ([209.85.160.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBAUX36QQKGQEK54MVBI@googlegroups.com>)
	id 1XcYwl-0005Vf-L4
	for gcvm-msysgit@m.gmane.org; Fri, 10 Oct 2014 14:05:23 +0200
Received: by mail-yk0-f186.google.com with SMTP id 19sf730676ykq.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 10 Oct 2014 05:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=LuLNA7eTyg9stlJzfymdSGsIQpcM8Hx0JXMz4s6TBto=;
        b=hOpRr6Dgi/3cZ523etBHXfhUrN9qQ7/1K8pJ1ny5HMS7KHd5C6B2R+6CezRaAh39Eo
         vQI9muAZK9M6b0Igh3A2O22uDzD8cIZNveyoXYS+beoielcDw+bDS8CNNT7P2oMbJW4U
         dqM5hOUCsbEDdbe9hWVph3MJ1Sll3jAJv+c+48ynVibwlqF5wF9VnHasoXUDp9aImXyN
         HhAbJi8KpqgVBwXzLYLFlkKxfJU2slwA7jZv4BVR4lpYtpEVOXQLO9z9WkslcR+rLmxH
         rPMPONj0vLrT7u2Hm8otyiNyRgnIXoNCx3/ZC9U9KUdPqYWBxa0x8wco1AvKKCLOlWKB
         IX8w==
X-Received: by 10.140.20.246 with SMTP id 109mr71759qgj.0.1412942722739;
        Fri, 10 Oct 2014 05:05:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.18.193 with SMTP id 59ls760998qgf.7.gmail; Fri, 10 Oct
 2014 05:05:22 -0700 (PDT)
X-Received: by 10.236.25.99 with SMTP id y63mr2693177yhy.50.1412942722242;
        Fri, 10 Oct 2014 05:05:22 -0700 (PDT)
Received: from mail-ig0-x22f.google.com (mail-ig0-x22f.google.com [2607:f8b0:4001:c05::22f])
        by gmr-mx.google.com with ESMTPS id nt9si188123igb.1.2014.10.10.05.05.22
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 Oct 2014 05:05:22 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:4001:c05::22f as permitted sender) client-ip=2607:f8b0:4001:c05::22f;
Received: by mail-ig0-x22f.google.com with SMTP id uq10so2397675igb.2
        for <msysgit@googlegroups.com>; Fri, 10 Oct 2014 05:05:22 -0700 (PDT)
X-Received: by 10.42.20.84 with SMTP id f20mr15379166icb.48.1412942722136;
 Fri, 10 Oct 2014 05:05:22 -0700 (PDT)
Received: by 10.107.131.1 with HTTP; Fri, 10 Oct 2014 05:04:52 -0700 (PDT)
In-Reply-To: <5437CAEC.1020902@virtuell-zuhause.de>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:4001:c05::22f
 as permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

On Fri, Oct 10, 2014 at 7:02 PM, Thomas Braun
<thomas.braun@virtuell-zuhause.de> wrote:
> Are you compiling git.git or msysgit.git?

git.git

> And how about the test suite?

running right now, fingers crossed.. kinda slow, not sure if it's wine
or it's the msys thing.
-- 
Duy

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
