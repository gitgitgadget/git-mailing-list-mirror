From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: Git for Windows 1.9.0
Date: Tue, 18 Feb 2014 10:10:25 +0100
Message-ID: <53032381.2090001@atlas-elektronik.com>
References: <alpine.DEB.1.00.1402180036150.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"msysgit@googlegroups.com" <msysgit@googlegroups.com>
X-From: msysgit+bncBDK4H2WVWYLBBTWGRSMAKGQEDKKVQFY@googlegroups.com Tue Feb 18 10:09:35 2014
Return-path: <msysgit+bncBDK4H2WVWYLBBTWGRSMAKGQEDKKVQFY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fa0-f58.google.com ([209.85.161.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDK4H2WVWYLBBTWGRSMAKGQEDKKVQFY@googlegroups.com>)
	id 1WFggI-0004hT-W6
	for gcvm-msysgit@m.gmane.org; Tue, 18 Feb 2014 10:09:35 +0100
Received: by mail-fa0-f58.google.com with SMTP id n1sf76220fan.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 18 Feb 2014 01:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=dSaPaFzofOllaQIYnlEJ0R4HSaS2Fw27G1OKSq5o2k4=;
        b=FNrAjOkhECnT4jXI+lPjnuQ/eIrfdS7aKN5nsGEBOQqIRJG9qLS/XNxnuIlmr6yEYm
         HBq2R5qGTRVqKxMRbcC0SrV0gQMC41GKuW4iUkeRB05r0F4f4kjoLslmj0FwCDcmzd65
         MFYMzuSaE+xCCWNiOXIDQx0y+FWM+IyH36/dAu2wxXUaERliBFfM2kcCM6CulSP16jPr
         uRBQ1A5FotFdOQ9pXbBBFHWbIkJL0vfyjRtK88OnYwiiuwKMZdhj9Tp6FyMaRyukMaMT
         CRUPocRUh+Q20jV3CpzpI2+vohTmF7MCjLuJe0jSSwj5xXSuvyzIN/QSHo06KXMTowkr
         1owA==
X-Received: by 10.153.4.8 with SMTP id ca8mr273313lad.1.1392714574596;
        Tue, 18 Feb 2014 01:09:34 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.37.226 with SMTP id b2ls266647lak.56.gmail; Tue, 18 Feb
 2014 01:09:33 -0800 (PST)
X-Received: by 10.112.126.138 with SMTP id my10mr15814863lbb.17.1392714573753;
        Tue, 18 Feb 2014 01:09:33 -0800 (PST)
Received: from mail96.atlas.de (mail96.atlas.de. [194.156.172.86])
        by gmr-mx.google.com with ESMTPS id n42si1420975eep.1.2014.02.18.01.09.33
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 01:09:33 -0800 (PST)
Received-SPF: neutral (google.com: 194.156.172.86 is neither permitted nor denied by best guess record for domain of stefan.naewe@atlas-elektronik.com) client-ip=194.156.172.86;
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 694021075B;
	Tue, 18 Feb 2014 10:09:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3cDnoxec0fUd; Tue, 18 Feb 2014 10:09:32 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Tue, 18 Feb 2014 10:09:32 +0100 (CET)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 05F7F27169;
	Tue, 18 Feb 2014 10:09:31 +0100 (CET)
Received: from [10.200.54.97] (10.200.54.97) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.279.5; Tue, 18 Feb
 2014 10:09:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <alpine.DEB.1.00.1402180036150.14982@s15462909.onlinehome-server.info>
X-Enigmail-Version: 1.6
X-Original-Sender: stefan.naewe@atlas-elektronik.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 194.156.172.86 is neither permitted nor denied by best guess
 record for domain of stefan.naewe@atlas-elektronik.com) smtp.mail=stefan.naewe@atlas-elektronik.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242286>

Am 18.02.2014 00:38, schrieb Johannes Schindelin:
> Dear Git fanbois,
> 
> this announcement informs you that the small team of volunteers who keep
> the Git ship afloat for the most prevalent desktop operating system
> managed to release yet another version of Git for Windows:
> 
> Git Release Notes (Git-1.9.0-preview20140217)
> Last update: 17 February 2013
> 
> Changes since Git-1.8.5.2-preview20131230
> 
> New Features
> - Comes with Git 1.9.0 plus Windows-specific patches.
> - Better work-arounds for Windows-specific path length limitations (pull
>   request #122)
> - Uses optimized TortoiseGitPLink when detected (msysGit pull request
>   #154)
> - Allow Windows users to use Linux Git on their files, using Vagrant
>   http://www.vagrantup.com/ (msysGit pull request #159)
> - InnoSetup 5.5.4 is now used to generate the installer (msysGit pull
>   request #167)
> 
> Bugfixes
> - Fixed regression with interactive password prompt for remotes using the
>   HTTPS protocol (issue #111)
> - We now work around Subversion servers printing non-ISO-8601-compliant
>   time stamps (pull request #126)
> - The installer no longer sets the HOME environment variable (msysGit pull
>   request #166)
> - Perl no longer creates empty sys$command files when no stdin is
>   connected (msysGit pull request #152)
> 
> Ciao,
> Johannes
> 

Thanks to all involved!


Stefan
-- 
----------------------------------------------------------------
/dev/random says: I didn't cheat, I just changed the Rules!
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"

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
For more options, visit https://groups.google.com/groups/opt_out.
