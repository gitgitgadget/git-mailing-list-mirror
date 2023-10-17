Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB1154B0
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EtsLBURi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EpPcmZap"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D92BA7
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 23:37:22 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 5ECC93200A90;
	Tue, 17 Oct 2023 02:37:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 17 Oct 2023 02:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697524638; x=1697611038; bh=Td
	uUNfiFba1ROk+uo7S5VUZI5RIASc9MbnG4FtG+Aj8=; b=EtsLBURic4ec7zkPdY
	BtTTERD9VrxOz8O3yqlzYYKrcull2giWsIyfJdCFJDB3g1IvEG9hNXMdYes7ZNYr
	lTCRMgboSy0aA/dp+fkH8NDCFJ4tcTpBsEO7pK5tEoO5NRF3WS2I0jYwb+gangdh
	fUCbLkxDhsH06yy35d9czFjEila1q8l+rpG9bXdplfWmLPWMhaEtZ/7EkgJhCbVr
	2g7FgRNCoAZ1jThZ9oA8X5qnmXdlN3nC93840h3dwJz6NXvzp8izO7WVGUN6LLVy
	eJ9fsS49fEIzeCmy5NHUXtkC4pNGErHF7VJxQnxLMEl6mL4EhpZLLY9mGq6QD7TJ
	vLtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697524638; x=1697611038; bh=TduUNfiFba1RO
	k+uo7S5VUZI5RIASc9MbnG4FtG+Aj8=; b=EpPcmZapVzhlRjwaa7CClFmvWOki+
	4XQLqmcaX4M+Mxx9YpS1Xy9CQn4lxEbDBMPRCoXvqk+ngn+h0gXm/+b60T/TDwko
	TIqz2W4Da+aqPz1AFegGou/8r7vXmhf1xpoUKrgNYCjKfgq+YkeRIzREngHgN8gU
	+tKmlUmGqV4leZraeaWfvPrymwKJzqkEAGesXWJ7Rv+4P0PssDRkTLOfz8dbXAn9
	w+d22FIUlpci/pXLpClaiaR2Kg/weosQDCG8kYoi8VfxyB1uAJReHbefunzBZTEE
	oGqJGpel5pn6SMulUZwUfN6fCFbC8oTMnoHAF7mKB9nukuxBHcS2elDGQ==
X-ME-Sender: <xms:nisuZWvtSlHDa6U-dtsM9in3fTMuClKtOmyE1xG1Yvrjm4Ns-8tsPg>
    <xme:nisuZbdUz97fwz2CXQO_dAn2cwl245vo3rDGQkD2WI-MMv-g6eq_4C96o5rekIfNr
    rVf0c8Nu0ib0cUfLA>
X-ME-Received: <xmr:nisuZRzUd-YZIDbWvEcP9EsvL2r6lHzmLrRF0PIjqX2XrPqRY_qX-WA7jEi1Pyl9LtRIjQDXu88qQ6DZOuUTZbpMptNmLMo3Fum7CUabZ76fPbk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedugddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:nisuZRPkSeDD-ah8tTNb7OdvMZ0N3ufCCVwomTHBGamFvQ8kX850TA>
    <xmx:nisuZW_yJtpuDEYYUl4ouzYli88zHeuj7NS7Q5kGXnlOBPPSkKTSfw>
    <xmx:nisuZZWPnyEu8b1CgtNPPaUmjuOqF_p0jgUDMmEfv__Ip47IhabKYw>
    <xmx:nisuZYI-bgeljlXdQ5l_nDi43t9aRxjrkDrAW2LsPMWItRSACj-92A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Oct 2023 02:37:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 76cec625 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Oct 2023 06:37:15 +0000 (UTC)
Date: Tue, 17 Oct 2023 08:37:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] commit: detect commits that exist in commit-graph but
 not in the ODB
Message-ID: <ZS4rmtBTYnp2RMiY@tanuki>
References: <ZSkCGS3JPEQ71dOF@tanuki>
 <b0bf576c51a706367a758b8e30eca37edb9c2734.1697200576.git.ps@pks.im>
 <xmqq1qdy1iyr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X+gxa2eBjiM2P8tL"
