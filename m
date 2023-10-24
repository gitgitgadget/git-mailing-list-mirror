Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43264125DE
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bGtKoyP4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p7vGG5KY"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFABA3
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 07:04:56 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 353523200A26;
	Tue, 24 Oct 2023 10:04:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 24 Oct 2023 10:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698156294; x=1698242694; bh=uJ
	Nva0vwUe9QMR7XD5tUgMCQcGvDUlr6H2OfA//vNo0=; b=bGtKoyP4JJsvmZBpaw
	Az4mfGsMZPEaoT2v715t43ApHJW+4v2QIGX/kovt27e7bI8IrnE2EVqYfOgARTyX
	ArNVou95NaZyO/dICLq9LkGV9i5KaQUwwi5Wuo6OQHec4fOTnHG5JpKSWwt/uEon
	nxgsRlHyQi3VLOsSZfsbu1Q0uHnzUzYzRDVRBuVPhm5XCYhAGuXcJECdK+gK4aX4
	umvixNFyQ5uD05ee5bLHZlSZ/8KHuSqYekOAWel9IzrIZ6MPkKRPcarbn+cGbN+P
	4dYOn8qBlMiZ0itvdVKDKt6pQUfFnjKTuTSuXJzTUG7RqIolEa4E59NBSmM6z/gB
	KZgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698156294; x=1698242694; bh=uJNva0vwUe9QM
	R7XD5tUgMCQcGvDUlr6H2OfA//vNo0=; b=p7vGG5KYZZekf/Crb5pBLjjLvnfGw
	guK+RrXEz6S5gH5+BsekqppuvDh93eYKSoyUphSYNsLjQRA7Ev0H8alo92+xkWYi
	vI1fDvYj8Q5cmn0fqoFRJmfo6jkU78Y0dGM4KZwq/r1BQiiZhwBoohJ8CgFVF6Ml
	AW5J2THwGxzZQixRO71lJkS/9IIFqsQENkf/TPXHJd/pLXkdMRZ9wmQCdMw/MHDx
	U55RPDFGml0DWseIet/2lluWibktXGPUtYMgxPOMMHc3ZC8wq0ra2cWaN4tJSyM3
	ej1DqhdVrJADCs07SZPvKA0naiDj/rTrkXAYYevaHmHwEFW0bwqupGjYw==
X-ME-Sender: <xms:Bs83ZeG15uA3e_j5gEzSr_fvCgjmpeHCl2-XIi1Ab8P_avgPU-Ztbg>
    <xme:Bs83ZfWyBRtlevUI3g6GOvKqSvY5-7Fgo5I9_677sZ7Hw3hDXSJ-Em2LNlPAn4_Cj
    E6391t8zViQySDd9w>
X-ME-Received: <xmr:Bs83ZYKocQdMDDdV21YKyvrF70UGsdQYt_llhL__Oj_oF6qzzOx55Z25vfmg6PFfUSuqbNUSJAwZPru61XjBtfS6DF4HFEdJAolhKcQHabfiG1k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Bs83ZYH3hKFBEPqVmA1A7OBGakBNqijCDhRK7dsCeU41MivRtLX3SQ>
    <xmx:Bs83ZUUMK4HFSeN5LtwIvx6_IhO5uSptgFaA70HC5scf_-QQERnLOg>
    <xmx:Bs83ZbPT3FLI1MimEY7lsYXia2PPu4uYFZoqIhPIDOpjmI_DIDGIGg>
    <xmx:Bs83ZbTceoGaPsdc11aZsNbkRz036xBlHX3ZcFd4MZXXqHUbX4O68A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 10:04:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 841d4965 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 14:04:46 +0000 (UTC)
Date: Tue, 24 Oct 2023 16:04:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/9] t: reduce direct disk access to data structures
Message-ID: <cover.1698156169.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dqM14yfdvsLJLPIC"
Content-Disposition: inline
In-Reply-To: <cover.1697607222.git.ps@pks.im>


--dqM14yfdvsLJLPIC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that aims to reduce access
to on-disk data structures in favor of using plumbing tools where
possible.

Changes compared to v1:

    - Patches 1, 3: I've dropped these patches that introduced and
      started to use the test helper for reference existence. This has
      been split out into a separate patch series now that instead
      implements the logic as part of git-show-ref(1), see [1].

    - Patch 4: I've made it more explicit that tests in t1450 are all
      ran in detached HEAD mode via a new `orig_head` variable that is
      set in the test setup. This variable is later used to reset HEAD
      back to that original state.

    - Patch 4, 5: I've reordered some of the logic such that we schedule
      `test_when_finished` before doing the actual mutation of the repo.

    - Patch 8: I've adopted the proposal of a `remove_replace_refs()`=20
      helper function to clean up replace refs.

    - Now comes with a base commit. Unbelievable.

