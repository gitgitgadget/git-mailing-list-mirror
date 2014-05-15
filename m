From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH] transport-helper: add trailing --
Date: Thu, 15 May 2014 01:05:05 -0500
Message-ID: <53745911291b2_27ec161d2fc0@nysa.notmuch>
References: <20140515053214.GA12133@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, 
 msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>, 
 GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBDBJVMGGZYNBBJFX2GNQKGQEG7BB3AA@googlegroups.com Thu May 15 08:16:12 2014
Return-path: <msysgit+bncBDBJVMGGZYNBBJFX2GNQKGQEG7BB3AA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f64.google.com ([209.85.213.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDBJVMGGZYNBBJFX2GNQKGQEG7BB3AA@googlegroups.com>)
	id 1Wkoxa-0006fr-71
	for gcvm-msysgit@m.gmane.org; Thu, 15 May 2014 08:16:06 +0200
Received: by mail-yh0-f64.google.com with SMTP id b6sf732017yha.29
        for <gcvm-msysgit@m.gmane.org>; Wed, 14 May 2014 23:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=cc9wRxlBafCJgsnJToTUI3xGI7fXYFlvqJ5I/P5uGKE=;
        b=jMWgp8UpYpCnpxXyiUFXD48vtcu2ykB3qqVU7zYpiPCSnB04j+K1hYwK/a12vjOlIr
         dlCi60lPliTx8c3EtbtoOHxkkR4BRz9etKCbVNuLV5V0hM05T8/+u+iQzLCTg3vDpDGD
         +1l7bxzthPp67kev14JR8PiAeyGckgMXxiQ+tATY3p4NdOCzD7n4hNSJB1yTyH+fvymw
         GeCgzMN2KjJ/mtYBwrxFbYhw2jW9PprwiSTicsCiITZlFyQy9mt1JpccatM9FVwN3Amo
         BCXs62diEvRqps1islRtIEcLcFV3y/uU7XBvjlQojg6xkOF0fjC8uZSarayl7kYzQneY
         b8sQ==
X-Received: by 10.50.50.147 with SMTP id c19mr965320igo.14.1400134565216;
        Wed, 14 May 2014 23:16:05 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.79.162 with SMTP id k2ls141733igx.4.canary; Wed, 14 May
 2014 23:16:04 -0700 (PDT)
X-Received: by 10.66.157.35 with SMTP id wj3mr1655428pab.11.1400134564608;
        Wed, 14 May 2014 23:16:04 -0700 (PDT)
Received: from mail-ob0-x22f.google.com (mail-ob0-x22f.google.com [2607:f8b0:4003:c01::22f])
        by gmr-mx.google.com with ESMTPS id iq7si1449230igb.0.2014.05.14.23.16.04
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 14 May 2014 23:16:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 2607:f8b0:4003:c01::22f as permitted sender) client-ip=2607:f8b0:4003:c01::22f;
Received: by mail-ob0-f175.google.com with SMTP id wo20so692337obc.34
        for <msysgit@googlegroups.com>; Wed, 14 May 2014 23:16:04 -0700 (PDT)
X-Received: by 10.182.231.138 with SMTP id tg10mr8105056obc.44.1400134564270;
        Wed, 14 May 2014 23:16:04 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id b9sm14048735oel.4.2014.05.14.23.16.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 May 2014 23:16:03 -0700 (PDT)
In-Reply-To: <20140515053214.GA12133@camelia.ucw.cz>
X-Original-Sender: felipe.contreras@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of felipe.contreras@gmail.com designates
 2607:f8b0:4003:c01::22f as permitted sender) smtp.mail=felipe.contreras@gmail.com;
       dkim=pass header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249062>

Stepan Kasal wrote:
> From: Sverre Rabbelier <srabbelier@gmail.com>
> Date: Sat, 28 Aug 2010 20:49:01 -0500
> 
> [PT: ensure we add an additional element to the argv array]
> 
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
> 
> Hi,
>   this patch was present in msysgit from Mar 2012.
> Do you like it?

Adding an extra '--' would make sense if we do something like
'git fast-export $stuff master' and there was a file named master.
However, we do 'git fast-export $stuff refs/heads/master', which case
the '--' is a no-nop *always*.

It doesn't hurt to add it though. I think.

-- 
Felipe Contreras

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
