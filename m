Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87CD020248
	for <e@80x24.org>; Thu, 28 Mar 2019 00:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbfC1AGX (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 20:06:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35318 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726173AbfC1AGW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Mar 2019 20:06:22 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:d97:2d03:d5df:c7a7])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 49D976048F;
        Thu, 28 Mar 2019 00:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1553731578;
        bh=ZRLiybfRX54bI9vvvz392qGiMFmAybR9bo8YQnBY+ek=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=MA6K4hi7M9HhjsZ6TP/hM9kzAXtetiwcivpbt2qRFsnYBOoGMMSSZz+wfCES6zs8G
         eUsBE0Jat8WGv6h6olyPrs3ZSk/GIJttDxITWqUExTRuHcQTr/qKzjj26EF0ecmOe+
         MjJNcvrvz6DMgFkgDJWFHb0nkah0Aoqw5oLaCMnnGCm++352xIg5nUiF58mT30fw0H
         +55kLkYTC+2xFBdneUQDZuYSgENsqRmiF1picKz44Zp4X7SDxXnB1GMGAtcD13w5Tw
         eJAd6hVPK8kG5N2HZslXtfHpcRamg5XDWXNpSV3FfN+FFB+A60yjTn1XoknO/AW16E
         8oem/HZUMS6i6KSD1kcNVKomt7wmqOybTfB/ttsKp3MBDACEWU98j/TBmSZk6aBYr8
         hCrn+251fchlwCxTNCPdsIH4EHJTK6bZeezpxQxPNC+caMblihnNsqXnuSGcCeJ0QE
         I0r6axe1IQ0EH/s+FGZaKjP0bz99vCQfa4xQg4KL7YKK1H2booh
Date:   Thu, 28 Mar 2019 00:06:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190328000612.GA12419@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>, Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
References: <20190317194431.GY31362@pobox.com>
 <CAN0heSrajiswzpm+au_5nmZMZG9406iZa-CK9p5CaHLTuxm8nw@mail.gmail.com>
 <20190320181715.GJ31362@pobox.com>
 <CAN0heSpJvsPm_qq63VumokmyOG6N=6fwMZRqf_9CzoCeHsdiyQ@mail.gmail.com>
 <20190323192756.GK4047@pobox.com>
 <20190324121619.GD312@sigill.intra.peff.net>
 <20190324162131.GL4047@pobox.com>
 <20190325150633.GC19929@sigill.intra.peff.net>
 <20190325190041.GM4047@pobox.com>
 <20190327010603.GR4047@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20190327010603.GR4047@pobox.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2019 at 09:06:03PM -0400, Todd Zullinger wrote:
> There's still the matter of 2.0 dropping docbook45.  I'll
> try to get around to testing 1.5.x releases with docbook5 to
> see if they work reasonably well.  If not, we can add a
> version check and set ASCIIDOC_DOCBOOK appropriately.
>=20
> One other issue that crops up with docbook5 is that the
> xmlto toolchain now outputs:
>=20
>     Note: namesp. cut : stripped namespace before processing
>=20
> as documented at
>=20
>     https://docbook.org/docs/howto/howto.html#dbxsl
>=20
> It's mostly an annoyance which we either want to strip out,
> or pass an alternate docbook5 xsl, I think.  But I'm not
> very familiar with the guts of the xml/docbook toolchains.

I'm quite familiar with this area, because I used DocBook and its
stylesheets for my college papers. There are two sets of stylesheets,
the namespaced ones (for DocBook 5) and the non-namespaced ones (for
DocBook 4). They can be distinguished because the URLs (and typically
the paths) use "xsl" (for non-namespaced) or "xsl-ns" (for namespaced).

xmlto by default uses the older ones, and assuming you have a reasonably
capable XSLT processor, either set of stylesheets can be used, since
they simply transform the document into the right type (although with a
warning, as you've noticed).

Unfortunately, xmlto is hard-coded to use the non-namespaced stylesheets
with no option to specify which to use, and it doesn't appear to be
actively developed. There's an option to specify the stylesheet (-x),
but it can't take a URL, since xmlto "helpfully" fully qualifies the
path. That means we'd need to know the location on disk of those
stylesheets in order to use them, since we can't rely on catalog
resolution.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.14 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlycD/QACgkQv1NdgR9S
9ot7lBAAx6vadVoi7Y6EVJyb1AnDsMLgHbXqMcl+RYdpAeqFCwP+ljmYNNhChoF5
5uj4KF4afe7SalD8DE8srHttX/nUuMsMHk4ID3/8YfnE3SrFYnFmnViMoo6iz26r
zOqd5vcdWmBPOVsmSxod1C7uqbEMmLUJqMSlGpO7hjAagLK1cY2JW4rOgguQJjpc
M5IcVj+Us4iZVGiJmB6LFcm02wNZXdlpHO2AcHaAyHssHDRWZa2jlPRXcZfk+DO+
xJeaEueFvPDmZTBCFOzU5qpdMZ5W/vTJNv54BCpCH9rECvCiFSvRxkbRNh2Ip9bH
ea+kDJ4QprFM/orug16WqaiJmmDpRY7Wfac/Q1/mhNyhFR/f5NM4yglUdUQb4W6G
eQx03/stjG3QjUzoZb0BtqYjpsbOXsCn6xRKKKwmxBCuEJ8+eAkOnPQ7yfY4KFdS
Rg9IvAVzOy6/yb0WT5oRtt7vog/g86dYjTU7sLsk/+fBDll7Y8iSab0LTk0LsYG2
T2/vbuV3se9/x0kVQBkz82XqVHTpJfE/I6aQgmFgMLCun3hSSAbrrJRLnxyFzjGq
Y4FVYC/+j+fRsKT9U+5vUfB/yz+4CzGTZWyD0KA8gZ687ICEqfbV4cKxDzZQ2rBJ
Ne7BE/ITRC1WQycrP8VRbjb/NGCXvU46fVIbkpd3LlTA2E7Xnmw=
=UNBa
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