Thanks for all the feedback so far!

Patrick

Patrick Steinhardt (9):
  t: allow skipping expected object ID in `ref-store update-ref`
  t: convert tests to not write references via the filesystem
  t: convert tests to not access symrefs via the filesystem
  t: convert tests to not access reflog via the filesystem
  t1450: convert tests to remove worktrees via git-worktree(1)
  t4207: delete replace references via git-update-ref(1)
  t7300: assert exact states of repo
  t7900: assert the absence of refs via git-for-each-ref(1)
  t: mark several tests that assume the files backend with REFFILES

 t/helper/test-ref-store.c          | 11 ++++---
 t/t1400-update-ref.sh              | 50 ++++++++++++++++--------------
 t/t1430-bad-ref-name.sh            | 12 +++----
 t/t1450-fsck.sh                    | 44 +++++++++++++-------------
 t/t2011-checkout-invalid-head.sh   | 16 +++++-----
 t/t3200-branch.sh                  | 41 ++++++++++++------------
 t/t3400-rebase.sh                  |  2 +-
 t/t3404-rebase-interactive.sh      |  2 +-
 t/t4013-diff-various.sh            |  2 +-
 t/t4202-log.sh                     |  2 +-
 t/t4207-log-decoration-colors.sh   | 10 ++++--
 t/t5526-fetch-submodules.sh        |  2 +-
 t/t5605-clone-local.sh             |  4 +--
 t/t5702-protocol-v2.sh             | 24 ++++++++++----
 t/t7300-clean.sh                   | 23 ++++++++------
 t/t7900-maintenance.sh             |  3 +-
 t/t9133-git-svn-nested-git-repo.sh |  2 +-
 17 files changed, 142 insertions(+), 108 deletions(-)

Range-diff against v1:
 1:  e947feb1c77 <  -:  ----------- t: add helpers to test for reference ex=
istence
 2:  1f615d62f99 =3D  1:  c868198f8c1 t: allow skipping expected object ID =
in `ref-store update-ref`
 3:  ac6a49c7c84 <  -:  ----------- t: convert tests to use helpers for ref=
erence existence
 4:  c79431c0bf1 !  2:  4c0939d868e t: convert tests to not write reference=
s via the filesystem
    @@ Commit message
         test tool. The latter is required in some cases where safety check=
s of
         git-update-ref(1) would otherwise reject a reference update.
    =20
    +    While at it, refactor some of the tests to schedule the cleanup co=
mmand
    +    via `test_when_finished` before modifying the repository.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## t/t1400-update-ref.sh ##
    @@ t/t1400-update-ref.sh: test_expect_success "delete $m without oldval=
ue verificat
     =20
      test_expect_success "create $m (by HEAD)" '
     @@ t/t1400-update-ref.sh: test_expect_success 'delete symref without d=
ereference when the referred ref is
    + '
     =20
      test_expect_success 'update-ref -d is not confused by self-reference'=
 '
    ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DERE=
F refs/heads/self" &&
      	git symbolic-ref refs/heads/self refs/heads/self &&
     -	test_when_finished "rm -f .git/refs/heads/self" &&
    -+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DERE=
F refs/heads/self" &&
      	test_path_is_file .git/refs/heads/self &&
      	test_must_fail git update-ref -d refs/heads/self &&
      	test_path_is_file .git/refs/heads/self
    -@@ t/t1400-update-ref.sh: test_expect_success 'update-ref -d is not co=
nfused by self-reference' '
    + '
     =20
      test_expect_success 'update-ref --no-deref -d can delete self-referen=
ce' '
    ++	test_when_finished "test-tool ref-store main delete-refs REF_NO_DERE=
F refs/heads/self" &&
      	git symbolic-ref refs/heads/self refs/heads/self &&
     -	test_when_finished "rm -f .git/refs/heads/self" &&
    -+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DERE=
F refs/heads/self" &&
      	test_path_is_file .git/refs/heads/self &&
      	git update-ref --no-deref -d refs/heads/self &&
      	test_must_fail git show-ref --verify -q refs/heads/self
    @@ t/t1400-update-ref.sh: test_expect_success 'Query "main@{2005-05-28}=
