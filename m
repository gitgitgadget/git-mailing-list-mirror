Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E3B2941C
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TlP+T933";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sXm2i5Qe"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B513129
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 06:11:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id B02863200946;
	Tue, 24 Oct 2023 09:11:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 24 Oct 2023 09:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698153092; x=1698239492; bh=zz
	OH5ueITiZTBr1TZ6jNHry3ZIaZVc9wnVkZyZ5d64g=; b=TlP+T933/ltJdnPX4S
	mrJ/az6XF0kIwXRAML0pkLRs6zNK8B4n8OHOE2OWjK0CdIwy0ceUZEstFsf5JS4r
	CGXqsMfSF0ho91VPYXBvuXaNAgZ0DMQIKAOsFCcbKns9cxrfFqnA0ikZH8BevmPR
	SAy5c5uCSDwWNDiIkE5+X3T8CVbCuatyNdbXZu4ku3LDo2+LW6QP2MiMKTSO3/i/
	D3IqozCHHCn+c0FDDV8yz1WV7U3NP8sILIyU1OGBJDJwFKFbPcK1STRRnDXNLGva
	Esr6s0vsEhtFxcy1xnO3WaS50GVi3pE0GxPr+79WjH/eHOfjRPjREoAvqesBPai1
	qoMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698153092; x=1698239492; bh=zzOH5ueITiZTB
	r1TZ6jNHry3ZIaZVc9wnVkZyZ5d64g=; b=sXm2i5Qe551annuRcKZJ6wY/cleSI
	BPLH6TQltcv/b09mMgT1voznxorMtpgE+x34UqsffKlYUAiE3fygwxPIUQ0LUATJ
	Wq1BiFYcFGOqlv+3XKgvHOIEC4fD1GNJbS+niS0ekg1qZD3uI5u7RR9QibT5FL22
	4VHx1R04pOSbtmu5a09Ubj0+LwPMy7jo3ORycpPaIfqZAILygXFKDY4+/+qh3Q5N
	AUyt2cUqnApDoMHkErSORmJxgqoDlndgMEuP94T0GAo46M7bkz02YOjviTYMD4pI
	ZaeuONOyDuy6lufas9NFN2iEFkh2903NOmRF6obgbdDi9M94oRmQh37vA==
X-ME-Sender: <xms:g8I3ZVgLve8Y857qAxpmkOcjiLTtF2nU-EIwEgN9G70XEBu7MUu-9A>
    <xme:g8I3ZaAAxfhnvym5Y2ckHEYLt9RbxBjCXLYCB9UpgPpi3ZHBgJ6vpJVdBAO5zb04A
    ob-lxkBoYp6kxhSZQ>
X-ME-Received: <xmr:g8I3ZVFcUTVtE0yvgYSD7I_f9d60l1Di_JUpHejKTBt1FNmde4QiNXOmJQmKdXgimte6S2NGtmBZi-qg9GfmFZbF_pcqAODYThiBdz608efWGwM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:hMI3ZaSAJGp5qHuKyQaE6UeJo2XUhI_duazVZ92N2_-zkXM3dKwKiQ>
    <xmx:hMI3ZSzikQgarSQhV5HwkbR-0gv38j_OaN5MC2ogYhz2A9gCp8tLxw>
    <xmx:hMI3ZQ5xx-A94wzuU2tTkaay8a5RT7QdN2LyDa_Ax6yxzh-aZxMnlg>
    <xmx:hMI3Zd-IbnebGZKtWky48bXfW5oGyiI0vWn5T5ZKQi6pcV-naSIHVA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 09:11:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4041d07e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 13:11:26 +0000 (UTC)
Date: Tue, 24 Oct 2023 15:11:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 12/12] t: use git-show-ref(1) to check for ref existence
Message-ID: <a3a43d82e1f713c51d2ef7ee332dbf653cdbbf1d.1698152926.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MM6kN4DCJ3RokskW"
Content-Disposition: inline
In-Reply-To: <cover.1698152926.git.ps@pks.im>


