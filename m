From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: BUG I can't start git on Windows 7
Date: Mon, 8 Sep 2014 19:34:02 +0400
Message-ID: <20140908193402.c755f942853c278c10b75c7d@domain007.com>
References: <CA+4EQ5eXQTVPz-20Y-k-sJMyVcvAeUXBm44LGYFuqmaEwgB3Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: Petr Bena <benapetr@gmail.com>
X-From: msysgit+bncBCWKX34CSUCBB4EYW6QAKGQED7EP7QY@googlegroups.com Mon Sep 08 17:34:10 2014
Return-path: <msysgit+bncBCWKX34CSUCBB4EYW6QAKGQED7EP7QY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f60.google.com ([74.125.83.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCWKX34CSUCBB4EYW6QAKGQED7EP7QY@googlegroups.com>)
	id 1XR0xF-0006Ci-Tx
	for gcvm-msysgit@m.gmane.org; Mon, 08 Sep 2014 17:34:09 +0200
Received: by mail-ee0-f60.google.com with SMTP id b15sf1037985eek.15
        for <gcvm-msysgit@m.gmane.org>; Mon, 08 Sep 2014 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=djLbVALe8QQ/nP+JkZLEbsbkuQJ4zBGcVEIVcy2Z0sY=;
        b=OITMBIsN9gL+97tp+15keQ4HMUhlHASaIYuVzzFEbJX21iDkGexrQPt1sJiYc56r7q
         wTo2Bq/30U5ZMZfYzxqZrOpVC+0HoN92o3yZ+XLmpVJn9xXCvnDdY+Dv4gNzMNxSqJ6R
         teW6QH4OQ8bSgHGTFobfLwBo0ioOf4Td6CBM+ZnivoTSbImHI4BCIOGaG5EdjrOMuKTT
         kToEGaTDMCUCTHkN/uUeuICS/4NXMvHsI2g/RrfDefO/7ZMYLq/q4vcuItQFs/LpIJp1
         hb/n8WBKs/VTvU6d0Bl3f9mF6EPvdFXrLuSddmkjwGDo+N8KqSv5oDOLc2T4gLy22Ss8
         1yAA==
X-Received: by 10.152.5.37 with SMTP id p5mr8093lap.31.1410190449297;
        Mon, 08 Sep 2014 08:34:09 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.7.169 with SMTP id k9ls282662laa.91.gmail; Mon, 08 Sep
 2014 08:34:07 -0700 (PDT)
X-Received: by 10.152.26.225 with SMTP id o1mr465133lag.4.1410190447314;
        Mon, 08 Sep 2014 08:34:07 -0700 (PDT)
Received: from mailhub.007spb.ru (mailhub.007spb.ru. [84.204.203.130])
        by gmr-mx.google.com with ESMTPS id b6si1245354lbd.1.2014.09.08.08.34.06
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 08 Sep 2014 08:34:06 -0700 (PDT)
Received-SPF: none (google.com: flatworm@users.sourceforge.net does not designate permitted sender hosts) client-ip=84.204.203.130;
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id s88FY33x028915;
	Mon, 8 Sep 2014 19:34:04 +0400
In-Reply-To: <CA+4EQ5eXQTVPz-20Y-k-sJMyVcvAeUXBm44LGYFuqmaEwgB3Rg@mail.gmail.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-Original-Sender: flatworm@users.sourceforge.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: flatworm@users.sourceforge.net does not designate permitted
 sender hosts) smtp.mail=flatworm@users.sourceforge.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256652>

On Mon, 8 Sep 2014 11:15:44 +0200
Petr Bena <benapetr@gmail.com> wrote:

> I installed git on my system using official package from git-scm.com
> but I can't launch it, I am always getting this error:
> 
> C:\Users\petr.bena>"C:\Program Files (x86)\Git\bin\sh.exe" --login -i
>       0 [main] us 0 init_cheap: VirtualAlloc pointer is null, Win32
> error 487 AllocationBase 0x0, BaseAddress 0x68570000, RegionSize
> 0x40000, State 0x10000 C:\Program Files (x86)\Git\bin\sh.exe: ***
> Couldn't reserve space for cygwin's heap, Win32 error 0
> 
> 
> At some point this could be an issue with cygwin, but I am not sure.
> Did anyone had similar issue?

Does [1] help?

I wonder, why the error message mentions Cygwin though.
One reason might be is that MinGW is originally a fork of some very
early Cygwin release so may be some error message is lingering there,
unmodified.

1. http://stackoverflow.com/a/24406417/720999

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