" (past end
      '
     =20
     -rm -f .git/$m .git/logs/$m expect
    ++rm -f expect
     +git update-ref -d $m
     =20
      test_expect_success 'creating initial files' '
      	test_when_finished rm -f M &&
    =20
      ## t/t1450-fsck.sh ##
    +@@ t/t1450-fsck.sh: test_expect_success setup '
    + 	git config --unset i18n.commitencoding &&
    + 	git checkout HEAD^0 &&
    + 	test_commit B fileB two &&
    ++	orig_head=3D$(git rev-parse HEAD) &&
    + 	git tag -d A B &&
    + 	git reflog expire --expire=3Dnow --all
    + '
     @@ t/t1450-fsck.sh: test_expect_success 'zlib corrupt loose object out=
put ' '
      '
     =20
      test_expect_success 'branch pointing to non-commit' '
     -	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
     +	tree_oid=3D$(git rev-parse --verify HEAD^{tree}) &&
    -+	test-tool ref-store main update-ref msg refs/heads/invalid $tree_oid=
 $ZERO_OID REF_SKIP_OID_VERIFICATION &&
      	test_when_finished "git update-ref -d refs/heads/invalid" &&
    ++	test-tool ref-store main update-ref msg refs/heads/invalid $tree_oid=
 $ZERO_OID REF_SKIP_OID_VERIFICATION &&
      	test_must_fail git fsck 2>out &&
      	test_i18ngrep "not a commit" out
      '
    @@ t/t1450-fsck.sh: test_expect_success 'zlib corrupt loose object outp=
ut ' '
      test_expect_success 'HEAD link pointing at a funny object' '
     -	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
     -	mv .git/HEAD .git/SAVED_HEAD &&
    -+	saved_head=3D$(git rev-parse --verify HEAD) &&
    -+	test_when_finished "git update-ref HEAD ${saved_head}" &&
    ++	test_when_finished "git update-ref HEAD $orig_head" &&
      	echo $ZERO_OID >.git/HEAD &&
      	# avoid corrupt/broken HEAD from interfering with repo discovery
      	test_must_fail env GIT_DIR=3D.git git fsck 2>out &&
    @@ t/t1450-fsck.sh: test_expect_success 'HEAD link pointing at a funny =
object' '
      test_expect_success 'HEAD link pointing at a funny place' '
     -	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
     -	mv .git/HEAD .git/SAVED_HEAD &&
    -+	saved_head=3D$(git rev-parse --verify HEAD) &&
    -+	test_when_finished "git update-ref --no-deref HEAD ${saved_head}" &&
    ++	test_when_finished "git update-ref --no-deref HEAD $orig_head" &&
      	echo "ref: refs/funny/place" >.git/HEAD &&
      	# avoid corrupt/broken HEAD from interfering with repo discovery
      	test_must_fail env GIT_DIR=3D.git git fsck 2>out &&
    @@ t/t1450-fsck.sh: test_expect_success 'HEAD link pointing at a funny =
place' '
     =20
      test_expect_success 'HEAD link pointing at a funny object (from diffe=
rent wt)' '
     -	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
    -+	saved_head=3D$(git rev-parse --verify HEAD) &&
    -+	test_when_finished "git update-ref HEAD $saved_head" &&
    ++	test_when_finished "git update-ref HEAD $orig_head" &&
      	test_when_finished "rm -rf .git/worktrees wt" &&
      	git worktree add wt &&
     -	mv .git/HEAD .git/SAVED_HEAD &&
 5:  1ac120368c6 !  3:  048583ed2c3 t: convert tests to not access symrefs =
via the filesystem
    @@ Commit message
      ## t/t1400-update-ref.sh ##
     @@ t/t1400-update-ref.sh: test_expect_success 'delete symref without d=
ereference when the referred ref is
      test_expect_success 'update-ref -d is not confused by self-reference'=
 '
    - 	git symbolic-ref refs/heads/self refs/heads/self &&
      	test_when_finished "test-tool ref-store main delete-refs REF_NO_DERE=
F refs/heads/self" &&
    + 	git symbolic-ref refs/heads/self refs/heads/self &&
     -	test_path_is_file .git/refs/heads/self &&
     +	git symbolic-ref --no-recurse refs/heads/self &&
      	test_must_fail git update-ref -d refs/heads/self &&
    @@ t/t1400-update-ref.sh: test_expect_success 'delete symref without de=
