Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E0F947E
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="byjVLzaJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U19N+mBm"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FA5C6
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:35:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id BD08F3200B01;
	Wed, 18 Oct 2023 01:35:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 18 Oct 2023 01:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697607319; x=1697693719; bh=BO
	lpV759OkrtsAxRiXnmXXOntEJ9/wMVqgpw4GDwAQ0=; b=byjVLzaJ2gPFHWcqZI
	wrJbCWXxculnbtEYXkDX/8vJAV4QmBwufCWNqoJsFXDtIBU4PrGiwgh0SWi8JEHJ
	xyjAc3E4Ax8hiN+d6xzN3RR4TKp/GXSvG4jcntGRF3pUlGcDbZHQ5K6GSjCLtz4z
	DVeGBTTsMo6Rk7qSKay0KRTl3pj9J5i9zVCMvWabz2v2XvE9HkPlvkOkZIi/M5UG
	9aec5A/UpI8r4gdnGnqBop/pd13D+kMDsO47w9KN17WXAuhnncXECXPIwlw7szBQ
	ZI1rYZ8NLWwMEaJimpZdEc830h0MuUwi+vcq8tEhZnKuDETsY3dU+l/zdeLip3Hv
	EBMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697607319; x=1697693719; bh=BOlpV759Okrts
	AxRiXnmXXOntEJ9/wMVqgpw4GDwAQ0=; b=U19N+mBm5Lu2zuDDvMIXyOleWrYEp
	IDyV+jrS0XwFQk9kqweplTxDlJRC/YIbuBHeUx25CLECCqWBWIMmHSgq15aLw4Wz
	rbJBvPpsX7mUTzOrD6C0xiY2Pk9U195Jjjfu/PUU0twMf5jR6RhK2lL+3JLiJ86h
	RBK1ALn4DWvKt4VoHW96+nRHFmDlGpR0doK1Xz9Nf4W+9DF8QJewTkkua10kxCXH
	mFSmLo+J2Io7XcrhjEjOzhDnJzfH+/jTEL0oeqqfEDcqowYgZL7cX9uLQxvpK07J
	uaCOVQe7oaFloFENqkI3znv9gameH6W8vDNMAJGm8rtmOF/fxJruZ+Zmg==
X-ME-Sender: <xms:l24vZXsoTc7d547T1asyvMGcAZBaIIhnmRJt76Z_VJmLL_vjl01MgA>
    <xme:l24vZYfakmwuRf_KPyXgjjkflL1zA8wWp0ixOFYTL64qE1eU7UAGPeV-MSN8j2s24
    gxdx9v6zZlHzYQPqQ>
X-ME-Received: <xmr:l24vZaytsKgYrc59wmkPfegPilvuTOWOPl__9N4fxV0HCYxKaig45aFqJFFnrEHfxP18oDx2i4vReo-i-CRuMhAqRBkkIOBuaFtc1iGgkwThnPMP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeefgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:l24vZWPmtRZom3gePHE-rIx-TzykhPlvyqRNxAPZvLrMNWMgTq-oUQ>
    <xmx:l24vZX_O95HlGAA90PYy17c5cGd9n0IG8wdgRIlimFjc9S5pbSJ_-w>
    <xmx:l24vZWWiA8qopETx5SGW3OyyNnUMqxeHQxwp4UjOcGMZNcUjchi3xQ>
    <xmx:l24vZUFUzZAIM1gueMrlabqnvcvai8Q6bV2Rr8-jYEqXkRBbw9j3vA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 01:35:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 90c54472 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Oct 2023 05:35:17 +0000 (UTC)
Date: Wed, 18 Oct 2023 07:35:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 03/11] t: convert tests to use helpers for reference existence
Message-ID: <ac6a49c7c84ad2b836f099557dd6989703ebda8f.1697607222.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nFm+D2i2K7hdSTnh"
Content-Disposition: inline
In-Reply-To: <cover.1697607222.git.ps@pks.im>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--nFm+D2i2K7hdSTnh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Convert tests that use `test_path_is_file` and `test_path_is_missing` to
instead use our new helpers `test_ref_exists` and `test_ref_missing`.
These hook into the reference database directly and thus work indepently
of the actual reference backend that is being used.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1430-bad-ref-name.sh | 27 ++++++++++++++++++---------
 t/t3200-branch.sh       | 33 ++++++++++++++++++---------------
 t/t5521-pull-options.sh |  4 ++--
 t/t5605-clone-local.sh  |  2 +-
 4 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index ff1c967d550..7b7d6953c62 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -205,8 +205,9 @@ test_expect_success 'update-ref --no-deref -d can delet=
