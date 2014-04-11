From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Git for Windows 1.9.2
Date: Sat, 12 Apr 2014 00:13:09 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1404120007020.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBCZPH74Q5YNRB5WRUGNAKGQEHVAZOOQ@googlegroups.com Sat Apr 12 00:13:12 2014
Return-path: <msysgit+bncBCZPH74Q5YNRB5WRUGNAKGQEHVAZOOQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-bk0-f59.google.com ([209.85.214.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB5WRUGNAKGQEHVAZOOQ@googlegroups.com>)
	id 1WYjh9-0006m6-Hj
	for gcvm-msysgit@m.gmane.org; Sat, 12 Apr 2014 00:13:11 +0200
Received: by mail-bk0-f59.google.com with SMTP id my13sf454387bkb.4
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Apr 2014 15:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=3pWzrOkiGr9lGxCR8JVLjU2JCraZQEIxJ55Hna87DL8=;
        b=CynGCL+92drfb3J9m9k2Akftss6jmpNx4JR5ZTHZ2ySRH9D3vcB9Sd1CFJWcB3zDIN
         7ZqVkFFkkc9lJg+UQ5poSbMyF9F4s0O8e8z74fvivCnmJtfZ4GLDwtq8s1y/lb1X2C0M
         ceEgYN4phpZw+DPuoqE5PzEC2WAAg0MizMvY98YZLW3DmInVfbE9nqJt0pgm3GIJknTN
         eOa3c6dGqJ3msooCPKmcXROGH6IrOtwA5JfQukoFbtvl//vF4hi9ri/JvQ6hIac6Z+AX
         1Uf1CVFIbnckwbHx8o8MdxI9F9tc4V6iF2hrGnR13b+vlMIQlrijEwO4ma7MVBBxV2zf
         YceQ==
X-Received: by 10.152.27.129 with SMTP id t1mr292264lag.0.1397254391139;
        Fri, 11 Apr 2014 15:13:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.3.136 with SMTP id c8ls245283lac.67.gmail; Fri, 11 Apr
 2014 15:13:10 -0700 (PDT)
X-Received: by 10.152.115.171 with SMTP id jp11mr2606538lab.3.1397254390152;
        Fri, 11 Apr 2014 15:13:10 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id u49si2096589eeo.1.2014.04.11.15.13.10
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA bits=256/256);
        Fri, 11 Apr 2014 15:13:10 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0Lx8ZJ-1X1eV21VQv-016dFd;
 Sat, 12 Apr 2014 00:13:09 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:FyuSWAzedh+uTx169iEDnRMoa17eJG2qm3ZQxFRlkMd206wi+vd
 gcINNq12IAwDhHgu861M6nCtyFJhG1+90htY2x+P2pHxJIxQxKVuFpKbfl13u7SVPS4vyYV
 jVylFR1nD5XdNBV2kLn/MiLph2n7ZoJ3pu7uqVBcY2so4gHqTtwC3N23/WqLKV67ZhbgUPi
 7h7B2aJ6IJsmQFVz2BzIg==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246152>

Hi,

the Git for Windows team just released version 1.9.2 of the
Windows-specific installers.

New Features
* Comes with Git 1.9.2 plus Windows-specific patches.
* Custom installer settings can be saved and loaded, for unsupervised
  installation on batches of machines (msysGit PR #168).
* Comes with VIM 7.4 (msysGit PR #170).
* Comes with ZLib 1.2.8.
* Comes with xargs 4.4.2.

Bugfixes
* Work around stack limitations when listing an insane number of tags (PR
  #154).
* Assorted test fixes (PRs #156, #158).
* Compile warning fix in config.c (PR #159).
* Ships with actual dos2unix and unix2dos.
* The installer no longer recommends mixing with Cygwin.
* Fixes a regression in Git-Cheetah which froze the Explorer upon calling
  Git Bash from the context menu (Git-Cheetah PRs #14 and #15).

It can be downloaded here:

	https://github.com/msysgit/msysgit/releases/download/Git-1.9.2-preview20140411/Git-1.9.2-preview20140411.exe

This release also marks a change relevant only for developers wanting to
help with the development of Git for Windows: only the net installer (i.e.
a rudimentary Git environment that simply clones everything necessary to
build Git for Windows) is available for download; the "full" installers
were not useful for Git for Windows contributors.

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
