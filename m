From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Git for Windows 2.5.1 is out
Date: Mon, 31 Aug 2015 10:54:58 +0200
Organization: gmx
Message-ID: <44a7997123f03bb4d5f47724befd8417@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git-for-windows@googlegroups.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 31 10:55:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWKrs-00065z-Ue
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 10:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbbHaIzD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2015 04:55:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:59541 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908AbbHaIzB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 04:55:01 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MfF6I-1ZLwam2Q4A-00OrfB; Mon, 31 Aug 2015 10:54:58
 +0200
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:35XqCrhFDIaZ5f4FzBA/dM9Hp1xjxKMtxsR00wfg20hu7f9rnRm
 Fj84aUiPFmlpNEGxZ9X9RC6kt9d2UUdZ6aiSn6yFQ02kQlrZu476eCPUbrwaGiyLVJiBgfq
 OxiGC7sKd0btNu7l/C0DTreNwtSPdTu7GyDUpSF1R8dN4r6WzUaTSceAK4pb7WM44InUbFW
 U/cs/LTotnrrTVhct5How==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PUv0bqwaVpo=:cfXLeAWfapnpF+S2uwuGwH
 D+CWLWBt5Ak+jAYS+SAScsPGDwGsTC2MWBgYsq1Sz1SEjraLtbZ0ylX2WOWT27+q7fuMon02A
 ZRcmynTDRjRDVgF+z/kO36D2SEFyDLcyGqmT4u+cI24SIiyVC2NMNwoFErogeen2pZ4z1GSBF
 MXHfKsldM9C1kf4H6koFEUOtF+GbngyoVA7Ncm+Q1qSthe1aUhOuzTLa81hxcY9BrbrBoP7yo
 4x84GXozSY8GbtPnT0pdV+sPOQCRvpY/vkIXqActQXlbFA8nymLWwrxTAzMXkCeh9DCLPhB5f
 jTLRmBooi3qzymjSr2i//OtRpVK/rSYZwPSxWZjBAmTNQGlZ4TUUE0VAEsndnj4d6x6QYwv5+
 nJ6WDosa+KDuk7FI8rAsixedTrgbhRt+MhnQJy6YBLYIcW6C5GnWUa0ABJhb54+8tI105arOU
 vTBiW7wspyv6XLPL1WHWPMqNyVP+44cIxPyyP5hDVrzAF6F2ASbSAf/Ie0Zinwn9ffHvOdfNQ
 RkQ1SPxVft/CtWijNYOs7TqupZInYyx288NbhH74yJMzbvTsljiwxzJF+0E5C6FeFLG+TgSK9
 sxG7417rZiv88joUeDzybz0B6MoUQbZtEvF4P0PpmRXz9FQermVOHDx1ke5DS6ODy6BlKKv0O
 9QBZTIyWeBMREDx1jnF08IKtiEousAnaozwouOaVGPsouGsrKyIrvM+vBZ8yYcP5BEFa91VVW
 TzTAfNUO/GMppRyZ9USZuUeN/a7ZLT2ZN5fXMA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276857>

Dear Git (for Windows) users,

it is my pleasure to announce the release of Git for Windows 2.5.1. Apa=
rt from synchronizing with Git 2.5.1, the following bugs were fixed:

  =E2=80=A2 Backspace works now with ConHost-based (cmd.exe) terminal.
  =E2=80=A2 When there is a ~/.bashrc but no ~/.bash_profile, the latte=
r will be
    created automatically.
  =E2=80=A2 When calling a non-login shell, the prompt now works.
  =E2=80=A2 The text in the installer describing the terminal emulator =
options is no
    longer cut off.
  =E2=80=A2 The connect.exe tool to allow SSH connections via HTTP/HTTP=
S/SOCKS proxies
    is included in Git for Windows again, as it was in Git for Windows =
1.x.
  =E2=80=A2 The LANG variable is no longer left unset (which caused tro=
ubles with vim).
  =E2=80=A2 `call start-ssh-agent` no longer spits out bogus lines.
  =E2=80=A2 It is now possible even behind NTLM-authenticated proxies t=
o install Git
    for Windows' SDK.
  =E2=80=A2 We can handle the situation now when the first $PATH elemen=
ts point outside
    of Git for Windows' bin/ directories and contain .dll files that in=
terfere
    with our own (e.g. PostgreSQL's libintl-8.dll).
  =E2=80=A2 The patch tool is now included again as it was in Git for W=
indows 1.x.

Ciao,
Johannes
