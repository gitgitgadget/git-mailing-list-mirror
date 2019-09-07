Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B72691F461
	for <e@80x24.org>; Sat,  7 Sep 2019 16:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403900AbfIGQxM (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 12:53:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58572 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726669AbfIGQxM (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 7 Sep 2019 12:53:12 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6959:e43b:5cf6:a465])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A39356074C;
        Sat,  7 Sep 2019 16:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1567875190;
        bh=uXt4t6mbyWf3v1wlLubv+WYFUlqeGpHBuFOd1Z99y7E=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=DjdYLcirSMEcfII5bpEzUIU3G3o0bKPEfYbfq0IV46FgsVWR64qb4mG3aZ4LerUcs
         UFsAga36e9IB9GY5Uyd5k7uenFZHNEp2Etp5R5qCw+J/AFvizpvB3ga9eFZXGeHoBa
         e3jmCNGnCANcgMfCF/fQvqNlbVn5OwS87wswKN4WPr136t1aeqt4NVVuccflXVrIxh
         DvhiK6VxDvZMJv3fV4HicyaCJd5R6GlXHdfXw1pVGGu/bVGFw/7C3itqaVJUSOyAqW
         Vqg/iljf/29Tjvy7X3zIejo1jQ8EKkb8Y2+aUZs2BKWKWLBUUPXC1O3eV2/+p16aQs
         qDyToZFfB7tnTCH4112wPdWunx8xbRAGujtYmylazoUiWPHEYKcVM8BH18kHljOKfU
         IOkNb/jf48i2EmO/zTIa8QEJxyhjY4bh6rYnR5PcicyJPY4KXeRN3pG41M2hSX6AFB
         VJVxweF6FNLDc7QR1U5bUEG7S65p6j0XW22yN6bYH5fSadLxGyh
Date:   Sat, 7 Sep 2019 16:53:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190907165302.GK11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <CAN0heSr2zCQMM6wOM0UnD28qj_VygQ5CQHGHhMR9+H23snpt5Q@mail.gmail.com>
 <cover.1567534373.git.martin.agren@gmail.com>
 <20190904032609.GD28836@sigill.intra.peff.net>
 <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190907044021.GA24463@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZG5hGh9V5E9QzVHS"
Content-Disposition: inline
In-Reply-To: <20190907044021.GA24463@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZG5hGh9V5E9QzVHS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-07 at 04:40:22, Jeff King wrote:
> On Fri, Sep 06, 2019 at 11:29:47PM +0000, brian m. carlson wrote:
> > I'll look into this.  I requested the upgrade in sid.
> >=20
> > If it's the lack of DocBook 4.5 support, then I'll probably need to
> > patch xmlto for that.  DocBook 5 has been around for a decade now, so
> > it's time for xmlto to support it properly.
>=20
> Yes, it's the docbook45 thing. Switching to docbook5 lets asciidoc run,
> but then xmlto chokes.

I already have a patch for Git to fix this.  I'll send it out this weekend.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ZG5hGh9V5E9QzVHS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1z4G0ACgkQv1NdgR9S
9oviaw//TtITkNoqW5E1TdNqyUjrEY0RdQvGmZQEDP3jZmU9PpPkQFtdizbcXBHa
+j5Nr8OAb4w2wE1w85PeFXsoDpE7LwoXbk8cL2oo9h4S8ISdugwOVNQU0HotyJ2H
ivyNdogqyyG6CqU4cndMAhEd9s3gPoUoM0BsuEpU4uu2QYZ7jB/S8KgkLRN4aja0
N+V8hI/8splD6gpf0OMBbQhH1I4JJ1WyGfMHFbNuz4sPuKMxVCEsKOwcSSKDHwiu
XlV25yYJCjWP7FKf+IR+QcGB5I5APkIE4MOFJlxxN/UMoopmprKlfCLy1kLRaN9E
NTj4PL9BXodN5O1pJ95NiU0C6sSB9DNebVXPKwJhiJiu0rH+x0L/O//1duqW/1Gh
Dc3dOidC4kbMVQgEGer1f32JvER3Hh2MQozyC7Jw4mI7AEcvINEbPJT5uQMihPnG
HDDB+/bwFQdwRW1xgZrYijqnRlw3MH4RvDNrlfw6ZMYO6E5jEwG34JHV9+/OTLoi
yug1V6KgcD79H7TKsS3+3NdEdrpqXrHXE0RqOwHFBrtWzn+iD/p1G4Fq+njnY/Kk
I7P2fpmmv4mkeflBlGLwdUTJ/4M9goIYr98o/gEwlPIveRZZM3tX2WLSlQorQYKQ
ZoUfswf262hF2iJROUI4r4X2iIAN3iVxI5lGL5ZOHVlTJdrFwN4=
=ctNl
-----END PGP SIGNATURE-----

--ZG5hGh9V5E9QzVHS--
