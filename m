From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH v4] MinGW(-W64) compilation
Date: Wed, 08 Oct 2014 01:09:20 +0200
Message-ID: <543472A0.3020401@virtuell-zuhause.de>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
X-From: msysgit+bncBCL7JHHTPAIKRZORUECRUBELYQVQ2@googlegroups.com Wed Oct 08 01:09:31 2014
Return-path: <msysgit+bncBCL7JHHTPAIKRZORUECRUBELYQVQ2@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f190.google.com ([209.85.212.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAIKRZORUECRUBELYQVQ2@googlegroups.com>)
	id 1Xbdsn-0005k2-EW
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 01:09:29 +0200
Received: by mail-wi0-f190.google.com with SMTP id ho1sf545296wib.27
        for <gcvm-msysgit@m.gmane.org>; Tue, 07 Oct 2014 16:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=dd1qad+Cw41IrCMfEB9ZFD2MRn18an0dgnJ3xJQ4+1A=;
        b=Fw+MCsGMGn/IhNjw1OOKCPv8QdLFL9+H0mjcUbuPtDOK6DOCRTzMuC0UDFlq4/cacW
         rI+4zhmEmmENpzU9VTUEzkUns1L/sV5eMMEBuJ8bsNSVs2x7K0gwoHRrm/8UTO26s19i
         0jSeZMj9SyGWN6OW7/096cGh2HJj8lFAvJ9Xy/H3wtUtSfYaPGmBUt9LmTGXqN+kSJjG
         cW1MM/yPj/tSxj5IXvnb8g9TiG/+9IetmKcL73Lcc3xGEcuzsSEKjyXf2fITJEXbGkgW
         wVNVp0krIARjxMd9iPxMdlqenGyJ+8muiXD0ixCOTPrqFxZHIGX7zbRTLnA6zOKGvlTz
         33Dg==
X-Received: by 10.180.98.167 with SMTP id ej7mr41245wib.15.1412723369166;
        Tue, 07 Oct 2014 16:09:29 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.87.1 with SMTP id t1ls820213wiz.13.canary; Tue, 07 Oct
 2014 16:09:28 -0700 (PDT)
X-Received: by 10.180.82.74 with SMTP id g10mr4623906wiy.0.1412723368172;
        Tue, 07 Oct 2014 16:09:28 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [2a01:488:42::50ed:84a3])
        by gmr-mx.google.com with ESMTPS id us10si2161864lbc.1.2014.10.07.16.09.27
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 07 Oct 2014 16:09:28 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=2a01:488:42::50ed:84a3;
Received: from p5ddc1944.dip0.t-ipconnect.de ([93.220.25.68] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1Xbdsj-00044b-OO; Wed, 08 Oct 2014 01:09:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1412723368;ad24809d;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted
 sender hosts) smtp.mail=thomas.braun@virtuell-zuhause.de
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

Am 30.09.2014 um 09:02 schrieb Marat Radchenko:
> This patch series fixes building on modern MinGW and MinGW-W64 (including x86_64!).
> 
> *Compilation* tested on:
>  - MSVC
>  - msysGit environment (twice)

Hi Marat,

I wanted to verify that on msysgit but some patches fail to apply
cleanly. Did you also had to tweak the patches?
If yes, are these tweaked patches still available somewhere?

Thomas

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