e symref to broken name'
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...ref" &&
 	test-tool ref-store main create-symref refs/heads/badname refs/heads/brok=
en...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/badname" &&
+	test_ref_exists refs/heads/badname &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
-	test_path_is_missing .git/refs/heads/badname &&
+	test_ref_missing refs/heads/badname &&
 	test_must_be_empty output &&
 	test_must_be_empty error
 '
@@ -216,8 +217,9 @@ test_expect_success 'branch -d can delete symref to bro=
ken name' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...ref" &&
 	test-tool ref-store main create-symref refs/heads/badname refs/heads/brok=
en...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/badname" &&
+	test_ref_exists refs/heads/badname &&
 	git branch -d badname >output 2>error &&
-	test_path_is_missing .git/refs/heads/badname &&
+	test_ref_missing refs/heads/badname &&
 	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" o=
utput &&
 	test_must_be_empty error
 '
@@ -225,8 +227,9 @@ test_expect_success 'branch -d can delete symref to bro=
ken name' '
 test_expect_success 'update-ref --no-deref -d can delete dangling symref t=
o broken name' '
 	test-tool ref-store main create-symref refs/heads/badname refs/heads/brok=
en...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/badname" &&
+	test_ref_exists refs/heads/badname &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
-	test_path_is_missing .git/refs/heads/badname &&
+	test_ref_missing refs/heads/badname &&
 	test_must_be_empty output &&
 	test_must_be_empty error
 '
@@ -234,8 +237,9 @@ test_expect_success 'update-ref --no-deref -d can delet=
e dangling symref to brok
 test_expect_success 'branch -d can delete dangling symref to broken name' '
 	test-tool ref-store main create-symref refs/heads/badname refs/heads/brok=
en...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/badname" &&
+	test_ref_exists refs/heads/badname &&
 	git branch -d badname >output 2>error &&
-	test_path_is_missing .git/refs/heads/badname &&
+	test_ref_missing refs/heads/badname &&
 	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" o=
utput &&
 	test_must_be_empty error
 '
@@ -245,8 +249,9 @@ test_expect_success 'update-ref -d can delete broken na=
me through symref' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...ref" &&
 	test-tool ref-store main create-symref refs/heads/badname refs/heads/brok=
en...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/badname" &&
+	test_ref_exists refs/heads/broken...ref &&
 	git update-ref -d refs/heads/badname >output 2>error &&
-	test_path_is_missing .git/refs/heads/broken...ref &&
+	test_ref_missing refs/heads/broken...ref &&
 	test_must_be_empty output &&
 	test_must_be_empty error
 '
@@ -254,8 +259,9 @@ test_expect_success 'update-ref -d can delete broken na=
me through symref' '
 test_expect_success 'update-ref --no-deref -d can delete symref with broke=
n name' '
 	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...symref" &&
+	test_ref_exists refs/heads/broken...symref &&
 	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
-	test_path_is_missing .git/refs/heads/broken...symref &&
+	test_ref_missing refs/heads/broken...symref &&
 	test_must_be_empty output &&
 	test_must_be_empty error
 '
@@ -263,8 +269,9 @@ test_expect_success 'update-ref --no-deref -d can delet=
e symref with broken name
 test_expect_success 'branch -d can delete symref with broken name' '
 	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...symref" &&
+	test_ref_exists refs/heads/broken...symref &&
 	git branch -d broken...symref >output 2>error &&
-	test_path_is_missing .git/refs/heads/broken...symref &&
+	test_ref_missing refs/heads/broken...symref &&
 	test_i18ngrep "Deleted branch broken...symref (was refs/heads/main)" outp=
ut &&
 	test_must_be_empty error
 '
@@ -272,8 +279,9 @@ test_expect_success 'branch -d can delete symref with b=
roken name' '
 test_expect_success 'update-ref --no-deref -d can delete dangling symref w=
ith broken name' '
 	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...symref" &&
+	test_ref_exists refs/heads/broken...symref &&
 	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
-	test_path_is_missing .git/refs/heads/broken...symref &&
+	test_ref_missing refs/heads/broken...symref &&
 	test_must_be_empty output &&
 	test_must_be_empty error
 '
@@ -281,8 +289,9 @@ test_expect_success 'update-ref --no-deref -d can delet=
e dangling symref with br
 test_expect_success 'branch -d can delete dangling symref with broken name=
' '
 	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...symref" &&
