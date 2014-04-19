From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Sat, 19 Apr 2014 19:37:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1404191935140.14982@s15462909.onlinehome-server.info>
References: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org, 
    msysGit Mailinglist <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCZPH74Q5YNRBXPIZKNAKGQEDDGSHZI@googlegroups.com Sat Apr 19 19:37:35 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBXPIZKNAKGQEDDGSHZI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f192.google.com ([74.125.82.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBXPIZKNAKGQEDDGSHZI@googlegroups.com>)
	id 1WbZCo-0000qM-7b
	for gcvm-msysgit@m.gmane.org; Sat, 19 Apr 2014 19:37:34 +0200
Received: by mail-we0-f192.google.com with SMTP id t60sf234970wes.9
        for <gcvm-msysgit@m.gmane.org>; Sat, 19 Apr 2014 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=GKJnm9cVC/RCUe4Nf3k1o1zLrHZyXukZKGOur9JMHA8=;
        b=GWEOStzDlGK51JfTykR8odDa11C+RbzJRxBELuXWEtaP0bKRmtkW6K/dLNFQeIMAAJ
         oj5stsa5rodXgO/s/gb4H76C9e6gvxt9JemMHuFYjHe1C5bO7QBqRQZTntcq6TkICMSH
         blz2PNAKnz0qfqYmfPRaxgcMuPdB1vxkCEz3lmDc8nndGK+RddP3j8T8NqBYMS0GLgJp
         GKUnUbJb7Oy29ILzioL7oNf2E2nICdRVdrurnRKJ07o5kEAJvgm0/2CFNU/fEJdt9dLM
         XGoKfETmONK203jvP85FaQwQDwsDcG6VPFhrn719JGNS4WyWe+rYhPRVbgBCQfzkkhNI
         1kkg==
X-Received: by 10.152.88.3 with SMTP id bc3mr146lab.13.1397929053935;
        Sat, 19 Apr 2014 10:37:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.37.129 with SMTP id y1ls368515laj.19.gmail; Sat, 19 Apr
 2014 10:37:33 -0700 (PDT)
X-Received: by 10.112.162.193 with SMTP id yc1mr5817lbb.19.1397929053130;
        Sat, 19 Apr 2014 10:37:33 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id u49si1889671eeo.1.2014.04.19.10.37.33
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA bits=256/256);
        Sat, 19 Apr 2014 10:37:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as permitted sender) client-ip=212.227.15.18;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0M7CRe-1WpECg34OE-00x6RP;
 Sat, 19 Apr 2014 19:37:08 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:wKBhv4nTrY21rt/dM2LR6EB7eyHGef18tPwPT/sA+y7fNxhPwbD
 pG0UMhnCoFFduH+DoAWpkK+VuhsEjV3aS3nwVAax1Of2Fx9BGKGjPy8SqiscnWhsJCzrTK5
 R6nOUXiV+9QWnV9ziLyK1AsluqC97EILlhFul1C0SgQE89oIUg/tLhYIal57hq3mMNHPIjp
 YQjyOiU59Hg5rkVPQAOTQ==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246520>

Hi Marat,

On Sat, 19 Apr 2014, Marat Radchenko wrote:

> But in practice, msysgit is:
>  1) outdated msys that was patched in multiple ways without
>   sending patches upstream
>  2) heavily patched git, again not upstreamed

Again, this time explicitly: I wish you had done a little more research on
the matter, and I wish you had participated in the msysGit community
before going on to reinvent the wheel.

I have nothing per se against your effort, of course, you can spend your
time as you want, but please refrain from claiming things that are
provably incorrect.

Ciao,
Johannes

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
