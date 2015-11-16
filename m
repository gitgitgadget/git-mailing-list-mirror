From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [bug] git 2.6.2 (64-bit) blocks keyboard input (running in RDP,
 Win7 x64)
Date: Mon, 16 Nov 2015 13:10:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511161308510.1686@s15462909.onlinehome-server.info>
References: <D28D2D5A78DB8B49BB75DB10E72239683ABA1700@IRSMSX102.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Ryabov, Vasily V" <vasily.v.ryabov@intel.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 13:10:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyIcK-0001GG-UJ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 13:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbbKPMKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 07:10:36 -0500
Received: from mout.gmx.net ([212.227.15.18]:60897 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562AbbKPMKf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 07:10:35 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0M0y47-1aErrV133H-00v9nu;
 Mon, 16 Nov 2015 13:10:30 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <D28D2D5A78DB8B49BB75DB10E72239683ABA1700@IRSMSX102.ger.corp.intel.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:mnrncyEhDLh5ne9Fny0XeuPJLQ1LFftPLqJfjRtf6AAxDz2cRrA
 60YSdxG0H9LKEiaDv+pi//qYQU9uSa60o9Vqqvt7QhD0O6aZ6pKSOIFZ9+euSYlLy9Tze3V
 ni+Bhx7auFuiMG99p7p+F9xKpKl5zhdSqmE1IEl++WRFyDMnN4Z+hVp78CFQ6I+zJaC7C2j
 0716uVS/DmrEX8x+UpuLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4n/D+owmEd8=:0FnRujRJ7AnSzl1l9INiaQ
 U4TuUwiyoySfLJJRsERP2W95wdG4pjdSZMyGll9lVj4gMt4a1z0vy2jnpniMS16k1KZcbjkiF
 YhwtOABg1oFi0fcMLJNx7tuINHzuBnrREsjDJFLVnNdtZ5P0+udoZFokoacoV8oFo9cJGulV5
 AZcqFrTI3+aMEpFzHU92qZDRwb87frN2rYRDMZOA05NahIqVm5FdRKg6Z7V6fY/LFU2Hc57DQ
 8/SFtcWWnIAdDHdfDon2zLGkZ/1sqfxknXbHNt0Y4s+sgHIlTUEbVO17nh+9QhQ8y+lvsl5sq
 P9taywtHreYG786AElVX8A/0w4/xoPeKIUv1aBkOwnDvTZbTwoDCEiVBq1kHfokTsOwSsI/Yj
 1t8PjxhMLHetH60h8YCPnIIkdQQrSIltS7buu/uUus4K+zpCnIuLEaP0CVqu6NhWlcCjHjzNq
 5DkqGy9NMN315le7l+ZPrnstwaSbkC3etNP2WM+w1pclRAE7hkFj4ItCuGw8NtmawnNIb7r6S
 NHumVkCH2rQYQDiq1GM2ee43Mrd85CvbTVBcxYVuussRdHYyjL1NN1oWJlJEyrFdNK5BdWiUF
 K4LWv0RZ26hiDDOKBITyP+X+nTNWd/CLjabAUCx7CQcCyCqnwRmMe2/1iP4Y7Q+b6Z0jgutVM
 AU/E+6oFWv2AbB6afz2yNpFmj3xz+Ej5bTBI1bzXV9xyFexms8XA+c3B/ORX+tlnjQU3tXfUb
 eV1jm+PEEFnUe5EFQkh1KeUb7rUhWEDQGL7/zxGt2TgDLK9z1Tsy8cYl+GKZeWS8qdGMcGj9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281335>

Hi Vasily,

On Tue, 10 Nov 2015, Ryabov, Vasily V wrote:

> I'm trying to run something like this (on the remote machine (Win7 x64 with git 2.6.2 64-bit) through RDP):
> ```
> git pull --tags --progress ssh://<username>@<repo_URL>:<tcp_port>/<repo_name> +refs/heads/*:refs/remotes/origin/*
> ```
> It worked on local machine with git 1.9.5.
> 
> Git asks to confirm an action:
> ```
> The server's host key is not cached in the registry. You
> have no guarantee that the server is the computer you
> think it is.
> The server's dss key fingerprint is:
> ssh-dss 1024 <...>
> If you trust this host, enter "y" to add the key to
> PuTTY's cache and carry on connecting.
> If you want to carry on connecting just once, without
> adding the key to the cache, enter "n".
> If you do not trust this host, press Return to abandon the
> connection.
> Store key in cache? (y/n)
> ```
> I'm typing `y`, but there is no reaction at all. No symbols appears in the console. But...
> When I'm pressing `Ctrl+C`, it's killed. And I can see `yyyyy` keys in the bash console for the next command.

This is a known issue, mentioned in the release notes
(https://github.com/git-for-windows/build-extra/blob/master/installer/ReleaseNotes.md#known-issues):

> * If configured to use Plink, you will have to connect with putty first
>   and accept the host key.

Ciao,
Johannes
