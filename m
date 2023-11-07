Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F82D030
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FCTPOMGb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N8jkp0p+"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5589AA3
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 02:50:00 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 9CAAF320096D;
	Tue,  7 Nov 2023 05:49:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 07 Nov 2023 05:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699354199; x=1699440599; bh=9E
	byfpBp2A4oQEjN6TA65ik92H0r95PRa0EUZY1b7SU=; b=FCTPOMGbT5CT15yFse
	lKsrthilc2gWConhO+9feJ3q6fyxkngXBx2bdgj2++YFThqI0xVId5BHod5uGrGj
	HZ1FOeJj1jzDmnTh0gxA2y+Fvs769hwd8K5LF4/5ORGOYYHd3J6T6f7c5Y2Z/Vmt
	14XPXfE5N39hovTn2MKjHJus/d4U6WGKhi2LQs7Qr8BG/lFLc+pXBkl136DR9bX4
	uhBCap2oMJEKmgsHZpDip5ACiv1RpvTfNzJqD7YRS6R5DnX4/8XjcS6oDuCUTZx7
	Nw8PpcUtz75UAPaBjJskaLj57vu93v9VFrpBnTApAiPIdgHns9ENcGiOUl6bcT9y
	l78A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699354199; x=1699440599; bh=9EbyfpBp2A4oQ
	EjN6TA65ik92H0r95PRa0EUZY1b7SU=; b=N8jkp0p+tpIcrPXeGFbmkx5XGK69i
	rnLDDZJsLEw6JCw+BMNqQ59R9chLMU+lRNdsBZDInXZVlWibVZL8fnK8PA1yGOgV
	2IhZi4UkjiAcu1DC9EzYeb+GpCMXwiOa/YvIpEevaMVz84ru4LLuNHfWAYx4+pjb
	53KUdSOkbHGYmTDjIJgADiL7UxFmkwZgK/zGkhiFxJp3L6YBAqrs3p/xd/D+zrFY
	suDNEmvLazPxTFrjSerD4NwyeP6z2uZ0wmOIf9VJyTX6HyqM38y0s48uqxVw2+rj
	arddCyoa900Ltvwka4PYVJ8oD6zpl85DhpM1Z5jZN0iCWJF6Ogd4BeT5Q==
X-ME-Sender: <xms:VxZKZXktrKXzZXf3gRm-oz7t51_7HAFLwrq3RrvOcESGdcmBuLKZvg>
    <xme:VxZKZa0urFzb7NDzm_IaLmvD6LjjIsdIyxuujiv8ovvzAXKj_XJ6hnqkQ9-MSttkM
    8ipvu5Rin-03xY94g>
X-ME-Received: <xmr:VxZKZdqlGyzWy5f_Qm2G31hXpxz7jboAReG8EVSyV5jzOpgraXn9BCTQVxpu3vz3zWQfKJNKSf7OGR3uJ5_EFfxXLF8wBN1UKiAXZDj6CfNvZ-CXXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:VxZKZfnlotSaYvcM6Jw9NNVzW-I129KF6weJFnXh9niAxigfCoEubg>
    <xmx:VxZKZV1lyQ-Gfe3mOTc7v_omOcoBc8ndxSJ4lk-Z0Q9IlWvCMZcJSA>
    <xmx:VxZKZetSdEKXDxeceYfvpWoS2kjb7JlfZ3JmvhbWjuBRan9EymIPwg>
    <xmx:VxZKZW9XKZX-uJRzZRUdaAYteQw59hwZCduffEw4tq_id2ebMSy8WA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 05:49:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c8f4f720 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Nov 2023 10:49:35 +0000 (UTC)
Date: Tue, 7 Nov 2023 11:49:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 7/9] ref-filter.c: filter & format refs in the same
 callback
Message-ID: <ZUoWVPSE1GcJdHFE@tanuki>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
 <84db440896c162bcbeeaaf00d528839056aefaa5.1699320362.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FARY/IEAS6Cstrhs"
Content-Disposition: inline
In-Reply-To: <84db440896c162bcbeeaaf00d528839056aefaa5.1699320362.git.gitgitgadget@gmail.com>


