Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B82C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 17:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B826610A6
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 17:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhGKRFt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 13:05:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39312 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229688AbhGKRFt (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Jul 2021 13:05:49 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9ECDD6042E;
        Sun, 11 Jul 2021 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1626022981;
        bh=560nFeSzNtpr5IhPdb3kXNOnIHhys4eX5xhN1WWaLPo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=RBbwPcdN242hKTCK4crXJE9eSN89XGZtnJG+drIWo1ZtuUvb+QWR1LeaGXFiAP+9P
         Lrco/9FI3NR26KCoATnuVTpK+xz7jFwjfKgrABjnnQVuBtGSawM7BrYi6De3vB3H67
         VIrBWNTRtwvHFguALKHCliIwR1dv1GQcWaHVd90XXvots53/yYQZFmMjvw0El54dtX
         Y95b4zHMUTdby+fScdAREzJFJNErCaMdGuxKQE94m90Toxq2bMGdwvZJ3WbyvPmWMT
         dLuzH0vkuLDQSXvj5kjpV3S8BHoYUGPljbR4wwJAYrn/kV/Hr/nZmN2qOrlrwiR9yM
         pZGeU+d2pUBonlMmeeubWx2MFJz/Eip4zDQBFMbrtL1xvCrItNaX8NjSLI5cAlC6yd
         UTwFM42usM7iNiJ/SUkQhklkhJqj6xvh0ni2oxDJUUFhDfRr/G4lmXwtlS3/OLqllU
         8+qevjPuCvxPQidZFw3xbt3bpNLSsa64cnKNnt0iKCTCEWz+gBw
Date:   Sun, 11 Jul 2021 17:02:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] rev-list: add option for --pretty without header
Message-ID: <YOskQhWjD6Kg8t33@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
References: <20210706224321.14371-1-sandals@crustytoothpaste.net>
 <CAP8UFD0t0=us1MWHTtEvVhNhWB1P6Q5gp-6v5XVGLBVeZ5RYKg@mail.gmail.com>
 <xmqq8s2f8pbf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W/QzjIfHCmLwFW4l"
Content-Disposition: inline
In-Reply-To: <xmqq8s2f8pbf.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--W/QzjIfHCmLwFW4l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-07-09 at 15:44:20, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>=20
> > On Wed, Jul 7, 2021 at 12:47 AM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> >>
> >> In general, we encourage users to use plumbing commands, like git
> >> rev-list, over porcelain commands, like git log, when scripting.
> >> However, git rev-list has one glaring problem that prevents it from
> >> being used in certain cases: when --pretty is used, it always prints o=
ut
> >> a line containing "commit" and the object ID.
> >
> > You say always, but it looks like it doesn't do it when
> > --pretty=3Doneline is used.
>=20
> I've understood that he meant "when --pretty=3Dformat is used",
> though, as it is the only format whose intent was to allow
> generation of output stream that does not have to be preprocessed
> with "grep -v '^[0-9a-f]{40}'" etc.

Yes, that's the case.  I'll rephrase the commit message to reflect
that's what I meant.

> > It looks like the tests only check what happens in case
> > --pretty=3Dformat:'...' is used, but I wonder what the code does if a
> > builtin format is used.
>=20
> Good point.

I'll add some more tests.

> I also think the handling of --abbrev-commit may need to be
> rethought with this change.  See here:
>=20
>     diff --git a/builtin/rev-list.c b/builtin/rev-list.c
>     index 7677b1af5a..f571cc9598 100644
>     --- a/builtin/rev-list.c
>     +++ b/builtin/rev-list.c
>     @@ -132,7 +132,7 @@ static void show_commit(struct commit *commit, vo=
id *data)
>             if (revs->abbrev_commit && revs->abbrev)
>                     fputs(find_unique_abbrev(&commit->object.oid, revs->a=
bbrev),
>                           stdout);
>     -	else
>     +	else if (revs->include_header)
>                     fputs(oid_to_hex(&commit->object.oid), stdout);
>             if (revs->print_parents) {
>                     struct commit_list *parents =3D commit->parents;
>=20
> The original says that if --abbrev-commit is set and --abbrev is set
> to non-zero, we'd show unique abbreviation and if not, specifically,
> even when --abbrev-commit is set but --abbrev is set to 0, we didn't
> do the find_unique_abbrev() of full hexdigits but left the output to
> the else clause.  This was because the original code KNOWS that the
> else clause unconditionally emits the full commit object name.
>=20
> That assumption, which made the original code's handling of
> "--abbrev-commit --abbrev=3D0" correct, no longer holds with the
> updated code.  What happens is with --no-commit-header, if we give
> "--abbrev-commit --abbrev=3D4", we still see the unique abbreviation
> that is not shorter than 4 hexdigits (i.e. "--no-commit-header" is
> ignored), but if we say "--abbrev-commit --abbrev=3D0", we do not see
> any commit header.
>=20
> My hunch is that this "if / else", which determines if the commit
> header should give shortened or full length, should be skipped when
> the .include_header is false.

I'll take a look at this for a v2.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--W/QzjIfHCmLwFW4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYOskQgAKCRB8DEliiIei
gdllAP0dbZZxE37SOTL5JfeNzWxAslEcquNjde0AktIzDX4osQEAoZeKOecSrwFv
6DD/PMmkAjbb8ZwKooi4jw+v5qnGIw8=
=DAwH
-----END PGP SIGNATURE-----

--W/QzjIfHCmLwFW4l--
