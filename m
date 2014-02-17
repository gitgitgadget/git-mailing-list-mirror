From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Git for Windows 1.9.0
Date: Tue, 18 Feb 2014 00:38:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1402180036150.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBCZPH74Q5YNRBEF3RKMAKGQEYJ2EZIY@googlegroups.com Tue Feb 18 00:38:57 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBEF3RKMAKGQEYJ2EZIY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f185.google.com ([209.85.215.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBEF3RKMAKGQEYJ2EZIY@googlegroups.com>)
	id 1WFXm4-0000my-Mm
	for gcvm-msysgit@m.gmane.org; Tue, 18 Feb 2014 00:38:56 +0100
Received: by mail-ea0-f185.google.com with SMTP id r15sf1154065ead.12
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Feb 2014 15:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=tr9WQezN94bmeRPSCB6zbRqHvnTHWNaKAKEzhKjDskA=;
        b=bGVoOkJWv8LajNARg9UYgijVysMF64DdZGzkV6LVe752vw4aHPVE33xqKFyNMKdJbS
         uzB+2xTcYxknjXwMlNloKQFhl5dlIvsM+ePviWeP4x4rgzM5DdF2JErrmBsEns4mGhzU
         BiUoHjUOi30Ls/QEa5WRANEQ8GJV6icGwjOVlOxRm63z03v8Np775VyDCPt1UL/hWbei
         ZGi0w6/gG2o+kAn8bcBSeo5aYu3k5ecZPHkP9/3BKcUK4JUaowL2bdBhfAgnFFEd9W7l
         BeMsus+7KfrSD46JvOwAbjSfsd4R22mpBelyKpiYwo8itwI12GJBdvDeXVauT/NBeNvV
         oEmA==
X-Received: by 10.152.190.163 with SMTP id gr3mr38495lac.29.1392680336392;
        Mon, 17 Feb 2014 15:38:56 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.153.3.8 with SMTP id bs8ls243303lad.16.gmail; Mon, 17 Feb 2014
 15:38:55 -0800 (PST)
X-Received: by 10.152.180.35 with SMTP id dl3mr14933653lac.8.1392680335811;
        Mon, 17 Feb 2014 15:38:55 -0800 (PST)
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net. [82.165.159.12])
        by gmr-mx.google.com with ESMTPS id q13si953088eer.0.2014.02.17.15.38.55
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2014 15:38:55 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 82.165.159.12 as permitted sender) client-ip=82.165.159.12;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MfiFU-1Wcgpe29oa-00NDeL
 for <msysgit@googlegroups.com>; Tue, 18 Feb 2014 00:38:54 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:Tg0p71XHMCZVwLKRJhTGDag26hJiSlFmlJKqOlqXSFgzA3sfHJE
 1fiRNIxlFMU89F0xmuZymW9gOrsIpuQj/+xkoAXhY+4HV9EoNr+aV/9qYptR/HeYdyV/XJ5
 5eS6cYYC3SOjcGN/t5CzjsY6aoopCUR1neef1WUOygHyHHYGrx336bfn0LBZUcmy0UywWQG
 sRix7zoUyb5RPQU6BXhIw==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 82.165.159.12 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242269>

Dear Git fanbois,

this announcement informs you that the small team of volunteers who keep
the Git ship afloat for the most prevalent desktop operating system
managed to release yet another version of Git for Windows:

Git Release Notes (Git-1.9.0-preview20140217)
Last update: 17 February 2013

Changes since Git-1.8.5.2-preview20131230

New Features
- Comes with Git 1.9.0 plus Windows-specific patches.
- Better work-arounds for Windows-specific path length limitations (pull
  request #122)
- Uses optimized TortoiseGitPLink when detected (msysGit pull request
  #154)
- Allow Windows users to use Linux Git on their files, using Vagrant
  http://www.vagrantup.com/ (msysGit pull request #159)
- InnoSetup 5.5.4 is now used to generate the installer (msysGit pull
  request #167)

Bugfixes
- Fixed regression with interactive password prompt for remotes using the
  HTTPS protocol (issue #111)
- We now work around Subversion servers printing non-ISO-8601-compliant
  time stamps (pull request #126)
- The installer no longer sets the HOME environment variable (msysGit pull
  request #166)
- Perl no longer creates empty sys$command files when no stdin is
  connected (msysGit pull request #152)

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
For more options, visit https://groups.google.com/groups/opt_out.
