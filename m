From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH v4] MinGW(-W64) compilation
Date: Wed, 8 Oct 2014 11:35:11 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410081129401.990@s15462909.onlinehome-server.info>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org> <543472A0.3020401@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org, 
    msysGit <msysgit@googlegroups.com>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: msysgit+bncBCZPH74Q5YNRBUMK2SQQKGQEAZRYMPA@googlegroups.com Wed Oct 08 11:35:17 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBUMK2SQQKGQEAZRYMPA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f55.google.com ([209.85.215.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBUMK2SQQKGQEAZRYMPA@googlegroups.com>)
	id 1XbneN-0008S2-Ll
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 11:35:15 +0200
Received: by mail-la0-f55.google.com with SMTP id hz20sf764980lab.10
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 02:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=i1CZFJYWz6rO+wuYO63kCccwE1uTc+asgwhh1vuwc5E=;
        b=pmppol7W/T0DVBIQdzG1DAX0ywztLLAmMKX/XgydI/hQHxf9ytsFd3hY79SAyqRaId
         r3s0yiPbk3LdnLHRAVeX+mzngto5cMrFwVL8a+yMOfI7PxD+Tws3CbrtqFbbZMvUg67O
         LUt2kcRMDudMuuhEZAJ/4Ztj2e0A9EQ7CaGgNv0opjLSegTY/9ATFpA+kI50RSTVS/FK
         a3yGSLlZzuJgXOi5b1QJUBM95s0atEDuZlCQGGryqySl7zjAXKYk+90qAHE+iy5Kmo/d
         63sYpte7rTdIHGffZ6xJ2nKaJMK3aQe0dHvGMrbqmhc/bcop+vKtg4t62K8/aStmAazY
         Wuzg==
X-Received: by 10.152.42.194 with SMTP id q2mr7559lal.10.1412760915408;
        Wed, 08 Oct 2014 02:35:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.10.72 with SMTP id g8ls40657lab.23.gmail; Wed, 08 Oct 2014
 02:35:13 -0700 (PDT)
X-Received: by 10.112.198.226 with SMTP id jf2mr1415070lbc.1.1412760913484;
        Wed, 08 Oct 2014 02:35:13 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.19])
        by gmr-mx.google.com with ESMTPS id us10si2327057lbc.1.2014.10.08.02.35.13
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 02:35:13 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.19 as permitted sender) client-ip=212.227.15.19;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0Md3Eg-1Xu1Ft3bus-00IARE;
 Wed, 08 Oct 2014 11:35:11 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <543472A0.3020401@virtuell-zuhause.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:zEi+7bM+G4dwP/2/TCYG9gQnwUcsSCZGvWjm5WDM+c+xMr/qx87
 lACtNj887iBhaKRCSjIX06tZj0ltpSbYIooiSDcSxv8mP2Nz31CQ/mcS59B6k8Jj++vhXhC
 8i42HT821m4qTD6YPxf39wwky9gmdneczlTT0hFs1hzarabFCegoRehMW4q+RpGzLc87puM
 q2Dqom/NJAoi6o2ykG/iA==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.19 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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

Hi Thomas,

On Wed, 8 Oct 2014, Thomas Braun wrote:

> I wanted to verify that on msysgit but some patches fail to apply
> cleanly. Did you also had to tweak the patches?

I applied the patches to git-for-windows/git's master, manually fixing
three of them, and pushed the result to the 'w64' branch in my fork.
Please find them here:

	https://github.com/dscho/git/compare/git-for-windows:master...w64

and rebased onto msysgit's master:

	https://github.com/dscho/git/compare/msysgit:master...w64-msysgit

Ciao,
Dscho

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