reference wh
      '
     =20
      test_expect_success 'update-ref --no-deref -d can delete self-referen=
ce' '
    - 	git symbolic-ref refs/heads/self refs/heads/self &&
      	test_when_finished "test-tool ref-store main delete-refs REF_NO_DERE=
F refs/heads/self" &&
    + 	git symbolic-ref refs/heads/self refs/heads/self &&
     -	test_path_is_file .git/refs/heads/self &&
     +	git symbolic-ref --no-recurse refs/heads/self &&
      	git update-ref --no-deref -d refs/heads/self &&
    @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref -d can dele=
te broken na
     -	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
     +	test-tool ref-store main create-symref refs/heads/broken...symref re=
fs/heads/main &&
      	test_when_finished "test-tool ref-store main delete-refs REF_NO_DERE=
F msg refs/heads/broken...symref" &&
    - 	test_ref_exists refs/heads/broken...symref &&
      	git update-ref --no-deref -d refs/heads/broken...symref >output 2>er=
ror &&
    + 	test_path_is_missing .git/refs/heads/broken...symref &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref --no-deref=
 -d can delete symref with broken name
      '
     =20
    @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref --no-deref =
-d can delet
     -	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
     +	test-tool ref-store main create-symref refs/heads/broken...symref re=
fs/heads/main &&
      	test_when_finished "test-tool ref-store main delete-refs REF_NO_DERE=
F msg refs/heads/broken...symref" &&
    - 	test_ref_exists refs/heads/broken...symref &&
      	git branch -d broken...symref >output 2>error &&
    + 	test_path_is_missing .git/refs/heads/broken...symref &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -d can delete =
symref with broken name' '
      '
     =20
    @@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -d can delete s=
ymref with b
     -	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...sym=
ref &&
     +	test-tool ref-store main create-symref refs/heads/broken...symref re=
fs/heads/idonotexist &&
      	test_when_finished "test-tool ref-store main delete-refs REF_NO_DERE=
F msg refs/heads/broken...symref" &&
    - 	test_ref_exists refs/heads/broken...symref &&
      	git update-ref --no-deref -d refs/heads/broken...symref >output 2>er=
ror &&
    + 	test_path_is_missing .git/refs/heads/broken...symref &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref --no-deref=
 -d can delete dangling symref with br
      '
     =20
    @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref --no-deref =
-d can delet
     -	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...sym=
ref &&
     +	test-tool ref-store main create-symref refs/heads/broken...symref re=
fs/heads/idonotexist &&
      	test_when_finished "test-tool ref-store main delete-refs REF_NO_DERE=
F msg refs/heads/broken...symref" &&
    - 	test_ref_exists refs/heads/broken...symref &&
      	git branch -d broken...symref >output 2>error &&
    + 	test_path_is_missing .git/refs/heads/broken...symref &&
    =20
      ## t/t1450-fsck.sh ##
     @@ t/t1450-fsck.sh: test_expect_success 'HEAD link pointing at a funny=
 object' '
    +=20
      test_expect_success 'HEAD link pointing at a funny place' '
    - 	saved_head=3D$(git rev-parse --verify HEAD) &&
    - 	test_when_finished "git update-ref --no-deref HEAD ${saved_head}" &&
    + 	test_when_finished "git update-ref --no-deref HEAD $orig_head" &&
     -	echo "ref: refs/funny/place" >.git/HEAD &&
     +	test-tool ref-store main create-symref HEAD refs/funny/place &&
      	# avoid corrupt/broken HEAD from interfering with repo discovery
    @@ t/t3200-branch.sh: test_expect_success 'git branch -M should leave o=
rphaned HEAD
     +		git symbolic-ref HEAD >expect &&
     +		echo refs/heads/lonely >actual &&
     +		test_cmp expect actual &&
    - 		test_ref_missing refs/head/lonely &&
    + 		test_path_is_missing .git/refs/head/lonely &&
      		git branch -M main mistress &&
     -		grep lonely .git/HEAD
     +		git symbolic-ref HEAD >expect &&
    @@ t/t3200-branch.sh: test_expect_success 'deleting a symref' '
     +	git symbolic-ref --no-recurse refs/heads/dangling-symref &&
      	echo "Deleted branch dangling-symref (was nowhere)." >expect &&
      	git branch -d dangling-symref >actual &&
    - 	test_ref_missing refs/heads/dangling-symref &&
    + 	test_path_is_missing .git/refs/heads/dangling-symref &&
    =20
      ## t/t4013-diff-various.sh ##
     @@ t/t4013-diff-various.sh: test_expect_success 'log -S requires an ar=
