From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Announcing Git for Windows 2.6.1
Date: Mon, 05 Oct 2015 23:02:58 +0200
Organization: gmx
Message-ID: <517f6b5dd3edb6935bdba9f8f24f474b@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git for Windows Mailing List <git-for-windows@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 05 23:03:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCua-00020d-B2
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 23:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbbJEVDD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2015 17:03:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:58299 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770AbbJEVDB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 17:03:01 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lee2I-1aPPET2fTa-00qPFt; Mon, 05 Oct 2015 23:02:59
 +0200
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:1tQDs2MTLHMAQTJFfbhKo39zmyxO0uTBRcoykxH17oNFvmFxbOf
 61Eps/QhngmcShBxa229frWM0ajR4uDV55lmfB/SpQ1mbE4v6hiFIPjRK2RkKCMvOFvoJaw
 6T7/V88AifVokKboR0PJjwio2Y9D55uJU7k9j/VB1G68wEK08587OwmbhwfTD5yny7moWBn
 pcNHCWnUOnO+il9nlz4iQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f//Ks5yPIE4=:qLHwyb8dNQ9Ty2eum8waOT
 M8+dPkH8Naov9rO2/AZHbsIeUyFQJswCM0D7VbYedcyNgyh2x6y1+78co3Sehw/L2sQv5bMNy
 zqHsDLuTOeMbs0uqx+OzWWQ4oXkV6+jlGlT7Wysupeq7ujf7JMmg5cw6A6bpUrM/pEOs6NwBF
 YTGgpLCLQla0mE0wK9vol+iIyVOfYq3TcOCY0ivmBEsL78l/zM5tEbJPxUn6tAo/0mKlzO5SX
 JBDbZTQXjRhIJAU6T2RL4ckrSCjBbPpdORTtTXbvrUvXkBYfd06xuU7NRzE/duNOkzZJubzJb
 pWPx/7LfmxjFh8KlZqs2hSVf74ZuVekVRyrO+Ks5XcbhiZibXiapJ4C/5/sM220WsTGnwoJrH
 bV7siz1SkU72kYYL+la8dgrWakHAWyOHFats8ZYONkhkYJ9UZ8L+VVkqjeU1Ax6BCafOxDzer
 XhZzV1Vv3ORPoryJQ73HmUaF3tUHHPpPlhLFA4aE1nF4xbe0xp7ZwrAJvMVmC7t0knVN3mA+H
 g1eYp56kllFbU1IZUByrG0tgolb/767ZnJUIx3wpfuqEOyUVohQkJwBtH3FaVis5vggwP/8zi
 pmFxeF7F0QV9koE6ar+TvPPJ1TzxddK3NqjalKOfV6gOGn+a5BUUa1o9I5xdhvx91KdCaEMXV
 /BEo3kfmXi0Qiva7g2RCb+F2BO/rJS7XSECZoHnv48yG2rNlFXQRhu3v+iMmGJUbg6xx3tyNI
 RXJ9Z665Or8WdzR9aJY9Sxy5RzGxQfxou3+/H/lllbVtTQlApgCtECuv9Q1T1R8mcvPQKUdS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279095>

Dear Git users,

it is my pleasure to announce version 2.6.1 of Git for Windows, availab=
le from https://git-for-windows.github.io/.

Changes since Git for Windows 2.6.0 (September 29th 2015)

New Features

  =E2=80=A2 Comes with Git 2.6.1
  =E2=80=A2 The installer now writes the file /etc/install-options.txt =
to
    record which options were chosen at install time.
  =E2=80=A2 Replaces git flow with the AVH edition which is maintained
    actively, in surprising and disappointing contrast to Vincent
    Driessen's very own project.

Bug Fixes

  =E2=80=A2 The PATH variable is now really left alone when choosing th=
e "Use
    Git from Git Bash only" option in the installer. Note that
    upgrading Git for Windows will call the previous version's
    uninstaller, which might still have that bug.
  =E2=80=A2 Git GUI's Registry>Create Desktop Icon now generates correc=
t
    shortcuts.
  =E2=80=A2 The antiword utility to render Word documents for use in gi=
t diff
    now works correctly.
  =E2=80=A2 In 64-bit installations, we no longer set a pack size limit=
 by
    default.
  =E2=80=A2 When installing Git for Windows as regular user, the instal=
ler no
    longer comptries to create privileged registry keys.

Ciao,
Johannes
