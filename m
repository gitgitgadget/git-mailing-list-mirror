Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3C2C873
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V+Fbceku";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o2s6Lx3T"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B073A3
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 02:49:55 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 9F50A32009E0;
	Tue,  7 Nov 2023 05:49:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 07 Nov 2023 05:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699354194; x=1699440594; bh=wc
	ZSO6ShfPHT8laPqA5w4jUTlxf14IyBW+mwhabEqvA=; b=V+Fbceku9Vvf+/CVTA
	//lLPBEJ1YT3IFOA6sczjinEgJzPievkqjm5SQnfHjYUHTSnId9JFMOPCVqR5Je1
	aKUUmd5sU71ZX+crGIlWtSrjK9PZnKkAckOLV2sx4Ac1qxF3MHdxxn9bVvWsh49Y
	oPqMZpNbK0IR+PNCEKSIpbi0KhokINxLqckbXGvkwjfNjFdasl2wP1JGaev5C5F9
	heCAzbwMlUgDvtJ7p5qXsx2XluMxea9FKarAP8ZRs6uQSJZk7HGxM5CWl1nmfrVN
	Gf5TW0SaSl2CVsYz/AIwNwc/u2DlCTTaVZl/sg/qn9RL+VTdKD1alp+ymBMOsnfN
	az3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699354194; x=1699440594; bh=wcZSO6ShfPHT8
	laPqA5w4jUTlxf14IyBW+mwhabEqvA=; b=o2s6Lx3ThMukTQQ1N64mrLBYN8U8b
	b8yIMrmsg8geJLOwLZq1jPyhomA2D621LxX0Pm3IJewNlrOpAUsfwRUp4njzGh5i
	CaoYEyHSnarfOBNnj435cjMB4w6ZToWgYz08UTj58tpptkCbm6lOaSdccxRjW+KX
	ENe/ql016ygHBoXWJKtpXF97W9/YKkLX80PoD/njh7eEdo8CKb3K6wbtBTYGzNJK
	Mjo66Jn9eQfw9Ypj5QPxqZWXYcvD9PCh9i0CBX9/Ev2jk0Zp2GKEcXv2QJlptPVl
	F4aJptw2D2c7HwpJ4RbJGcZKXWSb+EIPWuzkZprhlx2ZH0h/u+xsOAMYg==
X-ME-Sender: <xms:URZKZboK2Y6f-qnmGHiBolJ0RoBd-YQE4vqt2QsjHlF4C3N6j-INTg>
    <xme:URZKZVrJeknJkq40vmDDysd5nPJbn4WsvBE-7QjYrzSLAUVWIocDKL4Lh1o6mTRTt
    DzOd9F4zsT80n2hGw>
X-ME-Received: <xmr:URZKZYPvhjx7ZP1Wv2I9uFPku8UInJplFFwDVxDZkVabxnS3_FnilzE0Eose4hHn7G8QhOZEox7W7ebckvqwWjL5FEWiYiFSo7wCC7fFJQtrSH3gKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:URZKZe4YS6wbXQsvJLtCEAJR4VjGLQPwdTCnhZE32nODtvin5-MB3A>
    <xmx:URZKZa41C3D1kJCRQqXSlWpX9qvLw-OW96g3BvSsCfYAjMnr3Jh4Xg>
    <xmx:URZKZWjLTqgx6q-bEBvT9Ms0oV465ausjB5Rtbp9IeqmNOFsYrku2Q>
    <xmx:UhZKZQQU52HEYfH-Fd-_HkOg5DscK0vLNRIDwI8LuC9tIIKh6PiqUA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 05:49:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 60d706b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Nov 2023 10:49:30 +0000 (UTC)
Date: Tue, 7 Nov 2023 11:49:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 6/9] ref-filter.c: refactor to create common helper
 functions
Message-ID: <ZUoWT8GyrZlvH_Go@tanuki>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
 <8c77452e5dd8d5cafd95c68480bf5675d51b4736.1699320362.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pwi3aOtwCej758dU"
Content-Disposition: inline
In-Reply-To: <8c77452e5dd8d5cafd95c68480bf5675d51b4736.1699320362.git.gitgitgadget@gmail.com>


