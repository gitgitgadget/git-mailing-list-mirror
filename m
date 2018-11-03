Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 024E81F453
	for <e@80x24.org>; Sat,  3 Nov 2018 15:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeKDBKE (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 21:10:04 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:33924 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbeKDBKE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 21:10:04 -0400
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id D47E7335C8F;
        Sat,  3 Nov 2018 15:58:20 +0000 (UTC)
Message-ID: <1541260696.1028.16.camel@gentoo.org>
Subject: Re: [PATCH v4] gpg-interface.c: detect and reject multiple
 signatures on commits
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Date:   Sat, 03 Nov 2018 16:58:16 +0100
In-Reply-To: <CACsJy8DwGHWLWxLrC2XZ5XS+se2W6gYCXtFjzWghgkgYGi08ig@mail.gmail.com>
References: <20181020193020.28517-1-mgorny@gentoo.org>
         <CACsJy8DKD3F3o74gTHW-WEL_hpB8x+oaWX8_SwN01Nmz3W9Z_w@mail.gmail.com>
         <1541259137.1028.12.camel@gentoo.org>
         <CACsJy8DwGHWLWxLrC2XZ5XS+se2W6gYCXtFjzWghgkgYGi08ig@mail.gmail.com>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-yBTuKrgkywwlUPXX/KjB"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-yBTuKrgkywwlUPXX/KjB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-11-03 at 16:36 +0100, Duy Nguyen wrote:
> On Sat, Nov 3, 2018 at 4:32 PM Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>=
 wrote:
> > > Perhaps my gpg is too old?
> > >=20
> > > $ gpg --version
> > > gpg (GnuPG) 2.1.15
> > > libgcrypt 1.7.3
> > > Copyright (C) 2016 Free Software Foundation, Inc.
> > > License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/=
gpl.html>
> > > This is free software: you are free to change and redistribute it.
> > > There is NO WARRANTY, to the extent permitted by law.
> > >=20
> > > Home: /home/pclouds/.gnupg
> > > Supported algorithms:
> > > Pubkey: RSA, ELG, DSA, ECDH, ECDSA, EDDSA
> > > Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
> > >         CAMELLIA128, CAMELLIA192, CAMELLIA256
> > > Hash: SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
> > > Compression: Uncompressed, ZIP, ZLIB, BZIP2
> >=20
> > Perhaps this is indeed specific to this version of GnuPG.  The tests
> > pass for me with both 1.4.21 and 2.2.10.  We don't have 2.1* in Gentoo
> > anymore.
>=20
> Yeah I have not really used gpg and neglected updating it. Will try it
> now. The question remains though whether we need to support 2.1* (I
> don't know at all about gnupg status, maybe 2.1* is indeed too
> old/buggy that nobody should use it and so we don't need to support
> it).

GnuPG upstream considers 2.2 as continuation/mature version of 2.1
branch.  They currently support running either newest version of 1.4
(legacy) or newest version of 2.2 [1].  In other words, this might have
been a bug that was fixed in newer release (possibly 2.2.x).

[1]:https://gnupg.org/download/index.html#text-end-of-life

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-yBTuKrgkywwlUPXX/KjB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEXr8g+Zb7PCLMb8pAur8dX/jIEQoFAlvdxZlfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDVF
QkYyMEY5OTZGQjNDMjJDQzZGQ0E0MEJBQkYxRDVGRjhDODExMEEACgkQur8dX/jI
EQrA0xAA3Bd4Oeq5P5Vf7WXuPbqxD9Ng+TAQP6rCAicIHPU2OD3AXsiGFLdHCnKt
8JElSlMcTMzb0RmVO3M7gynn2lhh/kgA9AK11NktukVA1049cT600V5rIyiY/kMg
Pe9iqCfFOmo6yA0kAQZFqDSjZAK2teNCrSHej9GJsV03e9In+oBbQn7R1Nmp0Iiu
E+7qQF5l6cLe/eYHNtdpWYXq4DdgHBRTAgWYD8Vy0t27Zv/DnjGKeVwZJpckeVIm
KqPwHrJX/VO4XiFVCNW3Z3BXX8wVoHjM7kndR3rxIteKv3bu2uUJfSZmZGFsix4b
adqqk1xtAdGgxUSmYHw9+W2Uqzj4c5K4glM1i9Oon8ORzlSWOO2AoYtBlehd5oO+
wLD2jQbG+pOkJmZL+HxY0JAqOqk9PE1fWRlmzOuYWy526R/QiWsWz21jc6RNEqvA
h1ZX9PcYzuw0qBPn0BYkhIR26pDcDA9G7pd9doFfQlMFi6imJ+EAYQXF86t8/1LA
Qt74/bCo+qvIplkplydf5UT4xOZ3Jc/2UDp7hMavsePc1jM0CokrPPQnv4/KQofH
wOtu785m95lBzigX/LuPc+YA7tVQ951dFE7bOHHHI6i/qOII0PVkh2VHWfXYSVze
kPIIou9IUM4AkNOJSZ5Q2LHKhm4A7IecIs4oK3McDEH3S/BApeI=
=G+aY
-----END PGP SIGNATURE-----

--=-yBTuKrgkywwlUPXX/KjB--

