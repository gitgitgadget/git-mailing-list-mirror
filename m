Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4EF1799C
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rD8aL0VJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R5OPF4ML"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A14137
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:35:57 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 07F793200AFA;
	Wed, 18 Oct 2023 01:35:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 18 Oct 2023 01:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697607356; x=1697693756; bh=b6
	NQZzXBj1UzYduSEynmL03y06lSv0ZButWcRfMdQ6Q=; b=rD8aL0VJh+JWB1bBal
	pp2c6zcmaMiO3wHniip7MWBfW8WxxMWrTHL7mM+Foy1L/Yt51nW68xhucWj/TYcg
	n0KHW9kxVUPwyJ+hU4ZfY3bVN6gZs4+PjxBNikyX5syopgmnKFY3bSh5Bm/UGjGy
	GEYUuR8Q7XX2BTM2JhkfDlZso5V/rLRkOiMjL3yH18+emqkqrSPFhoySBpKMvxOl
	JEcow22SNyCo5fGBcPgku3BJkpXG7ofePiOVedwoMBGq65UqDjGw+7cfcq0pfmnB
	PgZO5NPmRCIxN2i4HJKJMQL42Nkk9BZSvlwKXoBKiGkB6xPsZcudqxZO2rX4Dd/N
	4Upg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697607356; x=1697693756; bh=b6NQZzXBj1UzY
	duSEynmL03y06lSv0ZButWcRfMdQ6Q=; b=R5OPF4MLkZC/XwY+ku6ZLugEiw5ri
	4jFDSDLWQF5Pkhem5XDgNJunZF9MLaD235/mtKefdNXd5aj5qnT9JEabBPAsaF/l
	RvGIZpw6yL0TB3vRa8cDAzFuyS62bEWnz7lJnJl8c7XIKH39DPrWAfqkCl2WXt18
	S/1Bgti6LMLvYHwVdAj2O0LllQuxXnQrzai5mFx0hnVhsbWDbN4mTdUCkX34FWfN
	1EIQYi/sSWf+m50iibWHYvpSctIVzQYPwevcBQjijMkiLO10mNcrUNhLucx1F35O
	3/hjWIMA73rmLLxFS/TXX5nxcw/iXIVVTffWeeVyNInQ4zrPrSifNF81Q==
X-ME-Sender: <xms:vG4vZe5ooTqwqx5CH7m5YXAy2yxBAgS2MqUVEtKopVvoMzWme_LJaw>
    <xme:vG4vZX6dXWKdZhSZ7luRHnmhqZ4o3t52fVbVWxIHvmxzJ9qaRWVsAL1Y6Y14QCw_-
    SXP9_1Iltgbw0JI3g>
X-ME-Received: <xmr:vG4vZdea42hgGAdgM0E77gNnDUoo_G_DFF8Pc4snJO1StBn3cug2d7EV-u1iFvU3rwEbcrbDTislbLgJOf2riZt8izP_RsKvkofj_HvtBxuQedDf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeefgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:vG4vZbKDHZsW-e8sdInTVMD1lwXMqO4V-Ofuhlh4BAtFYFLwOM_NMQ>
    <xmx:vG4vZSLDPpB46IUOx2d7w3wDLllt-Wj9fWivwdAC4EyfqJ1q9sQ5kQ>
    <xmx:vG4vZcw9SK43jVGmjxhPkqrTrKwa6BiYeix6Hlt0Rm9_9d9PUzYLxg>
    <xmx:vG4vZcyb4vR7K7yTil874XUOCTrNwNkG1b-Dndxs-rZN6a_DqVE7uA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 01:35:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6111fa3c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Oct 2023 05:35:54 +0000 (UTC)
Date: Wed, 18 Oct 2023 07:35:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 11/11] t: mark several tests that assume the files backend
 with REFFILES
