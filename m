From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Announcing Git for Windows 2.5.3
Date: Fri, 18 Sep 2015 21:46:32 +0200
Organization: gmx
Message-ID: <3143d9c98b472ca9eb6dfc2e36f1d3a9@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git for Windows Mailing List <git-for-windows@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 18 21:46:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd1cK-0004ad-NP
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 21:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbbIRTqh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Sep 2015 15:46:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:52049 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962AbbIRTqf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 15:46:35 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MHrk1-1ZZzsK33L3-003bQw; Fri, 18 Sep 2015 21:46:33
 +0200
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:filNf3tuKLZsx3g2l5jjp7DZe7m5pAeHPYy6WRHZXi158WMdofD
 OEBtCDA9HA24k0FZ6Gji5MZqaedL6voUbSHcB1JkjsJCo8lP8xshFps8rFp0TGRRs5dvLVk
 j25XFv2oQ2Uuqw4ug7rwBMMyRlCqbYLJh7xcgBcKTWq4HX9h0fzIsjFj3sg4mtR2b1p1J/W
 2cshgAULJq7EyBYKWMIwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OXCvxuZV/ag=:QhXMDJHcK5GX78FuG0C5DE
 +nkvcXebYtOt5nVYNk1PjArmmIWI2mZEAJlUxmdLGJj5lpzsLk0QIv7Lb5Y170QLloei75qga
 Xh0WDmyyKRVoMOd+d+OcFgjRoG+PT86FAX7+pZBSFhGHwKoIoJgqjiSI38V8kN99JdYxuwmSn
 Q2AoC641Nc2v3Rbytjsgtrccrk+ut3IuAjm1JS9+g4j8QuYQAl+vnSQbF7xctIZko9pBHX0rS
 UbXgqJ1V1d1Iy5P+D7du9U2zM2yBtdp8V5tSisjPsJxYS853hQpcWGWdIIdK9thvRzmenydqs
 m/uet+6uH5Syq9LT4WM6ixYr9KT32OsZkBRwlTrxDYt/JvhRyDiegKYY5UqgKas3PXzUgPpqc
 Zm17GGLv4i4ofLWskCzhcjixBCaCJeYZJxJVi1haWLKPY5MIR1JhfCqSflD+C18zCmwHocBy/
 0YKKMfbyEG/4Dl4wDbaHQDNdc6yQelbxQReNt7P/jYka+eA+XjQQWeo6t8NXmvLZdBOHZCgap
 ld9I1nvpK2KALXR4CWa+vsvewhhr7lZka4yaC844FV3xf/Gl/jWFWKgUR3PjnjG9DPMfeVAOg
 DzrodKFA/dpSuJ44eShwNATJIeNK2a1vN68AFuCzXkbA9rO3kRJLNIO/+xotVFDeVp8TrukOh
 Wtqld1GueJ5O4hFZJGmSLKL2N4INQMsgV1/Rd4I2rw1cmO1jt3WlLJDnKi3fVocVQw1DQmBj1
 RwxFACnZtwhxjYt6keR+d9+o6kmSvZZIdMM9kw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278222>

Dear Git users,

it is my pleasure to announce that Git for Windows 2.5.3 can be downloa=
ded from https://git-for-windows.github.io/.

I would like to take this opportunity to thank everybody who contribute=
s to this project (and you will see below that there have been quite a =
few changes since release 2 of version 2.5.3 this past Sunday), in part=
icular Matthias A=C3=9Fhauer and @nalla for tireless testing and contri=
buting patches.

Changes since Git-2.5.2(2) (September 13th 2015)

New Features

  =E2=80=A2 Comes with Git 2.5.3.
  =E2=80=A2 Includes git flow.
  =E2=80=A2 By configuring `git config core.editor notepad`, users can =
now use
    notepad.exe as their default editor. Configuring `git config
    format.commitMessageColumns 72` will be picked up by the notepad
    wrapper and line-wrap the commit message after the user edited it.
  =E2=80=A2 The Subversion bindings for use with git svn were upgraded =
to
    version 1.9.1.
  =E2=80=A2 Some interactive console programs, e.g. psql.exe, now work =
in
    mintty thanks to pre-configured aliases.
  =E2=80=A2 The mechanism to diff .pdf, .doc and .docx files known from=
 Git for
    Windows 1.x has been ported to Git for Windows 2.x.
  =E2=80=A2 Git can now access IPv6-only hosts via HTTP/HTTPS.

Bug fixes

  =E2=80=A2 The .vimrc in the home directory is now allowed to have DOS=
 line
    endings.
  =E2=80=A2 The README.portable file of the portable Git mentions the n=
eed to
    run post-install.bat when the archive was extracted manually.
  =E2=80=A2 Home directories for user names with non-ASCII characters a=
re
    handled correctly now.
  =E2=80=A2 The documentation no longer shows plain-text linkgit:... "l=
inks"
    but proper hyperlinks instead.
  =E2=80=A2 The mtab link is written to /etc/mtab again, as it should.
  =E2=80=A2 When run inside the PowerShell, Git no longer gets confused=
 when
    the current directory's path and what is recorded in the file
    system differs in case (e.g. "GIT/" vs "Git/").

Ciao,
Johannes
