Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12212E62F
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tTCYQLS9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aAzuCILt"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCABD10C3
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 07:05:33 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 4E34E3200A8D;
	Tue, 24 Oct 2023 10:05:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 24 Oct 2023 10:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698156331; x=1698242731; bh=xC
	5MSLBIaMkZjTcJpiDNpb7tTBB9/8ix79RVCdctk5Y=; b=tTCYQLS9gnAQWyi8VI
	iDqI6zrUPpfN1m4zkCtMZHicwNbOuyfZ9MguBOM//BYB9IOyhRpRhZslGTr4NgzT
	h+jcMb1hh7v63vs7nAHmntlS6l/zSPwDMSS2y22jGeP+IwPoctllyncOXLK6vD9v
	d9OgX8m71dBnX6cu4kKmwjHsUCOmSiqwsCmNVaXY5t5x9QxJ9nVBu2Sa2hJNALEA
	ZKY6QJfKIqtiuuevVQ5lz2rGwf9wYqbRP0Ejvo+/WVibTxicZ8NjylsLSXvRCx6P
	GdDbalAbc3YZoWRx2QfK1SL55owSfzETcj4uKmUxYRTvjOQr8OeSqxPluCDgVRfU
	yANA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698156331; x=1698242731; bh=xC5MSLBIaMkZj
	TcJpiDNpb7tTBB9/8ix79RVCdctk5Y=; b=aAzuCILtAlJt/qscfr3i2nusyEN51
	0dsvDJIHZWOjRS/6pPhOLHB+2xmxVSal/r7JjemGh6kbTst0vGnu563S8L/r9V4O
	XWDIqWQIGcrLt9x9bLrMv6oH3T8ur9Q9U1kEX8wVYv1K05iJdFm1TFLMjAWwumfh
	81dgsVMSLOn3q/VY1evUkbdMEeAKszTW4PHpNvBZG++53rD56sgZlS43hrZiXAaN
	BiJjidtIWfMPumbmafCwuuGB4sSXQCHj7hV4lPwnrnrlYBj/DNi2OeXK2TL1DL3q
	B3dbBiT6KUa/Sjs2t+MDtfZ+N1AzoZRYVHykO6dz4qUKgY3XVJlQWH1TA==
X-ME-Sender: <xms:K883ZRp0DhbTiGiSAc5SLKzTTf4z8xIljmLYi3EPGHePL3fE9_JJwA>
    <xme:K883ZTrnZDzvtzp_-249P55qLuM3qUzelO15Pvkuu9X01Yz6yswjkV4jSn8aym91P
    6HwK9DIbK5N0qW4IQ>
X-ME-Received: <xmr:K883ZePnjMt242CURmIHrWyRTqwnmig66vvQDwGWjKnYL76uNKf4fbdQTeZ6csoB1_nmWoO_3rCn2D6u-tPCu0YYZYhwRoxJhH8kIYjie8CQ0i8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:K883Zc4ZfCcBMKOxr0GYtqFuZzifmBcTxukHxRVowpsAIde8oncZCA>
    <xmx:K883ZQ7VMflAYY977qkgtYqS0bAumFM19jJ4kHYhmtp76-238RT9nA>
    <xmx:K883ZUjncO1U7wGQ5TumbrOrJoK1Ul-QGFkXeycLhhwYlLdNUd00Vg>
    <xmx:K883ZentQ8ak2mxKrqfz5qgcF6S8H95WMEmbYx-pPzj5hLKmFTd2AA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 10:05:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 32c6180b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 14:05:25 +0000 (UTC)
Date: Tue, 24 Oct 2023 16:05:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 9/9] t: mark several tests that assume the files backend
 with REFFILES
Message-ID: <497e43ae5c362da9ad972e2813dc907df58a8676.1698156169.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
 <cover.1698156169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yWt4GbSehEqnmICI"
Content-Disposition: inline
In-Reply-To: <cover.1698156169.git.ps@pks.im>


--yWt4GbSehEqnmICI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add the REFFILES prerequisite to several tests that assume we're using
the files backend. There are various reasons why we cannot easily
convert those tests to be backend-independent, where the most common
one is that we have no way to write corrupt references into the refdb
via our tooling. We may at a later point in time grow the tooling to
make this possible, but for now we just mark these tests as requiring
the files backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1400-update-ref.sh            |  8 ++++----
 t/t1450-fsck.sh                  |  6 +++---
 t/t2011-checkout-invalid-head.sh | 16 ++++++++--------
 t/t3200-branch.sh                |  8 ++++----
 t/t3400-rebase.sh                |  2 +-
 t/t5605-clone-local.sh           |  2 +-
 6 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index b7d1e5deede..70a760ba378 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -236,7 +236,7 @@ test_expect_success 'update-ref --no-deref -d can delet=
e self-reference' '
 	test_must_fail git show-ref --verify -q refs/heads/self
 '
