Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED0D1C31
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AOP7vlSe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VJa/u0tD"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D12C0
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 00:16:15 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id D3C8B3200A15;
	Tue, 31 Oct 2023 03:16:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 31 Oct 2023 03:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698736574; x=1698822974; bh=V6
	QmuxscR3kBBcjbDSMLS0KPSscoPYjqiJA8bSdfvKc=; b=AOP7vlSeQv6PXXzy5s
	1BCWvtAeYMvglAem4Ln+M3pkQPjPlX1HlZmqUiAzumhrvNAcQ5u4gwgzYYta6wsh
	tVmt0/NC4hW+UayYHHoGNySD1+UVySKDzDO4UMJ39ghQZW8P7ugKRTa4LQa2vgeW
	YBb3GvloQrTvI9G1vA2fIh+LB2i/KyTvzKtmQPJImsdrtbweVcsVqE4ozTEXGor4
	nLBHyONb2PQD7aSI6z/RdigKfy2h7noD9RV0+Q9li2RGVK2oJ6QB0cHKhowH7dSv
	fLyiyT0F4v6A5FO/tUN3TY9fvTwHIyk15XDpkQjRrCm9ecVyYuqawjPjVa6rER+j
	K6OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698736574; x=1698822974; bh=V6QmuxscR3kBB
	cjbDSMLS0KPSscoPYjqiJA8bSdfvKc=; b=VJa/u0tDrG5cMfbYCairk35p/x9Rm
	1wZtu06z9/211bqxaptXgaHH2q6IZbdvf3+Ss8upx/py/L0+DOQWrC+BQfSJ0llM
	NuyChwUCuhSb8vzD8agRqTAROr4qy9Nx5SP06P/P5ZNNL8AjUHCF0uKd44hTGPn1
	dRrTqhkF9euEzp4SCicyFmqb1cXmEuq7H70PkfovJTjvFiiF331d/1lG3UmANFtb
	mNZpNucSe3ml/6TvNr/j+TrhSFx4JRxsIfgXc4687f1BAnMVMAGlhd5O7bz62HoP
	vIhpv25I5iDpZwQUsltncS/FDOJMe5sGyqElhuhcmJe1X6/8+jtsYPp+g==
X-ME-Sender: <xms:vqlAZSPsf1o9eahXja2N3CJHSq71BnMUfsrA_J_VQr80AbbEvANshA>
    <xme:vqlAZQ8Z2chqDWRdCfg12xhvl8td180v6CyBB-Z0HEhxWIPrp7hnJtAafsb92sjP9
    DruHknee5_7sPLBvQ>
X-ME-Received: <xmr:vqlAZZR9J6RvNmGmfbF6Wwo1BVMllpUPxYqB-JFQCzPlFpl78GqGTDoO2ANTdNEyARaKK2o0Yz-o0MGtRD3eV2ARxAoCf-il4Lr7tt2rTEgdupU3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:vqlAZSvc9sBM_uYu2QQpVMtWW779PwlbmYQoKhUl7M4EZdowdc0qrw>
    <xmx:vqlAZack0nBFRYgsXt7fqt2Q0LJkM06wGFIamabN-M5IiA6hU3vNGw>
    <xmx:vqlAZW1BQvNDDyYueAXmV5sM2d_MnUEjrPPnrHACdd8RgXBXU58IVw>
    <xmx:vqlAZa6Hlo8StYznSJSWGESGhF8ROGoNIHM5qm0X_f4WX0fpElg5aw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 03:16:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 88a8e3da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 07:16:03 +0000 (UTC)
Date: Tue, 31 Oct 2023 08:16:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 0/2] commit-graph: detect commits missing in ODB
Message-ID: <cover.1698736363.git.ps@pks.im>
References: <cover.1698060036.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hDSIqqaL/93MmO5v"
Content-Disposition: inline
In-Reply-To: <cover.1698060036.git.ps@pks.im>


--hDSIqqaL/93MmO5v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is version 3 of my patch series to more readily detect commits
parsed from the commit graph which are missing in the object database.

Changes compared to v2:

    - Rewrote the help text for `GIT_COMMIT_GRAPH_PARANOIA` to be more
      accessible.

    - Renamed the `object_paranoia` variable to `commit_graph_paranoia`.

    - Fixed a typo.

Thanks!

Patrick

Patrick Steinhardt (2):
  commit-graph: introduce envvar to disable commit existence checks
  commit: detect commits that exist in commit-graph but not in the ODB

 Documentation/git.txt   | 10 +++++++++
 commit-graph.c          |  6 +++++-
 commit-graph.h          |  6 ++++++
 commit.c                | 16 +++++++++++++-
 t/t5318-commit-graph.sh | 48 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 84 insertions(+), 2 deletions(-)

