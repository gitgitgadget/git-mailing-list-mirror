Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EDC2C86E
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KWe6FDP3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KvwM+Cfn"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC2F128
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 07:05:06 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id A7EAB3200A8F;
	Tue, 24 Oct 2023 10:05:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 24 Oct 2023 10:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698156305; x=1698242705; bh=qy
	QFOFqQtyyLibNmMF87Y63XIVE7SXR2lM0PUL42Qh4=; b=KWe6FDP3BiRyCcUu7X
	u4KnVEM2tHIdO2EdBD8VsSUDANda7amcP8Sl/aa36KpxXFviNG32VEic8VI5jN2/
	zrUKIqcov+L8M3pKvCRxYR+51IWJHo2I7dcfdbb9w5h1qA5ZjKFe6u6DA1tHUHLF
	Tmm6aZQSUsC8Ctq7hZmdpM9l8nQEd8h1JxfhdmmvZfnNkxG9ng2cuYmphOXaBkMp
	5gcldxIL+x1av7N2XOIrlRx1tQNfaSCYbS8j2dAczJ/r/QgIJ3+TeszyJ5UFGMfX
	TRoTQ7NiGJhqw8vnogEEo3IdiyTgUKjZ5P1opBtjz8kdQMmFOofRW9ypZtkOAWO1
	f9Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698156305; x=1698242705; bh=qyQFOFqQtyyLi
	bNmMF87Y63XIVE7SXR2lM0PUL42Qh4=; b=KvwM+CfnBtJSsKQy66s6e4VUVc/rk
	ygtkFsVyneEiz32aNON0ncc2Gfhm5NRxxip/CeoTU/cqrDLYq4xzqJJgkXxk3ziJ
	YCax71qEL9G3ScXVJm3WFeer0SPNG2vARhXA22R0QoGHkVfWzUxHFhKSxwxCFg8b
	w3BYAW9DjVrjRbE0K6C1fj3+09UPDAXWEjt5f6hq50uIyuw80IgCWb+IjnRpE5d4
	FqlcEmLrIh12Y3ahRLkp1d/PwcS7AxaQqSwUWwf5vfboIX7bh96D33obaCpWoIFP
	8Gj0skO3otUztAlswoEvxBtEtF89T5b2UUn3+L/7CzhHGTym8K+xBqJKg==
X-ME-Sender: <xms:EM83ZT6IdndB4kGusZW8ehwnHs2n0lchY1BxPRf-KeCZYkYDPa8PAQ>
    <xme:EM83ZY7S_QBZKM5APVMY3Bjdbzw2jjQepl5x3ckPWoekW0CPT7t2avO17WQVhxJvZ
    1BqyQifTaZMgIiSRQ>
X-ME-Received: <xmr:EM83ZaeShq0Omnxdi65BhKDWzATb8LhZj2wgxZs8r67lz1pZmLuLJgo8dokzB2YWE59GkeH2PrjIdf0BhhWeIZZIhKlju7TLWEU4g0d--xSL6PM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Ec83ZULn5RIxRVwSWjqzzsQGvVv1MiapNTb37ejE4FAjZV9tVKVeoA>
    <xmx:Ec83ZXKHxEIPUWQssnBXXkM0omyq1bO-uTtIXH2tvby9ik9rYL3Elg>
    <xmx:Ec83ZdyzXDk65WDo1L-MOXNcWjhi3hGm2BjdvTw-73-PllCO3uXE0w>
    <xmx:Ec83Zf04HYGtO5LWoQpkmwIfsxYXXmt8QKgiKTkRrNMWhnBLs0Zm8Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 10:05:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b331e5cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 14:04:59 +0000 (UTC)
Date: Tue, 24 Oct 2023 16:05:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/9] t: convert tests to not access symrefs via the
 filesystem
Message-ID: <048583ed2c3bd70fb455b9355c6b9030a7ca77cb.1698156169.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
 <cover.1698156169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rJhKvOvNe6hYufvn"
Content-Disposition: inline
In-Reply-To: <cover.1698156169.git.ps@pks.im>


--rJhKvOvNe6hYufvn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of our tests access symbolic references via the filesystem
directly. While this works with the current files reference backend, it
this will break once we have a second reference backend in our codebase.

