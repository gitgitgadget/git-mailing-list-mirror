Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C35C81F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBLBmW (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:42:22 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34446 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726815AbfBLBmW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:42:22 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 482E76042D;
        Tue, 12 Feb 2019 01:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549935740;
        bh=WeV9GhIvhKlU+PE9oZznGG2avRiyHjPgfMDSWEMzDEw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xZwkvGEcWNF+T5rVsHwCE279tdDe4FaRHbj4oxZyZSSvZJdagc1rb7YRY0oJ5nL/v
         Up4qEv+lJ2DT9Dfaa6exAcrhC95DSBddQJLmvyz3xJOZ5QGMO3+BF7WdZJ74nDxVJU
         zkVI91v5BwRGX273d8RaD0La3Rq9rjtJoY2HqNGHwd6YAaDHn+oqseViHDMRYNW5Ez
         umTYZtjhJJEcJdJwPj9fOO7Thf9dRbURHL0O4MvtlSsoykWr5wMO2X2AiNOnNzVQwQ
         U2Ho8x32jJq/sxJ05AAU56aqc0bl4ACAokn0saVHRzsp4dUqizclTgQcM3pGKNbaOD
         e4zn2ILau9xmSJ9toQ6HP/ligbwj8OHo7e1qrF04brJid/AMEzHCNz6x33FxYH4Hq4
         qJQGjIjb1t6742Rsg/WenUXNlANIbn1EbDUxHV3r59yMqgA3eu75KO/Grsy6MicWIY
         T/4TKcy6W0YS+kuTcq2Hs3MvJXC4sWBVIt4icHzWZAYaAgi1FOT
Date:   Tue, 12 Feb 2019 01:42:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 08/31] notes: make hash size independent
Message-ID: <20190212014215.GE684736@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
 <20190212012256.1005924-9-sandals@crustytoothpaste.net>
 <CAPig+cRQrkeD6rL8M9pL4kjPTwbPdjUYyH4Kes3jk9Wn0O-NtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline
In-Reply-To: <CAPig+cRQrkeD6rL8M9pL4kjPTwbPdjUYyH4Kes3jk9Wn0O-NtA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 08:37:49PM -0500, Eric Sunshine wrote:
> On Mon, Feb 11, 2019 at 8:23 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > diff --git a/notes.c b/notes.c
> > @@ -527,15 +529,15 @@ static unsigned char determine_fanout(struct int_=
node *tree, unsigned char n,
> > -/* hex SHA1 + 19 * '/' + NUL */
> > -#define FANOUT_PATH_MAX GIT_SHA1_HEXSZ + FANOUT_PATH_SEPARATORS + 1
> > +/* hex oid + one slash between each pair + NUL */
> > +#define FANOUT_PATH_MAX GIT_MAX_HEXSZ + FANOUT_PATH_SEPARATORS_MAX + 1
>=20
> I had trouble understanding to what pair you are referring. I _think_
> you mean "pair of hex digits". If so, perhaps:
>=20
>     /* hex oid + '/' between each pair of hex digits + NUL */
>=20
> (but not worth a re-roll).

Yes, I did. I fully expect to do at least one reroll here, so I'll
update it when I do.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxiJHcACgkQv1NdgR9S
9ovf7xAAuQ1RQt+519ld19x7AOnQn+ah6WRddvh83ZxiA3CJqx3U/eAY8aCrgA+x
xYSHR8r6N/6/nB4qfeVVWCilduT4d+EfZrQSOAHweQCJGAjThfbW0kiIH9K6qyBf
cLuDuuCdfLIlj7OiIBpLx6wLll36H9ocJukk+taDz9SObOcEbActuoRIL9MaSzuc
zvcxTYp+RIt1Igfo1H0LMLbdhJCYybPOzPliNCYsQiGwxtuNuhp7/KrO79C3fVX7
cPJj2O7KrYGgzQaGKOGDcztTsBMhA6gvkqU0W7CzYGkXoHNBRJDDi4+ILRXICs1m
yKRNjytjRQCVk2O4g83Wh3T/kPdU0LuyIexsVSzwFGNuGMcmtPStCkte0r5NunBy
9nbgarimEe+I+FCawVL3zkB1lGWLhGUApVJ1AAeO/n7DTr9D/VpUhIWiXk7Dz9iv
Gm1fSXJdZA7MryfjcSwRe40KtytnehE5nO/EIIwAmIcT/dPKFTP4CDW/2uRa+AXf
JkL+vUvHKX5hL1QKAf1GAJsMZXFS9uAHi/LHktuqdM+0o2wCtFvqdZfXfiBJ2K5X
JZKYVI5lI53U99fKWvh8LaN8FzHqpODnFsNsHSzPuFTFz0wQrPWf0kDigO0/fuX8
x1BGVf2p/wql6pXS36Fv7uIBmH/WRZvFxbOtevyDgyXG2L9rJ+U=
=6IFt
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