+	test_ref_exists refs/heads/broken...symref &&
 	git branch -d broken...symref >output 2>error &&
-	test_path_is_missing .git/refs/heads/broken...symref &&
+	test_ref_missing refs/heads/broken...symref &&
 	test_i18ngrep "Deleted branch broken...symref (was refs/heads/idonotexist=
)" output &&
 	test_must_be_empty error
 '
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 080e4f24a6e..bde4f1485b7 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -25,7 +25,7 @@ test_expect_success 'prepare a trivial repository' '
=20
 test_expect_success 'git branch --help should not have created a bogus bra=
nch' '
 	test_might_fail git branch --man --help </dev/null >/dev/null 2>&1 &&
-	test_path_is_missing .git/refs/heads/--help
+	test_ref_missing refs/heads/--help
 '
=20
 test_expect_success 'branch -h in broken repository' '
@@ -40,7 +40,8 @@ test_expect_success 'branch -h in broken repository' '
 '
=20
 test_expect_success 'git branch abc should create a branch' '
-	git branch abc && test_path_is_file .git/refs/heads/abc
+	git branch abc &&
+	test_ref_exists refs/heads/abc
 '
=20
 test_expect_success 'git branch abc should fail when abc exists' '
@@ -61,11 +62,13 @@ test_expect_success 'git branch --force abc should succ=
eed when abc exists' '
 '
=20
 test_expect_success 'git branch a/b/c should create a branch' '
-	git branch a/b/c && test_path_is_file .git/refs/heads/a/b/c
+	git branch a/b/c &&
+	test_ref_exists refs/heads/a/b/c
 '
=20
 test_expect_success 'git branch mb main... should create a branch' '
-	git branch mb main... && test_path_is_file .git/refs/heads/mb
+	git branch mb main... &&
+	test_ref_exists refs/heads/mb
 '
=20
 test_expect_success 'git branch HEAD should fail' '
@@ -78,14 +81,14 @@ EOF
 test_expect_success 'git branch --create-reflog d/e/f should create a bran=
ch and a log' '
 	GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
 	git -c core.logallrefupdates=3Dfalse branch --create-reflog d/e/f &&
-	test_path_is_file .git/refs/heads/d/e/f &&
+	test_ref_exists refs/heads/d/e/f &&
 	test_path_is_file .git/logs/refs/heads/d/e/f &&
 	test_cmp expect .git/logs/refs/heads/d/e/f
 '
=20
 test_expect_success 'git branch -d d/e/f should delete a branch and a log'=
 '
 	git branch -d d/e/f &&
-	test_path_is_missing .git/refs/heads/d/e/f &&
+	test_ref_missing refs/heads/d/e/f &&
 	test_must_fail git reflog exists refs/heads/d/e/f
 '
=20
@@ -213,7 +216,7 @@ test_expect_success 'git branch -M should leave orphane=
d HEAD alone' '
 		test_commit initial &&
 		git checkout --orphan lonely &&
 		grep lonely .git/HEAD &&
-		test_path_is_missing .git/refs/head/lonely &&
+		test_ref_missing refs/head/lonely &&
 		git branch -M main mistress &&
 		grep lonely .git/HEAD
 	)
@@ -799,8 +802,8 @@ test_expect_success 'deleting a symref' '
 	git symbolic-ref refs/heads/symref refs/heads/target &&
 	echo "Deleted branch symref (was refs/heads/target)." >expect &&
 	git branch -d symref >actual &&
-	test_path_is_file .git/refs/heads/target &&
-	test_path_is_missing .git/refs/heads/symref &&
+	test_ref_exists refs/heads/target &&
+	test_ref_missing refs/heads/symref &&
 	test_cmp expect actual
 '
=20
@@ -809,16 +812,16 @@ test_expect_success 'deleting a dangling symref' '
 	test_path_is_file .git/refs/heads/dangling-symref &&
 	echo "Deleted branch dangling-symref (was nowhere)." >expect &&
 	git branch -d dangling-symref >actual &&
-	test_path_is_missing .git/refs/heads/dangling-symref &&
+	test_ref_missing refs/heads/dangling-symref &&
 	test_cmp expect actual
 '
=20
 test_expect_success 'deleting a self-referential symref' '
 	git symbolic-ref refs/heads/self-reference refs/heads/self-reference &&
-	test_path_is_file .git/refs/heads/self-reference &&
+	test_ref_exists refs/heads/self-reference &&
 	echo "Deleted branch self-reference (was refs/heads/self-reference)." >ex=
pect &&
 	git branch -d self-reference >actual &&
