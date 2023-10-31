Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD3107AD
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fo/V6JW3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C7b86xvk"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E70C2
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 00:16:18 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 4A7AB3200A06;
	Tue, 31 Oct 2023 03:16:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 31 Oct 2023 03:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698736576; x=1698822976; bh=xA
	bFZFZNcDBmyeMYOQ4EYD02/wV+/gMlsObBM2p7G7g=; b=fo/V6JW3PF60wnejZ2
	EETch5wN5SvLAzDmKBgdTl4FeGMFt/FM2r3T5dx7MiA9QceOWZ413F+JEreX8DWI
	ze6eHggF2EzQpQGqW9Spikucq9VbO4Ax8F9GiaFeFoZRuv3bfTQqNdGc8EumGQOh
	wwVF4UqyQA08XG7MMGMLTv5tiW3w/2pJgWSkia2upSwF24EkKc13Hr/y6s4rCyKL
	P17kdUDJMM359Ae7ahw/jwvmpcXhR3j76IC8O9BmjCTTTQVjuxx39HUEg2r/ED6P
	NRhH9cf0E3azkEHOLaAZkglxQ64Ia9kXBgnAu+VBbGu1ZQ7Nr1wyuqyoxvW+HWBM
	fmvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698736576; x=1698822976; bh=xAbFZFZNcDBmy
	eMYOQ4EYD02/wV+/gMlsObBM2p7G7g=; b=C7b86xvkBy/Rl0ofZqexd91oZVq7s
	UWhK9hsdCaggjmesj+3vvc02S1Z8rPMLp9tJ0IvXyCTf340eeCsV6wpqU9BEX80X
	elowpG4RD3bmwnP1xe7ALolJmnPtIk54iOm3t4QWkfj8jTNeoCOeXcmP6BJ9IiJg
	KUL9puMNpBILLlZtpxDeePGuj9HIlrLnG30K+shF5Af3Hp5fsD1ND/c4I/1Qfd7t
	qVZP8tBjqHcNa2d14SpDvBAo4bMBfPllvfjs0it8jBTEOiJapEI5s+DCV1NWMuS6
	ywlF8fXW8RCKHtgLVZCPvyco7A0I4jGKmPoNG1kuC9mZTnDjXhyCN/4gw==
X-ME-Sender: <xms:wKlAZVIhWPcQFEkE_nsVvayliJznIG-_TZ2ZFwN6QhOOyk0F5ndoEQ>
    <xme:wKlAZRL4A5pquRhz1e18hHifk6VpiPaF_67jjVUjB2-mzmzOAdAgtOlwHB6denQy6
    xpxNC-psn1QE2N3dg>
X-ME-Received: <xmr:wKlAZdsjiWjQHJxcVAaJHw9CrDhsRq20qSPflU_nfKhEDhIjGhMzzUkaU9W03JN3AoCf_-Xn8Tlg8XMm8GCfzN5BeYKxw-OD8eSc6HXZuGC91jAp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:wKlAZWZyYvUEWwWtxpLzLcZs9VwPz_evZkz3z9X2o_dp0QhVR7EvzA>
    <xmx:wKlAZcYd_hMoFH2ZN_KLudz9uaMRK4xKL-eDkUV6uJsKgtgTd5Fz7Q>
    <xmx:wKlAZaAtYXm1iSkGITnhsBeieitzGExwJ-kw3SE6IhSMbAViDuKc0w>
    <xmx:wKlAZUGnpd5CCZiMrrGO7l2N95RSimxBOpS_4nArLT0_YmKkrygRJQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 03:16:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3eea230e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 07:16:08 +0000 (UTC)
Date: Tue, 31 Oct 2023 08:16:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 1/2] commit-graph: introduce envvar to disable commit
 existence checks
Message-ID: <c433ec125499e586d7a29d71f41a0ba197c28f58.1698736363.git.ps@pks.im>
References: <cover.1698060036.git.ps@pks.im>
 <cover.1698736363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iVmcP82Ch3IQy/Z5"
Content-Disposition: inline
In-Reply-To: <cover.1698736363.git.ps@pks.im>


--iVmcP82Ch3IQy/Z5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Our `lookup_commit_in_graph()` helper tries to look up commits from the
commit graph and, if it doesn't exist there, falls back to parsing it
=66rom the object database instead. This is intended to speed up the
lookup of any such commit that exists in the database. There is an edge
case though where the commit exists in the graph, but not in the object
database. To avoid returning such stale commits the helper function thus
double checks that any such commit parsed from the graph also exists in
the object database. This makes the function safe to use even when
commit graphs aren't updated regularly.

We're about to introduce the same pattern into other parts of our code
base though, namely `repo_parse_commit_internal()`. Here the extra
sanity check is a bit of a tougher sell: `lookup_commit_in_graph()` was
a newly introduced helper, and as such there was no performance hit by
adding this sanity check. If we added `repo_parse_commit_internal()`
with that sanity check right from the beginning as well, this would
probably never have been an issue to begin with. But by retrofitting it
with this sanity check now we do add a performance regression to
preexisting code, and thus there is a desire to avoid this or at least
give an escape hatch.

In practice, there is no inherent reason why either of those functions
should have the sanity check whereas the other one does not: either both
of them are able to detect this issue or none of them should be. This
also means that the default of whether we do the check should likely be
the same for both. To err on the side of caution, we thus rather want to
make `repo_parse_commit_internal()` stricter than to loosen the checks
that we already have in `lookup_commit_in_graph()`.