--pwi3aOtwCej758dU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 01:25:58AM +0000, Victoria Dye via GitGitGadget wro=
te:
> From: Victoria Dye <vdye@github.com>
>=20
> Factor out parts of 'ref_array_push()', 'ref_filter_handler()', and
> 'filter_refs()' into new helper functions ('ref_array_append()',
> 'apply_ref_filter()', and 'do_filter_refs()' respectively), as well as
> rename 'ref_filter_handler()' to 'filter_one()'. In this and later
> patches, these helpers will be used by new ref-filter API functions. This
> patch does not result in any user-facing behavior changes or changes to
> callers outside of 'ref-filter.c'.
>=20
> The changes are as follows:
>=20
> * The logic to grow a 'struct ref_array' and append a given 'struct
>   ref_array_item *' to it is extracted from 'ref_array_push()' into
>   'ref_array_append()'.
> * 'ref_filter_handler()' is renamed to 'filter_one()' to more clearly
>   distinguish it from other ref filtering callbacks that will be added in
>   later patches. The "*_one()" naming convention is common throughout the
>   codebase for iteration callbacks.
> * The code to filter a given ref by refname & object ID then create a new
>   'struct ref_array_item' is moved out of 'filter_one()' and into
>   'apply_ref_filter()'. 'apply_ref_filter()' returns either NULL (if the =
ref
>   does not match the given filter) or a 'struct ref_array_item *' created
>   with 'new_ref_array_item()'; 'filter_one()' appends that item to
>   its ref array with 'ref_array_append()'.
> * The filter pre-processing, contains cache creation, and ref iteration of
>   'filter_refs()' is extracted into 'do_filter_refs()'. 'do_filter_refs()'
>   takes its ref iterator function & callback data as an input from the
>   caller, setting it up to be used with additional filtering callbacks in
>   later patches.

To me, a bulleted list spelling out the different changes I'm doing
often indicates that I might want to split up the commit into one for
each of the items. I don't feel strongly about this, but think that it
might help the reviewer in this case.

Patrick

> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  ref-filter.c | 115 ++++++++++++++++++++++++++++++---------------------
>  1 file changed, 69 insertions(+), 46 deletions(-)
>=20
> diff --git a/ref-filter.c b/ref-filter.c
> index 8992fbf45b1..ff00ab4b8d8 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2716,15 +2716,18 @@ static struct ref_array_item *new_ref_array_item(=
const char *refname,
>  	return ref;
>  }
> =20
> +static void ref_array_append(struct ref_array *array, struct ref_array_i=
tem *ref)
> +{
> +	ALLOC_GROW(array->items, array->nr + 1, array->alloc);
> +	array->items[array->nr++] =3D ref;
> +}
> +
>  struct ref_array_item *ref_array_push(struct ref_array *array,
>  				      const char *refname,
>  				      const struct object_id *oid)
>  {
>  	struct ref_array_item *ref =3D new_ref_array_item(refname, oid);
> -
> -	ALLOC_GROW(array->items, array->nr + 1, array->alloc);
> -	array->items[array->nr++] =3D ref;
> -
> +	ref_array_append(array, ref);
>  	return ref;
>  }
> =20
> @@ -2761,46 +2764,36 @@ static int filter_ref_kind(struct ref_filter *fil=
ter, const char *refname)
>  	return ref_kind_from_refname(refname);
>  }
> =20
> -struct ref_filter_cbdata {
> -	struct ref_array *array;
> -	struct ref_filter *filter;
> -};
> -
> -/*
> - * A call-back given to for_each_ref().  Filter refs and keep them for
> - * later object processing.
> - */
> -static int ref_filter_handler(const char *refname, const struct object_i=
d *oid, int flag, void *cb_data)
> +static struct ref_array_item *apply_ref_filter(const char *refname, cons=
t struct object_id *oid,
> +			    int flag, struct ref_filter *filter)
>  {
> -	struct ref_filter_cbdata *ref_cbdata =3D cb_data;
> -	struct ref_filter *filter =3D ref_cbdata->filter;
>  	struct ref_array_item *ref;
>  	struct commit *commit =3D NULL;
>  	unsigned int kind;
> =20
>  	if (flag & REF_BAD_NAME) {
>  		warning(_("ignoring ref with broken name %s"), refname);
> -		return 0;
> +		return NULL;
>  	}
> =20
>  	if (flag & REF_ISBROKEN) {
>  		warning(_("ignoring broken ref %s"), refname);
> -		return 0;
> +		return NULL;
>  	}
> =20
>  	/* Obtain the current ref kind from filter_ref_kind() and ignore unwant=
ed refs. */
>  	kind =3D filter_ref_kind(filter, refname);
>  	if (!(kind & filter->kind))
> -		return 0;
> +		return NULL;
> =20
>  	if (!filter_pattern_match(filter, refname))
> -		return 0;
> +		return NULL;
> =20
>  	if (filter_exclude_match(filter, refname))
> -		return 0;
> +		return NULL;
> =20
>  	if (filter->points_at.nr && !match_points_at(&filter->points_at, oid, r=
efname))
> -		return 0;
> +		return NULL;
> =20
>  	/*
>  	 * A merge filter is applied on refs pointing to commits. Hence
> @@ -2811,15 +2804,15 @@ static int ref_filter_handler(const char *refname=
, const struct object_id *oid,
>  	    filter->with_commit || filter->no_commit || filter->verbose) {
>  		commit =3D lookup_commit_reference_gently(the_repository, oid, 1);
>  		if (!commit)
> -			return 0;
> +			return NULL;
>  		/* We perform the filtering for the '--contains' option... */
>  		if (filter->with_commit &&
>  		    !commit_contains(filter, commit, filter->with_commit, &filter->int=
ernal.contains_cache))
> -			return 0;
> +			return NULL;
>  		/* ...or for the `--no-contains' option */
>  		if (filter->no_commit &&
>  		    commit_contains(filter, commit, filter->no_commit, &filter->intern=
al.no_contains_cache))
> -			return 0;
> +			return NULL;
>  	}
> =20
>  	/*
> @@ -2827,11 +2820,32 @@ static int ref_filter_handler(const char *refname=
, const struct object_id *oid,
>  	 * to do its job and the resulting list may yet to be pruned
>  	 * by maxcount logic.
>  	 */
> -	ref =3D ref_array_push(ref_cbdata->array, refname, oid);
> +	ref =3D new_ref_array_item(refname, oid);
>  	ref->commit =3D commit;
>  	ref->flag =3D flag;
>  	ref->kind =3D kind;
> =20
> +	return ref;
> +}
> +
> +struct ref_filter_cbdata {
> +	struct ref_array *array;
> +	struct ref_filter *filter;
> +};
> +
> +/*
> + * A call-back given to for_each_ref().  Filter refs and keep them for
> + * later object processing.
> + */
> +static int filter_one(const char *refname, const struct object_id *oid, =
int flag, void *cb_data)
> +{
> +	struct ref_filter_cbdata *ref_cbdata =3D cb_data;
> +	struct ref_array_item *ref;
> +
> +	ref =3D apply_ref_filter(refname, oid, flag, ref_cbdata->filter);
> +	if (ref)
> +		ref_array_append(ref_cbdata->array, ref);
> +
>  	return 0;
>  }
> =20
> @@ -2967,26 +2981,12 @@ void filter_ahead_behind(struct repository *r,
>  	free(commits);
>  }
> =20
> -/*
> - * API for filtering a set of refs. Based on the type of refs the user
> - * has requested, we iterate through those refs and apply filters
> - * as per the given ref_filter structure and finally store the
> - * filtered refs in the ref_array structure.
> - */
> -int filter_refs(struct ref_array *array, struct ref_filter *filter, unsi=
gned int type)
> +static int do_filter_refs(struct ref_filter *filter, unsigned int type, =
each_ref_fn fn, void *cb_data)
>  {
> -	struct ref_filter_cbdata ref_cbdata;
> -	int save_commit_buffer_orig;
>  	int ret =3D 0;
> =20
> -	ref_cbdata.array =3D array;
> -	ref_cbdata.filter =3D filter;
> -
>  	filter->kind =3D type & FILTER_REFS_KIND_MASK;
> =20
> -	save_commit_buffer_orig =3D save_commit_buffer;
> -	save_commit_buffer =3D 0;
> -
>  	init_contains_cache(&filter->internal.contains_cache);
>  	init_contains_cache(&filter->internal.no_contains_cache);
> =20
> @@ -3001,20 +3001,43 @@ int filter_refs(struct ref_array *array, struct r=
ef_filter *filter, unsigned int
>  		 * of filter_ref_kind().
>  		 */
>  		if (filter->kind =3D=3D FILTER_REFS_BRANCHES)
> -			ret =3D for_each_fullref_in("refs/heads/", ref_filter_handler, &ref_c=
bdata);
> +			ret =3D for_each_fullref_in("refs/heads/", fn, cb_data);
>  		else if (filter->kind =3D=3D FILTER_REFS_REMOTES)
> -			ret =3D for_each_fullref_in("refs/remotes/", ref_filter_handler, &ref=
_cbdata);
> +			ret =3D for_each_fullref_in("refs/remotes/", fn, cb_data);
>  		else if (filter->kind =3D=3D FILTER_REFS_TAGS)
> -			ret =3D for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cb=
data);
> +			ret =3D for_each_fullref_in("refs/tags/", fn, cb_data);
>  		else if (filter->kind & FILTER_REFS_ALL)
> -			ret =3D for_each_fullref_in_pattern(filter, ref_filter_handler, &ref_=
cbdata);
> +			ret =3D for_each_fullref_in_pattern(filter, fn, cb_data);
>  		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
> -			head_ref(ref_filter_handler, &ref_cbdata);
> +			head_ref(fn, cb_data);
>  	}
> =20
>  	clear_contains_cache(&filter->internal.contains_cache);
>  	clear_contains_cache(&filter->internal.no_contains_cache);
> =20
> +	return ret;
> +}
> +
> +/*
> + * API for filtering a set of refs. Based on the type of refs the user
> + * has requested, we iterate through those refs and apply filters
> + * as per the given ref_filter structure and finally store the
> + * filtered refs in the ref_array structure.
> + */
> +int filter_refs(struct ref_array *array, struct ref_filter *filter, unsi=
gned int type)
> +{
> +	struct ref_filter_cbdata ref_cbdata;
> +	int save_commit_buffer_orig;
> +	int ret =3D 0;
> +
> +	ref_cbdata.array =3D array;
> +	ref_cbdata.filter =3D filter;
> +
> +	save_commit_buffer_orig =3D save_commit_buffer;
> +	save_commit_buffer =3D 0;
> +
> +	ret =3D do_filter_refs(filter, type, filter_one, &ref_cbdata);
> +
>  	/*  Filters that need revision walking */
>  	reach_filter(array, &filter->reachable_from, INCLUDE_REACHED);
>  	reach_filter(array, &filter->unreachable_from, EXCLUDE_REACHED);
> --=20
> gitgitgadget
>=20
>=20

--pwi3aOtwCej758dU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVKFk4ACgkQVbJhu7ck
PpTGHhAAo5WZHJny47GusTOOJN4BSJbG3DZiYWH4jYCHv6pPz1j4C+Ws3Tsq08cO
ip7rd7RTiNyzYRIFUdp/RcyrgwZdHlbvLTt9TSqCgfZCFPsGQ5oqB13jx4m8gN4E
FFe0C3LHNKTiM8UCAfUXYp7UJ1fcCLfGXUmoFirtrOfJTdchNbCRnEWJxpTUSVHE
Ga7XcJxwpk45zprTiZh9RHUwORTGpRXE38EQ0R/ES1cxywVOI2zOouock0JSlPsl
RAqQmSs/wl0kO8DV2HISkMUJNmaSMq3lyK7cFGNskU9VVlYVEnUJq5uDinwNkVDI
Lzz1I+euCoJ9oQPtSbkSnNg8s01cdSOfaJZl/IP8Gdbabg0BcLhrAGamgCIsZxHS
XEF0J/EtgIAVVDBrWHNKoT5BnCemYoiKWoBcZjmTjK62zvSU+FPkW+p4nghPSPTh
O8TKbkIW98QtiMbtH3rranEsVGSmS6d4JrByYg5b6u4xS+9Jl7stNX92NQdtj+bS
vLLogXs0B5HNtn8js4y7JbdOlS3XJzoR7xLaQhjaYGPmtqZFzLlyP1uN/obDIMLL
TIbYzYL85pgBOUqXojJjKCQOthgEe1tYy1BD9dUanAjYw1YyZDnY6c2cEIvmpsU/
8pvSuv5svJarfJ0Sr8/UQXog+40XVs5+0Uy+iqXG2faD8nH3T7I=
=4jHl
-----END PGP SIGNATURE-----

--pwi3aOtwCej758dU--
