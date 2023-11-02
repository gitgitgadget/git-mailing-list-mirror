Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA07474
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GaBbY/QS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pPbWh915"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF41131
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 01:46:53 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id F2CD632004ED;
	Thu,  2 Nov 2023 04:46:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 02 Nov 2023 04:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698914812; x=1699001212; bh=p6
	SY2J2sFPP+h79uJyq/1GPo9uJpcQqtdWL+0ByWyoQ=; b=GaBbY/QSTlfgCcjg18
	vwG6ZFormodzxLr8cLnirKzGqBzcrAMPh22x/+7dqygTwwctb84ztpLtLdqgYRp/
	PEKBo1V6GD4c6XnIQNHw4wCJY8aecFZ01KUvUBWiZ54ofjbePGrcJBo44tGON00v
	L/sBdh/eUXYx3GR2dT/xhsAXxObV5r7A7eJGLhkPUHD78RJ0eg0ZewqsjgDNqw5h
	Dnvqn+vsq8EPKX+Y+rkdnDTdfc4UFopDUhmyWItQChcjBz+laoGE0sWng5LYtqPe
	jfnAWEilyYoc5YjeQ5ckq/48Jcilrn0C3dLZBojJz7jqpgiuVluxwf7Of4lFYz6s
	1vkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698914812; x=1699001212; bh=p6SY2J2sFPP+h
	79uJyq/1GPo9uJpcQqtdWL+0ByWyoQ=; b=pPbWh915jv5KdSzywvPqTE+XRcOrF
	QicsC9b7+eQDq05F2ueES8W3BE6lDK0BQgKP1LAb7gYQq/amMo5mdfsMsup13xVD
	EsWRP1FSce8uN6+7x6L9KcLqyCThgbn8cRgzb4ieEHNcPSfopdkh5QhZGgwsCk9k
	A7kGQh8TMeQ/5v9KGlEpIOeC+mqJn4WC52WZ3mL0YV9I+aoh7bJv+LPHPJgRE5Zk
	tA6gigjIX2KfR0cE8IgclLZso1bBXJqwIzNFEbMOh6lqHeN2TyIFGVFHlFs5RifL
	1xLL4GHUXEcWH66fPbAkKbSIYvXvdyS4Ly+XKlIkO848PluXvfzHjyyuA==
X-ME-Sender: <xms:_GFDZYqN44jojkks5_FQ1JAkM2L-hk9LTCcz9DvBwoG3gJzARY_5sQ>
    <xme:_GFDZepbOymFCyVs2S7VfzxJXCh1EAQIo48blJ7i0snlvPV4ae3H_Rw_8tjjPix9H
    MzwjMOfT4xYpoD2DA>
X-ME-Received: <xmr:_GFDZdO28oH8CukvYjjHQ4ypJpKfGtAGvpYSbNhXdWOav66N5FKDL4ueDAuSzvhNreBqQ8hs932YZT8rokKSJuj8r-Vba5mltEcijqrWOB_SwH8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:_GFDZf7VAC7JkzD8-HtCPVZ0vum8OmDDlcpJfEy6HaNELFkKOHATbw>
    <xmx:_GFDZX4VCR0tQqT1g_42EQNIhXem9Z6woNSIMJvolNiDBotd5j8k_A>
    <xmx:_GFDZfj2Oxunh9_BCNdlUlEmaU8K6fzOs9R0TFBuiyPQEYYXg8qmPg>
    <xmx:_GFDZZlDn2Dob6u_Gc8kYfBki9pcDHpXdg7meQ9Mj-MV1b6rDZWQnw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 04:46:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eb10e1f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Nov 2023 08:46:39 +0000 (UTC)
Date: Thu, 2 Nov 2023 09:46:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/9] t: convert tests to not access symrefs via the
 filesystem
Message-ID: <d6307177132b57034d7544d49713013bdad2e891.1698914571.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
 <cover.1698914571.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jtnWMNS+po2ZYe/t"
Content-Disposition: inline
In-Reply-To: <cover.1698914571.git.ps@pks.im>


--jtnWMNS+po2ZYe/t
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
index 7b7d6953c62..5debb91f7b7 100755
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
@@ -257,7 +257,7 @@ test_expect_success 'update-ref -d can delete broken na=
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
 	test_ref_exists refs/heads/broken...symref &&
 	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
