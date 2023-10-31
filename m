Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B810784
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bG5Ewwpr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U3QQz0fP"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3997091
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:20:04 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 534D83200A81;
	Tue, 31 Oct 2023 02:20:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 31 Oct 2023 02:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698733199; x=1698819599; bh=Wl
	lWMjfCyN/TGewB3zcKLPcaBHspmIjjQatzZVyZjdc=; b=bG5Ewwpr2eSTG8pham
	jmm7fQtCT8nQl+n4B15ord4xIgh2rTF62vxr2DCmkECPGMXFu5ewHlh4e5wDpOEF
	Kfh004SiFJm+2WRKEyboiL1ETQuOfMk0phESxDbxozKbcyfIHdlvHguVTiyOyOlS
	JRA1ORR4hIliTFpxJUmAXNTHkggJzXlLwYA4pf49+vtgzqMQsGYtbM0awz3Peugn
	04ZyuDfgY4D7kJ4AV8DnnxCHPCFUTr28CKeLFJPh8CKuKP+YS0eCTSDDi2c3rC7/
	/gi7k5Xw/wPUlXJ6edlanFNr/mAYbnoaxzNAIFSQntVO4fNucw3bn0zoU3G/wkdD
	IIPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698733199; x=1698819599; bh=WllWMjfCyN/TG
	ewB3zcKLPcaBHspmIjjQatzZVyZjdc=; b=U3QQz0fP61nGUE6LyHAsWwOi3NG9L
	/lUaJwDQVIzmSK9jv+TIFay9z4KOGUmrzCmPAtgn0ZIlySHspCOESyPIP8i9QZbW
	7aDXbE38WQdJDrnXA4bIuKVvlykB/FLiA6/ajtM0JILnLYE5L/O9brluSnccvQBp
	D6razqS7vAPnFdLogzLgdLmFUTE3g0wXlBSGuKdoxIFMkzoLqdWhqhOOmtI41Kgd
	ISqBeaHMraKsk49qRFb4ccgiXcPr6u13oypEOmikQFyDxrxsl/gsMjCKuRszSgM7
	9dOpFMzB1dCWl4NBNWxYpBmG5vPkWUm71CuRY6sKcxvoztCPl8YNbEoiA==
X-ME-Sender: <xms:j5xAZd9l0ygIbI7saxLLSWN9MFlQqv7J9KvBDy4WFNEoPPznuvOMBA>
    <xme:j5xAZRvWEuOVqDdAPt0qRPxo1Vz3BCeRaKyM0mKxb8W1N27pwpI6siYEsa30Xd8tw
    -01zLnNBb3f5kfCcQ>
X-ME-Received: <xmr:j5xAZbDDpV2iL73W1MaUpIZ1saBDQoGJlMjTWBkvEuboWi7qZRLeHLyzSMC_QZbZJjivhh5A4Pn9KbRcUB9CAqS4swyOQ37V078DjPh5zZXfQsrx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:j5xAZRfehxiON1SzbVqYXaPFTEoNeU2Y_EInE_jn4_nt9cIwJHyjow>
    <xmx:j5xAZSP-2W6KYwjgn9AkugCTeiiflMLw2PcDYSajfxtFr5V1VLu75A>
    <xmx:j5xAZTlDTzC-IeyL-wy-jZaJXv-vXIPixoId2-QMDwYcxpaijGnKZA>
    <xmx:j5xAZfp23XiWxQxWNQy6IXPkPXlAaoR1YvCfhfe5uM0-UYErwF0nBg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 02:19:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1a0f200d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 06:19:49 +0000 (UTC)
Date: Tue, 31 Oct 2023 07:19:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] commit-graph: introduce envvar to disable commit
 existence checks
Message-ID: <ZUCci5kcGj-5Ybcn@tanuki>
References: <cover.1698060036.git.ps@pks.im>
 <a89c4355285bc0bb0ec339818e6fe907f9ffd30e.1698060036.git.ps@pks.im>
 <ZUAgPVR8HxgEZEWo@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OXhe/lalonnDWGz+"
