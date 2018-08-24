Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61FBB1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 01:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeHXFMg (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 01:12:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59934 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725735AbeHXFMg (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Aug 2018 01:12:36 -0400
Received: from genre.crustytoothpaste.net (108-60-118-130.static.wiline.com [108.60.118.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E418D60745;
        Fri, 24 Aug 2018 01:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535074813;
        bh=UaonI9LnFiv+rqiJK1A7+qTSmw2s5edWXu/zzLsVA6I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zYd1/XLylZQ88i/+D33yYlg0gXZ+l9bi3EVxy6ouIPS1uMl769TW4OWxBUHxaIm0S
         fRiujCY8klS1/dvU1OeBZ0jPpGXzU7aPWeUMWYMEyp/x3OBcvX463HeB4nhzW9USLu
         rixsnVKcUey3iEwRTVOvc3zEe2zV5ALxxPe49hP8So9weNkCg9RPbkSEpoyxBEV61K
         nlKUOXAHoscFOj51JVvPX/cfQvnPMG1goMZzOBzfdSj2jkbf2whEKsOqYS+7dZc+cM
         y9uRCraYIyLBjX+LMUBlc+oDTnrmB9dDOWnxfWCDdkosvGC/H1s5aMZ32YMEefSvKc
         pfvp2NpSi8qn2CmKYKU+LyLpPt3eGchIE8puUK7QSoQLsxqgStj5qTP4RvKNWUM86o
         jdi8U/XSNWCHlbU2UU9KRrBpyIrJh/KyRYgkM+6JnTYVnsqGEpnF4wxkPsww6A1ED9
         ysWNkS76gi3RdFMIaQes128v7AdGR75JJwl9lWxavL+hBodY6Ga
Date:   Fri, 24 Aug 2018 01:40:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Questions about the hash function transition
Message-ID: <20180824014007.GF535143@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
References: <878t4xfaes.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Content-Disposition: inline
In-Reply-To: <878t4xfaes.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2018 at 04:02:51PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> > [...]
> > Goals
> > -----
> > 1. The transition to SHA-256 can be done one local repository at a time.
> >    a. Requiring no action by any other party.
> >    b. A SHA-256 repository can communicate with SHA-1 Git servers
> >       (push/fetch).
> >    c. Users can use SHA-1 and SHA-256 identifiers for objects
> >       interchangeably (see "Object names on the command line", below).
> >    d. New signed objects make use of a stronger hash function than
> >       SHA-1 for their security guarantees.
> > 2. Allow a complete transition away from SHA-1.
> >    a. Local metadata for SHA-1 compatibility can be removed from a
> >       repository if compatibility with SHA-1 is no longer needed.
> > 3. Maintainability throughout the process.
> >    a. The object format is kept simple and consistent.
> >    b. Creation of a generalized repository conversion tool.
> >
> > Non-Goals
> > ---------
> > 1. Add SHA-256 support to Git protocol. This is valuable and the
> >    logical next step but it is out of scope for this initial design.
>=20
> This is a non-goal according to the docs, but now that we have protocol
> v2 in git, perhaps we could start specifying or describing how this
> protocol extension will work?

I have code that does this.  The reason is that the first stage of the
transition code is to implement stage 4 of the transition: that is, a
full SHA-256 implementation without any SHA-1 support.  Implementing it
that way means that we don't have to deal with any of the SHA-1 to
SHA-256 mapping in the first stage of the code.

In order to clone an SHA-256 repo (which the testsuite is completely
broken without), you need to be able to have basic SHA-256 support in
the protocol.  I know this was a non-goal, but the alternative is a an
inability to run the testsuite using SHA-256 until all the code is
merged, which is unsuitable for development.  The transition plan also
anticipates stage 4 (full SHA-256) support before earlier stages, so
this will be required.

I hope to be able to spend some time documenting this in a little bit.
I have documentation for that code in my branch, but I haven't sent it
in yet.

I realize I have a lot of code that has not been sent in yet, but I also
tend to build on my own series a lot, and I probably need to be a bit
better about extracting reusable pieces that can go in independently
without waiting for the previous series to land.

> > [...]
> > 3. Intermixing objects using multiple hash functions in a single
> >    repository.
>=20
> But isn't that the goal now per "Translation table" & writing both SHA-1
> and SHA-256 versions of objects?

No, I think this statement is basically that you have to have the entire
repository use all one algorithm under the hood in the .git directory,
translation tables excluded.  I don't think that's controversial.

> > [...]
> > Pack index
> > ~~~~~~~~~~
> > Pack index (.idx) files use a new v3 format that supports multiple
> > hash functions. They have the following format (all integers are in
> > network byte order):
> >
> > - A header appears at the beginning and consists of the following:
> >   - The 4-byte pack index signature: '\377t0c'
> >   - 4-byte version number: 3
> >   - 4-byte length of the header section, including the signature and
> >     version number
> >   - 4-byte number of objects contained in the pack
> >   - 4-byte number of object formats in this pack index: 2
> >   - For each object format:
> >     - 4-byte format identifier (e.g., 'sha1' for SHA-1)
>=20
> So, given that we have 4-byte limit and have decided on SHA-256 are we
> just going to call this 'sha2'? That might be confusingly ambiguous
> since SHA2 is a standard with more than just SHA-256, maybe 's256', or
> maybe we should give this 8 bytes with trailing \0s so we can have
> "SHA-1\0\0\0" and "SHA-256\0"?

This is the format_version field in struct git_hash_algo.

For SHA-1, I have 0x73686131, which is "sha1", big-endian, and for
SHA-256, I have 0x73323536, which is "s256", big-endian.  The former is
in the codebase already; the latter, in my hash-impl branch.

If people have objections, we can change this up until we merge the pack
index v3 code (which is not yet finished).  It needs to be unique, and
that's it.  We could specify 0x00000001 and 0x00000002 if we wanted,
although I feel the values I mentioned above are self-documenting, which
is desirable.

> > [...]
> > - The trailer consists of the following:
> >   - A copy of the 20-byte SHA-256 checksum at the end of the
> >     corresponding packfile.
> >
> >   - 20-byte SHA-256 checksum of all of the above.
>=20
> We need to update both of these to 32 byte, right? Or are we planning to
> truncate the checksums?
>=20
> This seems like just a mistake when we did s/NewHash/SHA-256/g, but then
> again it was originally "20-byte NewHash checksum" ever since 752414ae43
> ("technical doc: add a design doc for hash function transition",
> 2017-09-27), so what do we mean here?

Yes, this will be 32 bytes.  The code I have uses 32 bytes, because
truncating it means that we have to write special code just for that
case, which seems silly.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlt/YfcACgkQv1NdgR9S
9osBUg//ZW9LHQK2EyukLoFX13Eu83z7kmD4WlpSYQ9h4weQ7Ew4Jc5dcsFblMmn
2dEDSldCpOm9K4/DBRpDTz+XBjE9SnsO8eGniJxNVO41xDpV/6W+Z8ebtpcaK2Cm
0LAia5hqOrpzTlpfonvCtbcob50izHF0TzhjYno0ehywoSdfvlGWgDe32p5Xa3La
Q8vNasCRbkkTYYRhUOL52xnB1BdMl2ZaRSlHVfdV3h0vEEjdPX37MGHlXYo+LYEZ
Guc4wP7QAZZ+QTXR5pUOQp5WcE97uNP+fK1W/kuuSx5x8qXgg4Wpquj8hZyjdFgJ
JNV0TEo5CpIRiKn6RnDBFL0T0RLOqylhwoZm1/hvSqaeS8Poq7YjrBREnMX6n+Hl
JQU+ImoQeR+uIhQ4YtbyhMRvO6OrjwKcBPDmOOBUa4Uph/xD9a4ktiZyAu5cOJEz
NlCmyCrD2PZgDdlnCvjdpesEvwsGgZdpdJGTp8jbKAj8+1R+i0QX4/wAyx7zqO54
D7CYksD1MHdKkY08rcypsPeuo/HoiF8tIN33F24TAU3cLK6iI5/sI/36I8GIfXkg
L3neml/lVQ5XXALYLszqQO7t+/JCYcSf/wJhfVDCTv/s6tzgNHk60MjVa4zaTomy
DjCXOpHoY7nSh7lW/VlBX8guoA0/9kmL7Va27VrHaeUhCROrQoY=
=rQkz
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--
