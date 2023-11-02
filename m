Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B9711184
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ddkV4PSJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WvNhpby5"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4358C128
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 01:46:58 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 4B5E732004ED;
	Thu,  2 Nov 2023 04:46:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 Nov 2023 04:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698914816; x=1699001216; bh=qN
	R0A+DYDnlmOFt5NcUk/0Ol49FKWc4X7ice6/I89Sw=; b=ddkV4PSJwuj0AzVxl+
	HMLrBE50teT80V04V6fed63dizb6nX/vgke+lIgc5e9DQu0I2nI77seeoZcMWt+x
	2SjZ9HdwUzxV72Cd3wPnXKL8EdziqFaB0bHt62DYpZJL189/Wc0pdyv7NyfrlPSz
	/mzvoZ4KEQoKC+ctzLmlYApMlDqL3eSd6P1CkM7hb2oaOCkkjaYK+3jLtI7FVYGI
	Oy8PDU5QK+hNUzsqWO5YSSUPaIfoN8q9TPx1djy3P5iP3/xPV7tFzIt0cu+oCxik
	eFNc3DdDoLYzZwgmFSTX1JoXha+SevVOv44wxvzxDP0HeYV62N2BetvC1H1aJgLb
	HH+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698914816; x=1699001216; bh=qNR0A+DYDnlmO
	Ft5NcUk/0Ol49FKWc4X7ice6/I89Sw=; b=WvNhpby5TJaI61I6lv+BrUYed+pbU
	DKRfJAwsGqzTkt7xkHJFUGJ8MtVm8Fti80pO0Xjm/PIvIM+X/IIqthNSmwGb21jL
	zyryxd6DAMY2phVQBuHY5O/L0LKxzNveFindnvCOAqNLbPxmMIJhxF7bO+DeJ6On
	iEGSMtfhyoNCZ50yd6Ufgwmj0v2kQEpQUMGUKAEpU9RA1CtgAYNyxd0WjNAuJzNg
	4H6CQIiKg59Rp03Gd+0At5mssJzFruT4Yg3vE0PKTnY0G03+00jOoD4EC4hSSW98
	hSAU6ljGY6KRseIWeFF3x4Q34P43v9gt0P8AULOezpPB62E+v7NdlaYIQ==
X-ME-Sender: <xms:AGJDZSC8Exk-7iydnHej7UiLCDknYPZ7LssiqqoFvJU23AvMuDB7uA>
    <xme:AGJDZcj14d01J7D5weE_ADYmYmmwQYW7K3smjN7b0YwFJWAdurtl5_zcYwpB3Nd58
    Hm1WpbhTdj6rGPdsw>
X-ME-Received: <xmr:AGJDZVmux3cu-ZzKGUEIzKWUhLWJMK8FAVhhdevLR5EU7ZBILfs66RFLAtopmf6tWqFI4gBorHQl-DV4Pnwrive4MGWdwSZZqrWMZnY1Dwdz1m0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:AGJDZQyemJOPsYYUyjAeLR08eNfJfr68bLUwmG_wTsYce991NMSTyA>
    <xmx:AGJDZXTXTU09WpW4tGHrMXbcifuNmQrCYJEFrNCySOVnSg6MgKzjkQ>
    <xmx:AGJDZbaQjZE2UVe2fDOdir_Xb5273EhfF72J_A0JjFeZZkyMrLUImg>
    <xmx:AGJDZRcXF4r8EHyXa0_j6BMXFZ99wyDXsbCpKongMSVmne5XIqTxng>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 04:46:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d9be76f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Nov 2023 08:46:43 +0000 (UTC)
Date: Thu, 2 Nov 2023 09:46:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/9] t: convert tests to not access reflog via the
 filesystem
Message-ID: <fdf6768922739322854fa3ccfa295228f279ac5a.1698914571.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
 <cover.1698914571.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4yrJS40J3WgPFhOq"
Content-Disposition: inline
In-Reply-To: <cover.1698914571.git.ps@pks.im>


--4yrJS40J3WgPFhOq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of our tests reach directly into the filesystem in order to both
read or modify the reflog, which will break once we have a second
reference backend in our codebase that stores reflogs differently.

