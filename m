From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH v5] MinGW(-W64) compilation
Date: Thu, 9 Oct 2014 14:39:21 +0400
Message-ID: <20141009103921.GA18641@seldon>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
 <alpine.DEB.1.00.1410091205560.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gister@pobox.com,
	msysGit <msysgit@googlegroups.com>, marat@slonopotamus.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCE7TAPITACRBX6L3GQQKGQEX5U5DPI@googlegroups.com Thu Oct 09 12:39:33 2014
Return-path: <msysgit+bncBCE7TAPITACRBX6L3GQQKGQEX5U5DPI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f187.google.com ([209.85.217.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBX6L3GQQKGQEX5U5DPI@googlegroups.com>)
	id 1XcB86-0005B9-3M
	for gcvm-msysgit@m.gmane.org; Thu, 09 Oct 2014 12:39:30 +0200
Received: by mail-lb0-f187.google.com with SMTP id w7sf88133lbi.4
        for <gcvm-msysgit@m.gmane.org>; Thu, 09 Oct 2014 03:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=VHb7Vr/fJli+KQGetq3o3xLjYLGLZUylH6dmGQEoKwc=;
        b=MAMbmmRBQV2hQoaWxqMGguFtlbsLu6cr2b5V0xW2C5AeMvQ3mxwuW8Ey2RjYKrBeqr
         dTq1yDt8C3vauWl4AkpxXhmZMq0ST0iwmaAkGJUJbGRcwljLBPndIDLbvb/MAI/g1xDW
         tytcaIWFKdFxAJAGZMThCV2GWjWkKk7FIo4NNanYQwNkU/SgfJ1O0Rdf+D7gb4elFF12
         d64V5ytmdLXf4/z3Xya6ls8BiztNalhv8n+cY95fZHbJf1eEBwjuAzCHTGloJjqTCpMQ
         wGE+C77mN6+Rx1O+2V43LgkqemtUm+Tl3BxUXf+biovMZDHhEC/RE9Vsbl1CdTMTQQOr
         dOlg==
X-Received: by 10.152.21.228 with SMTP id y4mr64393lae.11.1412851168863;
        Thu, 09 Oct 2014 03:39:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.6.134 with SMTP id b6ls149093laa.77.gmail; Thu, 09 Oct
 2014 03:39:27 -0700 (PDT)
X-Received: by 10.152.26.225 with SMTP id o1mr1348955lag.4.1412851166997;
        Thu, 09 Oct 2014 03:39:26 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id hv5si236828wib.1.2014.10.09.03.39.26
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 03:39:26 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XcB7x-0004rv-KL; Thu, 09 Oct 2014 14:39:22 +0400
In-Reply-To: <alpine.DEB.1.00.1410091205560.990@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
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
Content-Disposition: inline

On Thu, Oct 09, 2014 at 12:11:01PM +0200, Johannes Schindelin wrote:
> I also added one patch I find highly convenient:
> 
> https://github.com/dscho/git/commit/29749c7d7b4638c63369d6cf067f5d524d0092f9

There already were two attempts to this issue:

 1. http://www.spinics.net/lists/git/msg230028.html
 2. http://www.spinics.net/lists/git/msg229822.html

Neither of them was accepted to git.git. I doubt your one will be.

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