Refactor these tests to instead use git-symbolic-ref(1) or our
`ref-store` test tool. The latter is required in some cases where safety
checks of git-symbolic-ref(1) would otherwise reject writing a symbolic
reference.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1400-update-ref.sh              |  8 ++++----
 t/t1430-bad-ref-name.sh            | 12 ++++++------
 t/t1450-fsck.sh                    |  4 ++--
 t/t3200-branch.sh                  |  9 ++++++---
 t/t4013-diff-various.sh            |  2 +-
 t/t4202-log.sh                     |  2 +-
 t/t5605-clone-local.sh             |  2 +-
 t/t5702-protocol-v2.sh             | 24 ++++++++++++++++++------
 t/t9133-git-svn-nested-git-repo.sh |  2 +-
 9 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 91cc6dff724..51a8d0bba98 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -221,15 +221,15 @@ test_expect_success 'delete symref without dereferenc=
e when the referred ref is
 test_expect_success 'update-ref -d is not confused by self-reference' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF ref=
s/heads/self" &&
 	git symbolic-ref refs/heads/self refs/heads/self &&
-	test_path_is_file .git/refs/heads/self &&
+	git symbolic-ref --no-recurse refs/heads/self &&
 	test_must_fail git update-ref -d refs/heads/self &&
-	test_path_is_file .git/refs/heads/self
+	git symbolic-ref --no-recurse refs/heads/self
 '
=20
 test_expect_success 'update-ref --no-deref -d can delete self-reference' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF ref=
s/heads/self" &&
 	git symbolic-ref refs/heads/self refs/heads/self &&
-	test_path_is_file .git/refs/heads/self &&
+	git symbolic-ref --no-recurse refs/heads/self &&
 	git update-ref --no-deref -d refs/heads/self &&
 	test_must_fail git show-ref --verify -q refs/heads/self
 '
@@ -239,7 +239,7 @@ test_expect_success 'update-ref --no-deref -d can delet=
e reference to bad ref' '
 	test_when_finished "rm -f .git/refs/heads/bad" &&
 	git symbolic-ref refs/heads/ref-to-bad refs/heads/bad &&
 	test_when_finished "git update-ref -d refs/heads/ref-to-bad" &&
-	test_path_is_file .git/refs/heads/ref-to-bad &&
+	git symbolic-ref --no-recurse refs/heads/ref-to-bad &&
 	git update-ref --no-deref -d refs/heads/ref-to-bad &&
 	test_must_fail git show-ref --verify -q refs/heads/ref-to-bad
 '
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index ff1c967d550..7d2dfc97256 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -164,9 +164,9 @@ test_expect_success 'rev-parse skips symref pointing to=
 broken name' '
 test_expect_success 'for-each-ref emits warnings for broken names' '
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_s=
ha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...ref" &&
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test-tool ref-store main create-symref refs/heads/badname refs/heads/brok=
en...ref &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/badname" &&
-	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
+	test-tool ref-store main create-symref refs/heads/broken...symref refs/he=
ads/main &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...symref" &&
 	git for-each-ref >output 2>error &&
 	! grep -e "broken\.\.\.ref" output &&
@@ -252,7 +252,7 @@ test_expect_success 'update-ref -d can delete broken na=
me through symref' '
 '
=20
 test_expect_success 'update-ref --no-deref -d can delete symref with broke=
n name' '
-	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
+	test-tool ref-store main create-symref refs/heads/broken...symref refs/he=
ads/main &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...symref" &&
 	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
@@ -261,7 +261,7 @@ test_expect_success 'update-ref --no-deref -d can delet=
e symref with broken name
 '
=20
 test_expect_success 'branch -d can delete symref with broken name' '
-	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
+	test-tool ref-store main create-symref refs/heads/broken...symref refs/he=
ads/main &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...symref" &&
 	git branch -d broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
@@ -270,7 +270,7 @@ test_expect_success 'branch -d can delete symref with b=
roken name' '
 '
=20
 test_expect_success 'update-ref --no-deref -d can delete dangling symref w=
ith broken name' '
-	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
+	test-tool ref-store main create-symref refs/heads/broken...symref refs/he=
ads/idonotexist &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...symref" &&
 	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
@@ -279,7 +279,7 @@ test_expect_success 'update-ref --no-deref -d can delet=
e dangling symref with br
 '
=20
 test_expect_success 'branch -d can delete dangling symref with broken name=
' '
-	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
+	test-tool ref-store main create-symref refs/heads/broken...symref refs/he=
ads/idonotexist &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...symref" &&
 	git branch -d broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index f55b539b083..a3c97b9c7fc 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -133,7 +133,7 @@ test_expect_success 'HEAD link pointing at a funny obje=
ct' '
=20
 test_expect_success 'HEAD link pointing at a funny place' '
 	test_when_finished "git update-ref --no-deref HEAD $orig_head" &&
-	echo "ref: refs/funny/place" >.git/HEAD &&
+	test-tool ref-store main create-symref HEAD refs/funny/place &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail env GIT_DIR=3D.git git fsck 2>out &&
 	test_i18ngrep "HEAD points to something strange" out
