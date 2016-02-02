From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.7.0(2)
Date: Tue, 2 Feb 2016 18:09:27 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602021805250.2964@virtualbox>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1518765025-1454432968=:2964"
To: git-for-windows@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 18:09:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQeSW-0004TY-LW
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 18:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933606AbcBBRJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 12:09:40 -0500
Received: from mout.gmx.net ([212.227.17.20]:52859 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933585AbcBBRJa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 12:09:30 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LdKs1-1Zil450tFZ-00iSdF; Tue, 02 Feb 2016 18:09:28
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:mu+RKOvlKOlAfZNNFR9BHtbYyFrmZngKBEku0Lc3dbtrPVw8yHN
 sudck9nP9PzV23kO3tbC7rNJ0yurkTnDmBfTuU7RQUOZ9aBgh3vZ7qvotNntA+CP44cGmlu
 THC3TKv8OASzUrmsXe4Zzo1CCsztZ1x5ayh7HbDI9bnztedTx8KcN3kpNsntqRMY7HeNwUA
 /z9oT5kP6xBgzm0xuJuYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2+y3DLdNBzQ=:PgIpBPIbznQGJwTO8BpSvq
 xyL1cZ8cfUgVvnze4Z8nSqIr9kTqeazSDIwXKM7H79heass6bGQnmjXJfVcS7rCqzdf2QRm+A
 F1F7KGwUpYxB3YE3SP1Cv//y9SisjevBSsDtyeFG9+ZWvZ1ZO90AiA29IajC1vy1y8m9nEr+W
 3QWGuXi44WesyI/DM3hCXp188kjbqshbUEZ5FcqeN/cBXeHmAW5G0XyHUVRTT2yGuitT+T/Sq
 DXmi5MBIvIwpc1f1AUOBBK9KaSXRd/NVBQfMHSQiJLZiS79Mx165N2zeCiKLdRNSPBJOBkzeD
 sdFavJASWloBFqzx9xZcAbQLNuubn6vfpDxOaX3nxyjn4qQvg3vYm4TvT638WG6YjarAkmoJ8
 l94yfpKgblkoWBnqY1I3FJRYATIysIV9fS7K+tTwnXuOp4G8uzi3et4fUq4FGC7u7wqYbFb1Z
 wzq7lyUhNQ4Ocv6WULwernPJ7JNt0aZV1zsEBmeJRZyWC4CE6YKDpKAQnivsHDr/YD1XVkGvY
 mqW+1A0oX4RPOhararLw3Etp+zC/PudSZ4dVZWv8ODpnFH/2tUUqPpi86ainBO24pBxSHlng5
 i+WJW9sX8fJQ2Pdx/ZEOz2GFbNB0CjTBqj43ztNEbRpaMnfdTM1QVJA27EuDeTb8vS7Vcipii
 v8Y8tRzb/rgCthVr4BJuz7f7Hl0HZerAYAaPn0EEZ30E6cdiS8jdaazhwp7XDovajRKgW1Q30
 vanmyg2k8C+2ClX+H1aa3QFqJPN/NfSmkumyddA80Io11kczOp8wiHp+G0bHX5LtNxQuq6GS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285282>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1518765025-1454432968=:2964
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

It is my pleasure to announce that Git for Windows 2.7.0(2) is available fr=
om:

=09https://git-for-windows.github.io/

I would like to dedicate this release to everyone who helps develop Git
(for Windows), whether it be by contributing code, by reviewing code
contributions, by answering questions here on the mailing lists or on the
bug tracker, by reporting carefully written and complete bug reports that
are a pleasure to read, and to everyone who is supporting us in any other
way. This very much includes helpful or encouraging comments in the
bug tracker. Thank you!  You are awesome. You make it all worth it.

Changes since Git for Windows v2.7.0 (January 5th 2016)

New Features

  =E2=80=A2 To stave off exploits, Git for Windows now uses Address Space
    Layout Randomization (ASLR) and Data Execution Prevention (DEP).
  =E2=80=A2 Git for Windows' support for git pull --rebase=3Dinteractive th=
at was
    dropped when the pull command was rewritten in C, was resurrected.
  =E2=80=A2 The installers are now dual signed with SHA-2 and SHA-1
    certificates.
  =E2=80=A2 The uninstaller is signed now, too.

Bug Fixes

  =E2=80=A2 When installing as administrator, we no longer offer the option=
 to
    install quiicklaunch icons because quicklaunch icons can only be
    installed per-user.
  =E2=80=A2 If a ~/.bashrc is detected without a ~/.bash_profile, the gener=
ated
    file will now also source ~/.profile if that exists.
  =E2=80=A2 The environment variable HOME can now be used to set the home
    directory even when running with accounts that are part of a
    different domain than the current (non-domain-joined) machine (in
    which case the MSys2 runtime has no way to emulate POSIX-style
    UIDs).
  =E2=80=A2 Git can now fetch and push via HTTPS even when the http.sslCAIn=
fo
    config variable was unset.
  =E2=80=A2 Git for Windows is now handling the case gracefully where the
    current user has no permission to list the parent of the current
    directory.
  =E2=80=A2 More file locking issues ("Unlink of file ... failed. Should I =
try
    again?") were fixed.

Filename | SHA-256
-------- | -------
Git-2.7.0.2-64-bit.exe | c9f0ba628d79886427e05b6b2833f65630ccfc49ecceaab7cf=
f0c6723d1d6e47
Git-2.7.0.2-32-bit.exe | 8f14d50a1950264a7fd53128a81884f5757ca2b645e092ce81=
122993433657f8
PortableGit-2.7.0.2-64-bit.7z.exe | aa29dcfffda49bde58c84d34cec8e38f4ea85d9=
7c5bb789a56e00ab86a60de5e
PortableGit-2.7.0.2-32-bit.7z.exe | b5af00c5bcffd67c57beb9ce379a8080e44a2f9=
fe05650a8d7d460382832cbea
Git-2.7.0.2-64-bit.tar.bz2 | 9ed65a54b2586059a53ce64a57d2faa99386b282dd427a=
4a7e5474feb00d0851
Git-2.7.0.2-32-bit.tar.bz2 | a9c2daf66ed9864146945e5e2e0970a13cd9140b0fb032=
7a668e2550a7cc24e8

Ciao,
Johannes
--8323329-1518765025-1454432968=:2964--
