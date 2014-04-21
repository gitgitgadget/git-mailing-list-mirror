From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Re: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Mon, 21 Apr 2014 20:37:45 +0200
Message-ID: <53556579.3050709@gmail.com>
References: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com> <20140419184210.GB3617@book-mint> <alpine.DEB.1.00.1404210003540.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org, 
 msysGit Mailinglist <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Heiko Voigt <hvoigt@hvoigt.net>
X-From: msysgit+bncBDZMLEGXWQLBBAOL2WNAKGQEGQO2JTA@googlegroups.com Mon Apr 21 20:37:57 2014
Return-path: <msysgit+bncBDZMLEGXWQLBBAOL2WNAKGQEGQO2JTA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f62.google.com ([209.85.215.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBBAOL2WNAKGQEGQO2JTA@googlegroups.com>)
	id 1WcJ6I-0003JH-0z
	for gcvm-msysgit@m.gmane.org; Mon, 21 Apr 2014 20:37:54 +0200
Received: by mail-la0-f62.google.com with SMTP id el20sf6578lab.17
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Apr 2014 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=qu81uzbjMVUOx9YqUnfCMCNfl4jwOApEGa9WcpsFe/Q=;
        b=uHD1vO7d9l5C/Z55ZmV7NP+RRttgvNb6FQPPb466vn0QAZFKwxVxjSfIoEzo2myKk8
         ao0nY5FxJNeQMUTjP6zw3S5yUTKy+pa6DnhnlYem1S9AQWwuWmtAIE9D2P/gzbVdv93w
         6kpSiixqZ0/apo+UbMnOhswPuPPH6XYtheUqP0BsBEbFV5Oho/oXzoOoAhh5IZjkfFC8
         2QaBr/T0zFFQYFEuPKOPrNUFPG+j3Ej5DUASWIZ0VjSVJhSX21D8jdzv5u0A1ue0hkQt
         2Y+ESr5lqZ7qYoH63cUpX+ZNDoaF3lMwM3Ptv3jydR+i6PX27g+IKALEIhvR0v3lCsCW
         BreA==
X-Received: by 10.152.29.1 with SMTP id f1mr28546lah.24.1398105473822;
        Mon, 21 Apr 2014 11:37:53 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.42.172 with SMTP id p12ls455491lal.1.gmail; Mon, 21 Apr
 2014 11:37:53 -0700 (PDT)
X-Received: by 10.112.209.102 with SMTP id ml6mr2658502lbc.1.1398105473123;
        Mon, 21 Apr 2014 11:37:53 -0700 (PDT)
Received: from mail-ee0-x233.google.com (mail-ee0-x233.google.com [2a00:1450:4013:c00::233])
        by gmr-mx.google.com with ESMTPS id u49si2356288eeo.1.2014.04.21.11.37.53
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Apr 2014 11:37:53 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4013:c00::233 as permitted sender) client-ip=2a00:1450:4013:c00::233;
Received: by mail-ee0-f51.google.com with SMTP id c13so3839327eek.38
        for <msysgit@googlegroups.com>; Mon, 21 Apr 2014 11:37:53 -0700 (PDT)
X-Received: by 10.15.36.136 with SMTP id i8mr2702391eev.113.1398105473010;
        Mon, 21 Apr 2014 11:37:53 -0700 (PDT)
Received: from [192.168.188.20] (p57A25734.dip0.t-ipconnect.de. [87.162.87.52])
        by mx.google.com with ESMTPSA id h47sm105782175eey.13.2014.04.21.11.37.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Apr 2014 11:37:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git,gmane.comp.version-control.msysgit
In-Reply-To: <alpine.DEB.1.00.1404210003540.14982@s15462909.onlinehome-server.info>
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4013:c00::233
 as permitted sender) smtp.mail=sschuberth@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246617>

On 21.04.2014 00:10, Johannes Schindelin wrote:

> tests do not pass yet. (I also would like to look into getting the
> performance improvement Hannes Sixt achieved by his patch [*1*] into
> mingwGitDevEnv's Git installation, too.)
>
> Whoops. Footnote *1*: https://github.com/msysgit/msysgit/commit/a0f5d4f

Dscho, this patch of Hannes is already in, see [1]. Also see the other 
files in that directory for the other MSYS patches being applied. In 
fact, mingwGitDevEnv has all MSYS patches that msysgit has except [2], 
[3] and [4] (because they mess up Bash for me and break many tests).

[1] 
https://github.com/sschuberth/mingwGitDevEnv-packages/blob/master/msys-core/0008-Do-not-start-the-fstab-observer-thread.patch
[2] 
https://github.com/msysgit/msysgit/blob/msys/src/rt/patches/0014-msys.dll-support-Unicode-console-input.patch
[3] 
https://github.com/msysgit/msysgit/blob/msys/src/rt/patches/0015-msys.dll-support-ALT-NUMPAD-console-input.patch
[4] 
https://github.com/msysgit/msysgit/blob/msys/src/rt/patches/0016-msys.dll-backport-multibyte-support-functions-from-n.patch

-- 
Sebastian Schuberth

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