-	test_path_is_missing .git/refs/heads/self-reference &&
+	test_ref_missing refs/heads/self-reference &&
 	test_cmp expect actual
 '
=20
@@ -826,8 +829,8 @@ test_expect_success 'renaming a symref is not allowed' '
 	git symbolic-ref refs/heads/topic refs/heads/main &&
 	test_must_fail git branch -m topic new-topic &&
 	git symbolic-ref refs/heads/topic &&
-	test_path_is_file .git/refs/heads/main &&
-	test_path_is_missing .git/refs/heads/new-topic
+	test_ref_exists refs/heads/main &&
+	test_ref_missing refs/heads/new-topic
 '
=20
 test_expect_success SYMLINKS 'git branch -m u v should fail when the reflo=
g for u is a symlink' '
@@ -1142,7 +1145,7 @@ EOF
 test_expect_success 'git checkout -b g/h/i -l should create a branch and a=
 log' '
 	GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
 	git checkout -b g/h/i -l main &&
-	test_path_is_file .git/refs/heads/g/h/i &&
+	test_ref_exists refs/heads/g/h/i &&
 	test_path_is_file .git/logs/refs/heads/g/h/i &&
 	test_cmp expect .git/logs/refs/heads/g/h/i
 '
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 079b2f2536e..3681859f983 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -143,7 +143,7 @@ test_expect_success 'git pull --dry-run' '
 		cd clonedry &&
 		git pull --dry-run ../parent &&
 		test_path_is_missing .git/FETCH_HEAD &&
-		test_path_is_missing .git/refs/heads/main &&
+		test_ref_missing refs/heads/main &&
 		test_path_is_missing .git/index &&
 		test_path_is_missing file
 	)
@@ -157,7 +157,7 @@ test_expect_success 'git pull --all --dry-run' '
 		git remote add origin ../parent &&
 		git pull --all --dry-run &&
 		test_path_is_missing .git/FETCH_HEAD &&
-		test_path_is_missing .git/refs/remotes/origin/main &&
+		test_ref_missing refs/remotes/origin/main &&
 		test_path_is_missing .git/index &&
 		test_path_is_missing file
 	)
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index 1d7b1abda1a..946c5751885 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -69,7 +69,7 @@ test_expect_success 'local clone of repo with nonexistent=
 ref in HEAD' '
 	git clone a d &&
 	(cd d &&
 	git fetch &&
-	test ! -e .git/refs/remotes/origin/HEAD)
+	test_ref_missing refs/remotes/origin/HEAD)
 '
=20
 test_expect_success 'bundle clone without .bundle suffix' '
--=20
2.42.0


--nFm+D2i2K7hdSTnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUvbpMACgkQVbJhu7ck
PpTwiBAAiopBR/Wl5SQNg1X8ud16zE71MiyI/MoAeaFcf19oOt9M8F2g5f+26dc6
jSQaZf44xTVZ9vc6iN+K/NLV6oo7h4pt9GoEyDnkjrwU8GP7Z2v8NMIEr9bPqf+b
pKT75LPmH3XkNmmvTLbfbWAs6MJRadnFQVENkNJEcvCEwa9ePgf77fqyso5Qr6ST
Yy8m4yx/ywu7xZ+wfgbGYTBQqcdTJTmJDjAkn71hswQtUmgh+ZlMQh5Nyhk4BqCf
tg0oeUsnd52G+RQCmIG23jlJmv0BAiXHi6WKXKXZj9VeRKCPxrO1OYiM2eoSZga+
Yh+JZkL3I9hPkG1I2rpRbI8WXght+emolQ2Fm1zHzUNjVUZ7zUsRZu0wtsUBGlKe
waUxep8UiQ0TAN2MqGVE4CDsXMTAwB3RqrBqpmY0+pRyjFFieQww4HnpFsIbSouH
heKgbQ0ijpGfw00e18XVlD0dhrB9E3tPhkyFRn29VEFzc7Aw3DdWhesV3xt3s3WS
ybYk7d+o9WVNgEfKr/nBc/u+zq219/hb3JEfvEUjeK/LlQj3GPDrs3OHVrl046go
TQqeyAn2aOmPR8OLKWPX33QrAEmEm/4tmWeTJ8W9/sHzYb6Akhk3iO5Xqq3C+YXv
qaSDrBNn8y1GXLZ0pQAeg+juPgNGvhlVpwzzMvZCKyOKDpAXunM=
=lKe2
-----END PGP SIGNATURE-----

--nFm+D2i2K7hdSTnh--
