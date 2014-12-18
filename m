From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Announcing Git for Windows 1.9.5
Date: Thu, 18 Dec 2014 22:47:52 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412181143570.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: msysgit+bncBCZPH74Q5YNRBC4XZWSAKGQEX6WGEBQ@googlegroups.com Thu Dec 18 22:47:56 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBC4XZWSAKGQEX6WGEBQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f57.google.com ([74.125.82.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBC4XZWSAKGQEX6WGEBQ@googlegroups.com>)
	id 1Y1ivM-0006Xy-96
	for gcvm-msysgit@m.gmane.org; Thu, 18 Dec 2014 22:47:56 +0100
Received: by mail-wg0-f57.google.com with SMTP id a1sf190501wgh.2
        for <gcvm-msysgit@m.gmane.org>; Thu, 18 Dec 2014 13:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:subject:message-id:user-agent:mime-version
         :content-type:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=3domwFbjfDr+Q+vsptWtYDrt1O/crDhwfi2whdldb24=;
        b=l2gPCx3PAzPfyRRh92L/BPJi2wvq0+h30Of+xItnWLflNUAPLA3J0xpSVnEY+9e0+6
         cyI7caUNW8W9uP/yr0muojdxNfVkm1kpu8nOoChLkMsW47uc5c8y0q8AWf2twtOwpUOW
         DCQW4kQaOrOv4MGiEo4H3jsq7xoMTbJT3JS8wm7wHqgxwZbK1u+nvxQWZDWiW78eIb+1
         hBYnnwvlNtr9FrSMPcUgYRQ7mwE+lyFJZ/yldQDbJJa+j67a5VB8bZNIB9z5gyu10v1I
         8UsRWn+762VplYiJA8jv2vJQ1MavlLZeOlBZPHcLh2G0QHuWC//3Uu2rC1ae+sGZ+nqJ
         p+eA==
X-Received: by 10.180.73.116 with SMTP id k20mr44847wiv.11.1418939275992;
        Thu, 18 Dec 2014 13:47:55 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.100.98 with SMTP id ex2ls3974wib.11.canary; Thu, 18 Dec
 2014 13:47:55 -0800 (PST)
X-Received: by 10.180.7.226 with SMTP id m2mr710340wia.5.1418939275289;
        Thu, 18 Dec 2014 13:47:55 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id jv2si5961wid.1.2014.12.18.13.47.55
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Dec 2014 13:47:55 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MSuMn-1YSurN1eJp-00Rmvk;
 Thu, 18 Dec 2014 22:47:52 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:bss1GIvpR1g2+vAjJGa2MNdTO8J16NqU9Yz8G44uz2ngUhAoae5
 E0o5ejD4r3YBBjcn8hDflduYHua9iDJMS0htbqGXpyQAHCz961HaXgOzZAszvSr/MqVII9U
 y3+xCJCmDo6CGJ4jQwz3M+ci9+Grpcig9nQTYz5Cb5eTP8QG2oEDVwtlinD0/euF9vNX2NZ
 pRqOCXtDBfW7+7H+ehs1Q==
X-UI-Out-Filterresults: notjunk:1;
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
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261537>

Dear users of Git for Windows,

a new Git for Windows version has been released, and we urge everybody to
update because it fixes some critical bugs.

Please download the new version from:

https://github.com/msysgit/msysgit/releases/Git-1.9.5-preview20141217

The installer is called Git-1.9.5-preview20141217.exe, with checksums:

	SHA-1: 21bd5187ef2f7e5124dd7bf1a0a8b7713a7c4953
	MD5: b962aee34e84a749e4951237fb04ac39

Short release notes:

	Git Release Notes (Git-1.9.5-preview20141217)
	Last update: 17 December 2014

	Changes since Git-1.9.4-preview20140929

	New Features
	- Comes with Git 1.9.5 plus Windows-specific patches.

	Bugfixes
	- Safeguards against bogus file names on NTFS (CVE-2014-9390).

For detailed release notes, please have a look here:

https://github.com/msysgit/msysgit/raw/master/share/WinGit/ReleaseNotes.rtf

On behalf of the Git for Windows developers,
Johannes
