Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 544BB1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 02:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbeKNMM3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 07:12:29 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54380 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727005AbeKNMM2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 07:12:28 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 15C6460489;
        Wed, 14 Nov 2018 02:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1542161483;
        bh=4eFSQs7HkIYxV0I9l1IqsprndlnRzohNf0SXiTot/Hk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zLMCLx/lBE+MPyy4fGrx382KneOOyrmGb5nZvLq1zsglxI7v91Bd7Yus8RrhT490i
         EkYC8sEkP5JtEncTAw171uHacErqjyIe8wc/ZTIi9ZC2slEFQuzwhWZMqzXDRSd4Bs
         iGcFn4w3iqucYUmelNep3u4+k7ND3grIlKZkw1LE2fY4/8uuT5zx8XgsaAbwekk/6Q
         iCkyYjiLXnT6tPt3r6RvucMFtjwnK3pCz84WAnO8TFbBG7ZgWur0dXnpGzIK4xizGq
         M2O2yI1qGOzOlOemmMfnELS+loDCYgdqUt2iIRagZrxV+b4n1LMYxDJVL0unu0n5CC
         KnCpvFoHYPMwPn2tO9iV2im9pQL2osM11Ta0nJEFfK6w9EkoWG7/HHNk90GAWt286W
         mDYv8PrSkx3eo+JivtTunTntauT6MCI29rr1qfE9uDUzlBkV7eRWVCRufRk3yScT+7
         BBJY8tT0u5t4UddyqvuGe2OfioypGtJ6axUvoVhuD0fhR+W+hI7
Date:   Wed, 14 Nov 2018 02:11:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 02/12] sha1-file: provide functions to look up hash
 algorithms
Message-ID: <20181114021118.GN890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-3-sandals@crustytoothpaste.net>
 <06e5bc95-b901-163a-5088-888878187ca2@gmail.com>
 <000ff851-3068-36f0-4fff-1e69cd24cbec@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EqVOK5mkaJAMmtSx"
Content-Disposition: inline
In-Reply-To: <000ff851-3068-36f0-4fff-1e69cd24cbec@ramsayjones.plus.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EqVOK5mkaJAMmtSx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2018 at 12:11:07AM +0000, Ramsay Jones wrote:
>=20
>=20
> On 13/11/2018 18:42, Derrick Stolee wrote:
> > On 11/4/2018 6:44 PM, brian m. carlson wrote:
> >> +int hash_algo_by_name(const char *name)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 int i;
> >> +=C2=A0=C2=A0=C2=A0 if (!name)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return GIT_HASH_UNKNOWN;
> >> +=C2=A0=C2=A0=C2=A0 for (i =3D 1; i < GIT_HASH_NALGOS; i++)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!strcmp(name, hash_alg=
os[i].name))
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn i;
> >> +=C2=A0=C2=A0=C2=A0 return GIT_HASH_UNKNOWN;
> >> +}
> >> +
> >=20
> > Today's test coverage report [1] shows this method is not covered in th=
e test suite. Looking at 'pu', it doesn't have any callers.
> >=20
> > Do you have a work in progress series that will use this? Could we add =
a test-tool to exercise this somehow?
>=20
> There are actually 4 unused external symbols resulting from Brian's
> 'bc/sha-256' branch. The new unused externals in 'pu' looks like:
>=20
>     $ diff nsc psc
>     37a38,39
>     > hex.o	- hash_to_hex

I have code that uses this in my object-id-part15 series.  I also have
another series coming after this one that makes heavy use of it.

>     > hex.o	- hash_to_hex_algop_r

I believe this is because it's inline, since it is indeed used just a
few lines below its definition.  I'll drop the inline, since it's meant
to be externally visible.

>     > sha1-file.o	- hash_algo_by_id

This will be used when I write pack index v3, which will be in my
object-id-part15 series.

>     > sha1-file.o	- hash_algo_by_name

This is used in my object-id-part15 series.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--EqVOK5mkaJAMmtSx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvrhEYACgkQv1NdgR9S
9ouf4BAAmjTkgLy/PVqCmO5ezHRvcskNLWnSngJj4eWz2kOL48H3m5ofqAXYCf8J
LdbZhgZS3NPMEs4W1fOG6iPhqdbbk2IFMHtt4JqK4dljzf2F7ODHLKEPFirktR0O
CRTQYd5/48lbBbzHdrK4Y8FWAoQtLiiQKapetdHbFejflXagqVn5ROBNcsTyLl56
BzeuMr8wy6nIc33I07LXoZBiASp8pKDPAMg79xxm5/1AxUYPAkx6OnwjDuBQvGzC
c759bCq1pcQ9vGw+3DHT5WLhPz1q3aslv89zmkhJ4O05ekJqMwRoOKlTPXc9XN8o
r6Egy7j5fBUd8UK+SSJJVQnkZ8wA/3C3qOrZ9BwbIb0QDfQt5pMbh6FYyDb9q4s2
s8q6BkRwUAXqjMa7CieDiedKgFzE7GF8q8opcn40iUnb5og6+rKZ7eP2mbeWZEa7
5SkTwOZh1gB26rawkbaiY8ocIV4Cf/pMIsZyXeI0EaEKUdXgI1ER6QbsMOMkwEvB
sR25HXwf+hRs2UShT8B7HakFqO7nRv32Fz0ZO2YYLyNoVSGgBTrfMhILgRVOZwub
Fi6/lQo2gX9o0EshUmRCxoOak+vB49x+IjOPZAs2BXNMfols5O+ZL2tlgEhfTK1x
YXsRbWhConfW44zuzTMgnQ2JSb0y7cg1Hkik1TkzljVV9clYK6E=
=NuI4
-----END PGP SIGNATURE-----

--EqVOK5mkaJAMmtSx--