Refactor these tests to either use git-reflog(1) or the ref-store test
helper. Note that the refactoring to use git-reflog(1) also requires us
to adapt our expectations in some cases where we previously verified the
exact on-disk log entries. This seems like an acceptable tradeoff though
to ensure that different backends have the same user-visible behaviour
as any user would typically use git-reflog(1) anyway to access the logs.
Any backend-specific verification of the written on-disk format should
be implemented in a separate, backend-specific test.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1400-update-ref.sh | 17 +++++++++++------
 t/t3200-branch.sh     | 24 ++++++++++++------------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 51a8d0bba98..b7d1e5deede 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -90,7 +90,8 @@ test_expect_success "deleting current branch adds message=
 to HEAD's log" '
 	git symbolic-ref HEAD $m &&
 	git update-ref -m delete-$m -d $m &&
 	test_must_fail git show-ref --verify -q $m &&
-	grep "delete-$m$" .git/logs/HEAD
+	test-tool ref-store main for-each-reflog-ent HEAD >actual &&
+	grep "delete-$m$" actual
 '
=20
 test_expect_success "deleting by HEAD adds message to HEAD's log" '
@@ -99,7 +100,8 @@ test_expect_success "deleting by HEAD adds message to HE=
AD's log" '
 	git symbolic-ref HEAD $m &&
 	git update-ref -m delete-by-head -d HEAD &&
 	test_must_fail git show-ref --verify -q $m &&
-	grep "delete-by-head$" .git/logs/HEAD
+	test-tool ref-store main for-each-reflog-ent HEAD >actual &&
+	grep "delete-by-head$" actual
 '
=20
 test_expect_success 'update-ref does not create reflogs by default' '
@@ -130,7 +132,7 @@ test_expect_success 'creates no reflog in bare reposito=
ry' '
=20
 test_expect_success 'core.logAllRefUpdates=3Dtrue creates reflog in bare r=
epository' '
 	test_when_finished "git -C $bare config --unset core.logAllRefUpdates && \
-		rm $bare/logs/$m" &&
+		test-tool ref-store main delete-reflog $m" &&
 	git -C $bare config core.logAllRefUpdates true &&
 	git -C $bare update-ref $m $bareB &&
 	git -C $bare rev-parse $bareB >expect &&
@@ -263,7 +265,10 @@ test_expect_success "(not) changed .git/$m" '
 	! test $B =3D $(git show-ref -s --verify $m)
 '
=20
-rm -f .git/logs/refs/heads/main
+test_expect_success "clean up reflog" '
+	test-tool ref-store main delete-reflog $m
+'
+
 test_expect_success "create $m (logged by touch)" '
 	test_config core.logAllRefUpdates false &&
 	GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
@@ -316,7 +321,7 @@ $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 111715=
0260 +0000	Switch
 $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
 EOF
 test_expect_success "verifying $m's log (logged by touch)" '
-	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expec=
t" &&
+	test_when_finished "git update-ref -d $m && git reflog expire --expire=3D=
all --all && rm -rf actual expect" &&
 	test-tool ref-store main for-each-reflog-ent $m >actual &&
 	test_cmp actual expect
 '
@@ -346,7 +351,7 @@ $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 111715=
0380 +0000	Switch
 $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000
 EOF
 test_expect_success "verifying $m's log (logged by config)" '
-	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expec=
t" &&
+	test_when_finished "git update-ref -d $m && git reflog expire --expire=3D=
all --all && rm -rf actual expect" &&
 	test-tool ref-store main for-each-reflog-ent $m >actual &&
 	test_cmp actual expect
 '
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 874520e3f10..933aa9eebbd 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -76,14 +76,14 @@ test_expect_success 'git branch HEAD should fail' '
 '
=20
 cat >expect <<EOF
-$ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +000=
0	branch: Created from main
+$HEAD refs/heads/d/e/f@{0}: branch: Created from main
 EOF
 test_expect_success 'git branch --create-reflog d/e/f should create a bran=
ch and a log' '
 	GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
 	git -c core.logallrefupdates=3Dfalse branch --create-reflog d/e/f &&
 	test_ref_exists refs/heads/d/e/f &&
-	test_path_is_file .git/logs/refs/heads/d/e/f &&
-	test_cmp expect .git/logs/refs/heads/d/e/f
+	git reflog show --no-abbrev-commit refs/heads/d/e/f >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success 'git branch -d d/e/f should delete a branch and a log'=
 '
@@ -203,10 +203,9 @@ test_expect_success 'git branch -M baz bam should succ=
eed when baz is checked ou
 	test $(git rev-parse --abbrev-ref HEAD) =3D bam
 '
