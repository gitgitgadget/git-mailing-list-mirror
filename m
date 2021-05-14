Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14427C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 00:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C427061221
	for <git@archiver.kernel.org>; Fri, 14 May 2021 00:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhENANJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 20:13:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47178 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230316AbhENANI (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 May 2021 20:13:08 -0400
Received: from camp.crustytoothpaste.net (unknown [138.237.15.37])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9C59E6043F;
        Fri, 14 May 2021 00:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620951117;
        bh=odt+wGZw9yMQkPRATu7qadX4kA7Rf8J3WYZL1DEuJiY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OPAPF3Mc4AvRRb2jAVCbyb4AFvamUAjI3JHmI0Org3N6oG8o3k6eRYkBwWseNoNvK
         52xMdGtJcRJy6KGTs5GHAmaDFdwE6R7Nn7rfHCNvdniFEmpfyIy9fQwRuESC4Nwdxh
         RAj2SQoFyWLN1bmql5+JtwKUZARzEhy6JaiMNRvvotu6U552kGaiFassUKffzcE2qZ
         YwobiRxGzdodQ7lRtQunKyCHlFSX1csnayXZ0kguGRHa1e6xL6F7pWGpkwWXvA5M2x
         fTd9vlZINA0GxGjV8/iHPO1K6mPehRMJSr/lP1iIQXuP8xjBEqpRVq55Idzw/ouL6z
         2Cq2eAOAawNPfLZKPmo+Fc26oVF3Wi7jNpPmVbWJMYefcjsYBUjnBy2/5lFJRolwE0
         +DX9JrXANb6xB0YGrsYfbmbMPKQK0ch5a6P03b/HRTR7rri0FoJvIHBH4YDxHK6kOW
         KsS147A0Gfya9aGIhWHIZq687j4AeJJFpUFj111NwWCVXcqbruz
Date:   Fri, 14 May 2021 00:11:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] doc: remove GNU_ROFF option
Message-ID: <YJ3ASK/LezQ86ct1@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <20210512021138.63598-2-sandals@crustytoothpaste.net>
 <609b5d814b95c_678ff208d6@natae.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xFXItq15x7RFagDa"
Content-Disposition: inline
In-Reply-To: <609b5d814b95c_678ff208d6@natae.notmuch>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xFXItq15x7RFagDa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-12 at 04:45:53, Felipe Contreras wrote:
> brian m. carlson wrote:
> > By default, groff converts apostrophes in troff source to Unicode
> > apostrophes.  This is helpful and desirable when being used as a
> > typesetter, since it makes the output much cleaner and more readable,
> > but it is a problem in manual pages, since apostrophes are often used
> > around shell commands and these should remain in their ASCII form for
> > compatibility with the shell.
> >=20
> > Fortunately, the DocBook stylesheets contain a workaround for this case:
> > they detect the special .g number register, which is set only when using
> > groff, and they define a special macro for apostrophes based on whether
> > or not it is set and use that macro to write out the proper character.
> > As a result, the DocBook stylesheets handle all cases correctly
> > automatically, whether the user is using groff or not, unlike our
> > GNU_ROFF code.
> >=20
> > Additionally, this functionality was implemented in 2010.  Since nobody
> > is shipping security support for an operating system that old anymore,
> > we can just safely assume that the user has upgraded their system in the
> > past decade and remove the GNU_ROFF option and its corresponding
> > stylesheet altogether.
>=20
> I'm not sure of all that, but my machine uses Arch Linux, it ships with
> groff, I've never used GNU_ROFF=3D1, and I can copy text with apostrophes
> from the genrated man pages just fine.

I'll rephrase to be clearer.  Solaris 10 is still security supported,
but no major Linux distro is, and I think we'll be both be fine dropping
support for OSes shipped in 2005.

I'm glad to hear confirmation that things work for you, though.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--xFXItq15x7RFagDa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJ3ASAAKCRB8DEliiIei
gSwxAP9Zda6T9OypZNPx1jezJKDfeUXo1ROmcvxoDMYXLie0LQD/QLGhNJVcyyCs
Xr6NfP3w0w8GeTJJlJ90iOB5e1yjcgw=
=fNbJ
-----END PGP SIGNATURE-----

--xFXItq15x7RFagDa--