Content-Disposition: inline
In-Reply-To: <xmqq1qdy1iyr.fsf@gitster.g>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--X+gxa2eBjiM2P8tL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 11:21:48AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > @@ -572,8 +572,13 @@ int repo_parse_commit_internal(struct repository *=
r,
> >  		return -1;
> >  	if (item->object.parsed)
> >  		return 0;
> > -	if (use_commit_graph && parse_commit_in_graph(r, item))
> > +	if (use_commit_graph && parse_commit_in_graph(r, item)) {
> > +		if (!has_object(r, &item->object.oid, 0))
> > +			return quiet_on_missing ? -1 :
> > +				error(_("commit %s exists in commit-graph but not in the object da=
tabase"),
> > +				      oid_to_hex(&item->object.oid));
> >  		return 0;
> > +	}
>=20
> Ever since this codepath was introduced by 177722b3 (commit:
> integrate commit graph with commit parsing, 2018-04-10), we blindly
> trusted what commit-graph file says.  This change is a strict
> improvement in the correctness department, but there are two things
> that are a bit worrying.
>=20
> One.  The additional check should certainly be cheaper than a full
> reading and parsing of an object, either from a loose object file or
> from a pack entry.  It may not hurt performance too much, but it
> still would give us more confidence if we know by how much we are
> pessimising good cases where the commit-graph does match reality.
> Our stance on these secondary files that store precomputed values
> for optimization purposes is in general to use them blindly unless
> in exceptional cases where the operation values the correctness even
> when the validity of these secondary files is dubious (e.g., "fsck"),
> and doing this extra check regardless of the caller at this low level
> of the callchain is a bit worrying.

Fair point indeed. The following is a worst-case scenario benchmark of
of the change where we do a full topological walk of all reachable
commits in the graph, executed in linux.git. We parse commit parents via
`repo_parse_commit_gently()`, so the new code path now basically has to
check for object existence of every reachable commit:

Benchmark 1: git -c core.commitGraph=3Dtrue rev-list --topo-order --all (gi=
t =3D master)
  Time (mean =C2=B1 =CF=83):      2.913 s =C2=B1  0.018 s    [User: 2.363 s=
, System: 0.548 s]
  Range (min =E2=80=A6 max):    2.894 s =E2=80=A6  2.950 s    10 runs

Benchmark 2: git -c core.commitGraph=3Dtrue rev-list --topo-order --all (gi=
t =3D pks-commit-graph-inconsistency)
  Time (mean =C2=B1 =CF=83):      3.834 s =C2=B1  0.052 s    [User: 3.276 s=
, System: 0.556 s]
  Range (min =E2=80=A6 max):    3.780 s =E2=80=A6  3.961 s    10 runs

Benchmark 3: git -c core.commitGraph=3Dfalse rev-list --topo-order --all (g=
it =3D master)
  Time (mean =C2=B1 =CF=83):     13.841 s =C2=B1  0.084 s    [User: 13.152 =
s, System: 0.687 s]
  Range (min =E2=80=A6 max):   13.714 s =E2=80=A6 13.995 s    10 runs

Benchmark 4: git -c core.commitGraph=3Dfalse rev-list --topo-order --all (g=
it =3D pks-commit-graph-inconsistency)
  Time (mean =C2=B1 =CF=83):     13.762 s =C2=B1  0.116 s    [User: 13.094 =
s, System: 0.667 s]
  Range (min =E2=80=A6 max):   13.645 s =E2=80=A6 14.038 s    10 runs

Summary
  git -c core.commitGraph=3Dtrue rev-list --topo-order --all (git =3D maste=
r) ran
    1.32 =C2=B1 0.02 times faster than git -c core.commitGraph=3Dtrue rev-l=
ist --topo-order --all (git =3D pks-commit-graph-inconsistency)
    4.72 =C2=B1 0.05 times faster than git -c core.commitGraph=3Dfalse rev-=
list --topo-order --all (git =3D pks-commit-graph-inconsistency)
    4.75 =C2=B1 0.04 times faster than git -c core.commitGraph=3Dfalse rev-=
list --topo-order --all (git =3D master)

The added check does lead to a performance regression indeed, which is
not all that unexpected. That being said, the commit-graph still results
in a significant speedup compared to the case where we don't have it.

> Another is that by the time parse_commit_in_graph() returns true and
> we realize that the answer we got is bogus by asking has_object(),
> item->object.parsed has already been toggled on, so the caller now
> has a commit object that claimed it was already parsed and does not
> match reality.  Hopefully the caller takes an early exit upon seeing
> a failure from parse_commit_gently() and the .parsed bit does not
> matter, but maybe I am missing a case where it does.  I dunno.

We could also call `unparse_commit()` when we notice the stale commit
graph item. This would be in the same spirit as the rest of this patch
as it would lead to an overall safer end state.

In any case I'll wait for additional input before sending a v2, most
importantly to see whether we think that consistency trumps performance
in this case. Personally I'm still of the mind that it should, which
also comes from the fact that we were fighting with stale commit graphs
several times in production data.

Patrick

> Other than that, sounds very sensible and the code change is clean.
>=20
> Will queue.  Thanks.
>=20
> > diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> > index ba65f17dd9..25f8e9e2d3 100755
> > --- a/t/t5318-commit-graph.sh
> > +++ b/t/t5318-commit-graph.sh
> > @@ -821,4 +821,27 @@ test_expect_success 'overflow during generation ve=
rsion upgrade' '
> >  	)
> >  '
> > =20
> > +test_expect_success 'commit exists in commit-graph but not in object d=
atabase' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +
> > +		test_commit A &&
> > +		test_commit B &&
> > +		test_commit C &&
> > +		git commit-graph write --reachable &&
> > +
> > +		# Corrupt the repository by deleting the intermittent commit
> > +		# object. Commands should notice that this object is absent and
> > +		# thus that the repository is corrupt even if the commit graph
> > +		# exists.
> > +		oid=3D$(git rev-parse B) &&
> > +		rm .git/objects/"$(test_oid_to_path "$oid")" &&
> > +
> > +		test_must_fail git rev-parse HEAD~2 2>error &&
> > +		grep "error: commit $oid exists in commit-graph but not in the objec=
t database" error
> > +	)
> > +'
> > +
> >  test_done

