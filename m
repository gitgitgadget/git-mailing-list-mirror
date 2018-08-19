Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A87E1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 23:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbeHTDJ1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 23:09:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55438 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726436AbeHTDJ1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Aug 2018 23:09:27 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6C3116047A;
        Sun, 19 Aug 2018 23:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1534722968;
        bh=2E12/ZXHvcwdFKQyrhPSr6wlbvSvGb7oevWXUIMQUHM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EK6fsp0ziWD65xBP5f9ojXse6jGJ+Cg2hHj/R8eodgeNuKpVZGN80oNRzOBA4LJ56
         qJzVasGTF7iGMIfAnVwZaUkU7K/TCHZleCnUh5PmarRvuQz5ZVrTKzePsgYmMSgL5z
         iyXlC01Ecz9LjbnDbOlKm8iw/7zAAGJwpX+8hk41bg0P3zByuBQq5nke+1tffsxTe6
         dMZaCOluh/gJLV/rcpinC8AWcvwunv9+oJZU+xlbKD9syx2lFETQqnyj1cNP54q989
         O2OxF8wQuH6DiqKkxlEltAVqRRkR7SIDpqxApKrMRUw5EZvIkl5UaFh5Ec7jMAGkWz
         S0y6mMWtMXR7LtG2AsEauLXgcjQDb4cz2j2Zuom/tGW9XGbR2W2uIJ6nnyNiXKrcmK
         5GxNWVF0vXCN2TA6gb1maLpJXW+EF53KbwMOSFkxIOQlGVyy4s6kgOrLkeQbtFerKU
         io+axI6+EzMSjrtOMVdnl187KJqHfq4xT2Df8alcnYl9yhc/PNJ
Date:   Sun, 19 Aug 2018 23:56:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 01/11] t: add tool to translate hash-related values
Message-ID: <20180819235603.GK70480@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
References: <20180819175351.449973-1-sandals@crustytoothpaste.net>
 <20180819175351.449973-2-sandals@crustytoothpaste.net>
 <CAPig+cRZsJ00wNW08-jxmD=aW0V1hJJYEa9EVTMQT4=r0B+jeQ@mail.gmail.com>
 <20180819215022.GH70480@genre.crustytoothpaste.net>
 <CAPig+cRSUDAdE2ECcH+b8h4urJySaS_VybQdHNv24rad_kFEag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+svXpSx+RSEd8UhP"
Content-Disposition: inline
In-Reply-To: <CAPig+cRSUDAdE2ECcH+b8h4urJySaS_VybQdHNv24rad_kFEag@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+svXpSx+RSEd8UhP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 19, 2018 at 07:06:14PM -0400, Eric Sunshine wrote:
> On Sun, Aug 19, 2018 at 5:50 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > I think what I'd like to do instead is store in a variable and make
> > test_oid return unsuccessfully if the value doesn't exist.  I think
> > that's better for writing tests overall and will accomplish the same
> > goal.
>=20
> My knee-jerk reaction is that could get clunky in practice, but
> perhaps I'm not seeing the full picture.
>=20
> An alternative would be to return a distinguished error value.

We already do it in several other places in the testsuite when we want
to check the exit status of a command substitution, so I think it will
end up being fine.  I'd like to try it and see.

I think that we need to fix the return code either way, though.

> > Putting them in a separate directory makes it possible to do something
> > like this:
> >
> >    (cd t && ./t0002-* --verbose)
> >
> > and then use shell editing to change the command line.  If we put them
> > in the same directory as the tests, we make developers' lives a bit
> > harder.
>=20
> Perhaps I'm missing something obvious, but I'm not following what
> you're trying to convey.
>=20
> Okay, thinking upon this further, I guess you mean people who type
> your example directly rather than using "./t0002-*.sh" or something.

Right.  It also makes completion nicer (in Vim at least).

> I'm still open to the idea of supporting experimentation with other
> hash algorithms and I see how lumping all the OID tables into a single
> directory can make it easy to locate everything that will require
> adjustment for a new algorithm. But, this information can also be
> gleaned via a simple grep for "test_oid_cache", so I'm not sure the
> lumped-directory approach buys much.
>=20
> Also, my gut feeling is that such experimentation will be very rare,
> whereas the addition of new tests which have some sort of
> OID-dependency will likely be a more frequent occurrence. And, the
> locality of an OID-table plopped down right next to the test which
> requires it seems a win (in my mind).

Okay.  I'll do that, and we'll see how it works.

> However, I'm sympathetic to the ugliness each caller having to specify
> "$TEST_DIRECTORY/...". In my review of 2/11, I suggested the idea of a
> test_oid_init() function which could load those common OID tables for
> scripts which need them, thus hiding that ugliness. Another idea which
> has some appeal is to define an $OIDDB variable (or some such name)
> with value "$TEST_DIRECTORY/oid-info", which lets callers use:
>=20
>     test_oid_cache <"$OIDDB/bloop"
>=20
> which isn't so bad.

I'll stuff in a test_oid_init function.  I think I like that approach
the best.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--+svXpSx+RSEd8UhP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlt6A5MACgkQv1NdgR9S
9ouXIg/8CcyifyD9HyOKUZaSPD8jZIUe0eciB4ziOTb20KiuBrixN/4EKxvFpiSR
+Ukg6eWIDvti4MXKWISxjpJoy38vi/SV2AZ1eNWvoeUPzU0vp72og1pYzj8zh07p
U8PLGikmLp6z/y3iD8NIVNR2YDsnLhAHCTJkXKbrOysmuISBiMJK9KiK2b6GtXcd
vCweXq8mmoKziHvYTdrM0EaR9smd2JAE3Vw6ld+gUxhMZQolGMfK6+WhQWfzTyHx
6kXM/ZBlQLCbX1kgqbhsqqttF9XFcad28NIS5MlCjMhd5rLiSxUQELHvLte/GAwf
7TC4v+G9zJ98GF7xM1IZzYTM1ArIxLIqHzOi3BSMbJhHLXn//lNj6YnQ09OvkPD/
D1EiqJLPzvTukksKzAFPNv0N24dPqfkhDkyn+H+YsQOg/m5gkE3Su584jIIz3TvI
r9HTsFKpTeH6jXv5LfCPPTZj0aOQNIBpWQ8XNwXy7b2johzxwD7nZkEGk+ol8QEz
s0fS4tP8uD5MgdxZS9xUXf+fpgmDB1H5Q6hVHCCOoFs9luT4kHoOIQiBFgq38yOd
op6ovCIeibM85/VOot81pyZb5rYcjjpc2EME1KqMyfjTZi6pEVL+dHcCde7xZx57
LKE0vGBPDEulm7ebn3jSht5Gxp9C+uRDgCE5MsVuK7I4nDvDUVc=
=X70/
-----END PGP SIGNATURE-----

--+svXpSx+RSEd8UhP--
