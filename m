Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB4F1F404
	for <e@80x24.org>; Sun, 28 Jan 2018 21:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeA1VwP (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 16:52:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58482 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752570AbeA1VwP (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 16:52:15 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8080160431;
        Sun, 28 Jan 2018 21:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517176333;
        bh=D3e1crH/JJVk8HL5DomPrI+vyCE5yfGTKxVCLEjlWcE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=AWiMZhGbz7jVYjPYIYJfBSQj8YcWT5NB1hhz1wszznyJmTZXqQmtNmzoZ95MWgOlm
         3wx4LltG67z8LAb5uQhFei5rD+/FJNsRyFEvz60/vsME19uQJtGSbuleVDWrfLf0OG
         PbN8I54Yhrx/IB+rdn9c7IWf2fdTchnDOl/5ZcYyETSp9ovEfOJfDKH0tqehsJm0Ok
         E1NtLCvgzXQd5FYpAe2GWTBwMMq8ZYn4zxFCbt3dRkbaT0hh9PYSNNVr8WkSpax6h9
         JkJ18yMzcVcjeDg9334xS107rAJauTSgPHZ2cpMugrGoCvq+VgZtVJVM/mjywGwEEA
         r+3y0hf+ecYKGy/aaKFRwr8ya8mQzPlxxRqPKMHH/db+r2gNPOvPqJ5ZBcft0od2m9
         o0GMSuLpnZA2Vf7PEJ5H7LKQ+TsdBJqApZ+wj6HrXZRxqGrkbT8TVvvWpQZHQfukMT
         j1XahkWwzAEVF9lJt6Ya/FibOqR36e4H/lFMzCddU2Xir5tzFPF
Date:   Sun, 28 Jan 2018 21:52:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/12] pack-write: switch various SHA-1 values to
 abstract forms
Message-ID: <20180128215207.GL431130@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patryk Obara <patryk.obara@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
References: <20180128155722.880805-1-sandals@crustytoothpaste.net>
 <20180128155722.880805-9-sandals@crustytoothpaste.net>
 <76f6c291-9c48-279d-3bb6-fc42a8e0eb9b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RNGrj7vazCqBHNw7"
Content-Disposition: inline
In-Reply-To: <76f6c291-9c48-279d-3bb6-fc42a8e0eb9b@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RNGrj7vazCqBHNw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2018 at 09:30:36PM +0100, Patryk Obara wrote:
> On 28/01/2018 16:57, brian m. carlson wrote:
> >   		if (partial_pack_offset =3D=3D 0) {
> > -			unsigned char sha1[20];
> > -			git_SHA1_Final(sha1, &old_sha1_ctx);
> > -			if (hashcmp(sha1, partial_pack_sha1) !=3D 0)
> > +			unsigned char hash[GIT_MAX_RAWSZ];
> > +			the_hash_algo->final_fn(hash, &old_hash_ctx);
> > +			if (hashcmp(hash, partial_pack_hash) !=3D 0)
>=20
> Maybe "hash" should be struct object_id here?

In this case, I opted not to do that because it's specifically not an
object ID.  It's a checksum for the pack, which isn't a normal Git
object, so I tried to preserve that distinction.

> >   char *index_pack_lockfile(int ip_out)
> >   {
> > -	char packname[46];
> > +	char packname[GIT_MAX_HEXSZ + 6];
> > +	int len =3D the_hash_algo->hexsz + 6;
>=20
> Just me nitpicking, but "len" can be const :)

I wanted it to be const, too, but I recall getting feedback discouraging
it.  I"m happy to make the change; after all, it can only help the
compiler and any future readers.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--RNGrj7vazCqBHNw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpuRgYACgkQv1NdgR9S
9osU6A/+Jsg0BHEllxm0NCCYIqZTR9XKRLposRZRBKyoz6gspCFLVOmFPnQayYBO
d8BGggCxaglv1Dxyzq1vAfIH7igb1uQMnif/haH8wWHQ3lCqBXG4vuBGUEsoZSpj
WGFg2gF2etK0/z+c/N+qSDRvIK1zagxclWgk+iw4q1hnF0b8rSGADqbKZ85faD0q
fh4a6zH1BRhIR9vhFvgiJ+WmF6uh20OkjekAONgYubnanklUcL90hw/JShKCeOv3
kgZc0KXzMUsh8aA9WR1EbkM8Tc5OaLa7R4rJrILLd5cXX3mzH/atOfXGwH0jUaLm
MeR0c10JfgdApBeIDTU8gyuEopII6b/aIWurQY0QVw1IkRqZJugYP3npLU7aUQaI
gyL4tGS3VPsD66LbvLJMfW3YFmihopPw3Ja8Gj5s6MEklN9qEciW3xroSHCeFuj7
5ZWk7x6HbhjcTL71N7KzaqiT806HYkTdRS591fpbxDYLZjQ8VDou9DCAjvCkQr8f
VxO1MSjdsvu0LSuxXotwQw1mdZkrkTJbrFdclgwCOGiIDx9qpZzBhCspEyWZ4Yjm
LIP7L/DmA0uLF51sp1hGI4Z7hSDxst0Yl3b+Gd44Ev6GdxM5nEo2PPb06TGhlC0I
9pHU5B+Rg1GEb8c9nS7jLZmcSfzLSvyLl1SCqwxDItRU1NuXv+U=
=zSzP
-----END PGP SIGNATURE-----

--RNGrj7vazCqBHNw7--
