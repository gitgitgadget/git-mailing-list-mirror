Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29131C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 22:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC6FC61287
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 22:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbhDLW6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 18:58:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60166 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236485AbhDLW6H (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 18:58:07 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2D1CE60422;
        Mon, 12 Apr 2021 22:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618268268;
        bh=HaidZ1GS5ZDhjNGbxAV3NRc/dPS6MMo7HavUs1CvBOY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=MMoXN/OtVB7/CcKrbYNW0JNAK+9Ud/dmvOooKq+jvCRs9DTwwNzP2Lzxlzpcxk2pb
         4pvcoYu7ElyjAr4XLEDXUs18vWsAxTJZu95kJU/dkg4eELuLTNd+Kqw09uVMIw9Vo8
         +EvfHQ1rFgmtiu+KHpKyIDwsGDzWMO6iv2QKke4hVSsVtv97FXmJx+4Y3QYnjAC/R5
         H7G8bRhjhWBew2UNhSSBVMShlUznAjR0oHakU9zKkVao6EgSIvJ8a4xhyu43kc2ndp
         uBnv2VYPBPFBobx5vIZbY99lOyY/jud0jy922kJL50pEN7AplV67SAY97mJa7ukLwX
         GUR4dTb0ptmNsGYIO53wXitm0KN1koiK0zV+tjXNVnEb8shRxKvyOOh8DOBJiLzsxC
         DfsPlIbYWh+KY0AAXfR4R2LZ3DYRwgSpaVo6RKQUZIIEqZOChLkC4Q1ihawp1LOZOX
         41ijN2vzI1MfFtZA5uffu11Vqdo0ISJ/dXcJBMlslW5WKapEvoL
Date:   Mon, 12 Apr 2021 22:57:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] C99: harder dependency on variadic macros
Message-ID: <YHTQZK5ja8Ypja0l@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Users <git@vger.kernel.org>
References: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net>
 <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
 <67645f4b-b320-3ed6-bf5d-552bae0c2688@gmail.com>
 <87r1jfeku8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X4dizgCQbvyCkTfT"
Content-Disposition: inline
In-Reply-To: <87r1jfeku8.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--X4dizgCQbvyCkTfT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-12 at 12:41:35, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Mon, Apr 12 2021, Bagas Sanjaya wrote:
>=20
> > On 12/04/21 18.02, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> But I'm submitting this because of brian m. carlson's note[3] about
> >> wanting to submit more general patches for declaring a hard dependency
> >> on all of C99.
> >
> > I think we should bump standard requirement to C99, right?
>=20
> I think that's worth discussing, but isn't the topic of this more narrow
> change.

I'm in favor of this more narrow change as well.

Junio's statement that packages may not have had time to update is true,
but I also just looked at a variety of packages that run on Linux,
FreeBSD, and NetBSD (and, since it's pkgsrc, Solaris), and they're all
updated.  Usually most open source OS vendors are reasonably prompt
about updating their Git versions, at least in the bleeding edge
repositories.

If this works on Windows, it will also work on Unix, because POSIX has
required C99 support since the 2001 revision, and __VA_ARGS__ is C99.
Unix systems are not the thing preventing us from enabling C99 support
(or any subset of it) in any meaningful sense.

> As noted in
> http://lore.kernel.org/git/87wnt8eai1.fsf@evledraar.gmail.com if we
> simply do that some of our MSVC CI will start failing.
>=20
> I don't know what other compilers we need to support that may support
> our current subset of C99 features, but not the full set, or if e.g. the
> CI can simply have its MSVC compiler version bumped.

I'm looking at fixing our CI before I send in my series.  My series,
when it comes in, will have a green CI status because I do want to be
sure that we're providing a supported environment for MSVC wherever
that's possible.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--X4dizgCQbvyCkTfT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHTQYwAKCRB8DEliiIei
gR6/AQC8jsR55BxlONhn/D/lx8z5+u54xh3sepjXLQZlTJvJMAEAgPC+2JIYAYKb
BjDAmCmy2mizlYYFvU9djJHCFTRNYAo=
=Ncot
-----END PGP SIGNATURE-----

--X4dizgCQbvyCkTfT--
