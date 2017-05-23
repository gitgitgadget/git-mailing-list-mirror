Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50EB61FF30
	for <e@80x24.org>; Tue, 23 May 2017 10:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933027AbdEWKx0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 06:53:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:59929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757271AbdEWKxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 06:53:25 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTjMy-1dM1QF0HCq-00QQnI; Tue, 23
 May 2017 12:53:19 +0200
Date:   Tue, 23 May 2017 12:53:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Git Mailing List <git@vger.kernel.org>, gitster@pobox.com
Subject: Re: [PATCH 0/2] Fix warnings on access of a remote with Windows
 paths
In-Reply-To: <947b2453-52b6-4940-fd20-ddf350c5df4d@kdbg.org>
Message-ID: <alpine.DEB.2.21.1.1705231248150.3610@virtualbox>
References: <cover.1495261020.git.j6t@kdbg.org> <alpine.DEB.2.21.1.1705221357360.3610@virtualbox> <947b2453-52b6-4940-fd20-ddf350c5df4d@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1634976650-1495536799=:3610"
X-Provags-ID: V03:K0:Us/kCsSuCdXznY+Wx71lF6tugsfHKBTRJfMxUmjghTu3cyWRg2K
 fOp6ttYMqHloluJDdQOQEn6HL1QAXiGNEc9Cu/QX9JoEOp3+/tHSJUFxZBWelUfhPdBDObQ
 UNnfgW3TD1u0p0obXHWMStDllv7ZmPgrj3NCCWo3MZusA1g5D796JMm2lWWVIJIrUFpqEG3
 twFTg4Eakc/3cC1iw/wpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gz6BMD4gu0M=:q2fnKotcDtaESsO0Vm6ADz
 A8mFMm6TggP+HHImsORfYNw4u3rwJQ16HT4IQoByP6mbLSz8+qheI2JGiCAFyLizXerfEUR47
 ZdHbEIw1gq6B5ocHFopLMWzJlLURYGrk841u7j1PS3Em89QPtWC0zjPWBiiOrI+F5B1cDPX+X
 UvuoXFPJyKJrZHVrT6BU0wpulshLhATvny+BsaPfpVLtbWQd6fEAe119ftrzVnd3WUJz5xYoA
 1+m/h/1cTux+dp4fxxPIorsQqukDXS+GqMAhsRVHFCMBKrl+K7PHb9OrQ7gY/1fy+1HZMoiza
 AQFj9ldiUaZMScFmQWeX1iiho1ouI18HtOB6HmVIRmIV0gJRrSXP2e+NIx9bFQ/Y1YWucb8W4
 tomSdSMkVmk7V4EwBy0YdHacAMlGL37JicFzwUoQOJtkmEI3C/KrFqxUpqdAp4KWCYmN2aJSs
 eErAU5bWmrQKRJynfi83TcKgsuYoqKuqLi7e2oJX3WczKlxaUHI4rTllh7Hby03mL53kBwMjF
 ofKMA+/YZoKUcP1Yj6gNEHe2qUgUGlq1wd6TlgtBcwldRwnZigVY4CrurSo5l1demEF/0Wm+I
 5LalZ7sCZs7D8o0LwwDMxt9NXAWM9qpB36ruViO9a1I8Ew+LmCHrTw5ZJVnzIl9m7mn77jvAa
 KduJhQMdgFZGfiRBO6Xs3CM8tpft0XU9uqZIiSxjzRVXwp1HVzjzfQr4y7AslrO0YxXE1TDJV
 ngEjdBw9mS/qa6fuagYtNToJAuVG+Iate6JP0MlGHrG9cVpQKzlyKp9q2mJvxt8xevSm5qIAK
 930rcha
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1634976650-1495536799=:3610
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Hannes (& Junio, see below),

On Mon, 22 May 2017, Johannes Sixt wrote:

> Am 22.05.2017 um 13:59 schrieb Johannes Schindelin:
> > On Sat, 20 May 2017, Johannes Sixt wrote:
> > > This small series fixes these warnings on Windows:
> > >
> > > C:\Temp\gittest>git fetch C:\Temp\gittest
> > > warning: unable to access '.git/remotes/C:\Temp\gittest': Invalid arg=
ument
> > > warning: unable to access '.git/branches/C:\Temp\gittest': Invalid
> > > warning: argument
> > >  From C:\Temp\gittest
> > >   * branch            HEAD       -> FETCH_HEAD
> > >
> > > The fix is in the second patch; the first patch is a
> > > preparation that allows to write the fix in my preferred style.
> >=20
> > Thank you!
> >=20
> > Maybe you want to accompany these patches with a simple test case that
> > uses e.g. ls-remote on $(pwd | tr / \\\\)?
>=20
> Actually, no, I don't want to. It would have to be protected by MINGW, an=
d I
> don't want to burden us (and here I mean Windows folks) with a check for =
a
> cosmetic deficiency. (Shell scripts, slow forks, yadda, yadda...)

Actually, yes, I want to.

Yes, it would have to be protected by MINGW, and yes, it would put a
burden on us, but also yes: it would put an even higher burden on me to
check this manually before releasing Git for Windows, or even worse: this
regression would be the kind of bug that triggers many bug reports,
addressing which would take a lot more time than writing this test case
and executing it as part of our test suite.

So here goes:

-- snipsnap --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Tue, 23 May 2017 12:42:13 +0200
Subject: [PATCH] mingw: verify that paths are not mistaken for remote nickn=
ames

This added test case simply verifies that users will not be bothered
with bogus complaints =C3=A0 la

=09warning: unable to access '.git/remotes/D:\repo': Invalid argument

when fetching from a Windows path (in this case, D:\repo).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5580-clone-push-unc.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
index b195f71ea98..93ce99ba3c6 100755
--- a/t/t5580-clone-push-unc.sh
+++ b/t/t5580-clone-push-unc.sh
@@ -1,13 +1,19 @@
 #!/bin/sh
=20
-test_description=3D'various UNC path tests (Windows-only)'
+test_description=3D'various Windows-only path tests'
 . ./test-lib.sh
=20
 if ! test_have_prereq MINGW; then
-=09skip_all=3D'skipping UNC path tests, requires Windows'
+=09skip_all=3D'skipping Windows-only path tests'
 =09test_done
 fi
=20
+test_expect_success 'remote nick cannot contain backslashes' '
+=09BACKSLASHED=3D"$(pwd | tr / \\\\)" &&
+=09git ls-remote "$BACKSLASHED" >out 2>err &&
+=09! grep "unable to access" err
+'
+
 UNCPATH=3D"$(pwd)"
 case "$UNCPATH" in
 [A-Z]:*)
--=20
2.13.0.windows.1

--8323329-1634976650-1495536799=:3610--
