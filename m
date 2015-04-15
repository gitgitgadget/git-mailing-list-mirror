From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] compat/mingw: stubs for getpgid() and tcgetpgrp()
Date: Wed, 15 Apr 2015 21:43:09 +0200
Message-ID: <CABPQNSZ-7FAgun8mxqXYWgy+Xc9xQMXKZonwujXb5WzLCKmNMw@mail.gmail.com>
References: <20150413134850.GC23475@mewburn.net> <alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr>
 <20150413144039.GD23475@mewburn.net> <alpine.LFD.2.11.1504131052090.5619@knanqh.ubzr>
 <20150414110312.GE23475@mewburn.net> <552EAE0A.3040208@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Luke Mewburn <luke@mewburn.net>, Nicolas Pitre <nico@fluxnic.net>, 
	GIT Mailing-list <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBDR53PPJ7YHRB5X6XKUQKGQEBHJUCBQ@googlegroups.com Wed Apr 15 21:43:52 2015
Return-path: <msysgit+bncBDR53PPJ7YHRB5X6XKUQKGQEBHJUCBQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qk0-f187.google.com ([209.85.220.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB5X6XKUQKGQEBHJUCBQ@googlegroups.com>)
	id 1YiTDz-0002kY-NA
	for gcvm-msysgit@m.gmane.org; Wed, 15 Apr 2015 21:43:51 +0200
Received: by qkbw1 with SMTP id w1sf82943871qkb.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 15 Apr 2015 12:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=zVwPlXAhJUVmE8JYNWDiwOuwYQewl8fn2C7InXt4Rl8=;
        b=XpQb2PkfCk3UmtZBj+0XTRiGGlV0w9pWAwAsE5Sw4RYzHHndtrX9Lhcib4iv/Z96zI
         kTa3FRnQ04Ua0O7v2/QSTi+TzKYj8T2XlmRKn3t8GvvNW+skMMzbZeiRaBKnM7CdqM29
         UN4oz9XDKoC0yFNWTauDZx6TUTk4/6nGYZ4d2/9Hg4d3M878qTNEcPvi3QT6nbKs6Fx8
         0pYFv2MEGDgC6PeRxsb+yXg49ADUis5yH0Fd9QiVkibSev5nDSUY5E/4gkVD+FPWtZVB
         Okv+rHSru5qFExvNOm8af/CHipSltE3MWGRQSxdh6Ys+xksHXGGp5gdpC/kHCXxqVrHL
         0TNg==
X-Received: by 10.182.63.40 with SMTP id d8mr195026obs.39.1429127030568;
        Wed, 15 Apr 2015 12:43:50 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.55.99 with SMTP id r3ls298202obp.73.gmail; Wed, 15 Apr
 2015 12:43:50 -0700 (PDT)
X-Received: by 10.182.99.229 with SMTP id et5mr35179548obb.35.1429127030051;
        Wed, 15 Apr 2015 12:43:50 -0700 (PDT)
Received: from mail-ig0-x22c.google.com (mail-ig0-x22c.google.com. [2607:f8b0:4001:c05::22c])
        by gmr-mx.google.com with ESMTPS id k3si559816igf.1.2015.04.15.12.43.50
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2015 12:43:50 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22c as permitted sender) client-ip=2607:f8b0:4001:c05::22c;
Received: by mail-ig0-x22c.google.com with SMTP id yr2so59501202igb.0
        for <msysgit@googlegroups.com>; Wed, 15 Apr 2015 12:43:50 -0700 (PDT)
X-Received: by 10.107.5.210 with SMTP id 201mr27901853iof.57.1429127029959;
 Wed, 15 Apr 2015 12:43:49 -0700 (PDT)
Received: by 10.64.88.165 with HTTP; Wed, 15 Apr 2015 12:43:09 -0700 (PDT)
In-Reply-To: <552EAE0A.3040208@kdbg.org>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22c
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267233>

On Wed, Apr 15, 2015 at 8:29 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Windows does not have process groups. It is, therefore, the simplest
> to pretend that each process is in its own process group.

Windows does have some concept of process groups, but probably not
quite what you want:

https://msdn.microsoft.com/en-us/library/windows/desktop/ms682083%28v=vs.85%29.aspx

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
