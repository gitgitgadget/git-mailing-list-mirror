From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: Git for Windows 1.6.2.2
Date: Wed, 08 Apr 2009 07:20:14 +0200
Message-ID: <49DC340E.9010101@gmail.com>
References: <alpine.DEB.1.00.0904080440170.10279@pacific.mpi-cbg.de>
Reply-To: mstormo@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Apr 08 07:21:56 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f199.google.com ([209.85.217.199])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrQEU-0005ob-8O
	for gcvm-msysgit@m.gmane.org; Wed, 08 Apr 2009 07:21:54 +0200
Received: by gxk23 with SMTP id 23so178312gxk.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 07 Apr 2009 22:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:message-id
         :date:from:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:reply-to:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=hSRMn1a7m9Ln9QQkqCnjobs+xZ+bwUTVGuQek8V57CM=;
        b=58Ue9e3o6ksm/n2K1UOynuLJrb+LPYR+imWaPhwTlLHOa07ITuIAd/uexIXspSCn6Q
         ikChHaRvYhkgPQ7qdyoijJiJ8xYd08/Fu1esDymQMHGu20vYcg3LNOYz8wYnNAXDXv31
         WujavBjQUgJPBmj9HA0k+lxiV4WQFKjZ/PSjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=dgLhj/VRNncDCpiGDWCs8cBkHcRKUle5IBDXEl6Wq+gaA5YUl8LytZOkWDFep8ifH1
         JFUt7WZ89lfF5Lrt1D7SiQu7GGwco55iwrBcpKkHfg16WTW2gza3kPcx8VER/5mHMMpt
         8YM3mEv26OqcGtoqmLgIK22PUrXxUR5UEJl5A=
Received: by 10.90.83.2 with SMTP id g2mr135481agb.16.1239168018456;
        Tue, 07 Apr 2009 22:20:18 -0700 (PDT)
Received: by 10.176.233.6 with SMTP id f6gr4696yqh.0;
	Tue, 07 Apr 2009 22:20:18 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.86.70.3 with SMTP id s3mr11928fga.20.1239168017512; Tue, 07 Apr 2009 22:20:17 -0700 (PDT)
Received: from mail-fx0-f172.google.com (mail-fx0-f172.google.com [209.85.220.172]) by gmr-mx.google.com with ESMTP id 3si284822fgg.14.2009.04.07.22.20.16; Tue, 07 Apr 2009 22:20:16 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.220.172 as permitted sender) client-ip=209.85.220.172;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.220.172 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by fxm20 with SMTP id 20so2532066fxm.12 for <msysgit@googlegroups.com>; Tue, 07 Apr 2009 22:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from :user-agent:mime-version:to:cc:subject:references:in-reply-to :content-type:content-transfer-encoding; bh=AMExYSTMa98+OoYAw57k+QLIlrHX4IaMdqJhCkdXsW8=; b=IhIEkAyeRBUSV1buekWPEJg3E8ONhM6KzGFmujtnm3QLgS9wGeI4ZJ1jgEZ0emdo7i z1p0TKcni0yrwJn92Q/VDygcPTjV3HEtHLU8ipYzLnq1Nc2O2FET1LH8gJ6ohCXA+RWo jYyg4Dq/ST1CYouXoBq3987RRfLZEv6rkTsi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:user-agent:mime-version:to:cc:subject :references:in-reply-to:content-type:content-transfer-encoding; b=T+Vrb0Uwh4JmfxHZgRFncSVIKiEgCJ8evNrU2dZyoj/3M3Out36U6HCxaXvh63awzB Bm2d4aRhPpEcklazgIoW7ugY4JxmX25BRg84Hqkj5ddtxn+2FqDwX/F0DR6oXGFER37N qwRW/3wml/fO8aktdO8S71Qwimnu/1QRmj/10=
Received: by 10.204.124.7 with SMTP id s7mr769452bkr.52.1239168016395; Tue, 07 Apr 2009 22:20:16 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104]) by mx.google.com with ESMTPS id 12sm2980728fks.5.2009.04.07.22.20.15 (version=TLSv1/SSLv3 cipher=RC4-MD5); Tue, 07 Apr 2009 22:20:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.21) Gecko/20090302 Lightning/0.9 Thunderbird/2.0.0.21 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <alpine.DEB.1.00.0904080440170.10279@pacific.mpi-cbg.de>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116036>


Johannes Schindelin said the following on 08.04.2009 04:46:
> Hi,
> 
> this email tries to inform you that the Windows installer was updated to 
> the newest version of Git.
> 
> Changes since Git-1.6.2.1-preview20090322
> 
> New Features
> 
> - Comes with official git 1.6.2.2.
> - Upgraded Tcl/Tk to 8.5.5.
> - TortoiseMerge is supported by mergetool now (Thanks Markus Heidelberg).
> - Uses pthreads (faster garbage collection on multi-core machines).
> - The test suite passes!
> 
> Bugfixes
> 
> - Renaming was made more robust (due to Explorer or some virus scanners, 
>   files could not be renamed at the first try, so we have to try multiple 
>   times).
> - Johannes Sixt made lots of changes to the test-suite to identify 
>   properly which tests should pass, and which ones cannot pass due to 
>   limitations of the platform.
> - Support PAGERs with spaces in their filename.
> - Quite a few changes were undone which we needed in the olden days of 
>   msysGit.
> - Fall back to / when HOME cannot be set to the real home directory due to 
>   locale issues (works around Issue 108 for the moment).

Excellent work guys! Thanks plenty!

Oh, and go to sleep! :-p

--
.marius