The escape hatch is added in the form of a new GIT_COMMIT_GRAPH_PARANOIA
environment variable that mirrors GIT_REF_PARANOIA. If enabled, which is
the default, we will double check that commits looked up in the commit
graph via `lookup_commit_in_graph()` also exist in the object database.
This same check will also be added in `repo_parse_commit_internal()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git.txt   | 10 ++++++++++
 commit-graph.c          |  6 +++++-
 commit-graph.h          |  6 ++++++
 t/t5318-commit-graph.sh | 21 +++++++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 11228956cd..3bac24cf8a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -911,6 +911,16 @@ for full details.
 	should not normally need to set this to `0`, but it may be
 	useful when trying to salvage data from a corrupted repository.
=20
+`GIT_COMMIT_GRAPH_PARANOIA`::
+	When loading a commit object from the commit-graph, Git performs an
+	existence check on the object in the object database. This is done to
+	avoid issues with stale commit-graphs that contain references to
+	already-deleted commits, but comes with a performance penalty.
++
+The default is "true", which enables the aforementioned behavior.
+Setting this to "false" disables the existence check. This can lead to
+a performance improvement at the cost of consistency.
+
 `GIT_ALLOW_PROTOCOL`::
 	If set to a colon-separated list of protocols, behave as if
 	`protocol.allow` is set to `never`, and each of the listed
diff --git a/commit-graph.c b/commit-graph.c
index fd2f700b2e..6d21ea6301 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -939,14 +939,18 @@ int repo_find_commit_pos_in_graph(struct repository *=
r, struct commit *c,
=20
 struct commit *lookup_commit_in_graph(struct repository *repo, const struc=
t object_id *id)
 {
+	static int commit_graph_paranoia =3D -1;
 	struct commit *commit;
 	uint32_t pos;
=20
+	if (commit_graph_paranoia =3D=3D -1)
+		commit_graph_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
+
 	if (!prepare_commit_graph(repo))
 		return NULL;
 	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &pos))
 		return NULL;
-	if (!has_object(repo, id, 0))
+	if (commit_graph_paranoia && !has_object(repo, id, 0))
 		return NULL;
=20
 	commit =3D lookup_commit(repo, id);
diff --git a/commit-graph.h b/commit-graph.h
index 20ada7e891..bd4289620c 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -8,6 +8,12 @@
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE "GIT_TEST_COMMIT_GRAPH_DIE_ON_P=
ARSE"
 #define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANGED=
_PATHS"
=20
+/*
+ * This environment variable controls whether commits looked up via the
+ * commit graph will be double checked to exist in the object database.
+ */
+#define GIT_COMMIT_GRAPH_PARANOIA "GIT_COMMIT_GRAPH_PARANOIA"
+
 /*
  * This method is only used to enhance coverage of the commit-graph
  * feature in the test suite with the GIT_TEST_COMMIT_GRAPH and
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index ba65f17dd9..c0cc454538 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -821,4 +821,25 @@ test_expect_success 'overflow during generation versio=
n upgrade' '
 	)
 '
=20
+test_expect_success 'stale commit cannot be parsed when given directly' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_commit B &&
+		git commit-graph write --reachable &&
+
+		oid=3D$(git rev-parse B) &&
+		rm .git/objects/"$(test_oid_to_path "$oid")" &&
+
+		# Verify that it is possible to read the commit from the
+		# commit graph when not being paranoid, ...
+		GIT_COMMIT_GRAPH_PARANOIA=3Dfalse git rev-list B &&
+		# ... but parsing the commit when double checking that
+		# it actually exists in the object database should fail.
+		test_must_fail git rev-list -1 B
+	)
+'
+
 test_done
--=20
2.42.0


--iVmcP82Ch3IQy/Z5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAqb0ACgkQVbJhu7ck
PpQeqg//UDrRRrOGZ4hiTwsMZmWF57YHP2IbNiaZpXMPFQtM0xtq7FXSlwHlKRYu
xN1C7ZPA7VF0Al3pnbojnSuk9ug7mkqhIvXlfcWgEKVdVjb/A+bGEZ5C+aRrU5FR
ciuhinSR+cOOPjVBdFf/gSBMtKhaBUUzCG1+jndQdsfsy+Hn0Fao3iOr93stpH++
V3JaAN3/Bvk+arGx0zIVHCpK8WtLeYYymrkJrGh1WTs4xiBb2Nr5Zjp9RBd4NXJ4
zBrqgMlXi05m3QujA+d/BMmBYohsgM74dJpiYj6PGoiU8tQhfBad+7LMvgm6A1hb
xVRuSvKVsP2/U813uYJl/smkyc2CNNiOOBMkRuG3bO+OI5cJWqWJbrJD4vc5Ybz/
UBmXsZEgvcJdNlJ072zihgcNZFn5ve5D5VYHfLGQD4lbjx/8nPNJVMqHfJqGZTB3
ctsYc+WGn83K5ilHDqTFZPVum3AtgNIU4qRCdO2A8PFVM0JTyXFpceDclvoiUuMr
TfdGTuHDde5LhpK1Nm72pd61ndq1ufa7di5kXXqUOL3+MGe18T13SjHUaI9NO3Nz
fkCtB2k3Ct6xiY7fvgRMpmxYeEbkhp6RvNv/E2mpaHfkqk/lDlLepviU8fC5s3Lx
ajItgx3qD/bQPnTMT+FOaS+iRzi4NBnfummuijnvJq5vu3Wgxso=
=4cJj
-----END PGP SIGNATURE-----

--iVmcP82Ch3IQy/Z5--
