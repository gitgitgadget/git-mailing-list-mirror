Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539F0C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 02:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C7E2465E
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 02:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgKRC0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 21:26:09 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42938 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbgKRC0J (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Nov 2020 21:26:09 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 50B816044F;
        Wed, 18 Nov 2020 02:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1605666337;
        bh=SowNt4Vhsm1cGk+dSP4/UK2mIJ2r1SboNEjnbofiXMk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=GkRkg92f9/o61obwWQ+ODEc2Y1THbFayEtAMd3OF1grwqt9hgjvJBeEbVpqW4dAKA
         zN429IyD3E1MPlYmuA97q4V4qaAgvcd23coBXQiTubT8d41cAklfUwNdIyv1wGFw2/
         erJFJ9yYRHMDXhXdjOyA40VLnUENC3p0jJUcJ9DXVPU0044OXkI0lENkZT/ZK0bZfX
         8FeL4gSauiim8Yo1VPFCdgjW03tp1ioH7gWftfMGFB+i4U7pLyFKJjkO27tF1xmzwR
         w+3u9SA4ghpqtNgFig8CRw7On73MceTagkBcVO6/fx00cN9GcQSb8uYXRcwE4SD1Fc
         k19w1Bqs6wFkraJYKQ2mnKIvvNaNpRlHqlHUem6guslK0ALjyYX7yJf8tufaeQETXP
         w/RvsE8diLRcVV51UV8oHBphSqxI3Ho3G4q/OLfWI2HTsXcME7ULztmYOQRPmoZuMg
         8AMadnkcJkGnLvBFMulpyC0quTKCPIsZ3pv3UpD1YcQEBIo8L9m
Date:   Wed, 18 Nov 2020 02:25:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
Message-ID: <20201118022532.GD389879@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1605269465.git.ps@pks.im>
 <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
 <87mtzlflw7.fsf@evledraar.gmail.com>
 <xmqqy2j1851k.fsf@gitster.c.googlers.com>
 <20201117023454.GA34754@coredump.intra.peff.net>
 <20201118005014.GC389879@camp.crustytoothpaste.net>
 <20201118015907.GD650959@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
Content-Disposition: inline
In-Reply-To: <20201118015907.GD650959@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-18 at 01:59:07, Jeff King wrote:
> I think we mostly already have that tooling.
>=20
>   $ GIT_CONFIG_PARAMETERS=3D$(
>       git rev-parse --sq-quote \
>         foo.bar=3Dvalue \
>         'section.key=3Dwith spaces' \
>         "or.even=3Dembedded 'quotes'" |
>       sed 's/^ //'; # yuck
>     )
>   $ export GIT_CONFIG_PARAMETERS
>   $ git config --list --show-scope | grep ^command
>   command	foo.bar=3Dvalue
>   command	section.key=3Dwith spaces
>   command	or.even=3Dembedded 'quotes'
>=20
> The "yuck" there is because --sq-quote insists on putting a space at the
> front. Our parser should probably ignore that, but right now it's quite
> picky.

I feel that this approach leaves a few things to be desired, yes.

> Though I suppose:
>=20
>   - do you mean ENV_VAR to literally look up an environment variable?
>     That solves Patrick's original problem of not wanting to put
>     sensitive values onto the command line. But it's much more annoying
>     to use if you _don't_ already have the value in an environment
>     variable. I'm not sure if that original problem matters here, as a
>     program that does a lot of this would probably implement the quoting
>     itself.

Yeah, I did mean that, or various options to either read a literal value
or from the environment.  Your proposal, while it obviously works,
doesn't solve Patrick's problem.

>   - obviously it is doubling down on the shell-quoting as a public
>     thing, and part of your point is that we would leave it opaque.
>     I'm OK with that aspect (even if it ends up as an alias for
>     --sq-quote for now). I'm not entirely sure people aren't using this
>     in the wild already, though. Saying "it was undocumented" may give
>     us a leg to stand on if we change the format, but it will still be
>     annoying to people we break.

I've been telling people for some time that Git doesn't have a way to do
this, so I'm comfortable sticking with that line until we have a
documented way to do it.  I knew we had an internal environment variable
(because I was curious and looked), but I knew from just looking at it
that it was internal.

> Yes, I think concatenating uri_encode(key) + "=3D" + uri_encode(value)
> would be easier to reason about, and solves the ambiguity problem. If we
> are willing to break from the existing format, it's probably a
> reasonable direction.

We'll have to deal with embedded NULs, but other than that it seems
robust and easy to reason about.  I like the proposal below better,
though.

> I wondered at first how this is different from:
>=20
>   git -c a.b.c=3Dvalue foo
>=20
> but I guess it is meant to do the same environment-lookup? We could
> probably add:
>=20
>   git --env-config a.b.c=3DENV_VAR foo
>=20
> to have Git internally stick $ENV_VAR into $GIT_CONFIG_PARAMETERS. That
> avoids all of the rev-parse rigamarole, keeps the format of the
> environment variable opaque, and solves Patrick's problem of putting the
> value onto the command-line.

Sure, that could be an option.  It's the simplest, and we already know
how to handle config this way.  People will be able to figure out how to
use it pretty easily.

> It doesn't solve the ambiguity with "=3D" in the subsection, but IMHO that
> is not all that important a problem.

I'm fine with saying that we don't support environment variable names
with equals signs and just going with that.  It solves the ambiguity
problem and I'm not sure that they could usefully work on Unix anyway.

Moreover, people usually use the unrestricted data in the second chunk
for URLs, which shouldn't have unquoted equals signs.  You could
technically name other second fields that way, but why would you when
you could just not?

So I'm not too worried about it either way.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX7SGHAAKCRB8DEliiIei
gYtoAP0Rtm7n7FwW9noLHKpm3E91xukrYkvaEYfcJUkpi9LQhAD/VlOA7KBxYByb
72MKOlHVYkLUckIM/GzfNExc7483qgg=
=I3/j
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--
