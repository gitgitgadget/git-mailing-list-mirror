From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Announcing Git for Windows 2.5.2
Date: Thu, 10 Sep 2015 22:47:27 +0200
Organization: gmx
Message-ID: <84e270410b18c9684fd4c8a98d309a07@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git for Windows Mailing List <git-for-windows@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 10 22:47:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za8kp-0004m4-7R
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 22:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbbIJUrb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2015 16:47:31 -0400
Received: from mout.gmx.net ([212.227.17.21]:57765 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbbIJUra (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 16:47:30 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MBaDy-1ZSxD428wA-00ATxg; Thu, 10 Sep 2015 22:47:28
 +0200
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:QXipy79q8DluejQaedlwBiYlAFw0NTzqZ7AP3tutjFMhZggYTcX
 6EJKRr/+DhKZVCVDzAM1sJhNr96PfHfKVaARe+T7RWazoPXTxzDJ1YhehzsphCvyPF2d3gJ
 LQI9KVRTdhiVJTGVBEpmMEyFvUJhRZ0fiffnZittJhxgPhE9shOEy00PK5FcZp4vZMxf2/T
 hy4kK65egGMtEKo7xM2pQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mDCi4N0fxAo=:asjwD3Av+B5UJPuyPPPc3U
 lmB6sPFYNp0wOazW/QaoaeaKbkqRyBneH+i6A+1k77aXgNdNNQ64KRyfeNeW4e3PndJwFs4Rm
 AVTqNi9Fc8ut5aCqd0JQajqq7g/VCN/dp6JKj6Zjx7RbqjbMSOenesayBpRmpOhiH/Klr6uUY
 yLWlySn2kt4zzRoWwqcyycJNPz0t6xLgTfWxWKvbivG+wKjK981F8q82IJ7Q4DIuW+ksrkuMQ
 tHrpnzrhowbiDym3pT6p2wppVMk3uqgFVySm46NDLuZKg9M+ggMr5AaJ0KNMgk/u/wHhctjSs
 3akjvzdFJXn4z28HNHIqseQyVH7LdjKju72YMNwLYHwngJ570BLoB+XaCDVLrbRAeC6HtrPb/
 KHp4NIXFs1/CuyB9ps/3i7OzBZAZ0GCEb0nPiQ/vt4Up9lFDV4X/jHdFPtDkZ8PmgQKrKCTwo
 E3wi/TzE9nAL2EV7Jfx/TuVnHirPSD0oUxdu3pImrTkdM6wtATDiZOVdssTG6JkCD7UG0yhfx
 VBdt7nv8mAM8jtOAJx3CuUJKdRSoa7NwpaiyMdOF4tKtqHl2PYbbBTXGTT/Wos2Cx2IGWjEoo
 ydWo+p3Z5L+1TmwI37mlrdf2GEXXn6mzSJIF1hcfNBdYCvYezqQMd/dQJwmrEGf4inrgBAPaB
 K21dSSwwABoka4qMqDeSH4rXtgrAgRvhanJ6hb7zfmvC0/eXhmWUAuxQnRKZboLAJirkWoDHS
 yFAz9m04mxeBwJterPYL0TzAwXXUNv1aFoTTbg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277635>

Dear Git users,

it is my pleasure to announce Git for Windows 2.5.2. The installers and=
 portable versions can be downloaded from our home page at https://git-=
for-windows.github.io/.

We have been quite busy, lots of contributions (mostly bug reports, but=
 also the occasional Pull Request). Thank you all! The changes since Gi=
t for Windows 2.5.1 are:

New Features

  =E2=80=A2 Comes with Git 2.5.2

  =E2=80=A2 Alternates can now point to UNC paths, i.e. network drives.

Bug fixes

  =E2=80=A2 The MSys2 runtime was taught not to look hard for groups, s=
peeding up
    Git Bash's startup time.

  =E2=80=A2 A work around was added for issues when installing 32-bit G=
it for
    Windows on 64-bit Windows 10.

  =E2=80=A2 The installer no longer freezes when there are interactive =
commands
    in the user's .profile.

  =E2=80=A2 git rebase --skip was speeded up again.

  =E2=80=A2 The redirector in /bin/bash.exe now adjusts the PATH enviro=
nment
    variable correctly (i.e. so that Git's executables are found) befor=
e
    launching the real Bash, even when called without --login.

  =E2=80=A2 When installing Git for Windows to a location whose path is=
 longer
    than usual, Git commands no longer trigger occasional Bad address
    errors.

  =E2=80=A2 Git no longer asks for a DVD to be inserted again when one =
has been
    ejected from the D: drive.

Ciao,
Johannes
