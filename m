Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01228FD
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v48M3Tho";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rUF0x/u3"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADF6A3
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 02:49:50 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 8FE1232009E1;
	Tue,  7 Nov 2023 05:49:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 07 Nov 2023 05:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699354189; x=1699440589; bh=R/
	t6NxoSQTll1G2wtiXkhwVtkfZztcX1HbAxb7PSoL0=; b=v48M3ThoLbpFCyP9vN
	P2rHyuypkDUHXzlZVJwnO/ko4ppQvDmEKF7lUEZJK8qp3eYBHlMcnuOJanwR216A
	I35vCgIpybeeNZuRoJjMOpUsqdFXIaLmMjpxTsMC3/cMOngdtEMoEaW3JiquJv+R
	Kk8tKsOUGy48FiBc51QknljZnXNvbi7z03ziiCHR2BGt9wbvQakn8oxbAj2HDwoL
	S88wATG5DBPIJPN8X2ynKSx7KlfAk0Ln6B0opaeTc1r4tysLg1Mv9D2txyT2UVo5
	kOfweHfd7ZRLPF9NjvYJ913P3MRHnT+uMviOvErgSo6DXzr6vaSlrdOiqr0Pn8At
	SuBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699354189; x=1699440589; bh=R/t6NxoSQTll1
	G2wtiXkhwVtkfZztcX1HbAxb7PSoL0=; b=rUF0x/u3d1rOY0R00XKadu2VZsP1L
	iAjcsBlNXB0Z6Fn1vjznX21zmZPJBO7y7qGKEr6Vzg/9CkGfnChjD/CZkljMHXNB
	kQSJRt9ke0uLuMHaBmKSVhz0XRC/NSPkfLcTCbcp2qtI2w5Ulk9wCxhy5UdSv/zP
	v4n05Eqqi5SNVuoDDT1yOa6ioljRVUrSNrRb/UxvnDWiNo07b5yL6dr28XTL6d1T
	SAC618Aqnw1KNW2UwZenHxL9D2NVTzCjipHmRf3275+xDg9m9Fetih09q25FXEmB
	sXX6yudHj5JLTaIv+hTy2vo7e/baaU/JACsxlrcWCNrNsx2jOHRGHi3Kw==
X-ME-Sender: <xms:TBZKZZ6IvJdf8LSXp1CEjoRyLSNw2_icxOoNA2ibrz3hy4Qg6u4N8Q>
    <xme:TBZKZW47ojvBOhOl0ReIH-DulPhkNADp4I2buwQse5H4vT9lnV4zYkZskJcP5vOBF
    __0kJgwwOABjMUypA>
X-ME-Received: <xmr:TBZKZQd6QEq1ABDUtf49KFxZZOCCKGALmCcY_FMwEuIH27bKGe30Kc7XSx9Qa9plzQ6mqks8x61mY2MbVWU-JH76J8gzOlsDYFXrAJSflHeHjHNu7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:TBZKZSKrbWBUktZHQgLW0MtIyQtiAbkFBYsLIixV82II6TwxBSOUxw>
    <xmx:TBZKZdItDhL-D3tqxLU78FCsFCQCe23kFjIRDz3ioL5pl5u8g1oe_A>
    <xmx:TBZKZbzKskeAXcIVXOKlg8QBwN_rE6nxA-E8yInRtEzzniQHZvOApA>
    <xmx:TRZKZbg4roBKeoqgliG3fTfXh1NAlgvuc8eHnU6T2_Q9bbUbaFwPAw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 05:49:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ec05ed51 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Nov 2023 10:49:25 +0000 (UTC)
Date: Tue, 7 Nov 2023 11:49:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 4/9] ref-filter.h: move contains caches into filter
Message-ID: <ZUoWSocLddxm_7WK@tanuki>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
 <6c66445ee31dd4117e1384d8da7be81f401317b3.1699320362.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OyILY+zqkg/koTOv"
Content-Disposition: inline
In-Reply-To: <6c66445ee31dd4117e1384d8da7be81f401317b3.1699320362.git.gitgitgadget@gmail.com>


--OyILY+zqkg/koTOv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 01:25:56AM +0000, Victoria Dye via GitGitGadget wro=
te:
> From: Victoria Dye <vdye@github.com>
>=20
> Move the 'contains_cache' and 'no_contains_cache' used in filter_refs into
> an 'internal' struct of the 'struct ref_filter'. In later patches, the
> 'struct ref_filter *' will be a common data structure across multiple
> filtering functions. These caches are part of the common functionality the
> filter struct will support, so they are updated to be internally accessib=
le
> wherever the filter is used.
>=20
> The design used here is mirrors what was introduced in 576de3d956

Nit: s/is //

Patrick

