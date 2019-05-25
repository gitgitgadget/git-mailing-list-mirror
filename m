Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26B51F462
	for <e@80x24.org>; Sat, 25 May 2019 21:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfEYVTu (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 May 2019 17:19:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36726 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726739AbfEYVTu (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 May 2019 17:19:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:913f:ed51:73b0:1f35])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3932B60443;
        Sat, 25 May 2019 21:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1558819188;
        bh=o6NXr5hQMgkOlmFShsThqJ5ZiS6HX0V0RZYkEnCxzoE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zjjEq4+xaj48+wCYXRewkUMMepaGaxpGZbdz+JGE0Ed+LvnSm7TsKu6Rs4glii+zH
         WVC0f9MusiHpQqr2GlVZOyHkbcFfKKO+KlWN+yWga0ryxW0Du1CCOkwEp0JeRDuASg
         /KyTHu5dGO60wS4m9f5Swzgzsh/JOOOSXL/t5NTaAXaQhGbpkFTZUL/3u5E3yxgj0V
         2qOFzxxq4pC//kpTpGO1tsdZ+AivvE7SeHRJEWDYYmbyHtzvDTRZwrSSeGoC/hfwkf
         enBOe6BVKoLEs3lsiRljhg+J3ntCojK/JyYvP+td27WP7W9AassdCZhF+FhfHWChaN
         jtqdDPsRzFxxoVDalhGpGksu5MydybOVmzSYbX1DtflRMku0VQXznLYJqWc3Gbcxqq
         nX6Gzo6yjYixVngLMRANt8OSjroqs2L9Z38aJB8zScq0fEtW5TIHH+4aI3k3eBK5dH
         ODqTOESmIon9HXXLg/9OJl0zSMrHLVOQDnKZbqmNW2rklqMz+5e
Date:   Sat, 25 May 2019 21:19:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Keegan Carruthers-Smith <keegan.csmith@gmail.com>,
        git@vger.kernel.org
Subject: Re: git archive generates tar with malformed pax extended attribute
Message-ID: <20190525211942.GE8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Keegan Carruthers-Smith <keegan.csmith@gmail.com>,
        git@vger.kernel.org
References: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com>
 <20190524070644.GF25694@sigill.intra.peff.net>
 <878suufejr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
In-Reply-To: <878suufejr.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-25 at 20:46:16, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Solaris tar also complains about this. I've seen that for ages, but
> never thought to report it, I figured it was well-known.
>=20
> When you "tar xf" an archive git-archive it complains:
>=20
>     tar: pax_global_header: typeflag 'g' not recognized, converting to re=
gular file
>=20
> It will then extract the "pax_global_header" as if it were a file at the
> root of the archive. That file will look like this:
>=20
>     $ wc -c x/pax_global_header
>       52 x/pax_global_header
>     $ cat x/pax_global_header
>     52 comment=3D$40_CHAR_SHA_1
>=20
> Where $40_CHAR_SHA_1 is whatever commit this archive was produced from.

Ironically, for a long time the pax(1) utility shipped with Debian was
incapable of reading pax headers. There are various other utilities
(including 7-Zip) that don't understand them, and they invariably get
converted to regular files (since that's what the spec says to do). This
problem is well known to me, but I don't know if it's well known to
everyone.

In this case, I suspect Solaris has a pax(1) utility that works fine,
but nobody bothered to port that code to tar(1).

Usually the lack of support is because people prefer GNU tar archives
over actual POSIX tar and pax archives, so real-world archivers don't
see POSIX archives and don't handle the extensions properly.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzpsW0ACgkQv1NdgR9S
9ov5GhAAloDB3CO0ySwtfFOgDX1mXD4Vw1cb8ahx0MPxTrH2nSRIYONkm00Zh73s
4P52YJ4z5T5IZDSq7UCtmVDEMYaueNeXNV+LIRXY18C8RpPg7hUbMlsdbNaw7YHH
o+htX7KIKJ2ujpybSeKXBKJWfIu1una3DVMO4WrGhkzriSfDbi5gd/pmdiUQZHPv
/5il7QCw2MwuoQR1DRzrokP96c35DP5u/r7ymBRNVYD8akUlQAXu8Y+v/3xtiaOV
AzWY4pyxD4JELLxM6tF3SrCC3hZR6uKGIdluEQe144xpxRxQ3QcfLxuRSxOlHggf
102tnN9yoZFl5cX1yBBfLKUj5qsT9KaUDiaTKd+gMH1GihIDOYsMmc8VZgs/0Exj
Bk22XA3RpazsgoOPYSHmHUx8HbsfKbHOMWbX8jwaxi9Lona6ST1IBbF/gy47tBOK
mkG4Snuy78sb2lePMzOzQb3TDVa0ZOY3ivYTe+i5lP8ddfDJtYDqQYdVmrX3laPO
ZfG3IJql/k+eDtTORdf7UJYejw5KPnvL+oBrQ2tsFO5R7lkF/jssyR/VfKlktPXb
MQF9NNsp2F6B2IbqdIZrmTjDsM33DfGDM9ycjeC0jj9XybAwYwiB9DNs4jVuC02h
bNsMdmyynvZS551bIJCHJ5T49/ttoMZTCR4tyl2BEG9fKrqlAyA=
=qdox
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