--X+gxa2eBjiM2P8tL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUuK5QACgkQVbJhu7ck
PpQhBQ/9HuShkfvjKv8kSTfZD9xaulWr4PBqsIQy0yxGWGL2+n73zbI6imPYFXa8
1eERR/UKMJAOkvqAPOB7lzRBbURjTF4xSuMKhbqLjmFUvsmszdYFPuq1ptQrQV90
+SnLSftBxjk66QzgJ+Jla+8yJ44yfAZNt3+8nDEPc786I1xiZOFcrJ40Im6kYOy2
n9U/COAeWv/kmLqc07Tpt4Xz1wX0+N0q11lomcDG3LDrpUNTqrHXJwH7IGtuQqLW
mg6we1szn5v/1ltJ3W8qTgBe4DRsiIFAfXainIdJAjsoDyWMAZtCkOHY6SxqbpR6
bRSWKyRjNULTLLD44Ncl6N6020H0Op2XcW9BjDjoSTqlJA7znrYsWDKBdbe6M4I6
NMlt62gIgU/aM4PR994ykTx6yCIIuqx5o5VKpB7YMdWgJibdRc6kjDeEo/3JEImM
xiM76ZTA5LQbdmtjh8pxzko8HpOEqVo3YlZ3P1mBWvk0zPjz2UNkkXFvJ5il4x66
n8Pq1ySzhLTcN/QVVXfio7fU5Z1Ti43mNluEi5P2oUVfh0LKQjYouFGXPsccgbEx
OLB988PnWyEknTCdbrj4QXMxKhptrBx7BYeY4c02PPBgUzgC7k0f9VZ0CbQ3ot/z
/6NHaQOeGUx8h3l/KX7UTcTG2K0nxkEJuZ/v66vabZOzo+sJ6Cg=
=LoOp
-----END PGP SIGNATURE-----

--X+gxa2eBjiM2P8tL--