@@ -169,7 +169,7 @@ test_expect_success 'other worktree HEAD link pointing =
at missing object' '
 test_expect_success 'other worktree HEAD link pointing at a funny place' '
 	test_when_finished "rm -rf .git/worktrees other" &&
 	git worktree add other &&
-	echo "ref: refs/funny/place" >.git/worktrees/other/HEAD &&
+	git -C other symbolic-ref HEAD refs/funny/place &&
 	test_must_fail git fsck 2>out &&
 	test_i18ngrep "worktrees/other/HEAD points to something strange" out
 '
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 080e4f24a6e..7d9393f190d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -212,10 +212,13 @@ test_expect_success 'git branch -M should leave orpha=
ned HEAD alone' '
 		cd orphan &&
 		test_commit initial &&
 		git checkout --orphan lonely &&
-		grep lonely .git/HEAD &&
+		git symbolic-ref HEAD >expect &&
+		echo refs/heads/lonely >actual &&
+		test_cmp expect actual &&
 		test_path_is_missing .git/refs/head/lonely &&
 		git branch -M main mistress &&
-		grep lonely .git/HEAD
+		git symbolic-ref HEAD >expect &&
+		test_cmp expect actual
 	)
 '
=20
@@ -806,7 +809,7 @@ test_expect_success 'deleting a symref' '
=20
 test_expect_success 'deleting a dangling symref' '
 	git symbolic-ref refs/heads/dangling-symref nowhere &&
-	test_path_is_file .git/refs/heads/dangling-symref &&
+	git symbolic-ref --no-recurse refs/heads/dangling-symref &&
 	echo "Deleted branch dangling-symref (was nowhere)." >expect &&
 	git branch -d dangling-symref >actual &&
 	test_path_is_missing .git/refs/heads/dangling-symref &&
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5de1d190759..5abbea36b39 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -514,7 +514,7 @@ test_expect_success 'log -S requires an argument' '
 '
=20
 test_expect_success 'diff --cached on unborn branch' '
-	echo ref: refs/heads/unborn >.git/HEAD &&
+	git symbolic-ref HEAD refs/heads/unborn &&
 	git diff --cached >result &&
 	process_diffs result >actual &&
 	process_diffs "$TEST_DIRECTORY/t4013/diff.diff_--cached" >expected &&
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index af4a123cd22..57b298a4e22 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -2265,7 +2265,7 @@ test_expect_success REFFILES 'log diagnoses bogus HEA=
D hash' '
=20
 test_expect_success REFFILES 'log diagnoses bogus HEAD symref' '
 	git init empty &&
-	echo "ref: refs/heads/invalid.lock" > empty/.git/HEAD &&
+	test-tool -C empty ref-store main create-symref HEAD refs/heads/invalid.l=
ock &&
 	test_must_fail git -C empty log 2>stderr &&
 	test_i18ngrep broken stderr &&
 	test_must_fail git -C empty log --default totally-bogus 2>stderr &&
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index 1d7b1abda1a..a26689de379 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -65,7 +65,7 @@ test_expect_success 'Even without -l, local will make a h=
ardlink' '
 '
=20
 test_expect_success 'local clone of repo with nonexistent ref in HEAD' '
