Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBF491F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 01:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeKNLCk (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 06:02:40 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54362 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbeKNLCk (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 06:02:40 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0902660489;
        Wed, 14 Nov 2018 01:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1542157307;
        bh=KoMZ7YB97UmS77Rn3Rz83VPKxzTtNfkO8UyT7mPT7LQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=S2fKzhi/2fBIx6RqeV0wmCc6UGDWu9X9UwH7DrnSaVZT9rDSY6eaUL7NoYKqIVk5I
         GxTAeaBppSdfjzqgTWEfDUhk93Fip/X6yevaa4DjXKY34eMZSspDnQJCAkBJwih58h
         fxVw5nqV6KklnLuKDQKlaCbvjQII+z3/C4+Ns596qdSORZOEnBmPjbVaodPbC1+epw
         9sMhUtzQgvhyGf6O+zTVNQoZQoeGqk6iW3oankSlyDv96ShYp0iVzr/I+Uqen1pgrN
         jKtV79ssEc1zAO/jNnBBITtvZiDTCd+xAl17ENcOGfyWdndbmX8oN3wEvC8nRjSpn9
         GRPOoHKWBF9YnZms9YCtVYujp80KbwBcovysBD57nGiRTIJXzGEVZaiuWHNunc4KFW
         zKG+j8aSQeDKi292nEhh+OFS+EffizXvTyzXcX4s6HvdtRfPzes0+viktH1U7TAeqg
         zGUtEggwa0zttb6wMMuaA9AnBY9qe9ln2t3678fJfVh2sS++Egt
Date:   Wed, 14 Nov 2018 01:01:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 02/12] sha1-file: provide functions to look up hash
 algorithms
Message-ID: <20181114010141.GL890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-3-sandals@crustytoothpaste.net>
 <06e5bc95-b901-163a-5088-888878187ca2@gmail.com>
 <CACsJy8AtWG=3nJuqG07seczqeb8taimzT4fPbFHc-_3Y8FE_5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dfmC41YZQlborXoK"
Content-Disposition: inline
In-Reply-To: <CACsJy8AtWG=3nJuqG07seczqeb8taimzT4fPbFHc-_3Y8FE_5Q@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dfmC41YZQlborXoK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 07:45:41PM +0100, Duy Nguyen wrote:
> On Tue, Nov 13, 2018 at 7:42 PM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 11/4/2018 6:44 PM, brian m. carlson wrote:
> > > +int hash_algo_by_name(const char *name)
> > > +{
> > > +     int i;
> > > +     if (!name)
> > > +             return GIT_HASH_UNKNOWN;
> > > +     for (i =3D 1; i < GIT_HASH_NALGOS; i++)
> > > +             if (!strcmp(name, hash_algos[i].name))
> > > +                     return i;
> > > +     return GIT_HASH_UNKNOWN;
> > > +}
> > > +
> >
> > Today's test coverage report [1] shows this method is not covered in the
> > test suite. Looking at 'pu', it doesn't have any callers.
> >
> > Do you have a work in progress series that will use this? Could we add a
> > test-tool to exercise this somehow?
>=20
> Going by the function name, it should be used when hash-object or
> other commands learn about --object-format=3D<name>.

Correct.  I have extensions.objectFormat code that will use this.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--dfmC41YZQlborXoK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvrc/UACgkQv1NdgR9S
9ouK4xAAkfs44vTumejOMY+EsbaCCjBaLcCMY6JpTmXV5K+dJt9vyHwxTTDEWJ8d
eYToABbPQACzo+yI/iyIQKodvUu/PdjwaZkEhfM6ok3V9tsowRyP0zoJIsbtkcgi
DMoiRDIB7Ju7HZy1lp82CLuct6ZmTyaeAs4rdeP3KiCiHTVySDTkLMuaHrQowbKt
b7vVDSf3YXSXJJ+TuJesktXFW+Fhz9YReBlH6JYKsgcv7cJk5JdCZ4IZv2/+Jkxh
GY0QTZzGU8iz8NXhWhbVl+IpwWRm0p+Ze04dKfk3QoW3kUMlwDMIA7+AG9xNsEQY
54m2N66Yc+SB7D/8h5rPh31ceT0y0vb1PGzhCm9F/PX1oYA7ctYPcjtrIp1beuGF
AGMiSFeOuS/R42x0dopI19twMha9867CObEa13IpHhgoXh56CyccDDPIJL2p3xjU
DAxJ9e0K/Oq0cglPUYU/drEtVsM0rknLqRLW2ws11f7bcz8HDZTOJsYkc6MAbPPy
1KHovNcvfqlx4GHSPwo6Qg3RHQGsyxyEucrMfIpIf8xz6JOsHssBSX+jzVHAoMce
oP+sYuzkHS1zC66pQbPTNGf54Tgzq29ouxbG+d6pJxVnpBx2j4G0kJCqwdu64FZV
SyZTDMli7G8Fo7s/mmjCbkha2FbAy6bYkrEFxJDWPnqWtRiuLzA=
=xY/I
-----END PGP SIGNATURE-----

--dfmC41YZQlborXoK--