gument' '
 6:  eaac658bbfd !  4:  5e7937e7904 t: convert tests to not access reflog v=
ia the filesystem
    @@ t/t3200-branch.sh: test_expect_success 'git branch HEAD should fail'=
 '
      test_expect_success 'git branch --create-reflog d/e/f should create a=
 branch and a log' '
      	GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
      	git -c core.logallrefupdates=3Dfalse branch --create-reflog d/e/f &&
    - 	test_ref_exists refs/heads/d/e/f &&
    + 	test_path_is_file .git/refs/heads/d/e/f &&
     -	test_path_is_file .git/logs/refs/heads/d/e/f &&
     -	test_cmp expect .git/logs/refs/heads/d/e/f
     +	git reflog show --no-abbrev-commit refs/heads/d/e/f >actual &&
    @@ t/t3200-branch.sh: test_expect_success '--set-upstream-to notices an=
 error to se
      test_expect_success 'git checkout -b g/h/i -l should create a branch =
and a log' '
      	GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
      	git checkout -b g/h/i -l main &&
    - 	test_ref_exists refs/heads/g/h/i &&
    + 	test_path_is_file .git/refs/heads/g/h/i &&
     -	test_path_is_file .git/logs/refs/heads/g/h/i &&
     -	test_cmp expect .git/logs/refs/heads/g/h/i
     +	git reflog show --no-abbrev-commit refs/heads/g/h/i >actual &&
 7:  3dc65a80074 !  5:  089565a358e t1450: convert tests to remove worktree=
s via git-worktree(1)
    @@ Commit message
    =20
      ## t/t1450-fsck.sh ##
     @@ t/t1450-fsck.sh: test_expect_success 'HEAD link pointing at a funny=
 place' '
    +=20
      test_expect_success 'HEAD link pointing at a funny object (from diffe=
rent wt)' '
    - 	saved_head=3D$(git rev-parse --verify HEAD) &&
    - 	test_when_finished "git update-ref HEAD $saved_head" &&
    + 	test_when_finished "git update-ref HEAD $orig_head" &&
     -	test_when_finished "rm -rf .git/worktrees wt" &&
     +	test_when_finished "git worktree remove -f wt" &&
      	git worktree add wt &&
 8:  c4d09e3e5db !  6:  cb738888ed7 t4207: delete replace references via gi=
t-update-ref(1)
    @@ Commit message
    =20
      ## t/t4207-log-decoration-colors.sh ##
     @@ t/t4207-log-decoration-colors.sh: ${c_tag}tag: ${c_reset}${c_tag}A$=
{c_reset}${c_commit})${c_reset} A
    + 	cmp_filtered_decorations
      '
     =20
    ++remove_replace_refs () {
    ++	git for-each-ref 'refs/replace*/**' --format=3D'delete %(refname)' >=
in &&
    ++	git update-ref --stdin <in &&
    ++	rm in
    ++}
    ++
      test_expect_success 'test coloring with replace-objects' '
     -	test_when_finished rm -rf .git/refs/replace* &&
    -+	test_when_finished "git for-each-ref refs/replace*/** --format=3D${S=
Q}delete %(refname)${SQ} | git update-ref --stdin" &&
    ++	test_when_finished remove_replace_refs &&
      	test_commit C &&
      	test_commit D &&
     =20
    @@ t/t4207-log-decoration-colors.sh: EOF
     =20
      test_expect_success 'test coloring with grafted commit' '
     -	test_when_finished rm -rf .git/refs/replace* &&
    -+	test_when_finished "git for-each-ref refs/replace*/** --format=3D${S=
Q}delete %(refname)${SQ} | git update-ref --stdin" &&
    ++	test_when_finished remove_replace_refs &&
     =20
      	git replace --graft HEAD HEAD~2 &&
     =20
 9:  153b5b199c8 =3D  7:  e730e011de4 t7300: assert exact states of repo
10:  b99d98b00a3 =3D  8:  a1bdea52397 t7900: assert the absence of refs via=
 git-for-each-ref(1)
