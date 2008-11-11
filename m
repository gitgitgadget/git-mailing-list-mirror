From: "Li Frank" <Frank.Li@freescale.com>
Subject: RE: why not TortoiseGit
Date: Tue, 11 Nov 2008 09:51:06 +0800
Message-ID: <7FD1F85C96D70C4A89DA1DF7667EAE961E7EF2@zch01exm23.fsl.freescale.net>
References: <7FD1F85C96D70C4A89DA1DF7667EAE96125890@zch01exm23.fsl.freescale.net> <20081031121913.GE18221@sys-0.hiltweb.site> <490AFBA5.5090700@op5.se> <d411cc4a0810310857y5b4f8c46ue33e1f6a9e2c13d1@mail.gmail.com> <7FD1F85C96D70C4A89DA1DF7667EAE961E728C@zch01exm23.fsl.freescale.net> <320075ff0811030200q606b76a8i16496cf7b8b1b7d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Scott Chacon" <schacon@gmail.com>, "Andreas Ericsson" <ae@op5.se>,
	"Ian Hilt" <ian.hilt@gmx.com>, <git@vger.kernel.org>
To: "Nigel Magnay" <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 03:16:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzio9-0001rN-Mc
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 03:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbYKKCPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 21:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753626AbYKKCPa
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 21:15:30 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:49682 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbYKKCPa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 21:15:30 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id mAB2F8Xa021020
	for <git@vger.kernel.org>; Mon, 10 Nov 2008 19:15:25 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net [10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id mAB1p7N1017612
	for <git@vger.kernel.org>; Mon, 10 Nov 2008 19:51:08 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <320075ff0811030200q606b76a8i16496cf7b8b1b7d2@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: why not TortoiseGit
Thread-Index: Ack9mv3pe30kC1okSEmNP8ZMeHbrXAGAH0tQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100612>

Nigel Magnay:

I create a tortoisegit project at repo.or.cz. 
http://repo.or.cz/w/TortoiseGit.git

It is coming from TortoiseSVN. It is very early stage.  The context menu
have worked.  TortoiseGitProc.exe help command have been worked.  

Welcome contribute. 

Best regards
Frank Li

-----Original Message-----
From: Nigel Magnay [mailto:nigel.magnay@gmail.com] 
Sent: Monday, November 03, 2008 6:00 PM
To: Li Frank-B20596
Cc: Scott Chacon; Andreas Ericsson; Ian Hilt; git@vger.kernel.org
Subject: Re: why not TortoiseGit

> I read some code of TortoiseSVN and TortoiseHg Code.
> At beginning, TortoiseGit can git command to get information like
Qgit.
> After linkable library ready, replace "git command".
>
> I think TortoiseGit can start base on below way.
>
> 1.  Base on TortoiseHg, It is python Script.  Replace below hg 
> operator with Git.
> 2.  Base on TortoiseSVN, It is developed with C++. Need VS2008.
> ToritoiseSVN provide some built in diff and merge tools.
> 3.  Base on Qgit, which provide some basic UI, such comment dialogbox,

> history view and file annotate.
>
>

TortoiseSVN is a good place to start because it separates out the
windows icon decorators into a separate DLL (shared with TortoiseCVS).
This is significant, as these are a finite resource in the windows
shell, and so having a TortoiseSVN + TortoiseGIT on one machine and you
might run out, and I'd imagine lots of people wanting both.

On the minus side, building (Tortoise)SVN requires a lot of environment
setup just to get it to build - most of which can be immediately thrown
away as it's specific to SVN.

But it doesn't look like a hard project to me, just requires stripping
out a lot of junk and re-patching callouts to a git executable (which
could be the standard git tools) and a minimal git library that knows if
files are dirty.