@@ -267,7 +267,7 @@ test_expect_success 'update-ref --no-deref -d can delet=
e symref with broken name
 '
=20
 test_expect_success 'branch -d can delete symref with broken name' '
-	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
+	test-tool ref-store main create-symref refs/heads/broken...symref refs/he=
ads/main &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg=
 refs/heads/broken...symref" &&
 	test_ref_exists refs/heads/broken...symref &&
 	git branch -d broken...symref >output 2>error &&
@@ -277,7 +277,7 @@ test_expect_success 'branch -d can delete symref with b=
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
 	test_ref_exists refs/heads/broken...symref &&
 	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
@@ -287,7 +287,7 @@ test_expect_success 'update-ref --no-deref -d can delet=
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
 	test_ref_exists refs/heads/broken...symref &&
 	git branch -d broken...symref >output 2>error &&
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
index bde4f1485b7..874520e3f10 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -215,10 +215,13 @@ test_expect_success 'git branch -M should leave orpha=
ned HEAD alone' '
 		cd orphan &&
 		test_commit initial &&
 		git checkout --orphan lonely &&
-		grep lonely .git/HEAD &&
+		git symbolic-ref HEAD >expect &&
+		echo refs/heads/lonely >actual &&
+		test_cmp expect actual &&
 		test_ref_missing refs/head/lonely &&
 		git branch -M main mistress &&
-		grep lonely .git/HEAD
+		git symbolic-ref HEAD >expect &&
+		test_cmp expect actual
 	)
 '
=20
@@ -809,7 +812,7 @@ test_expect_success 'deleting a symref' '
=20
 test_expect_success 'deleting a dangling symref' '
 	git symbolic-ref refs/heads/dangling-symref nowhere &&
-	test_path_is_file .git/refs/heads/dangling-symref &&
+	git symbolic-ref --no-recurse refs/heads/dangling-symref &&
 	echo "Deleted branch dangling-symref (was nowhere)." >expect &&
 	git branch -d dangling-symref >actual &&
 	test_ref_missing refs/heads/dangling-symref &&
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 4b474808311..fc8a0588acc 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -522,7 +522,7 @@ test_expect_success 'log -S requires an argument' '
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
index 946c5751885..bedd29d0550 100755
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


--jtnWMNS+po2ZYe/t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVDYfgACgkQVbJhu7ck
PpT3KhAAgCsma/5jhbPxLzwjGN3PhJWysxGZg8ckCHbahY8lsSL2PKfgwnytSh6o
QnyOsk3HCU2TSeIVFnsK5/aNEtnAjEYqXHIwqcRdUhLqDjQpFfk2M4XWwfexkVR9
Pp3WPlT382S2Yp9DVMp5a6u3DfZFhNK54f4/WyNrs8Z0lQaTB3AGJLRd+gOQrbRT
Rue6ylLnUPnL9rqL4+LIeDdszjTuGNjlp3Ts9BO5xEaVIhjVDqWqepqR68iqZtrn
VhuUbdLcoJ70A0cRbZ72ihnnnT/89cXREeR1sPBmPmYPJma2vn+oPLnA5vQmmfX2
yh339Gh8lXywvLKZJxazUPQKdmHkLqbPO7DDPb/rYeZ4w1QbxAdrosqcYFiU+Icc
rf+bomIix+a0HC88EfRELG4lyfULVMD0gMuioN2yeKj0ddYV5M7Nd7Cbec5wAaAh
/nR666FStjf04HotyyfCljvO6745P3gMBkfwI4GCLkFrkwlbL+TOIdJ+WL7im5mJ
WTqjb/suf9hVr+iht51AS8+aK/JSUBFdBWZPHT2txkmL8j0bo4SR4D+PhFK8wsTW
vfaZOa/b0hduW5mj1IbBqUUMY5IMzsz7gQbAwQN8dcYwmjjRPexeufApTbjZJgN9
+ilV3un05Wg+y3sde9vCvr2eYCwcTKsHPsxjOyqsgG8lWuK34PQ=
=n0px
-----END PGP SIGNATURE-----

--jtnWMNS+po2ZYe/t--