=20
-test_expect_success 'update-ref --no-deref -d can delete reference to bad =
ref' '
+test_expect_success REFFILES 'update-ref --no-deref -d can delete referenc=
e to bad ref' '
 	>.git/refs/heads/bad &&
 	test_when_finished "rm -f .git/refs/heads/bad" &&
 	git symbolic-ref refs/heads/ref-to-bad refs/heads/bad &&
@@ -288,7 +288,7 @@ test_expect_success "set $m (logged by touch)" '
 	test $A =3D $(git show-ref -s --verify $m)
 '
=20
-test_expect_success 'empty directory removal' '
+test_expect_success REFFILES 'empty directory removal' '
 	git branch d1/d2/r1 HEAD &&
 	git branch d1/r2 HEAD &&
 	test_path_is_file .git/refs/heads/d1/d2/r1 &&
@@ -300,7 +300,7 @@ test_expect_success 'empty directory removal' '
 	test_path_is_file .git/logs/refs/heads/d1/r2
 '
=20
-test_expect_success 'symref empty directory removal' '
+test_expect_success REFFILES 'symref empty directory removal' '
 	git branch e1/e2/r1 HEAD &&
 	git branch e1/r2 HEAD &&
 	git checkout e1/e2/r1 &&
@@ -1639,7 +1639,7 @@ test_expect_success PIPE 'transaction flushes status =
updates' '
 	test_cmp expected actual
 '
=20
-test_expect_success 'directory not created deleting packed ref' '
+test_expect_success REFFILES 'directory not created deleting packed ref' '
 	git branch d1/d2/r1 HEAD &&
 	git pack-refs --all &&
 	test_path_is_missing .git/refs/heads/d1/d2 &&
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index a6af550867c..50b15bd7fc0 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -123,7 +123,7 @@ test_expect_success 'branch pointing to non-commit' '
 	test_i18ngrep "not a commit" out
 '
=20
-test_expect_success 'HEAD link pointing at a funny object' '
+test_expect_success REFFILES 'HEAD link pointing at a funny object' '
 	test_when_finished "git update-ref HEAD $orig_head" &&
 	echo $ZERO_OID >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
@@ -139,7 +139,7 @@ test_expect_success 'HEAD link pointing at a funny plac=
e' '
 	test_i18ngrep "HEAD points to something strange" out
 '
=20
-test_expect_success 'HEAD link pointing at a funny object (from different =
wt)' '
+test_expect_success REFFILES 'HEAD link pointing at a funny object (from d=
ifferent wt)' '
 	test_when_finished "git update-ref HEAD $orig_head" &&
 	test_when_finished "git worktree remove -f wt" &&
 	git worktree add wt &&
@@ -149,7 +149,7 @@ test_expect_success 'HEAD link pointing at a funny obje=
ct (from different wt)' '
 	test_i18ngrep "main-worktree/HEAD: detached HEAD points" out
 '
=20
-test_expect_success 'other worktree HEAD link pointing at a funny object' '
+test_expect_success REFFILES 'other worktree HEAD link pointing at a funny=
 object' '
 	test_when_finished "git worktree remove -f other" &&
 	git worktree add other &&
 	echo $ZERO_OID >.git/worktrees/other/HEAD &&
diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-he=
ad.sh
index d9997e7b6b4..3c8135831b8 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -18,18 +18,18 @@ test_expect_success 'checkout should not start branch f=
rom a tree' '
 	test_must_fail git checkout -b newbranch main^{tree}
 '
=20
-test_expect_success 'checkout main from invalid HEAD' '
+test_expect_success REFFILES 'checkout main from invalid HEAD' '
 	echo $ZERO_OID >.git/HEAD &&
 	git checkout main --
 '
=20
-test_expect_success 'checkout notices failure to lock HEAD' '
+test_expect_success REFFILES 'checkout notices failure to lock HEAD' '
 	test_when_finished "rm -f .git/HEAD.lock" &&
 	>.git/HEAD.lock &&
 	test_must_fail git checkout -b other
 '
=20
-test_expect_success 'create ref directory/file conflict scenario' '
+test_expect_success REFFILES 'create ref directory/file conflict scenario'=
 '
 	git update-ref refs/heads/outer/inner main &&
=20
 	# do not rely on symbolic-ref to get a known state,
@@ -39,26 +39,26 @@ test_expect_success 'create ref directory/file conflict=
 scenario' '
 	}
 '
=20
-test_expect_success 'checkout away from d/f HEAD (unpacked, to branch)' '
+test_expect_success REFFILES 'checkout away from d/f HEAD (unpacked, to br=
anch)' '
 	reset_to_df &&
 	git checkout main
 '
=20
-test_expect_success 'checkout away from d/f HEAD (unpacked, to detached)' '
+test_expect_success REFFILES 'checkout away from d/f HEAD (unpacked, to de=
tached)' '
 	reset_to_df &&
 	git checkout --detach main
 '
=20
-test_expect_success 'pack refs' '
+test_expect_success REFFILES 'pack refs' '
 	git pack-refs --all --prune
 '
=20
-test_expect_success 'checkout away from d/f HEAD (packed, to branch)' '
+test_expect_success REFFILES 'checkout away from d/f HEAD (packed, to bran=
ch)' '
 	reset_to_df &&
 	git checkout main
 '