=20
-test_expect_success 'git branch -M baz bam should add entries to .git/logs=
/HEAD' '
-	msg=3D"Branch: renamed refs/heads/baz to refs/heads/bam" &&
-	grep " $ZERO_OID.*$msg$" .git/logs/HEAD &&
-	grep "^$ZERO_OID.*$msg$" .git/logs/HEAD
+test_expect_success 'git branch -M baz bam should add entries to HEAD refl=
og' '
+	git reflog show HEAD >actual &&
+	grep "HEAD@{0}: Branch: renamed refs/heads/baz to refs/heads/bam" actual
 '
=20
 test_expect_success 'git branch -M should leave orphaned HEAD alone' '
@@ -228,7 +227,7 @@ test_expect_success 'git branch -M should leave orphane=
d HEAD alone' '
 test_expect_success 'resulting reflog can be shown by log -g' '
 	oid=3D$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-	HEAD@{0} $oid $msg
+	HEAD@{0} $oid Branch: renamed refs/heads/baz to refs/heads/bam
 	HEAD@{2} $oid checkout: moving from foo to baz
 	EOF
 	git log -g --format=3D"%gd %H %gs" -2 HEAD >actual &&
@@ -702,7 +701,8 @@ test_expect_success 'git branch -C c1 c2 should succeed=
 when c1 is checked out'
=20
 test_expect_success 'git branch -C c1 c2 should never touch HEAD' '
 	msg=3D"Branch: copied refs/heads/c1 to refs/heads/c2" &&
-	! grep "$msg$" .git/logs/HEAD
+	git reflog HEAD >actual &&
+	! grep "$msg$" actual
 '
=20
 test_expect_success 'git branch -C main should work when main is checked o=
ut' '
@@ -1143,14 +1143,14 @@ test_expect_success '--set-upstream-to notices an e=
rror to set branch as own ups
=20
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
-$ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +000=
0	branch: Created from main
+$HEAD refs/heads/g/h/i@{0}: branch: Created from main
 EOF
 test_expect_success 'git checkout -b g/h/i -l should create a branch and a=
 log' '
 	GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
 	git checkout -b g/h/i -l main &&
 	test_ref_exists refs/heads/g/h/i &&
-	test_path_is_file .git/logs/refs/heads/g/h/i &&
-	test_cmp expect .git/logs/refs/heads/g/h/i
+	git reflog show --no-abbrev-commit refs/heads/g/h/i >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success 'checkout -b makes reflog by default' '
--=20
2.42.0


--4yrJS40J3WgPFhOq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVDYfwACgkQVbJhu7ck
PpRhJxAAntjQGeAecPBxPtYzUuVCUCi0is8cgvlmSfeiYsBEkKbfAPBD4pBjtfFd
+G2RcXjmkof+TJVyA1CSXdfuhHhxuKb4nZLbM9L64UPtaHMhLquerk9nBZHMjrx8
wna31K6jUlKExaLR3JoiGAlk2npaOQknuTma8Dju+uesiTbjbid7uEIh3OQY4C2o
IBYdtfzGeoMo/RKv+7wQQM0o8XqasCVfs7L02assr0CHVG0dgaooaYKimNLaq7iF
Qp3XH5Eq04/AaT1xLoJmcJRzh4YAgBtHxvXBCLNRZcI7ZteVBueUV4oOYFIEKbgV
j6VoIeFiMOdkMPOac+Oy4cA4ViFDo9sTaX+D3TmY3hBfE/qIEgRWPGOjgpqcS0k1
uzF5y/kSZ2SyiBGcqPrbrt/l0Pq5MY/yIiNT6ctoqzr3d/2a3+ax3YuR6h6KaSiv
Ui2mov6b+PD48UmquaKodA6H75aHJg3FotAi5/2d6XVthksBTyZOknlu5VnixVWW
Ctxh3HqZgrpNExlrVmN9GVusfv0k4Z407VJFqHMFp7nLcMNeG7aP8lEQcAE6VnZ1
f1D41FDc2ZplRCr2c0Qj2qRx1PRinp9s8F2zxOLmVKyOCJGvsEaacF5I9eYodahm
JxKHsK6GzzsKxm64M7HJ2GTwt3mcO6luYL90adR8CurcdaUu/tk=
=zErF
-----END PGP SIGNATURE-----

--4yrJS40J3WgPFhOq--
