From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Should we discuss Windows-related changes on
 git@vger.kernel.org?
Date: Fri, 11 Jul 2008 17:51:15 +0200
Message-ID: <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de> <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, Junio C Hamano <gitster@pobox.com>, msysGit <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Jul 11 17:52:00 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHKue-0004TR-1T
	for gcvm-msysgit@m.gmane.org; Fri, 11 Jul 2008 17:52:00 +0200
Received: by yx-out-2122.google.com with SMTP id 22so1611849yxm.63
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2008 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:in-reply-to:subject:references:message-id
         :content-type:content-transfer-encoding:mime-version:date:cc
         :x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=3L9SziBh/QY1cFT/LepiQiKvGogCgYMyoaJe4l8ljWo=;
        b=Cv4rWXFE0NwUZbWw0/R4g4U/DAjHEK/cJVLwH6njpBDWKfPJc4voupNiR9VScVs9wo
         Btddp4ioXDC3P8DIOuwoW/gmv4pIpDOKYM8iCOaYc0gJBa4L4kaM8SiqVdk60JmMo+oL
         qo0EI05diL5MwKsafA70+dVbQI5bo5cjDIc6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        b=YdPvKo20JGGjMilL+EOh/jILJh6UbdDKQD6h+sccUMdcM2AzV7D3w1X/P/buACTn0j
         PS94ta/CVXmZPGi2DfLP7t53TetSRDJHMZOMww4kVbyh/NBjQY0x7gSYRAfYRv0MM8ia
         LiM/vTRnPxunp5tjB+bsUh4+00z/BcOcfN3d4=
Received: by 10.142.210.4 with SMTP id i4mr296296wfg.14.1215791457276;
        Fri, 11 Jul 2008 08:50:57 -0700 (PDT)
Received: by 10.106.63.1 with SMTP id l1gr2673pra.0;
	Fri, 11 Jul 2008 08:50:57 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.142.101.17 with SMTP id y17mr113491wfb.14.1215791456041; Fri, 11 Jul 2008 08:50:56 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 22si825772yxr.2.2008.07.11.08.50.55; Fri, 11 Jul 2008 08:50:56 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6BFonCP018488; Fri, 11 Jul 2008 17:50:54 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db9309a.pool.einsundeins.de [77.185.48.154]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6BFolF5023779 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Fri, 11 Jul 2008 17:50:47 +0200 (MEST)
In-Reply-To: <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness>
X-Mailer: Apple Mail (2.926)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88132>



On Jul 11, 2008, at 1:56 PM, Johannes Schindelin wrote:

> On Fri, 11 Jul 2008, Steffen Prohaska wrote:
>
>> I decided to stop queuing changes in 4msysgit.  Instead I'd like to
>> bring the diff between Junio's and 4msysgit's master to zero.  This
>> seems to be achievable after Junio merged Hannes' MinGW changes.
>>
>> I think all Windows-related changes to the git code base could be
>> discussed directly on the main git list and the msysgit list would be
>> reserved for the MinGW/MSYS runtime environment and the installer.
>
> I disagree.  Judging from the mails I read on the git list, Junio gets
> really swamped by patches these days (what with our very productive  
> GSoC
> students).

Sending the patches to the git list does not necessarily mean that
they are directly addressed to Junio.  We discuss JGIT, EGIT, gitk,
and git gui patches on the list too.  AFAIK, none of them are applied
by Junio directly but by the respective maintainers.  We could handle
Windows-related patches similarly.


> I really think that we should discuss the patches on the msysGit list
> first, whip them into shape, and then send them off.
>
> Just think of those patches that were sent off, only to realize that  
> they
> were no longer needed.  That should not have happened.


I intentionally sent the patches to show and discuss the differences
between the state of the MinGW port in Junio's master and in 4msysgit.
Some of the patches could be reverted in 4msysgit.  But, at least one
patch was unrelated to MinGW and is now in master.  Some other patches
need more work and are currently improved.  I think this was not a waste
of time.

	Steffen