> (unpack_trees: start splitting internal fields from public API, 2023-02-2=
7)
> for 'unpack_trees_options'.
>=20
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  ref-filter.c | 14 ++++++--------
>  ref-filter.h |  6 ++++++
>  2 files changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/ref-filter.c b/ref-filter.c
> index 7250089b7c6..5129b6986c9 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2764,8 +2764,6 @@ static int filter_ref_kind(struct ref_filter *filte=
r, const char *refname)
>  struct ref_filter_cbdata {
>  	struct ref_array *array;
>  	struct ref_filter *filter;
> -	struct contains_cache contains_cache;
> -	struct contains_cache no_contains_cache;
>  };
> =20
>  /*
> @@ -2816,11 +2814,11 @@ static int ref_filter_handler(const char *refname=
, const struct object_id *oid,
>  			return 0;
>  		/* We perform the filtering for the '--contains' option... */
>  		if (filter->with_commit &&
> -		    !commit_contains(filter, commit, filter->with_commit, &ref_cbdata-=
>contains_cache))
> +		    !commit_contains(filter, commit, filter->with_commit, &filter->int=
ernal.contains_cache))
>  			return 0;
>  		/* ...or for the `--no-contains' option */
>  		if (filter->no_commit &&
> -		    commit_contains(filter, commit, filter->no_commit, &ref_cbdata->no=
_contains_cache))
> +		    commit_contains(filter, commit, filter->no_commit, &filter->intern=
al.no_contains_cache))
>  			return 0;
>  	}
> =20
> @@ -2989,8 +2987,8 @@ int filter_refs(struct ref_array *array, struct ref=
_filter *filter, unsigned int
>  	save_commit_buffer_orig =3D save_commit_buffer;
>  	save_commit_buffer =3D 0;
> =20
> -	init_contains_cache(&ref_cbdata.contains_cache);
> -	init_contains_cache(&ref_cbdata.no_contains_cache);
> +	init_contains_cache(&filter->internal.contains_cache);
> +	init_contains_cache(&filter->internal.no_contains_cache);
> =20
>  	/*  Simple per-ref filtering */
>  	if (!filter->kind)
> @@ -3014,8 +3012,8 @@ int filter_refs(struct ref_array *array, struct ref=
_filter *filter, unsigned int
>  			head_ref(ref_filter_handler, &ref_cbdata);
>  	}
> =20
> -	clear_contains_cache(&ref_cbdata.contains_cache);
> -	clear_contains_cache(&ref_cbdata.no_contains_cache);
> +	clear_contains_cache(&filter->internal.contains_cache);
> +	clear_contains_cache(&filter->internal.no_contains_cache);
> =20
>  	/*  Filters that need revision walking */
>  	reach_filter(array, &filter->reachable_from, INCLUDE_REACHED);
> diff --git a/ref-filter.h b/ref-filter.h
> index d87d61238b7..0db3ff52889 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -7,6 +7,7 @@
>  #include "commit.h"
>  #include "string-list.h"
>  #include "strvec.h"
> +#include "commit-reach.h"
> =20
>  /* Quoting styles */
>  #define QUOTE_NONE 0
> @@ -75,6 +76,11 @@ struct ref_filter {
>  		lines;
>  	int abbrev,
>  		verbose;
> +
> +	struct {
> +		struct contains_cache contains_cache;
> +		struct contains_cache no_contains_cache;
> +	} internal;
>  };
> =20
>  struct ref_format {
> --=20
> gitgitgadget
>=20
>=20

--OyILY+zqkg/koTOv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVKFkkACgkQVbJhu7ck
PpQ0yQ/9Hfk5Q2E7NrH70w1kLJgEUiqGmcHM0rdzVxNNfJftasEHJkQFTIjGQBLD
HGHeRBChyRpg8WtGz7U8M3L775k9iBJOb8SH4lz8rdSG4QtXJ+XjHdPqf5jWdln5
2cZPl0S56NzZJB1XAw5CX3cN39zE9gm89jUlDmPfA0NwTriPG8b76uyZSQpLtpdF
JZrtgNWuuxahOqfuI/KK+3/oOD3jYyK+jCM4fysqK+rx4gdqfV18BXPt1q8xxQ1u
ic81hJ+zsQzQD6vl38JS8FrnzNLWBL03JS5l6cIs8BfXoQ+OYSUDy/fL956XE9IK
pDyeHhMbxbYyX55qaHvaKsZ7wShs8TimLSD810DgFhu1Lz+BqKtw8fXeLcXIuod3
xnZeMR++JzIzsYOQpoR1bhPWCIY/fsyFD8tTdmd201Ze6elYgL+8ty1Ois+Lim9H
/i63WatYgbEtqVeBUeuB5zIxcDKCKFCRHLa7bPM1Z8ssXAnWpVXD9K90bPqan4zc
lohEBVeP7kAYUIO9ZUDGF3+K4RbBb63qUzNYiEMKDDdNPpSK3Ff81c+zoN1DOIAO
fAeKxw7s4Y2Hmnq8xdEUM0zqv7n9dQ72a//Sol4ouEwDduP5gxYgkrb4VRUPIIID
vAB99/0Dn2Fv7yTefglJxaoZrlmh4kyGkdspe7R5lqONZWv0waI=
=y6mK
-----END PGP SIGNATURE-----

--OyILY+zqkg/koTOv--
