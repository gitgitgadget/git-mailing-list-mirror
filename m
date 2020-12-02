Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD91C6369E
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 23:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C76621D93
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 23:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgLBXqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 18:46:55 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52512 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727023AbgLBXqy (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 2 Dec 2020 18:46:54 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F325B6042E;
        Wed,  2 Dec 2020 23:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1606952743;
        bh=c9+HluurNmIhzZg8m9PWgh5spGLVmDJ8yfg22VPPwD4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=04leKSFxCOuiUljE+jq5TDnvLzoBx+RKsfMNvS/Klbu5eMGEVC357X/uM8i3bBwvB
         HsgGaNrLQgKnyJ5+geTro9bN5C7uqDxBCIijZnBe30iHW5tr5EmsvHnNBFV9KixG5T
         VMRFqinscav0KX2NfIHbXeuSESezaAJDg+ZOiNhDRq+GszQezNjT47aSyMO3FHrFP3
         CVj5PefnIkyNDQ9ML508EivCHw8/Nagp1F5rr4JLQmg1dP3s8ikAXrsUgIiJI1HZsh
         /Gi/fY7Fm4snYHac23GoX8Mnlrb8A+v37S6GjTw8RBwCO3HSIEAJeMB8i07CC3y0gg
         9rzTgxJ0ckzSXlHkvsQHLTAY5QPcE2sYZTxABDJo2DR9vO4M02OERMJ+fgZWJR09Vo
         3rOHIGAPNWa9Y5Tm1n87DhVN3HpRI/59whujCVMwjn0zXc6KAzkLrPKGZxOsVZVSVO
         SFtS/kQ2HAg+Ehu7um44igPMYu6rBy0PBuY5F5Xngw4IIvtvDAE
Date:   Wed, 2 Dec 2020 23:45:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Arnout Engelen <arnout@bzzt.net>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: make HTML manual reproducible
Message-ID: <X8gnItjchqX4wwmt@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>, Arnout Engelen <arnout@bzzt.net>,
        git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
References: <20201201095037.20715-1-arnout@bzzt.net>
 <20201201154115.GP748@pobox.com>
 <X8bhdyu/OlscI1ME@camp.crustytoothpaste.net>
 <20201202160755.GX748@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Wh0f451vcrYqeiNM"
Content-Disposition: inline
In-Reply-To: <20201202160755.GX748@pobox.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Wh0f451vcrYqeiNM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-02 at 16:07:55, Todd Zullinger wrote:
> brian m. carlson wrote:
> > If we want this to be effective, then yes, people will need to upgrade.
> > But if they're happy with the old behavior on ancient systems, that
> > shouldn't be a problem.
>=20
> Indeed.  Is it worth mentioning this at all in INSTALL?
> Something like:
>=20
>   -   The minimum supported version of docbook-xsl is 1.74.
>   +   The minimum supported version of docbook-xsl is 1.74.  For consiste=
nt
>   +   IDs in the HTML version of the user-manual, 1.79.1 or newer is
>   +   necessary.
>=20
> perhaps?

I don't know that that's even necessary.  Anyone doing reproducible
builds is already aware of the required versions in order to do a
reproducible build, and I don't think the average user is going to be
super interested.

We can if you feel strongly about it, but I don't personally see it as a
big deal.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--Wh0f451vcrYqeiNM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX8gnIgAKCRB8DEliiIei
gQ9hAP0R7Zs3edrvc6JqdIIlUtUdPahNg5Eie5LPcAyXF2dmbQD7Bl6POit8Xe0A
9EU0s+BbFt8K49P25IH4by0zc+o1RQ0=
=mDi0
-----END PGP SIGNATURE-----

--Wh0f451vcrYqeiNM--
