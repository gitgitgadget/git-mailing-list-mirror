Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5157D1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 22:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeBXW4c (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 17:56:32 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33774 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751474AbeBXW4b (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Feb 2018 17:56:31 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 113586096B;
        Sat, 24 Feb 2018 22:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519512990;
        bh=i8/qZWSjV1HmuaxoaLAcsActyeRMTuxY9Rvtc0iKjQw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=VAa1IsGxJmptv34HkUfteAJVisHs8jKYeOhreOtPCLSxDjHNvUNYYBwvGpcAWeuMG
         EuGZk0O1kFNyx0urppS5GgtkzJpstxvOey+JeVDIut6OgJYYWV5fmovGDx/IQXtxC0
         cD20mbkC3MEpOyamRldkhwGdFP+hOFrdvtpEPzw7DUQ2nruQehUFaFiYrz3xtXwbK0
         riFqJBol9ELRqyNvX07sotDPuY6Rhv2HBfI+VOqkqehx+abGCCW7cbpdLZFyNVwfGC
         LqiwhV6UK5Dl32X9xQVOTpsXvjGsKweel48bxF+2awID//MyvzKPXsvpwEKqJ2WB36
         HPTA8n+MvoA/nn1i040gWizXcTI6myRa1sItDj/hvJghauuUnAxI7OyAG1LO45XiGC
         IW1qVBoBpLyTJKzsKlsNcwZArWc9tc4V0D+8ZEtphdURjUKIlY5GTErxgriR6CDBZY
         DoY1YCAOf5iXaEpnSCGXyW7lnHYk+icU499KmReANbkI2VOUpCJ
Date:   Sat, 24 Feb 2018 22:56:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 3/5] index-pack: check (and optionally set) hash algo
 based on input file
Message-ID: <20180224225625.GC4620@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20180223095640.25876-1-pclouds@gmail.com>
 <20180224033429.9656-1-pclouds@gmail.com>
 <20180224033429.9656-4-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <20180224033429.9656-4-pclouds@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-1-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2018 at 10:34:27AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
> After 454253f059 (builtin/index-pack: improve hash function abstraction
> - 2018-02-01), index-pack uses the_hash_algo for hashing. If "git
> index-pack" is executed without a repository, we do not know what hash
> algorithm to be used and the_hash_algo in theory could be undefined.
>=20
> Since there should be some information about the hash algorithm in the
> input pack file, we can initialize the correct hash algorithm with that
> if the_hash_algo is not yet initialized. This assumes that pack files
> with new hash algorithm MUST step up pack version.
>=20
> While at there, make sure the hash algorithm requested by the pack file
> and configured by the repository (if we're running with a repo) are
> consistent.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  builtin/index-pack.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 7e3e1a461c..1144458140 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -326,10 +326,31 @@ static const char *open_pack_file(const char *pack_=
name)
>  		output_fd =3D -1;
>  		nothread_data.pack_fd =3D input_fd;
>  	}
> -	the_hash_algo->init_fn(&input_ctx);
>  	return pack_name;
>  }
> =20
> +static void prepare_hash_algo(uint32_t pack_version)
> +{
> +	const struct git_hash_algo *pack_algo;
> +
> +	switch (pack_version) {
> +	case 2:
> +	case 3:
> +		pack_algo =3D &hash_algos[GIT_HASH_SHA1];
> +		break;
> +	default:
> +		die("BUG: how to determine hash algo for new version?");
> +	}
> +
> +	if (!the_hash_algo)	/* running without repo */
> +		the_hash_algo =3D pack_algo;
> +
> +	if (the_hash_algo !=3D pack_algo)
> +		die(_("incompatible hash algorithm, "
> +		      "configured for %s but the pack file needs %s"),
> +		    the_hash_algo->name, pack_algo->name);

I like this.  It's a nice improvement and it should be easy for us to
pass additional information into the function when our pack format
understands multiple algorithms.

I might have done the comparison using the format_id members instead of
the pointers themselves, but that's more a personal preference than
anything.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqR7ZkACgkQv1NdgR9S
9ouXjA//Wh6yCcnGPW2WLk+DeTkG1bWfhyvu2003da3Ff1mzUoawBDa8D3J9K1MV
kIQOmsOe9uPJjEIlcBfeI/FPW8iIVI2/bxhxiDE6FywDoKPy3VRtjPQmF3ZfwNXX
6Km6mxZ7vvUEF3qoOE6EZIcWburHqr+eDgnuYMSMRYk6pAUe3pd6qb1IRX9ElrMy
mGZDBbe6g/8FBl7pPNStjFjlCAvdgZd9O/GnN2zCvPmJpaO2fMBk6gre9/PVEmut
nsiXJ7tphiK6ogeMC+B0stVYVhqaxIHD4BOEKiIv78equm7F3fEbZ3REhJaZUeJV
ESjqCflyUo2Ls+pmwexycHQBBZYD6JsLnyHeg/pD/jNlt0w7X9Z6TyRh0n737Qa5
mQYBoIyfydzKMMo0fr08/asa/jU0ivEraqDZHGdZkg1nxbQyYkfEc6Al1zRBF5NX
7KzZTP3TfBAZmBm463bfNPbhZr0DqiaHeZ1y4cSLwCe452AwB+/5k8FnTNTw7I7E
RdXKw7lqb2bZM+MM6/g3pOsnnTUafbaVflKsEsl3h36ui5hthVex2ftGIZ7erf7a
F4SM/Qh9E9Avq2op+Yo+IcMcEUn5wjgUMEvTFliOX464IAkl42029eouz0CkO6md
OTjrUsWb1YpuliYq1aiPJV0T0RHEfg9tpy11p6jdAam1pKyw420=
=k8oG
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