-	echo "ref: refs/heads/nonexistent" > a.git/HEAD &&
+	git -C a.git symbolic-ref HEAD refs/heads/nonexistent &&
 	git clone a d &&
 	(cd d &&
 	git fetch &&
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 6af5c2062fd..dcc4cd95fe7 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -221,7 +221,9 @@ test_expect_success 'clone of empty repo propagates nam=
e of default branch' '
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3D \
 	git -c init.defaultBranch=3Dmain -c protocol.version=3D2 \
 		clone "file://$(pwd)/file_empty_parent" file_empty_child &&
-	grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD
+	echo refs/heads/mydefaultbranch >expect &&
+	git -C file_empty_child symbolic-ref HEAD >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success '...but not if explicitly forbidden by config' '
@@ -234,7 +236,9 @@ test_expect_success '...but not if explicitly forbidden=
 by config' '
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3D \
 	git -c init.defaultBranch=3Dmain -c protocol.version=3D2 \
 		clone "file://$(pwd)/file_empty_parent" file_empty_child &&
-	! grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD
+	echo refs/heads/main >expect &&
+	git -C file_empty_child symbolic-ref HEAD >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success 'bare clone propagates empty default branch' '
@@ -247,7 +251,9 @@ test_expect_success 'bare clone propagates empty defaul=
t branch' '
 	git -c init.defaultBranch=3Dmain -c protocol.version=3D2 \
 		clone --bare \
 		"file://$(pwd)/file_empty_parent" file_empty_child.git &&
-	grep "refs/heads/mydefaultbranch" file_empty_child.git/HEAD
+	echo "refs/heads/mydefaultbranch" >expect &&
+	git -C file_empty_child.git symbolic-ref HEAD >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success 'clone propagates unborn HEAD from non-empty repo' '
@@ -265,7 +271,9 @@ test_expect_success 'clone propagates unborn HEAD from =
non-empty repo' '
 	git -c init.defaultBranch=3Dmain -c protocol.version=3D2 \
 		clone "file://$(pwd)/file_unborn_parent" \
 		file_unborn_child 2>stderr &&
-	grep "refs/heads/mydefaultbranch" file_unborn_child/.git/HEAD &&
+	echo "refs/heads/mydefaultbranch" >expect &&
+	git -C file_unborn_child symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
 	grep "warning: remote HEAD refers to nonexistent ref" stderr
 '
=20
@@ -295,7 +303,9 @@ test_expect_success 'bare clone propagates unborn HEAD =
=66rom non-empty repo' '
 	git -c init.defaultBranch=3Dmain -c protocol.version=3D2 \
 		clone --bare "file://$(pwd)/file_unborn_parent" \
 		file_unborn_child.git 2>stderr &&
-	grep "refs/heads/mydefaultbranch" file_unborn_child.git/HEAD &&
+	echo "refs/heads/mydefaultbranch" >expect &&
+	git -C file_unborn_child.git symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
 	! grep "warning:" stderr
 '
=20
@@ -315,7 +325,9 @@ test_expect_success 'defaulted HEAD uses remote branch =
if available' '
 	git -c init.defaultBranch=3Dbranchwithstuff -c protocol.version=3D2 \
 		clone "file://$(pwd)/file_unborn_parent" \
 		file_unborn_child 2>stderr &&
-	grep "refs/heads/branchwithstuff" file_unborn_child/.git/HEAD &&
+	echo "refs/heads/branchwithstuff" >expect &&
+	git -C file_unborn_child symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
 	test_path_is_file file_unborn_child/stuff.t &&
 	! grep "warning:" stderr
 '
diff --git a/t/t9133-git-svn-nested-git-repo.sh b/t/t9133-git-svn-nested-gi=
t-repo.sh
index d8d536269cf..8ca24670acb 100755
--- a/t/t9133-git-svn-nested-git-repo.sh
+++ b/t/t9133-git-svn-nested-git-repo.sh
@@ -11,7 +11,7 @@ test_expect_success 'setup repo with a git repo inside it=
' '
 	(
 		cd s &&
 		git init &&
-		test -f .git/HEAD &&
+		git symbolic-ref HEAD &&
 		> .git/a &&
 		echo a > a &&
 		svn_cmd add .git a &&
--=20
2.42.0


--rJhKvOvNe6hYufvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3zw0ACgkQVbJhu7ck
PpRMpQ//aiXDRCzy8wxyQRk4Ss8x2Su8OvdaxAstw2ZWAd2zVXHGDfl7BC7HJmhL
zW62BaXVVYwlpWdWmOcHXMdg1nSqgZMj/GNZc9YAZ+dur2IvPvSo9iHXmONsMQT6
LutKJwszDgBxjjV96lXFlgaZimcmEy19wofuzxL840k1tO6Ct0bP1ZYOaRYni09b
d76GUsvRSibordqU43pOHCb7yPbehTzSh/01hoztFWpG7EJMo3c3MjltyTVXnLyQ
gxwEsAYSXTK/Hg5kWUofCRqcDc3iqdJOWOeKuiZJt2aBbtUbGTh7JG7xH8+G3sM7
vcGC/i9suErbxK6VPZkp8TYPALde7634vCRow6hfcTho9Hm6NHMt6Hhg6cOiODIr
x3EiAWQyACCArLOb0uwVXd1GWB6sL/X6ZPE20CP8rPPyzLo3e3D1o9jRd3LM1e1B
ZnCozhpyaV+iB1CKpobr/6gSkhIEl/7UXhqjhWz55VtloZuKV3pvLSNIwBJTKFza
mrjj9/Jb4z6M6wlNYnxdE/V5ad5CML9h1pIpD7F6hOpoGeQM0Gbv+lwMVf3XqleQ
we9gbDmGBsbFu0SEt4FH/7hHzDoJrMmfOcsqvjd0RmMaG3ggaQ3kRAWWnUo4MWcd
hEBw5ybo97fbdSsSUosAvnNlXQiRh6XU4I2yOPFoYImc3PajiWs=
=9xuy
-----END PGP SIGNATURE-----

--rJhKvOvNe6hYufvn--
