Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CC9C433FE
	for <git@archiver.kernel.org>; Sun,  2 Oct 2022 00:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJBA1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Oct 2022 20:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJBA1a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 20:27:30 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCA957240
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 17:27:23 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9ECA75A0EA;
        Sun,  2 Oct 2022 00:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1664670442;
        bh=SSqNQxXtRKFkR7mSie4/ALdfiR/qfmFb7ACgZvanQYA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Qr23luAB7mqpugMPgWW/XA0d8xUHwVa1EWSlJTgv3YqBIO5l+2cRuOPqJ04ucvZvV
         46cKXh8HqCpnxEXCRop8bIePl8VNjPJ+8WuVeCpucwLdBCA5Dqqgw3nMeAdlG9fCJM
         x3ueC841M5Uh45bqDYulMvvqe3NjgBFJNreMUKcpdJ/jMUBRkgC9uigQcZos8FEst4
         G4JDuTQt+/aeDlj8OHEg6kyghWfigtewGXhKIzmedQUirheWBceJbGrJc3eB1CcNYU
         5IHIBgUc8PDwOk+A/VuysjD1WFGAdNexLenxO8CEO/hffE0S9zaL4Id12l3u9CNGNr
         m2O5q8A/rzkKSZZV3yJBK0WgH8FUawpsoLtbGlMZDbmwxDPCUz416dPnpmnAuAX17F
         nHH0n/dxM8STv7fje/iMT+axAzBPHZ9HYDcAfxjJdZ05uVYqDWIMB/07H3dMKVH30g
         dL9at/RENPJwDitbuPhqh/oScrcqLLPxwKQTcDaWFt4JeRK5ICH
Date:   Sun, 2 Oct 2022 00:27:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Gwyneth Morgan <gwymor@tilde.club>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 2/2] docs: document a format for anonymous author and
 committer IDs
Message-ID: <Yzja6eSq15Q1a8Rs@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Gwyneth Morgan <gwymor@tilde.club>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220919145231.48245-1-sandals@crustytoothpaste.net>
 <20220919145231.48245-3-sandals@crustytoothpaste.net>
 <YzdQwNCtwAYjhKWp@tilde.club>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OlkyWk73CGRFtlGQ"
Content-Disposition: inline
In-Reply-To: <YzdQwNCtwAYjhKWp@tilde.club>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OlkyWk73CGRFtlGQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-09-30 at 20:26:41, Gwyneth Morgan wrote:
> In general, I like this proposal. It seems like a good way forward.
>=20
> It should be made very clear to the user that a commit authored by a
> key-derived ID does not imply the commit is signed by that key or
> provide any security guarantees; anyone can put anything in that field,
> same as it is now. I could see someone seeing a commit authored by
> <47DEQpj8HBSa-_TImW-5JCeuQeRkm5NMpJWZG3hSuFU@_.sha256.ssh.id.git-scm.com>
> and thinking that implies the commit was signed by
> `47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU`.

Of course.  I'll update that when I turn this into a real series.

> On 2022-09-19 14:52:31+0000, brian m. carlson wrote:
> > +Anonymous IDs
> > +-------------
> > +
> > +Git will implement a new form of email address which is acceptable to =
existing
> > +implementations but is not valid according to RFC 1123.  This takes th=
e form of
> > +an email address where the local-part contains the identifier and the =
domain
> > +portion starts with `_.` and then a domain specifier which specifies an
> > +authority and the meaning of the identifier.
> > +
> > +In such a case, Git will specify the username as a single U+2060 in UT=
F-8 (the
> > +byte sequence 0xE2 0x81 0xA0), which is a zero width non-breaking spac=
e.  This
> > +is compatible with existing implementations.
>=20
> Could you add a note here explaining why that character was chosen for
> the name field? It seems like it would be easier to work with a single
> printable character like `?` or `X`, but maybe that doesn't matter here.

Sure, I'll include that there.  The author field cannot be empty for
compatibility reasons.  Since there's nothing to put there until it's
run through the mailmap, putting a single zero-width non-breaking space
produces the same rendering as nothing, and it doesn't require special
handling like "?" or "X". (Also, it should be noted that not all
languages use "?" as the question mark.)

Note that if this is mapped in the mailmap, you don't need to actually
put the personal name that exists in the commit.  The mailmap rewrites
based on the email address (or, in this case, the ID), so nobody ever
has to write the U+2060 in the mailmap.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--OlkyWk73CGRFtlGQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYzja6AAKCRB8DEliiIei
gYPxAQC1q5b6Z/UNNC9JjoWxkvKWpIYIU5cgLlBLZhKp/Lb5nwEAyUa/oa2uPPIv
gu2rKXGY9utTRrvGeOtgR4yp5SQucAs=
=jC8V
-----END PGP SIGNATURE-----

--OlkyWk73CGRFtlGQ--
