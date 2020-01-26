Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A000FC2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 22:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7167220716
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 22:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ITTeTIaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgAZWdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 17:33:49 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47636 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726670AbgAZWdt (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jan 2020 17:33:49 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4157B60482;
        Sun, 26 Jan 2020 22:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1580078028;
        bh=hgPSsspzD8+RvQRyU8BzHIKfSkGOWHfxNNzZok1VZdg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ITTeTIaNjHE+28XdE4cr1eEBqJDIeZVWvCZlduKC1Q9ChWm4D9JqSY0edvWzocuXc
         lP1rQ0FT5ZUltl6gk6nJgI4tqT4pbohwHdGJVFSCS8pblKomJJMmYhrD9y0zao+uNg
         O7QhtH3oUidUyVLqoMMRpsLJ9ZMxihne/JeObZpzjeexhCUbWz8KSj/fx6H1ya62q5
         QyV5rjb9gWVZ2iPUA4RR88Xb6beK2AFbhgawwQbQwoz4PlAsvPYl/kkLc/6WdbbkAR
         pHFI25mnJirIKU6iXxLiYLHFqtlk9l8bNeLd5eCI3eDB4U7K3BixdpXfF+5KV1I5NH
         zrBVVGgiASTwqRbW/461vm9BkbHYG/ka1NQ3QSWeNjZsO2elQqiH+YhUXZ7J5ifVtQ
         TIHIPV0PcdTjFWpjJ4Lba00iEjTeRf+uCtge3akhT8bd2z2UgVbAiKmjd7i++YRXD9
         AdeBMgfxRB36IcfrtSaRHXSAqUtzSb4szA7wDLda5rIYuFBrpzt
Date:   Sun, 26 Jan 2020 22:33:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 11/22] t5302: make hash size independent
Message-ID: <20200126223344.GH4113372@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
 <20200125230035.136348-12-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2001262315150.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2001262315150.46@tvgsbejvaqbjf.bet>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-26 at 22:23:32, Johannes Schindelin wrote:
> On Sat, 25 Jan 2020, brian m. carlson wrote:
>=20
> > Compute the length of object IDs and pack offsets instead of hard-coding
> > constants.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  t/t5302-pack-index.sh | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
> > index 91d51b35f9..93ac003639 100755
> > --- a/t/t5302-pack-index.sh
> > +++ b/t/t5302-pack-index.sh
> > @@ -8,7 +8,8 @@ test_description=3D'pack index with 64-bit offsets and =
object CRC'
> >
> >  test_expect_success \
> >      'setup' \
> > -    'rm -rf .git &&
> > +    'test_oid_init &&
> > +     rm -rf .git &&
>=20
> Why not consolidate the `test_expect_success` line into the current
> convention at the same time ("while at it")? I.e.
>=20
> 	test_expect_success 'setup' '

Sounds good.

> >       git init &&
> >       git config pack.threads 1 &&
> >       i=3D1 &&
> > @@ -32,7 +33,9 @@ test_expect_success \
> >  	 echo $tree &&
> >  	 git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
> >       } >obj-list &&
> > -     git update-ref HEAD $commit'
> > +     git update-ref HEAD $commit &&
> > +     rawsz=3D$(test_oid rawsz)
>=20
> Since the `rawsz` assignment has a lot to do with `test_oid_init`, I would
> coddle this added line with the `test_oid_init` line above instead of
> adding it here.

Sure, that seems like a good idea.

> > +'
> >
> >  test_expect_success \
> >      'pack-objects with index version 1' \
> > @@ -152,6 +155,7 @@ test_expect_success \
> >      '[index v1] 2) create a stealth corruption in a delta base referen=
ce' \
> >      '# This test assumes file_101 is a delta smaller than 16 bytes.
> >       # It should be against file_100 but we substitute its base for fi=
le_099
> > +     offset=3D$((rawsz + 4)) &&
> >       sha1_101=3D$(git hash-object file_101) &&
> >       sha1_099=3D$(git hash-object file_099) &&
> >       offs_101=3D$(index_obj_offset 1.idx $sha1_101) &&
> > @@ -159,8 +163,8 @@ test_expect_success \
> >       chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
> >       dd of=3D".git/objects/pack/pack-${pack1}.pack" seek=3D$(($offs_10=
1 + 1)) \
> >          if=3D".git/objects/pack/pack-${pack1}.idx" \
> > -        skip=3D$((4 + 256 * 4 + $nr_099 * 24)) \
> > -        bs=3D1 count=3D20 conv=3Dnotrunc &&
> > +        skip=3D$((4 + 256 * 4 + $nr_099 * offset)) \
> > +        bs=3D1 count=3D$rawsz conv=3Dnotrunc &&
>=20
> Similarly, the `offset` variable is only used here, so I would assign it
> just before the `dd` call. The name `offset` might be a bit to generic not
> to be reused, either, maybe `recordsz` or `index_entry_size` or `entrysz`?

Yeah, those would be better names.  As I will freely admit, I'm bad at
naming things.

> P.S.: I'll stop reviewing here for now (It is not that I am tired of
> looking at your patches, it is that I am just tired).

Sure.  It's late where you are.  I appreciate your review.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4uE8gACgkQv1NdgR9S
9otDoA//TkSuwzK+o7V4W+T4LjiScoXp19vX/0/dZYO4wkKY1WBKp4EViRR8+ozD
W50yEPVvTqqtguMgJGSEEVnKKVvpMP+brkF9HU++XepNleVTkfajxtlKJ7+GJ3es
Rj315M81FInxJmhpZDlt6sIw1tivbg4HoRy1ldxZpQ5W4XvRokycAzVhb1MOO8j7
KhO9p2jXdGkv9Q3H450/PN10UYVhT0QA4fG8mJd5pC96c52SOKWYU3SGpWXYX2gi
HVhBawVwKkjUW7FKdO4N3OLb2MjF2sMqTh9sA3U6bk9vuo8Q1BchnOGHUIYZV8Ij
rM7nmnY8a69CRWMINqMm0m0PydFU1TBoLuIDtSawTQOwqFAiB+/UYrXIucOppp4G
XdvFQz281Exf9KC41slaLrAucmufzhCeogzrj7BXxgEvV+4Va0qInCfjS+wed/jC
AFFYCGuzIAgenJPjF2mP/49EioRz+VhmIsE+y7JpChSUQ05Eo5l8KpZOE6lINXIL
Xa3HVuni2CRndscVJx2D+sN0hZHlTcUwiaIdu1RzV6j2yikplR0EuiIE64uhyFS2
wD5KC95bEb4bzjlaXv81ywsU2woLCkMBgLd9MDyYniSY/ZlkMk6DU71q4FlWwH4E
IwVbrwpEryLhuLnjn1N9u92NAP3vJE6IyV2r/atGmCVEV09+YcI=
=MQJc
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--