=20
-test_expect_success 'checkout away from d/f HEAD (packed, to detached)' '
+test_expect_success REFFILES 'checkout away from d/f HEAD (packed, to deta=
ched)' '
 	reset_to_df &&
 	git checkout --detach main
 '
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a38601dbbb7..8d82f9bc52a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -28,7 +28,7 @@ test_expect_success 'git branch --help should not have cr=
eated a bogus branch' '
 	test_path_is_missing .git/refs/heads/--help
 '
=20
-test_expect_success 'branch -h in broken repository' '
+test_expect_success REFFILES 'branch -h in broken repository' '
 	mkdir broken &&
 	(
 		cd broken &&
@@ -242,7 +242,7 @@ test_expect_success 'git branch -M baz bam should succe=
ed when baz is checked ou
 	git worktree prune
 '
=20
-test_expect_success 'git branch -M fails if updating any linked working tr=
ee fails' '
+test_expect_success REFFILES 'git branch -M fails if updating any linked w=
orking tree fails' '
 	git worktree add -b baz bazdir1 &&
 	git worktree add -f bazdir2 baz &&
 	touch .git/worktrees/bazdir1/HEAD.lock &&
@@ -833,14 +833,14 @@ test_expect_success 'renaming a symref is not allowed=
' '
 	test_path_is_missing .git/refs/heads/new-topic
 '
=20
-test_expect_success SYMLINKS 'git branch -m u v should fail when the reflo=
g for u is a symlink' '
+test_expect_success SYMLINKS,REFFILES 'git branch -m u v should fail when =
the reflog for u is a symlink' '
 	git branch --create-reflog u &&
 	mv .git/logs/refs/heads/u real-u &&
 	ln -s real-u .git/logs/refs/heads/u &&
 	test_must_fail git branch -m u v
 '
=20
-test_expect_success SYMLINKS 'git branch -m with symlinked .git/refs' '
+test_expect_success SYMLINKS,REFFILES 'git branch -m with symlinked .git/r=
efs' '
 	test_when_finished "rm -rf subdir" &&
 	git init --bare subdir &&
=20
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index d3df19a51f8..435943a0891 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -424,7 +424,7 @@ test_expect_success 'refuse to switch to branch checked=
 out elsewhere' '
 	test_i18ngrep "already used by worktree at" err
 '
=20
-test_expect_success MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs is a sym=
link' '
+test_expect_success REFFILES,MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs=
 is a symlink' '
 	git checkout main &&
 	mv .git/logs actual_logs &&
 	cmd //c "mklink /D .git\logs ..\actual_logs" &&
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index a26689de379..8ad6445eca7 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -157,7 +157,7 @@ test_expect_success 'cloning locally respects "-u" for =
fetching refs' '
 	test_must_fail git clone --bare -u false a should_not_work.git
 '
=20
-test_expect_success 'local clone from repo with corrupt refs fails gracefu=
lly' '
+test_expect_success REFFILES 'local clone from repo with corrupt refs fail=
s gracefully' '
 	git init corrupt &&
 	test_commit -C corrupt one &&
 	echo a >corrupt/.git/refs/heads/topic &&
--=20
2.42.0


--yWt4GbSehEqnmICI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3zycACgkQVbJhu7ck
PpQu+hAAlEMhCSF73q5DLH/Tco5bqTMUhRWnLrr4TwMoV1zuiO8dNUROFChgIN23
l+eLBR1g3Wx7fLzxxNXC6F+9QQbnnN9FLAlmvIar4M5evyZpHTSxLgXOYoGIXTpe
+SLLySbBQdWo8IJmpXXjCgK2J3/myNJEU0TM/zic6nEKP81naqkMJ207H8gdPVO0
yAqnMShvO32xXL/PHiydkJKtTQUKVw6bc5UUBhD0en/rDsu04lEnY1R9tj4mZYZt
2/ZC8h9mPGhFY1YqcyQkwHE2DP+OGD68UU539swnzNnB+KeWtKd14KX4Zv3SkSJa
ySJwHNcPpg6DS2yENbhvxi4mRKto7mIo5cpAXZufDEUWGv4dW/VMYBo5mMI/LV1g
DSBZrP6SDi95manF2xpQijlxzA55mUK3NeIJIAAm/1g3ZJ3rYQrM5YfyqL+GT3FZ
ETDm3w9fNgd89i3HCFwYBPf38a8S+xxvGGIH7oCDh6DWQBmSGBhWt4j37rzRN/Fy
WT/Nzkv7fpPsOrUOrK+hfv/aW6TXjz8VC5AorwDCN6LDLWSrqCl4PNx9ApzseGdX
a2De+OUqTEkzYBf2V9b1QjOUBRSV5QfGlCvmkWPezmaPGbkeg1O0WQDGypt+QzoJ
0tg6mOVGKHpjin1v4Pbccs1kqrIIQvQBbJWm2mD9dGbwong5BWk=
=fOkM
-----END PGP SIGNATURE-----

--yWt4GbSehEqnmICI--