Content-Disposition: inline
In-Reply-To: <ZUAgPVR8HxgEZEWo@nand.local>


--OXhe/lalonnDWGz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 05:29:33PM -0400, Taylor Blau wrote:
> On Mon, Oct 23, 2023 at 01:27:16PM +0200, Patrick Steinhardt wrote:
> > Our `lookup_commit_in_graph()` helper tries to look up commits from the
> > commit graph and, if it doesn't exist there, falls back to parsing it
> > from the object database instead. This is intended to speed up the
> > lookup of any such commit that exists in the database. There is an edge
> > case though where the commit exists in the graph, but not in the object
> > database. To avoid returning such stale commits the helper function thus
> > double checks that any such commit parsed from the graph also exists in
> > the object database. This makes the function safe to use even when
> > commit graphs aren't updated regularly.
> >
> > We're about to introduce the same pattern into other parts of our code
> > base though, namely `repo_parse_commit_internal()`. Here the extra
> > sanity check is a bit of a tougher sell: `lookup_commit_in_graph()` was
> > a newly introduced helper, and as such there was no performance hit by
> > adding this sanity check. If we added `repo_parse_commit_internal()`
> > with that sanity check right from the beginning as well, this would
> > probably never have been an issue to begin with. But by retrofitting it
> > with this sanity check now we do add a performance regression to
> > preexisting code, and thus there is a desire to avoid this or at least
> > give an escape hatch.
> >
> > In practice, there is no inherent reason why either of those functions
> > should have the sanity check whereas the other one does not: either both
> > of them are able to detect this issue or none of them should be. This
> > also means that the default of whether we do the check should likely be
> > the same for both. To err on the side of caution, we thus rather want to
> > make `repo_parse_commit_internal()` stricter than to loosen the checks
> > that we already have in `lookup_commit_in_graph()`.
>=20
> All well reasoned. I think the most compelling reason is that we're
> already doing this extra check in lookup_commit_in_graph(), and having
> that be somewhat inconsistent with repo_parse_commit_internal() feels
> error-prone to me.
>=20
> > The escape hatch is added in the form of a new GIT_COMMIT_GRAPH_PARANOIA
> > environment variable that mirrors GIT_REF_PARANOIA. If enabled, which is
> > the default, we will double check that commits looked up in the commit
> > graph via `lookup_commit_in_graph()` also exist in the object database.
> > This same check will also be added in `repo_parse_commit_internal()`.
>=20
> Sounds good.
>=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  Documentation/git.txt   |  9 +++++++++
> >  commit-graph.c          |  6 +++++-
> >  commit-graph.h          |  6 ++++++
> >  t/t5318-commit-graph.sh | 21 +++++++++++++++++++++
> >  4 files changed, 41 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git.txt b/Documentation/git.txt
> > index 11228956cd..22c2b537aa 100644
> > --- a/Documentation/git.txt
> > +++ b/Documentation/git.txt
> > @@ -911,6 +911,15 @@ for full details.
> >  	should not normally need to set this to `0`, but it may be
> >  	useful when trying to salvage data from a corrupted repository.
> >
> > +`GIT_COMMIT_GRAPH_PARANOIA`::
> > +	If this Boolean environment variable is set to false, ignore the
> > +	case where commits exist in the commit graph but not in the
> > +	object database. Normally, Git will check whether commits loaded
> > +	from the commit graph exist in the object database to avoid
> > +	issues with stale commit graphs, but this check comes with a
> > +	performance penalty. The default is `1` (i.e., be paranoid about
> > +	stale commits in the commit graph).
> > +
>=20
> The first two sentences seem to be flipped. Perhaps:
>=20
>     When loading a commit object from the commit-graph, Git will perform
>     an existence check on the object in the ODB before parsing it out of
>     the commit-graph. The default is "true", which enables the
>     aforementioned behavior. Setting this to "false" disables the
>     existential check when parsing commits from a commit-graph.

I was modelling this after the text we had in `GIT_REF_PARANOIA`, but I
like your version more indeed. I'll massage it a bit to mention _why_
one would want to disable this.

