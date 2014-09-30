From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4] MinGW(-W64) compilation
Date: Tue, 30 Sep 2014 17:10:03 +0700
Message-ID: <CACsJy8CTJUZxxxQqPJTNzt7YTZJZgfoNjhkb2Z--jJZjyMDYaQ@mail.gmail.com>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBC2ZN5PHQUMBBGMDVKQQKGQEX5SHFIA@googlegroups.com Tue Sep 30 12:10:35 2014
Return-path: <msysgit+bncBC2ZN5PHQUMBBGMDVKQQKGQEX5SHFIA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ig0-f190.google.com ([209.85.213.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBGMDVKQQKGQEX5SHFIA@googlegroups.com>)
	id 1XYuOA-0002XV-QF
	for gcvm-msysgit@m.gmane.org; Tue, 30 Sep 2014 12:10:34 +0200
Received: by mail-ig0-f190.google.com with SMTP id h3sf866507igd.7
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Sep 2014 03:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=IAR+8f19JYjr81RI4LWcGqsxA8doPiQkZ+j5XRDO5lQ=;
        b=T5ZMQ/1fCpwxK1LBkjmqxkRdy2Z38fSn6yXB15K1hDPN0kJ6Z3LPM4+6G9skiArmEz
         DNLBuNjUS+0s85ZKBCL1QCmlL2YOq25zOM7RxrEP7cgIasvDQBJpSOl7P/5/L714UOTS
         kD1YedjA0g/RhtD16OWUXHDnYNouQfmhAJnButbRolL0MZFkQ0BnuZ8s3H9mLu9omggG
         AmDlt11OYVupW9SOr7cRopvUhN4pgYIvCiHRo41IYJ88P8z22WGehqOzH/zFnDDaRJAk
         QyPfjXNqrJNZbI68ZsyLIEpcrTHHX9t9Pa2iLbBxbm+oQsPmrOvXWUTLTw2M/tWIu9xz
         q0/Q==
X-Received: by 10.50.119.73 with SMTP id ks9mr72867igb.12.1412071833931;
        Tue, 30 Sep 2014 03:10:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.66.179 with SMTP id g19ls2790626igt.28.canary; Tue, 30 Sep
 2014 03:10:33 -0700 (PDT)
X-Received: by 10.43.69.18 with SMTP id ya18mr42293820icb.0.1412071833436;
        Tue, 30 Sep 2014 03:10:33 -0700 (PDT)
Received: from mail-yh0-x22a.google.com (mail-yh0-x22a.google.com [2607:f8b0:4002:c01::22a])
        by gmr-mx.google.com with ESMTPS id e24si860871yhe.3.2014.09.30.03.10.33
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 03:10:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:4002:c01::22a as permitted sender) client-ip=2607:f8b0:4002:c01::22a;
Received: by mail-yh0-f42.google.com with SMTP id t59so1294998yho.1
        for <msysgit@googlegroups.com>; Tue, 30 Sep 2014 03:10:33 -0700 (PDT)
X-Received: by 10.236.10.66 with SMTP id 42mr64631868yhu.68.1412071833331;
 Tue, 30 Sep 2014 03:10:33 -0700 (PDT)
Received: by 10.170.62.136 with HTTP; Tue, 30 Sep 2014 03:10:03 -0700 (PDT)
In-Reply-To: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:4002:c01::22a
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257664>

On Tue, Sep 30, 2014 at 2:02 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> This patch series fixes building on modern MinGW and MinGW-W64 (including x86_64!).
>
> *Compilation* tested on:
>  - MSVC
>  - msysGit environment (twice)
>  - Linux cross-toolchain i686-pc-mingw32

Thanks. I always wanted to do this but never got around to clean up
and submit. There's a problem with include order in Makefile. I don't
want to specify CROSS_COMPILE or CC=mingw32-gcc from command line any
time I make a build, so I put all those in config.mak. But because
this file is included after config.mak.uname, all the default settings
for MINGW is ignored.

I'm not sure if we can move config.mak up before config.mak.uname. If
we can't I'm ok with including a new file (config.mak.pre or
something) before config.mak.uname. That would make "make" (no
arguments) work for me.
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