--MM6kN4DCJ3RokskW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Convert tests that use `test_path_is_file` and `test_path_is_missing` to
instead use a set of helpers `test_ref_exists` and `test_ref_missing`.
These helpers are implemented via the newly introduced `git show-ref
--exists` command. Thus, we can avoid intimate knowledge of how the ref
backend stores references on disk.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1430-bad-ref-name.sh | 27 +++++++++++++-------
 t/t3200-branch.sh       | 33 ++++++++++++++-----------
 t/t5521-pull-options.sh |  4 +--
 t/t5605-clone-local.sh  |  2 +-
 t/test-lib-functions.sh | 55 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 94 insertions(+), 27 deletions(-)

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
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2f8868caa17..56b33536ed1 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -251,6 +251,61 @@ debug () {
 	done
 }
=20
+# Usage: test_ref_exists [options] <ref>
+#
+#   -C <dir>:
+#      Run all git commands in directory <dir>
+#
+# This helper function checks whether a reference exists. Symrefs or objec=
t IDs
+# will not be resolved. Can be used to check references with bad names.
+test_ref_exists () {
+	local indir=3D
+
+	while test $# !=3D 0
+	do
+		case "$1" in
+		-C)
+			indir=3D"$2"
+			shift
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done &&
+
+	indir=3D${indir:+"$indir"/} &&
+
+	if test "$#" !=3D 1
+	then
+		BUG "expected exactly one reference"
+	fi &&
+
+	git ${indir:+ -C "$indir"} show-ref --exists "$1"
+}
+
+# Behaves the same as test_ref_exists, except that it checks for the absen=
ce of
+# a reference. This is preferable to `! test_ref_exists` as this function =
is
+# able to distinguish actually-missing references from other, generic erro=
rs.
+test_ref_missing () {
+	test_ref_exists "$@"
+	case "$?" in
+	2)
+		# This is the good case.
+		return 0
+		;;
+	0)
+		echo >&4 "test_ref_missing: reference exists"
+		return 1
+		;;
+	*)
+		echo >&4 "test_ref_missing: generic error"
+		return 1
+		;;
+	esac
+}
+
 # Usage: test_commit [options] <message> [<file> [<contents> [<tag>]]]
 #   -C <dir>:
 #	Run all git commands in directory <dir>
--=20
2.42.0


--MM6kN4DCJ3RokskW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3woAACgkQVbJhu7ck
PpSIeg//Ta2WMCRzCfblF2XYTa3VXI1XZZdwHrV8HFLBIxRwnGl1ew2K1azD0TQF
KbnLDWIbOkIP25FnkOtGZ844fg3vRig9Bt+X/AN/DEnjXo0RBGjqREHxNafg9wz4
YZJZWz45px4gF2BDRtA0kN8SXJMMTht3LXfAEBRyt3TWzejYQUTz0AHXUC2xPxCv
4tRAdWiKKUV5NUJZSZ1Inu09FjJcN8V6+N3t5d9znr7PyYqKrbMeL6D7KMpnhsg2
BZ0tmPfeSGbDrE/UheFMEWxOVCyvp0iG2QGoMKkiXNGJMjipjYv36g3s6EV3GUSZ
qz2ilRVkcL+7qsUmvl9zbVt2C6Obf7q187//e04Wm91PJ4ra/ubKVgTEIXzzBsb+
NmuT+DaJmL2tuk8fOEnYzPFhfd+EhcR47vSL5Op5oYba6WIbEfW7IT8dJ9WLq8z6
kbmFfP6ogeMpOlx4Cvb7q6LUw/6kBeHQy210LVcLoUZM50zslGxzLJgI1ghcrJOY
jlQYAIohLJZ3mRBQ6v75ckLBa+d3vl8NpUN63etu0qXIWdgyDV5F3E8jcHY+YRJF
KzjAAJiabOz5X85Qcy8SniRDoHcAKbDrwy+NHUup256F2MBTRcdiUnoznCMCS9av
Me/oGsigQCm80dK4NqWi3FANLSZJ91KwaRbuMLg33KYVE5Iwi5E=
=pl9D
-----END PGP SIGNATURE-----

--MM6kN4DCJ3RokskW--
