Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88293CA74
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FNb4YTQG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g18EbdoS"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A78118
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:35:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 5BAC63200B3A;
	Wed, 18 Oct 2023 01:35:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 18 Oct 2023 01:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697607327; x=1697693727; bh=Yi
	/U+VV14rQZnWDQqvysDcRNxAfzzR6sUJuaC0tXWac=; b=FNb4YTQGQ9EV/QDOrM
	/yjQ2TZkZiPs/50ynQGC0FAfBmTBMHRo0oIgABjqD8s/TzxQFS7eRZgSoiwiDghl
	BzkFoKyLq6RslIZytHk/BHf9KVBgrKSYLeBBaym4/rONijWmtYLtGHS8ixdciosD
	KW73++5QwbRJ6+twQhtrBxJlryVD7BT81dxYJ3/H1IXeFlG79wdgcVn8btQZbaNl
	w6DMs/ROqyMNg4qVd0V2bN3b5+cEaRnnp30UOPgcsBO+tdw75dN11WvZkPbwwG27
	2NS5CgMsQUrHfdfH3Ev+GgM28PHfqCmutiTQJcHKcQR0rqXdnz0A2sFuQKSFW8OI
	c7LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697607327; x=1697693727; bh=Yi/U+VV14rQZn
	WDQqvysDcRNxAfzzR6sUJuaC0tXWac=; b=g18EbdoSOr5/h3nKbETggsiUqmJdW
	HDqldV/DIeRfXPzUyE+zR2EBe+IwwtjApn5wZ7/vj9cAfOH70QWelh5iyGe42v9K
	PUZwuTRzYG7AIOChPAl7H1MG6VIuxr/a8hSvwJfFRffr443WiZnlBMXfJVshlVSK
	CzsCQubuLuzvPwTc0QiWZXEV0m31Q4IO9xFA7QVlPHKHEZA2m/beAJxB/1d4NHc0
	tvW8Ag24tpcDkegFmGtLS6UwVHN9N3aeGD5CcyOaHGe0YxUGP3+J/1NTPElOfKk6
	QRCX/2f8rTxNhhTgiTJ+vRdF9j1a+ThRC9Edt0hyOFWGvlUYVFQQD6psw==
X-ME-Sender: <xms:n24vZR7QcIevcHJpmhy44qHk-Fz-w8t3uH7EKnvEOf6dtfXZ105l9w>
    <xme:n24vZe6soS2qoth81V3Hj6ttqJqo6Z6QluPelzZzDiHS7Vf5aa3gQzd4GGiWhqc0q
    Xy0nANzvaVcal-Daw>
X-ME-Received: <xmr:n24vZYfN_HWMo2lFs8ot3VolCpyB8ZmfgulfSrFoJDKV4ZrdPFpFtfjc1bViok_r70J4yns3dyVmPmxFGp83fuRupuugl3RKC9kFyP9j1ueKP5hu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeefgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:n24vZaI4oixJzJZ23Q3Dk2uf2LpaB_voV166l97iFGGtFc-DphrAjA>
    <xmx:n24vZVJtj608BtxcuvvyGRJhqB2-No9VKv6YKRn9QPMn9O9Ge1qo4Q>
    <xmx:n24vZTzUxyZcaGfAscRxG2WX9Wd5V1yPGAUSRGdmImFxoz35P1VD3w>
    <xmx:n24vZXx0De_gn0jhj1FcB-66hBQ8EBb4Y28UO_GZ0J31gtdG-a6x5Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 01:35:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2c8e55d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Oct 2023 05:35:25 +0000 (UTC)
Date: Wed, 18 Oct 2023 07:35:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 05/11] t: convert tests to not access symrefs via the
 filesystem
Message-ID: <1ac120368c6cd995841c28bde7542e882ec7b04f.1697607222.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HN90kPZcayKhMmfC"
Content-Disposition: inline
In-Reply-To: <cover.1697607222.git.ps@pks.im>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--HN90kPZcayKhMmfC
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
index cd24018ce99..5f505e2f353 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -221,15 +221,15 @@ test_expect_success 'delete symref without dereferenc=
e when the referred ref is
 test_expect_success 'update-ref -d is not confused by self-reference' '
 	git symbolic-ref refs/heads/self refs/heads/self &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF ref=
s/heads/self" &&
-	test_path_is_file .git/refs/heads/self &&
+	git symbolic-ref --no-recurse refs/heads/self &&
 	test_must_fail git update-ref -d refs/heads/self &&
-	test_path_is_file .git/refs/heads/self
+	git symbolic-ref --no-recurse refs/heads/self
 '
=20
 test_expect_success 'update-ref --no-deref -d can delete self-reference' '
 	git symbolic-ref refs/heads/self refs/heads/self &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF ref=
s/heads/self" &&
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
index 5cce24f1006..804a5594ddd 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -134,7 +134,7 @@ test_expect_success 'HEAD link pointing at a funny obje=
ct' '
 test_expect_success 'HEAD link pointing at a funny place' '
 	saved_head=3D$(git rev-parse --verify HEAD) &&
 	test_when_finished "git update-ref --no-deref HEAD ${saved_head}" &&
-	echo "ref: refs/funny/place" >.git/HEAD &&
+	test-tool ref-store main create-symref HEAD refs/funny/place &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail env GIT_DIR=3D.git git fsck 2>out &&
 	test_i18ngrep "HEAD points to something strange" out
@@ -171,7 +171,7 @@ test_expect_success 'other worktree HEAD link pointing =
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


--HN90kPZcayKhMmfC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUvbpwACgkQVbJhu7ck
PpSL8g/8CFfBmyTiXU0VtGCFALIY7zMWaIvKX/RJt5voe/UtKSuEPLA3FRoSj/io
2iomM8ia8NDML69Go5lsDm+8FEn+t4qJdwNC+NlAg9wPSGwv9iR8T6Gp6pZUoIUU
uz0chXSF9tT2aQz4P0DqD9YSBCDl0dY9Oy74Uf9Dg6QhX6dbFg9KbJ9Lsk/4YL0u
90+8l7O3exrSi30KuyLdKu/7JU/Gkjh6X3yTf9avj/yi/IoHzEgkNWOXMJ8G208A
/MVr3FlqhMnrFXdNX/8Iqbues4GFCfwCm7k6/KsrGyywl4ZvZN/MO5gDdc89fSnZ
8fis5n+2jtH49mCu+5sxvRjl+oAyVxolXPNgNemGS1cGLu9gIiPjdRa0ckr1TQTp
wg5x7fCy7BlVgLLrgk/9Oy0/7ECYqT7vuOYUB4A216IHUk+yPG+7MvdeykXL/SD4
jOgz20OkJvoAZf+xuzG5W4L9RftPBsTBdA7mqVFht7e6ibwrPXqCvu07veN2XYs5
+NoUlRowEP+yZd22jchCMCr/vvpUcmqKg+RaTfGbj78xVZD+9pqFreh9GPmtU1ZQ
yvLKak/CKPCAL3Y7+iyF9GqxDMv9siS140M+/+Fz/hlA7bWsQeZtt8Beqnw7SDPe
081+2mlJVmNGrBM+LtsGFLuKGFT0k4CmjhD3aUqQC59P4YKxV5M=
=a8UL
-----END PGP SIGNATURE-----

--HN90kPZcayKhMmfC--