Range-diff against v2:
1:  a89c435528 ! 1:  c433ec1254 commit-graph: introduce envvar to disable c=
ommit existence checks
    @@ Documentation/git.txt: for full details.
      	useful when trying to salvage data from a corrupted repository.
     =20
     +`GIT_COMMIT_GRAPH_PARANOIA`::
    -+	If this Boolean environment variable is set to false, ignore the
    -+	case where commits exist in the commit graph but not in the
    -+	object database. Normally, Git will check whether commits loaded
    -+	from the commit graph exist in the object database to avoid
    -+	issues with stale commit graphs, but this check comes with a
    -+	performance penalty. The default is `1` (i.e., be paranoid about
    -+	stale commits in the commit graph).
    ++	When loading a commit object from the commit-graph, Git performs an
    ++	existence check on the object in the object database. This is done to
    ++	avoid issues with stale commit-graphs that contain references to
    ++	already-deleted commits, but comes with a performance penalty.
    +++
    ++The default is "true", which enables the aforementioned behavior.
    ++Setting this to "false" disables the existence check. This can lead to
    ++a performance improvement at the cost of consistency.
     +
      `GIT_ALLOW_PROTOCOL`::
      	If set to a colon-separated list of protocols, behave as if
    @@ commit-graph.c: int repo_find_commit_pos_in_graph(struct repository =
*r, struct c
     =20
      struct commit *lookup_commit_in_graph(struct repository *repo, const =
struct object_id *id)
      {
    -+	static int object_paranoia =3D -1;
    ++	static int commit_graph_paranoia =3D -1;
      	struct commit *commit;
      	uint32_t pos;
     =20
    -+	if (object_paranoia =3D=3D -1)
    -+		object_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
    ++	if (commit_graph_paranoia =3D=3D -1)
    ++		commit_graph_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1=
);
     +
      	if (!prepare_commit_graph(repo))
      		return NULL;
      	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &po=
s))
      		return NULL;
     -	if (!has_object(repo, id, 0))
    -+	if (object_paranoia && !has_object(repo, id, 0))
    ++	if (commit_graph_paranoia && !has_object(repo, id, 0))
      		return NULL;
     =20
      	commit =3D lookup_commit(repo, id);
2:  0476d48555 ! 2:  8629fd0892 commit: detect commits that exist in commit=
-graph but not in the ODB
    @@ commit.c: int repo_parse_commit_internal(struct repository *r,
      		return 0;
     -	if (use_commit_graph && parse_commit_in_graph(r, item))
     +	if (use_commit_graph && parse_commit_in_graph(r, item)) {
    -+		static int object_paranoia =3D -1;
    ++		static int commit_graph_paranoia =3D -1;
     +
    -+		if (object_paranoia =3D=3D -1)
    -+			object_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
    ++		if (commit_graph_paranoia =3D=3D -1)
    ++			commit_graph_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, =
1);
     +
    -+		if (object_paranoia && !has_object(r, &item->object.oid, 0)) {
    ++		if (commit_graph_paranoia && !has_object(r, &item->object.oid, 0)) {
     +			unparse_commit(r, &item->object.oid);
     +			return quiet_on_missing ? -1 :
     +				error(_("commit %s exists in commit-graph but not in the object d=
atabase"),
    @@ t/t5318-commit-graph.sh: test_expect_success 'stale commit cannot be=
 parsed when
     +		test_commit C &&
     +		git commit-graph write --reachable &&
     +
    -+		# Corrupt the repository by deleting the intermittent commit
    ++		# Corrupt the repository by deleting the intermediate commit
     +		# object. Commands should notice that this object is absent and
     +		# thus that the repository is corrupt even if the commit graph
     +		# exists.
--=20
2.42.0


--hDSIqqaL/93MmO5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAqbgACgkQVbJhu7ck
PpTFdQ//SmM8FBqUSJ7xX1eOA7JKp3G0KmEaudeKC0z7r27caRG6aQmQEEODe2ij
JfLoA8RG36i461ghBwSsE6fCrBXX8xmdRyqZCZ1KsH6MXyvWEB+W4Mtugr8ttQeG
3DjARNLDKnA7f0tpKP9PKJGUYhmHoCs7vSic39WM6ih/6IgLvA2xOhO0xL2sY9ny
WdRDJfRtDQFr7xI8dta7hk1IKGPA63uoJdxZ9TkJXtLpXzZWLho6qCbSDSkYY+AY
DmoAodPiWUtMw3gM0MzBbFRW197D7t1ML81RBkM7QgHB6jrG1cFyG1R9uhFwqTN1
2LocRRHtPemZSWrUM5OfuAKKV4oBoXf+9tgd8PTF8xaCdkwPRIRBDavz3bylLWrt
ZrMlr8pAbYmVP4ZPDMIk0asOgL9CfcR1t4CD2CqxhsNZwuK+66fUYv+oO8xXAuRg
/uYOCQn9ZPIwJfLFoKVqEadVDJtkLMJTJ3qIu/2on55Bd04ghrEPY/WAYhRk9r6A
BKrJL+4nm15NCncgZHOTgmrQ8ZOEwVz2y8UjqAxnjvFX6c0T5TSwAk8BIZcnlqtF
gaewveIWcITKlDixtECHUMRnGY7FnEOyq77ZpM/1S8BWl2n5B95SZCQW2foQdju5
9z5KGWuYj5CoPaPjwruIHH+81x/rVrfHQtqST+s8v5B1tHGxcfU=
=gxmG
-----END PGP SIGNATURE-----

--hDSIqqaL/93MmO5v--