11:  67cb282a414 !  9:  497e43ae5c3 t: mark several tests that assume the f=
iles backend with REFFILES
    @@ t/t1450-fsck.sh: test_expect_success 'branch pointing to non-commit'=
 '
     =20
     -test_expect_success 'HEAD link pointing at a funny object' '
     +test_expect_success REFFILES 'HEAD link pointing at a funny object' '
    - 	saved_head=3D$(git rev-parse --verify HEAD) &&
    - 	test_when_finished "git update-ref HEAD ${saved_head}" &&
    + 	test_when_finished "git update-ref HEAD $orig_head" &&
      	echo $ZERO_OID >.git/HEAD &&
    + 	# avoid corrupt/broken HEAD from interfering with repo discovery
     @@ t/t1450-fsck.sh: test_expect_success 'HEAD link pointing at a funny=
 place' '
      	test_i18ngrep "HEAD points to something strange" out
      '
     =20
     -test_expect_success 'HEAD link pointing at a funny object (from diffe=
rent wt)' '
     +test_expect_success REFFILES 'HEAD link pointing at a funny object (f=
rom different wt)' '
    - 	saved_head=3D$(git rev-parse --verify HEAD) &&
    - 	test_when_finished "git update-ref HEAD $saved_head" &&
    + 	test_when_finished "git update-ref HEAD $orig_head" &&
      	test_when_finished "git worktree remove -f wt" &&
    + 	git worktree add wt &&
     @@ t/t1450-fsck.sh: test_expect_success 'HEAD link pointing at a funny=
 object (from different wt)' '
      	test_i18ngrep "main-worktree/HEAD: detached HEAD points" out
      '
    @@ t/t2011-checkout-invalid-head.sh: test_expect_success 'create ref di=
rectory/file
    =20
      ## t/t3200-branch.sh ##
     @@ t/t3200-branch.sh: test_expect_success 'git branch --help should no=
t have created a bogus branch' '
    - 	test_ref_missing refs/heads/--help
    + 	test_path_is_missing .git/refs/heads/--help
      '
     =20
     -test_expect_success 'branch -h in broken repository' '
    @@ t/t3200-branch.sh: test_expect_success 'git branch -M baz bam should=
 succeed whe
      	git worktree add -f bazdir2 baz &&
      	touch .git/worktrees/bazdir1/HEAD.lock &&
     @@ t/t3200-branch.sh: test_expect_success 'renaming a symref is not al=
lowed' '
    - 	test_ref_missing refs/heads/new-topic
    + 	test_path_is_missing .git/refs/heads/new-topic
      '
     =20
     -test_expect_success SYMLINKS 'git branch -m u v should fail when the =
reflog for u is a symlink' '

base-commit: a9ecda2788e229afc9b611acaa26d0d9d4da53ed
--=20
2.42.0


--dqM14yfdvsLJLPIC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3zvwACgkQVbJhu7ck
PpQFAg//WZagfP/paQBShx3hfczclneyk+qxKBxlF4qZgqVEqUNHs5eQ/jsDVhxK
hR9Dfbxk5wAGSu3Zt/r33gH4EgRzS7b4aBNaSa8U+2eXMLMiQQO3dsVbB6yif/KU
Z9K4fKx3CKfL4zcWKr1mvOlG7kv4kBEiV+Lk3aHXNZSH3cB+Io6LOd47SLQePR1G
9uDk2jpZjF4DkFDdw70Ht4Rwx2ej6fDmch2dTmxB9t5LhS920H0NDVGtn6n8jySv
QAh1YstqK1P3NZquX7Rrdykjw/q/GdcMSPQBcqZgyRtKxW/IsQjuUxxg2MzsqgNf
bhXVcjjtltLIisQnaGZ6Wf4AsJSkyiKmlzLM4KFMDND4fv1ZEzk7VmooRtRCAM7c
KC+G0Rt6GSYttr+bhl11V/b1q+q2YjLei450Xmm+AUqY27nOJz6Bb04BpBsU4r99
x1lAyKb8JRQEy9650BtWOEh6btGvnzxvEujsyILK4NUosoX/yigr83JeUkEZ91EZ
2uFWvbPc9VcHki34L/5dtohFxwrO2Z/K6VRbyWMamdGZ0Tr7J/3YClAtPKtJyZny
6wAKQ1XbWn2ADhSglcHFb9VukHJJUJw5wNu4MibsgXad/o/sWLkmHH7pJnEcVtvX
P1d5Q1x2vXnVN6ESmMHDAxi6ESUowYyLJNujgYC2rZG0nhXbfKQ=
=MJoZ
-----END PGP SIGNATURE-----

--dqM14yfdvsLJLPIC--
