Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3D91F403
	for <e@80x24.org>; Tue, 12 Jun 2018 01:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934912AbeFLBJF (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 21:09:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37636 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934907AbeFLBJE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jun 2018 21:09:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b0c3:20dd:704c:b59d])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1419460741;
        Tue, 12 Jun 2018 01:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528765743;
        bh=WGnywbWybj+kD2136Wg6qHB7NjX6OAe1QjHFWNUPbWU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ajtzCMbCZkUNVI4rn+HRwzEoNP1JI90Zo+GxtXoexM9ocMUU2+3O6ExmJK+dpy6cs
         APjpXDwaJxWEUzqFGp0q1YUeAD06AwItG4k/YW6egQbd4wiy+MWOAhF7MjQCnzVbSc
         Eg9064iI8MrI0btzuLzF670pX9mtO60ixDw8fSGCgedzpz0okc5nXctVJh/0epb5OX
         ZWJSezOd7bewNcFgi1YBuQSCMmxel8EYxzVB6EnmffAvrvTpepFKzoOb9ia6yJvXCA
         PT9BK7Hi0qd5HhgZRsTFWgpiL/9eIoUO27/owDyUYVduOmFigJ6Hk2h56jrm/mh66O
         UOxgOigOx81WQVg/xIakci0fUDieNHO4IxzVKUaJQhXCZRJkVsyZBjUBA9u3JSDlk8
         4l8TwVTtbrtjw0AWW0rUXCdaupMxyckpggaTgzvLzXBRXQnwI9DXAADFNRv+Yy9V/+
         3XCo5UpYRjV8RWCSmfIIqLUDUzkVp2sWLn8Na31gXzt9KiGdRxN
Date:   Tue, 12 Jun 2018 01:08:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 05/10] t0064: make hash size independent
Message-ID: <20180612010858.GI38834@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
 <20180604235229.279814-6-sandals@crustytoothpaste.net>
 <CAPig+cTm4BYZjsFSV8AZ-jMjVPtze5H_7XUG1wBhmuFghJbc=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u/L2/WlOHZg+YGU4"
Content-Disposition: inline
In-Reply-To: <CAPig+cTm4BYZjsFSV8AZ-jMjVPtze5H_7XUG1wBhmuFghJbc=g@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--u/L2/WlOHZg+YGU4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 04:09:05AM -0400, Eric Sunshine wrote:
> On Mon, Jun 4, 2018 at 7:52 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >  test_expect_success 'lookup with almost duplicate values' '
> > +       # n-1 5s
> > +       root=3D$(test_translate 555555555555555555555555555555555555555=
 \
> > +               5555555555555555555555555555555555555555555555555555555=
55555555) &&
>=20
> This is rather unwieldy and ugly. How about simply re-using echoid()
> to compute the value, like this:
>=20
>     root=3D$(echoid "" 55) &&
>     root=3D${root%5} &&
>=20
> That is, use echoid() to generate the all-5's OID of correct length
> and then chop the last '5' off the end.

Sure, that would be nicer.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--u/L2/WlOHZg+YGU4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsfHSoACgkQv1NdgR9S
9ou7mw/8D/uMivy47i7m+Uq8lOtQXXHyLhTLLaUg3AgBgJ7oopfmPXb89r52APD4
cMoQ+3CB1oeggpFAkZGetVSz6ik7wjhDy3zX+JPkI2mTu+p83t3VA0dDu8m7cN0M
1Ns+2Jl/sohhIffRuNPmPSj0saUpEOXPoUsRQLNvaRX+RiYJAyoYHYwTDLlnlNOI
g+XzBCC9tz5Q0b++4dfVpyRhL6HH00OIaWYGqUN3hih+sBD2H6fnpN1nDMpCn+1L
Gm4w9M4xspfK7OWdvM3rCavP08kn8BRjNprNccv3WkQqDM6FdYhtf9ZbOSF+w0xY
rL10Wxue7stbBzczAOLX3w3fZVHxrzuDzMXTUyW1FWgqr1F/rdrWMIh43ppL4bgj
AQu8NesapE0RwSNmtZ6WVbkB5jfh0ahpknIT4WnbsipkBpDNGcr29rApL69bPvRT
VK9gHAthER5rZ4Bk1vDE12H6I57A7+c3gKtljE/koBD2WezGh6+KED9lSZLKGS4X
Nkk4bWvEHZU0g1YDw0A3o+fgo4RBCGDpHWrkEhiIWaO1M0msLZFE4XVnCl4XSpEy
NbyB4GzBpLQpkhkH4bC1eFs+bBr7vf5xn12h2pEbmajA3pTBujh1jud29sQ+xFox
5pM/X2QlZxhBkkltEDdnO+77Q+Bgitg3HzU1DyjJnTI7Fj/ZeGo=
=toT0
-----END PGP SIGNATURE-----

--u/L2/WlOHZg+YGU4--
