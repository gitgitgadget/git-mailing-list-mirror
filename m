Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0854C1F404
	for <e@80x24.org>; Sat, 23 Dec 2017 23:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbdLWXRt (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 18:17:49 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35936 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751325AbdLWXRs (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 Dec 2017 18:17:48 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8A151616C7;
        Sat, 23 Dec 2017 23:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1514071067;
        bh=fyW5lNc6twvOQ1z8rKMJeVBzG+95KnnmTfy2V01wmDQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ow6E3L2eHn4B2ZoxyQGjJilNA901vnlOhqL18+0xDyFtAR+1FaKBNjyt6u+XR1lXK
         hTAEFIxVbWrFkf08KgFurqRu72ZLU3KoW5ujg6/FV7YAAki8l90f7Dna8lsluOtYgq
         EO4OkfeqWJvaFIw+GnBdkKfW+jcTeQ1VokfYd5oDoIDfwaGb7tUhsbXK55kMkPRZG/
         WudbLkyraavYoJW7ekY75GzsAJGNke535tFM5Nq/jw1EhZSKx3Q/BCI/vtprP9rKJR
         ZEe03cPMka55SeMmYIj0s3NQrTRi3EHbZdDGfl8gABwSQVdw0RuQef2TP5g3JFr9n0
         t55QNm2gi5gLhACB1kZohXvo1RrY0zpR3AJml9ikTHD5GFTqdNU0lOc2BJ6Owshy3R
         VtiA49yxbs3k2vy709HcPNoda6CaXCqx4l4lNZ84OO5GGKgm9bsUpT11LoEt9b/2Kz
         d0KGrnf0CbOGwsTJtyW6ZS487Kr+OHYK/PwqhRiqz446QMKOZR5
Date:   Sat, 23 Dec 2017 23:17:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>, Jakub Narebski <jnareb@gmail.com>,
        Petr Baudis <pasky@suse.cz>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC/PATCH] perl: bump the required Perl version to 5.10.0 from
 5.8.0
Message-ID: <20171223231742.GF6217@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>, Jakub Narebski <jnareb@gmail.com>,
        Petr Baudis <pasky@suse.cz>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
References: <20171223174400.26668-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Content-Disposition: inline
In-Reply-To: <20171223174400.26668-1-avarab@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.14.0-1-amd64)
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2017 at 05:44:00PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> The reason to do this is to be able to use features released with perl
> in the last decade, 5.10 was a major feature release including things
> like new regex features, state variables, the defined-or operator
> etc.[3]
>=20
> I expect this to be more controversial as since the 5.8 release stayed
> along for longer in various distributions, e.g. it's the version
> shipped with RHEL 5, replaced by 5.10 in RHEL 6 released in late 2010,
> similarly the first Debian release to include 5.10 was 5.0 (Lenny)
> released in early 2009. The release history for other distributions
> can be seen on CPAN's "Perl Binaries" page[3].

This is fine by me.  As far as I know, 5.10.1 is the oldest version of
Perl still security-supported by a major Linux vendor.

Feature-wise, the release I'd much rather see is 5.14, since it provides
the r modifier to s/// and tr/// and undef-transparent length, but that
simply won't be possible until RHEL 6 and CentOS 6 go EOL.  Upgrading to
5.10 is better than nothing, and it does get us defined-or, which is one
of the only 5.10 features I ever see used.

I'm curious, though, is there some reason you went with the "v5.10.0"
syntax other than "5.010"?  I believe the latter provides a better error
message on older Perls, although I agree the former is more readable.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.3 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlo+5BUACgkQv1NdgR9S
9ovB0w/8CiiUMWIkvioeOqvKn/SRDl1tJEOYo4VfzRiNNMSGCIjGyFFgEIr3Phjt
kyHdE9mTxeEwkEPERWI6AbFJJhTaiz2Vi9crGzSPPx7My/9tqcdTLPi+XTsym02R
lr3YAp6x/3JGuHgeq2wGjWt3izMysLhcsapnIONkpdKCjxP/YDD/pGYM0MmGq51L
TF3hLBsbAEUvGSsCGlBRSW0ixao0YhmQ6uNLQWHCPst4Xx0LBX6DnwdHdfnYrIpD
MfqdfMT6mly31xNPDG8MCGz2VE83CEU4hKJOkV7RbNu7LJ6mWeCiNQqEGicjK4RN
ObxM2Kked5h/g9qp1JlUJ2jymmEbjQ8qexF09/R2056jVzcHHPio2ha4oPWZ5qUw
prq+TGjiElR10mK/V1OMd25Tac+3v7ceas99seMcvlEimPvPMcfYNhoX41TFKeWN
rJC3FaS+LI+JeBHJ98INLlOTh7NZaS9/ypK2sXHYhEc+EiOi0TJlY4tWINKZdmAv
WxwqToJXYftIIO8TtGaKf+WqwQw59GuJWgSVGmGVcOHT+hxkeqmIq4zskuvpkpUT
raUUTcAPK/Gwy+ggu31XZvVpM8oZzFTmq34kTDgpwTrP8D2sIhfmbcDJR31D5PZa
5qEC4q+bcYHuL+VDrobVMibw2+G+jxVDVy3da5lOUnRPch8rkUI=
=0rKz
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