--FARY/IEAS6Cstrhs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 01:25:59AM +0000, Victoria Dye via GitGitGadget wro=
te:
> From: Victoria Dye <vdye@github.com>
>=20
> Update 'filter_and_format_refs()' to try to perform ref filtering &
> formatting in a single ref iteration, without an intermediate 'struct
> ref_array'. This can only be done if no operations need to be performed o=
n a
> pre-filtered array; specifically, if the refs are
>=20
> - filtered on reachability,
> - sorted, or
> - formatted with ahead-behind information
>=20
> they cannot be filtered & formatted in the same iteration. In that case,
> fall back on the current filter-then-sort-then-format flow.
>=20
> This optimization substantially improves memory usage due to no longer
> storing a ref array in memory. In some cases, it also dramatically reduces
> runtime (e.g. 'git for-each-ref --no-sort --count=3D1', which no longer l=
oads
> all refs into a 'struct ref_array' to printing only the first ref).
>=20
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  ref-filter.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 74 insertions(+), 6 deletions(-)
>=20
> diff --git a/ref-filter.c b/ref-filter.c
> index ff00ab4b8d8..384cf1595ff 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2863,6 +2863,44 @@ static void free_array_item(struct ref_array_item =
*item)
>  	free(item);
>  }
> =20
> +struct ref_filter_and_format_cbdata {
> +	struct ref_filter *filter;
> +	struct ref_format *format;
> +
> +	struct ref_filter_and_format_internal {
> +		int count;
> +	} internal;
> +};
> +
> +static int filter_and_format_one(const char *refname, const struct objec=
t_id *oid, int flag, void *cb_data)
> +{
> +	struct ref_filter_and_format_cbdata *ref_cbdata =3D cb_data;
> +	struct ref_array_item *ref;
> +	struct strbuf output =3D STRBUF_INIT, err =3D STRBUF_INIT;
> +
> +	ref =3D apply_ref_filter(refname, oid, flag, ref_cbdata->filter);
> +	if (!ref)
> +		return 0;
> +
> +	if (format_ref_array_item(ref, ref_cbdata->format, &output, &err))
> +		die("%s", err.buf);
> +
> +	if (output.len || !ref_cbdata->format->array_opts.omit_empty) {
> +		fwrite(output.buf, 1, output.len, stdout);
> +		putchar('\n');
> +	}
> +
> +	strbuf_release(&output);
> +	strbuf_release(&err);
> +	free_array_item(ref);
> +
> +	if (ref_cbdata->format->array_opts.max_count &&
> +	    ++ref_cbdata->internal.count >=3D ref_cbdata->format->array_opts.ma=
x_count)
> +		return -1;

It feels a bit weird to return a negative value here, which usually
indicates that an error has happened whereas we only use it here to
abort the iteration. But we ignore the return value of
`do_iterate_refs()` anyway, so it doesn't make much of a difference.

> +	return 0;
> +}
> +
>  /* Free all memory allocated for ref_array */
>  void ref_array_clear(struct ref_array *array)
>  {
> @@ -3046,16 +3084,46 @@ int filter_refs(struct ref_array *array, struct r=
ef_filter *filter, unsigned int
>  	return ret;
>  }
> =20
> +static inline int can_do_iterative_format(struct ref_filter *filter,
> +					  struct ref_sorting *sorting,
> +					  struct ref_format *format)
> +{
> +	/*
> +	 * Refs can be filtered and formatted in the same iteration as long
> +	 * as we aren't filtering on reachability, sorting the results, or
> +	 * including ahead-behind information in the formatted output.
> +	 */

Do we want to format this as a bulleted list so that it's more readily
extensible if we ever need to pay attention to new options here? Also, I
noted that this commit doesn't add any new tests -- do we already
exercise all of these conditions?

More generally, I worry a bit about maintainability of this code snippet
as we need to remember to always update this condition whenever we add a
new option, and this can be quite easy to miss. The performance benefit
might be worth the effort though.

Patrick

> +	return !(filter->reachable_from ||
> +		 filter->unreachable_from ||
> +		 sorting ||
> +		 format->bases.nr);
> +}
> +
>  void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
>  			    struct ref_sorting *sorting,
>  			    struct ref_format *format)
>  {
> -	struct ref_array array =3D { 0 };
> -	filter_refs(&array, filter, type);
> -	filter_ahead_behind(the_repository, format, &array);
> -	ref_array_sort(sorting, &array);
> -	print_formatted_ref_array(&array, format);
> -	ref_array_clear(&array);
> +	if (can_do_iterative_format(filter, sorting, format)) {
> +		int save_commit_buffer_orig;
> +		struct ref_filter_and_format_cbdata ref_cbdata =3D {
> +			.filter =3D filter,
> +			.format =3D format,
> +		};
> +
> +		save_commit_buffer_orig =3D save_commit_buffer;
> +		save_commit_buffer =3D 0;
> +
> +		do_filter_refs(filter, type, filter_and_format_one, &ref_cbdata);
> +
> +		save_commit_buffer =3D save_commit_buffer_orig;
> +	} else {
> +		struct ref_array array =3D { 0 };
> +		filter_refs(&array, filter, type);
> +		filter_ahead_behind(the_repository, format, &array);
> +		ref_array_sort(sorting, &array);
> +		print_formatted_ref_array(&array, format);
> +		ref_array_clear(&array);
> +	}
>  }
> =20
>  static int compare_detached_head(struct ref_array_item *a, struct ref_ar=
ray_item *b)
> --=20
> gitgitgadget
>=20
>=20

--FARY/IEAS6Cstrhs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVKFlMACgkQVbJhu7ck
PpSt9g//X31kt5q5XOQQ/bNC3L5Ibf6QG3RZZqb1MkZNHfS2cgbXTDp4/9D/P6mq
3nc0znbXLxyHTIEO1CtLIW6ISTKQdXMljqDTtRXbwTUmfA4yAZO2pPmsbBtHLvKB
VFMDPEg0tWDkvTO05mVRaHv/q8aMIGsvFQCovA/Wr32YVvW7MGDX5m+WzZw40yVQ
qc4lbZQxJ7ZFMPo9+mcCA3UrATrGj3i09YQlSh+weSk3sCBRs4BrS2B2wobX0HG0
iMOjhrPL0EDVLeEMqI4hiirbaUHUjo8fWxVmh64xOZwnoiGe4zVG4ZvaErRhbPg8
3dif2ri9ATBaN4l474gdxD6zKf18i3heiTwQObTkE5j3dDrEPSQkih7OWr+7V7+d
jSSYclYa/+N0wwTcRUhkoW+wLb//pkHVoOqq8YIyAGP9sn0ajy2/nLmkfcOzuxLq
DeQddz86fuvhz5Zy1FHmUriP7F24T8vPqgkQbN/4Mo1iiuzHYJA1X1BZS+hPQ93i
dITAR0S/Msk8mQXYIaNRr5zH8QoORvdtfV0Ox20zA8oxRJCjWhRvBmH3wgnFw9Nd
TaZiNayDYHbRLMldMtLah7ROtksQJSR+eRYiCa2+ETT79wngS+Sm7aTG3/dZbmLA
uYNiTnMSLkwIXB9r2xnnfX++FxXs3SaXc288/PWqfzGyhXy2TfM=
=iILA
-----END PGP SIGNATURE-----

--FARY/IEAS6Cstrhs--
