Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50CAD1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 20:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeGUVT2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 17:19:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34464 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727952AbeGUVT2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Jul 2018 17:19:28 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 336A46047B;
        Sat, 21 Jul 2018 20:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532204727;
        bh=PpgUkSmcpCgOC63ZpshATaFCFtjh0mDxlqpO357cakM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=AlkB0godLFG4WQ2mqOJQvFKXRyWUJPzDSYFM6dt3N1G7VXbO8ReMapy+7HxEVQOvD
         H3UFSOWVzx4iGmnvTinhnSDy4JEbFdaLmKvvEsykkrRQ7j2kVftGxwn+F+jdx5NBwC
         Kj0LQsL+Wwa+ZD7szhiCFTbUgcVeg6fGJxH2ev4L22YfEUytUG9gtTpqyfw6uQniBV
         /O4x51b400uSaK6mtZZ07p5k/keA8JikBqy1ustceWIncWS+ukS2QdYD0ci8Z/UV1g
         +pZu6fD1CiDw0SwE67KKGUK+F7bfd3pyJTDn3rC3sidltqjZaQrYtB0+ehakkXWbs2
         n8Z5h2nG1Hy2qPnzUdMLEgnUYfnkXZdjV8ROu4WYMeRZmn7K+KlSIWVTaH1XjiwuNn
         SFbA2NN5WKE1ME5Gi0YoHuZJcdHL6CgU/tgawzoizJb1xFoeTR0sqUQ8Ipk8RXN6gf
         kLveudDdbY7vzPKydbsKAIGZmzlcKhLuZD41p2ua/WnZBdZOo+1
Date:   Sat, 21 Jul 2018 20:25:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>,
        The Keccak Team <keccak@noekeon.org>
Subject: Re: Hash algorithm analysis
Message-ID: <20180721202521.GF18502@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>, The Keccak Team <keccak@noekeon.org>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net>
 <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net>
 <87va98bc4a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DEueqSqTbz/jWVG1"
Content-Disposition: inline
In-Reply-To: <87va98bc4a.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DEueqSqTbz/jWVG1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 21, 2018 at 09:52:05PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
>=20
> On Fri, Jul 20 2018, brian m. carlson wrote:
> > I know this discussion has sort of petered out, but I'd like to see if
> > we can revive it.  I'm writing index v3 and having a decision would help
> > me write tests for it.
> >
> > To summarize the discussion that's been had in addition to the above,
> > =C3=86var has also stated a preference for SHA-256 and I would prefer B=
LAKE2b
> > over SHA-256 over SHA3-256, although any of them would be fine.
> >
> > Are there other contributors who have a strong opinion?  Are there
> > things I can do to help us coalesce around an option?
>=20
> I have a vague recollection of suggesting something similar in the past,
> but can't find that E-Mail (and maybe it never happened), but for
> testing purposes isn't in simplest if we just have some "test SHA-1"
> algorithm where we pretent that all inputs like "STRING" are really
> "PREFIX-STRING" for the purposes of hashing, or fake shortening /
> lengthening the hash to test arbitrary lenghts of N (just by repeating
> the hash from the beginning is probably good enough...).
>=20
> That would make such patches easier to review, since we wouldn't need to
> carry hundreds/thousands of lines of dense hashing code, but a more
> trivial wrapper around SHA-1, and we could have some test mode where we
> could compile & run tests with an arbitrary hash length to make sure
> everything's future proof even after we move to NewHash.

I think Stefan suggested this approach.  It is viable for testing some
aspects of the code, but not others.  It doesn't work for synthesizing
partial collisions or the bisect tests (since bisect falls back to
object ID as a disambiguator).

I had tried this approach (using a single zero-byte as a prefix), but
for whatever reason, it ended up producing inconsistent results when I
hashed.  I'm unclear what went wrong in that approach, but I finally
discarded it after spending an hour or two staring at it.  I'm not
opposed to someone else providing it as an option, though.

Also, after feedback from Eric Sunshine, I decided to adopt an approach
for my hash-independent tests series that used the name of the hash
within the tests so that we could support additional algorithms (such as
a pseudo-SHA-1).  That work necessarily involves having a name for the
hash, which is why I haven't revisited it.

As for arbitrary hash sizes, there is some code which necessarily needs
to depend on a fixed hash size.  A lot of our Perl code matches
[0-9a-f]{40}, which needs to change.  There's no reason we couldn't
adopt such testing in the future, but it might end up being more
complicated than we want.  I have strived to reduce the dependence on
fixed-size constants wherever possible, though.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--DEueqSqTbz/jWVG1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltTlrEACgkQv1NdgR9S
9osk6w//ZkNMnu950rJAnG723u93iZTRYlZQDRBTT0yyHt1H6+yTdVGMEQC/PKry
bPiDlFL9+PbYBotVoii3fWBWnRj+sKcNcGt597ViXojdyhNkcKv+z16FBkqVPG/+
WOTU/H4iyNpRZHCYeexTGD9BA8m+3frMtwmT9QbafSG27xFXxipZ38tfsnFPOriV
bdwSccnFSGKFet7pi0FVYF63DxtWQTUHyIRjN3Mr8l5Cqbb5bNJ6xiRQaJqPpJ2M
eUZX4jcenHz+VH4dyGvi4rgH1T+JCJxycZS6wKsSaLedj0vFhkImyup+POA5wuve
R3KBitMDJy0iryj4ZQrl6dLVInbSQW9Ei8aduGt+Ykf+WX1DFBdYGm7rp9JKthuu
UQ6wU+i0AFDF3e9xEhMNxT3KFNucf/QGuu7HYZJzeISR89PUuJbVWG1fsSoQ3PnR
8uDPQM6JnoEy/+XfDkp1bkajEORc8ebrXNBmHxEfzYuaYd2QILNSBrpY+ZY6SnD0
HsdwjNLH63viiQLkzwG8f9FqWCjTaHyilFStqa7vtj4IpICuXnaYuuCXjaydKZlx
09DDx3+LpPQI188trchbUNEXTYdM++YwtgUGapSMGMiiypmggWKnvxbVhAs4Bbqx
ulAYiDVfBXlGJaUcYI5EDbwCjvm6lNXNR2/Cz0NaTfaCLcaJFrk=
=vgSD
-----END PGP SIGNATURE-----

--DEueqSqTbz/jWVG1--
