Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B001F461
	for <e@80x24.org>; Fri, 21 Jun 2019 14:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfFUOeF (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 10:34:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:58471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfFUOeD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 10:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561127628;
        bh=BQTpriFiXmQSI84J3sZj9oaPLe4o7HK9ULkRWMKKShA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ux//6juDA7+STxy06Um0n6bZQ/rszVJ2POV4xLMCukfgw6H6LWlPSbDfFRnDdm2FI
         Cxxyx2gJGIdtqyg/oPNc/DnX2sgf4lpPpY4UaDbBnNF/QgRkKmmooF4OrnD7HkucfE
         ouFJ+ywgVx48CNPPwDLpvnazPqnGAf/NVCoBh+Pk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmOLO-1iDwHG2tiE-00ZtEM; Fri, 21
 Jun 2019 16:33:48 +0200
Date:   Fri, 21 Jun 2019 16:34:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] t0001: fix on case-insensitive filesystems
In-Reply-To: <c2fdcf28e725c91a1a48c34226223866ad14bc0a.1560978437.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906211632570.44@tvgsbejvaqbjf.bet>
References: <pull.151.git.gitgitgadget@gmail.com> <pull.151.v2.git.gitgitgadget@gmail.com> <c2fdcf28e725c91a1a48c34226223866ad14bc0a.1560978437.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WxZckyy45hPyIh3x5JrDmn6PZt1+3uvmYdlMye34LWc7P9Hy+Tn
 +MLv0B7ar5p5/sxfcvX69fxOrW6r6NGsLp1YUdn2GifNS8xGOUrHYDzr3kEuie768hJF1kD
 bDshV4NutL1ju+8fH30Wi9IrrLb6g1uBY1edoaYkyfjqRPAKvhMkuUrc/+oMiNgN9GiOHAc
 MRdNmvNHM6N4Hq7eiHuDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IIFgNkMJ/oA=:xss1ed9a1pkuf1t52aniSZ
 th8FRuh+4vKA7hTTadesKt/m2FJAiWTXqM215G1Uo2jJfGvASvlKVkW4YLCSFO6Uxmto35POQ
 eNxSJepHvVCPNceb2MN5Y+9PiRGTHlmw6+xhpodOCaMXg75/sVfSlmJqcRZsD4IiZo6GKb2v6
 772/h7e1ixiTnle5dj03wQ0Ea6B+4Xfy+NqZ1IHE56kgPZt/Pta8kKeMMbKj4ZeA1UqRlDncV
 fw3aBz1eUmkPwQ9NoncFu5aGcieqESu4Faz2g7kv+HPYzTkQkehp8OMkrMIaHAPj0d3t/08jj
 aJXS8fmlT6TDaDsznCtldbCFsG1SVgRRSNtsdvzk+AJ+8H+wSJDGoTGX7Fiy191/8rlYAi3P/
 jf3Dr47sdI/Z1uNAfwGy8/lLlXopgjWKpthXj7XxigNeKnBh7b5yTYF2CBvIrCRcJ8VkhAF2t
 FJLf/vQoBI4I10t/pJ0hxSUmLwukrqfMBWGBntIiqA+FYEFF6EJrQyTtBF0YOEHp1SWnRDttb
 DIOwAWtHS5rnlMyhnSjDt+/TV2GyUgz9mDftJccCzpk8TcjqGsFiX9e4u3mRTwTHG/r1XJLRx
 qlmKhGLTkOEsAySTlDP+I2xgUT4doccyLJxpzEj+THKtT/lembLsZz4AdiAEVaAyLTDWrAng/
 6ifvRDKd7OfEurYnZPIlHkBIN15IEgPNcvsK5ythG+M/msBFiMYhfVKNU1NaZ7F/bJkEWF3KS
 +JIRrNN47bpptz/gddclb18JywswSJokfQ7Q6tD8ofINIoMQiECJEta/xd8njiMn99hqPSePF
 cbfjXYmIhEgwy/tlB/OV8OY0BB2eJh4fOQ973bCPgN5wqIfxMAmL7vQ9aUOJ7avtc7VV+YgJy
 I8Y8R68PDTRt3Q9SPxuSzwVTJl6ZARGgQWq/O6yTHQ4+Onya2X++W762caKgBdC4icpg69bfJ
 akd6xdNRt5swbUrc+qiVcQZEq+uF78cWJfAJdM/SYQMXFZ0d7wjtL
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Re-sending, as the Git mailing list seems to have decided to silently
drop this patch, I cannot see it on public-inbox.org, at least]

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On a case-insensitive filesystem, such as HFS+ or NTFS, it is possible
that the idea Bash has of the current directory differs in case from
what Git thinks it is. That's totally okay, though, and we should not
expect otherwise.

On Windows, for example, when you call

	cd C:\GIT-SDK-64

in a PowerShell and there exists a directory called `C:\git-sdk-64`, the
current directory will be reported in all upper-case. Even in a Bash
that you might call from that PowerShell. Git, however, will have
normalized this via `GetFinalPathByHandle()`, and the expectation in
t0001 that the recorded gitdir will match what `pwd` says will be
violated.

Let's address this by forcing the comparison to be case-insensitive when
`core.ignoreCase` is `true`.

Reported by Jameson Miller.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 t/t0001-init.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 42a263cada..68f713884f 100755
=2D-- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -307,10 +307,22 @@ test_expect_success 'init prefers command line to GI=
T_DIR' '
 	test_path_is_missing otherdir/refs
 '

+downcase_on_case_insensitive_fs () {
+	test true =3D "$(git config --get --type=3Dbool core.ignorecase)" ||
+	return 0
+
+	for f
+	do
+		tr A-Z a-z <"$f" >"$f".downcased &&
+		mv -f "$f".downcased "$f" || return 1
+	done
+}
+
 test_expect_success 'init with separate gitdir' '
 	rm -rf newdir &&
 	git init --separate-git-dir realgitdir newdir &&
 	echo "gitdir: $(pwd)/realgitdir" >expected &&
+	downcase_on_case_insensitive_fs expected newdir/.git &&
 	test_cmp expected newdir/.git &&
 	test_path_is_dir realgitdir/refs
 '
@@ -365,6 +377,7 @@ test_expect_success 're-init to update git link' '
 	git init --separate-git-dir ../surrealgitdir
 	) &&
 	echo "gitdir: $(pwd)/surrealgitdir" >expected &&
+	downcase_on_case_insensitive_fs expected newdir/.git &&
 	test_cmp expected newdir/.git &&
 	test_path_is_dir surrealgitdir/refs &&
 	test_path_is_missing realgitdir/refs
@@ -378,6 +391,7 @@ test_expect_success 're-init to move gitdir' '
 	git init --separate-git-dir ../realgitdir
 	) &&
 	echo "gitdir: $(pwd)/realgitdir" >expected &&
+	downcase_on_case_insensitive_fs expected newdir/.git &&
 	test_cmp expected newdir/.git &&
 	test_path_is_dir realgitdir/refs
 '
=2D-
gitgitgadget