> >  `GIT_ALLOW_PROTOCOL`::
> >  	If set to a colon-separated list of protocols, behave as if
> >  	`protocol.allow` is set to `never`, and each of the listed
> > diff --git a/commit-graph.c b/commit-graph.c
> > index fd2f700b2e..12ec31902e 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -939,14 +939,18 @@ int repo_find_commit_pos_in_graph(struct reposito=
ry *r, struct commit *c,
> >
> >  struct commit *lookup_commit_in_graph(struct repository *repo, const s=
truct object_id *id)
> >  {
> > +	static int object_paranoia =3D -1;
> >  	struct commit *commit;
> >  	uint32_t pos;
> >
> > +	if (object_paranoia =3D=3D -1)
> > +		object_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
> > +
>=20
> I don't think that this is a reroll-able issue, but calling this
> variable object_paranoia to store a setting for *graph* paranoia feels
> like a good itch to scratch. But obviously not a big deal ;-).

Ugh, yeah. I first had the envvar as "GIT_OBJECT_PARANOIA", but
discarded that name because I feared that it might become overloaded
with semi-related checks.

Will fix.

> > @@ -821,4 +821,25 @@ test_expect_success 'overflow during generation ve=
rsion upgrade' '
> >  	)
> >  '
> >
> > +test_expect_success 'stale commit cannot be parsed when given directly=
' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit A &&
> > +		test_commit B &&
> > +		git commit-graph write --reachable &&
> > +
> > +		oid=3D$(git rev-parse B) &&
> > +		rm .git/objects/"$(test_oid_to_path "$oid")" &&
> > +
> > +		# Verify that it is possible to read the commit from the
> > +		# commit graph when not being paranoid, ...
> > +		GIT_COMMIT_GRAPH_PARANOIA=3Dfalse git rev-list B &&
> > +		# ... but parsing the commit when double checking that
> > +		# it actually exists in the object database should fail.
> > +		test_must_fail git rev-list -1 B
>=20
> Would "cat-file -p" be more direct here than "rev-list -1"?

No, because it doesn't use `lookup_commit_in_graph()`. I had to go
searching a bit to find something that exposes this inconsistency, and
git-rev-list(1) was the easiest one I found.

Patrick

--OXhe/lalonnDWGz+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAnIUACgkQVbJhu7ck
PpT5jBAAromemnAEJ73XrtsKbdUV1bMNT0VnlftfmmUQNU3EATBnoKzfQtVcsfWH
F14paOXwWCDCz898gnG2j40oJ0zfjl24fO6pG/898OeJ9O4OoMn9e8uWzt+0Amto
B3lHXmoBnNq6DiIwvqix1/CQHOdSOhbP4D6509DzYFaKvRR/5e+IA+5FbH9npDmL
my8pigWtvildm/3AHLQllCBf+5nUerwpXvDMK5P965ZwzfIXNJHSeaS00Y7PLZew
VvJ99cJ0x4sA22+zlRjbOd3TrMIGqUWAPfnXroD0GnJnily8gv6r+OU42yerkuSP
J9M4JAZwyAFktcNDZ1ogTMmNEC2bf24auzhpRvxBg0Pj9LFk0h4zCu6MYUe4UTvm
OGKXeUr7TX25PVB099h+loBhYtakw217yahW6wRBE/xQ8t7Zn8bi2kp7OubOcp3S
LJtcm7EE1UFafWqfE13013K2h5ZgJiKAURfpI66djXuw9Bjd+TbhwRqOzxVSRW0X
xzzsOpcKqHw20tdchGLufH2vAmygWqJnl0JWOrwFFy+2x7wkEkvQav0vDNMAjyud
4GImxhVdGKq5rG0YO8k7Z64LHTo7JN5ek5K5ej7VLvIGkJL0vGoueClNjiSJWR/M
CQ1cNYm2Bji078PPus/d0FkPz2MW7mw5+LPbxBQlT7q5tO08Kmk=
=NuMP
-----END PGP SIGNATURE-----

--OXhe/lalonnDWGz+--