Message-ID: <67cb282a414bf5b17934c20820289a416a7b49e7.1697607222.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P9c8t3bd1VZ9hJuK"
Content-Disposition: inline
In-Reply-To: <cover.1697607222.git.ps@pks.im>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--P9c8t3bd1VZ9hJuK
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
index b1d2c014132..feeba6ed7cd 100755
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
@@ -1638,7 +1638,7 @@ test_expect_success PIPE 'transaction flushes status =
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
index d356605d132..ca5a2719a19 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -122,7 +122,7 @@ test_expect_success 'branch pointing to non-commit' '
 	test_i18ngrep "not a commit" out
 '
=20
-test_expect_success 'HEAD link pointing at a funny object' '
+test_expect_success REFFILES 'HEAD link pointing at a funny object' '
 	saved_head=3D$(git rev-parse --verify HEAD) &&
 	test_when_finished "git update-ref HEAD ${saved_head}" &&
 	echo $ZERO_OID >.git/HEAD &&
@@ -140,7 +140,7 @@ test_expect_success 'HEAD link pointing at a funny plac=
e' '
 	test_i18ngrep "HEAD points to something strange" out
 '
=20
-test_expect_success 'HEAD link pointing at a funny object (from different =
wt)' '
+test_expect_success REFFILES 'HEAD link pointing at a funny object (from d=
ifferent wt)' '
 	saved_head=3D$(git rev-parse --verify HEAD) &&
 	test_when_finished "git update-ref HEAD $saved_head" &&
 	test_when_finished "git worktree remove -f wt" &&
@@ -151,7 +151,7 @@ test_expect_success 'HEAD link pointing at a funny obje=
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
index 933aa9eebbd..606c50fe66c 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -28,7 +28,7 @@ test_expect_success 'git branch --help should not have cr=
eated a bogus branch' '
 	test_ref_missing refs/heads/--help
 '
=20
-test_expect_success 'branch -h in broken repository' '
+test_expect_success REFFILES 'branch -h in broken repository' '
 	mkdir broken &&
 	(
 		cd broken &&
@@ -245,7 +245,7 @@ test_expect_success 'git branch -M baz bam should succe=
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
@@ -836,14 +836,14 @@ test_expect_success 'renaming a symref is not allowed=
' '
 	test_ref_missing refs/heads/new-topic
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
index bedd29d0550..a3055869bc7 100755
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


--P9c8t3bd1VZ9hJuK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUvbrkACgkQVbJhu7ck
PpQoqA//Za/mHBsvvWihEgyrYyLEdeBtUt71fCRFVmTKG53FEASSQWn5A/zYYqeG
J1WH6N9+Jqj1lOEbU/pHWge9hUFWRBGSNlpzipRoISELoNBtBh0r/xZNbJE3mTFI
z/31BRPtHvfeTkVFuip703iggIVYh81e6QougOvv4EVTm3wKI9DlMDMCcTlWPiwJ
D6ZlrHirIBnTP5EwE7o8bH+y0iyvOYQ4in+bk1NRDKGBnOEMcGmtttp559RYFgMy
c+BmqgwUN2peWeQeaznvaaN8FXtI9W+onzW6clIrAEKcMN56y2IXDfa8KMH1MtC9
4gS+DaDs9FUhn/dor5W7nplPoASnWpZPFxdt9ChN8VL5hcO+Yit9qSpwPpwuB8eA
BS1YQk+ztJcyP4NwV4rRmACdjTmWq4s61L9QOcuDbfoAbZxZ0E4r1tryYOowz1cn
RYFwKH3gcD0x+KcKVfy4p1VbrHQ6jQe1UfdL/U2jfmyWxSIyBP62Qzr0S0T3Eo1t
IcZqPvrGXSHR/kinItDOT6XqJUnI5DaeQQpkMmOYNnSmVIqwLMz/8ICmcwjsOCvZ
uMTIU81S1dfOxFzuuc9TZV0+o2zZwEY8yyzTNQHsxVOuNk5WQizHATKq2PzIuHW5
HL5KqWV+GgTfovkOm3PXJ/lLRysvIzviSS96VelAvYdF+GwvYPw=
=EZLn
-----END PGP SIGNATURE-----

--P9c8t3bd1VZ9hJuK--
