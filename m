Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BCC15E85
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ty8U0mLw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tfqbx1G7"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F8AC1
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 04:27:20 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 0C498320097D;
	Mon, 23 Oct 2023 07:27:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 23 Oct 2023 07:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698060439; x=1698146839; bh=lF
	CK0KTX+2Y/XXO2kKtdk0mvtPkS7kkoKSa2QgR1v0Q=; b=ty8U0mLwUtzJ5JuJxW
	i/l8zN4PVY8o2R135vc0Bx9tTU6bfSusOSeKcu3YfAAggnbeWBFhUIiIBqNDXEbc
	74fo5L2ucg7cj2cCakYuHVdbl0ZzgpxigzYOBVFoLuS1+/kC30yCZmgU/k54/KMV
	9e1XS7HDWmKPuh0AOESjO9Uh9rthRajwB/gi0gdSMzrnqE6lK5OTeFQrLVPOOJvk
	d2MamEIVATOkTqZWTf/upCGP+f/I/ljYh6/uAAhnMYDRPM46mdegpBGo59QVNMJr
	n817WafAucKB0gKwD8t7m2KkiUAJeWCJX7M8+OxiLpvMhL65vseKZx/mxmy141Fp
	FUoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698060439; x=1698146839; bh=lFCK0KTX+2Y/X
	XO2kKtdk0mvtPkS7kkoKSa2QgR1v0Q=; b=Tfqbx1G7GDiC/m9EFxKJVQIYiQNV8
	/gby+C9aEjTj09aApps4NE2eHXaBoEKJqXYqrsGnVtXUIKJHdc+gVJInVi/I+KZo
	RPxbuiTZze2ehICykv4aMQaBmkF1+EtjSaRp4WAKMfvEjvaVPpNePjYVkpSttG8+
	xZ4wE9g4xnH4IWxYkL4qtO3NCCX+Tk0yAOwQfwNjkjkMZW/DXKcCvoxlhkVeO3yd
	chUC86IQe2kM4PqbgLXo8EnQRzQ5eKteRlm2Uncu2B8m/ahEUFelEL4c6AsEkbT7
	IiTadhueKh1NyyR68y2IbEtqTg6CpPI/zSWwTZfUa+tHO8b6SG2AHsEiA==
X-ME-Sender: <xms:l1g2ZQsXe_gvvF2CfOISSyFDG5EAq-TwI5eri6MLnhzFsBd-nBFfZQ>
    <xme:l1g2ZdfNNnNCQWz86yTSeVnii3Ho0F8vML6HzOUfDWRftnsjodSGR2Af6XyhgtJhK
    vVEoHKEt8rVwybS7w>
X-ME-Received: <xmr:l1g2Zbwm2XarPOVs1xjDL8LaY1Gy9D6sbAErePBeBjX077qxjG1AOKpVabwdMY0DBuf1meo11Skdxh_6EnZC6QvsGzynB_KcYsHjCyCn2wBW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:l1g2ZTPSdbWKjOGj-K47aMpzwtSB2bnn4j1oeN5E2YUH5J5F1W7KCQ>
    <xmx:l1g2ZQ8WTFvqV_DF87_0U_1m9nHxOVP4dJl7l7feO52XgJWlqR0e_g>
    <xmx:l1g2ZbV68RO6bRk1OyQokrr0q_lSDKGx8K7_rHmH-jqUHKS5N74Pkw>
    <xmx:l1g2ZfahKJq1OhtA7E21wo8UfOtHeAtnNHvHy5SjZ6QQPcSS7O21Dw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 07:27:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c1d978b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 11:27:15 +0000 (UTC)
Date: Mon, 23 Oct 2023 13:27:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 1/2] commit-graph: introduce envvar to disable commit
 existence checks
Message-ID: <a89c4355285bc0bb0ec339818e6fe907f9ffd30e.1698060036.git.ps@pks.im>
References: <cover.1698060036.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mqHZ7MQatWDgc4+S"
Content-Disposition: inline
In-Reply-To: <cover.1698060036.git.ps@pks.im>


--mqHZ7MQatWDgc4+S
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
 Documentation/git.txt   |  9 +++++++++
 commit-graph.c          |  6 +++++-
 commit-graph.h          |  6 ++++++
 t/t5318-commit-graph.sh | 21 +++++++++++++++++++++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 11228956cd..22c2b537aa 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -911,6 +911,15 @@ for full details.
 	should not normally need to set this to `0`, but it may be
 	useful when trying to salvage data from a corrupted repository.
=20
+`GIT_COMMIT_GRAPH_PARANOIA`::
+	If this Boolean environment variable is set to false, ignore the
+	case where commits exist in the commit graph but not in the
+	object database. Normally, Git will check whether commits loaded
+	from the commit graph exist in the object database to avoid
+	issues with stale commit graphs, but this check comes with a
+	performance penalty. The default is `1` (i.e., be paranoid about
+	stale commits in the commit graph).
+
 `GIT_ALLOW_PROTOCOL`::
 	If set to a colon-separated list of protocols, behave as if
 	`protocol.allow` is set to `never`, and each of the listed
diff --git a/commit-graph.c b/commit-graph.c
index fd2f700b2e..12ec31902e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -939,14 +939,18 @@ int repo_find_commit_pos_in_graph(struct repository *=
r, struct commit *c,
=20
 struct commit *lookup_commit_in_graph(struct repository *repo, const struc=
t object_id *id)
 {
+	static int object_paranoia =3D -1;
 	struct commit *commit;
 	uint32_t pos;
=20
+	if (object_paranoia =3D=3D -1)
+		object_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
+
 	if (!prepare_commit_graph(repo))
 		return NULL;
 	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &pos))
 		return NULL;
-	if (!has_object(repo, id, 0))
+	if (object_paranoia && !has_object(repo, id, 0))
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


--mqHZ7MQatWDgc4+S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2WJMACgkQVbJhu7ck
PpTATg//X0ONNzQHxyxkIeipFo6GUbRQ1ZbG9u6umpt5FS3Re2pkaLKtIS30rpa2
84ZmQKRwL/I2nBtzZzDkL/eSoreTAqCb6NJ0vCr/lOr2WcqI7Jmb4WYpd0lwkLf9
PZUKy2iSk/4GcmV1AZbhRYfP1lco96xET7S1fuC2PjAYtOZ/FceHngDejjNV62et
ckYn54hcXYJ6zt9Rrai030htdFNac6KzeBlSjDI2+o7mc/gq33HhhuuPJOp7MUwk
ev1Nmd3+3olh+I5gwEM83cflNkc/il2DvIwYO6DyYy2mZkOciC/uHpH0rVB1Bunt
djQj2czhEtte+OC215i1xQzujHmgGao92xMkVNEEpTzQu3SMBHHmBBndJN2ZBbQ2
hlXm2+iLzRivnD5k5cgKSB56Xm3roZeSKcyoe4fMHPKKvh264/GvWhWbax6maoDv
CPUsEVOl7/dTCbZnq8nfY1agLDi5vSWBMVX2hph3WIlneXvDVCoNo3YjeeUR60ll
ED84lH8BdBzRWIK9EO277adtv1gLjTamXARNhDPFnxpBKNKOsYri3YEQPcW5L6i/
Rear9foEFcQcfq1Td6OhnrUW1kT9W7JNoylVv2lf8z+QmkpJ93j+TcfVndsX1WRW
1Ub/ZQsH/80cYmBBvp1zoQP5JvY33/fKn4cSiJr3FW+3rXn9aZI=
=Bc2X
-----END PGP SIGNATURE-----

--mqHZ7MQatWDgc4+S--
