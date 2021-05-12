Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E18FC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B6FC616E8
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhELC3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 22:29:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52464 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229934AbhELC3X (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 May 2021 22:29:23 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1195960749;
        Wed, 12 May 2021 02:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620786495;
        bh=hiG86x+kuJ9voLNvFZcUuSMuCQWrzxjXAGJwfHd0hfc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wC9LbIyLGGgQxfUcFR4MJ3/wOWaBH4fu2g1Pz/xq3WEbMmHUpi94+52nBtBdv5sx4
         0xh2R6Qt3fjC76P8yua8hsi9Sne7ROHesRO5dwgjC5mCtz/RL6qysd9b4peMm6rRlQ
         4RqxwAVrrJfPh4KITEf8+eBUVJZ1NoN1UYW8rObFdaNj8EiOdYZCNshJmhQZwVjCA0
         YzpxQ3bEduLhSvq9g+L9IswlfjHXOip2t/gpT75T5ZauuP1ykg41YVTxuDBYUXipJD
         jW4Dyc7yJ7o9gkqUi/X4uYDGyB+pxkIUqEB6F7CSlUjaN5qmHjqwiyz4Lyg8GI0BQz
         dff0goLmwpvVCfEh/jbukIPKGrhybNnBeJ0lXDReQRhzhlLKCHQyv5dq3elke4WwdD
         2FY0Vhk9xEGaUQeE8ahUp7tNLp4ignH3fNuRAIJK/cMzz+GXv9dYlQwu8H6+ykVzfG
         Czrs8wnTchWo1cteEz/Cb1Z/FmgeuOByTtFZKLtq52lgtbyg2hC
Date:   Wed, 12 May 2021 02:28:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] doc: remove GNU_ROFF option
Message-ID: <YJs9OvRjG3Hk0RsM@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <20210512021138.63598-2-sandals@crustytoothpaste.net>
 <CAPig+cQh+8Zo4mh9NtnZbGJLRRXY+zTj_9JXeMkCUz-b9nmkzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DZ392flrSxIATQaz"
Content-Disposition: inline
In-Reply-To: <CAPig+cQh+8Zo4mh9NtnZbGJLRRXY+zTj_9JXeMkCUz-b9nmkzw@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DZ392flrSxIATQaz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-12 at 02:18:54, Eric Sunshine wrote:
> On Tue, May 11, 2021 at 10:11 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > By default, groff converts apostrophes in troff source to Unicode
> > apostrophes.  This is helpful and desirable when being used as a
> > typesetter, since it makes the output much cleaner and more readable,
> > but it is a problem in manual pages, since apostrophes are often used
> > around shell commands and these should remain in their ASCII form for
> > compatibility with the shell.
> >
> > Fortunately, the DocBook stylesheets contain a workaround for this case:
> > they detect the special .g number register, which is set only when using
> > groff, and they define a special macro for apostrophes based on whether
> > or not it is set and use that macro to write out the proper character.
> > As a result, the DocBook stylesheets handle all cases correctly
> > automatically, whether the user is using groff or not, unlike our
> > GNU_ROFF code.
> >
> > Additionally, this functionality was implemented in 2010.  Since nobody
> > is shipping security support for an operating system that old anymore,
> > we can just safely assume that the user has upgraded their system in the
> > past decade and remove the GNU_ROFF option and its corresponding
> > stylesheet altogether.
> > ---
>=20
> Missing sign-off.

Thanks.  I'll add it below and if I do a reroll, I'll send out a fixed
patch.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--DZ392flrSxIATQaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJs9OgAKCRB8DEliiIei
gTD5AP0U97jX8cW1SFVk+qdMfrF/LXieue8ZM1okdcBJ69VcEQEAkCajO+W7oOIL
oHvRhwJZ2Wh96TqtNMbyZPBs3ePi9QE=
=n327
-----END PGP SIGNATURE-----

--DZ392flrSxIATQaz--
