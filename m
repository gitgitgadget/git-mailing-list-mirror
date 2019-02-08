Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A03A31F453
	for <e@80x24.org>; Fri,  8 Feb 2019 13:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfBHNvp (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 08:51:45 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33886 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727898AbfBHNvp (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Feb 2019 08:51:45 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:d42:63e7:5548:1ee8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9C79B6042D;
        Fri,  8 Feb 2019 13:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549633903;
        bh=0kEdqSw3Q2PnooeMrPvijySU7BsvT4l93ImIsAcj4Q0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=P4u9J08hiUQPlFcGWwY2jQwZP535dHSaHXdd+OiJ82XF6hlut+mvdngTy9VpyR6BE
         p0JtMtX7bS6ohHkRYZ63keu4X2mecAys4zDl1+ctWw2UV45B7XXrn+SFp63pwm4/my
         sgVXeMDcGNc5HVNHeN1SCd2HfLYLd+yhwY9QWDV8pM5wZOhzcXrgfCVuA2Lc7fSdbJ
         dYHlGC+/t23ytJaC0Llk+wudxCJE9Y+T3HNo9NHLccxl8m8dFob2hr8tZaiQtrxkll
         5cbQ9iUSeXxXJIaV+ohQMlTrhUn0oy9wxM/NFv2Iabs2kBdxSKT4IMTp0eZ+0H6Pvm
         xv3jBzYweeSDeUiT1RnKRcqvQ6xqKy1JrAkJA8nxx8UYchnikMJVoSTjqEh7I+EgV5
         rL9l9L7nwIxDQ941N/88mgQ2yNYWMX+ptX15lKQsr3FFS7gcC5QUkTUeYl3F+WJ3J/
         GkMxmFae7s6cMEpotTjbKNVes0DNdYzUxBggSwCoth88pO5FZCu
Date:   Fri, 8 Feb 2019 13:51:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     Rich Felker <dalias@libc.org>, Kevin Daudt <git@lists.ikke.info>,
        git@vger.kernel.org, larsxschneider@gmail.com
Subject: Re: t0028-working-tree-encoding.sh failing on musl based systems
 (Alpine Linux)
Message-ID: <20190208135137.GE11927@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kevin Daudt <me@ikke.info>, Rich Felker <dalias@libc.org>,
        Kevin Daudt <git@lists.ikke.info>, git@vger.kernel.org,
        larsxschneider@gmail.com
References: <20190207215935.GA31515@alpha>
 <20190208001705.GC11927@genre.crustytoothpaste.net>
 <20190208060403.GA29788@brightrain.aerifal.cx>
 <20190208114502.GD11927@genre.crustytoothpaste.net>
 <20190208115511.GA30779@alpha>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
Content-Disposition: inline
In-Reply-To: <20190208115511.GA30779@alpha>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 12:55:11PM +0100, Kevin Daudt wrote:
> On Fri, Feb 08, 2019 at 11:45:02AM +0000, brian m. carlson wrote:
> > On Fri, Feb 08, 2019 at 01:04:03AM -0500, Rich Felker wrote:
> > [..]
> > > In any case, this test seems mainly relevant to Windows users wanting
> > > to store source files in UTF-16LE with BOM. This doesn't really make
> > > sense to do on a Linux/musl system, so I'm not sure any action is
> > > needed here from either side.
> >=20
> > I do know that some people use CIFS or the like to share repositories
> > between Unix and Windows. However, I agree that such people aren't
> > likely to use UTF-16 on Unix systems. The working tree encoding
> > functionality also supports other encodings which musl may or may not
> > support.
> >=20
> > If you and your users are comfortable with the fact that the test (and
> > the corresponding functionality) won't work as expected with UTF-16,
> > then I agree that no action is needed.
>=20
> So would you suggest that we just skip this test on Alpine Linux?

That's not exactly what I said. If Alpine Linux users are never going to
use this functionality and don't care that it's broken, then that's a
fine solution.

As originally mentioned, musl could change its libiconv to write a BOM,
which would make it compatible with other known iconv implementations.

There's also the possibility of defining NO_ICONV. That basically means
that your system won't support encodings, and then this test shouldn't
matter.

Finally, you could try applying a patch to the test to make it write the
BOM for UTF-16 since your iconv doesn't. I expect that the test will
fail again later on once you've done that, though.

I don't have musl so I can't test a patch, but theoretically, you could
use a Makefile variable and lazy test prerequisite to control the
behavior of the code and test, and we could apply a patch. I'll try to
work something up later today which might work and which you could test.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxdiWkACgkQv1NdgR9S
9osbOBAAjrvBT7J66iaoeQdc6fLvjh21Z0D/3SMGezCTtAB0LeKXTdEDpUwDXdLq
V5KdB6w2XmKT1XATS2o8r8PhEiOv0aah9yD5GlBrNogRZogRPO8y7xqwDBFh3Hct
AqfiT82Mif6MXnJGkn/evt9I4BwsvMPOkJucStIE8Q/x/uyXbpTquSxtsAkfWa8e
x08h50+0gNO1Sz8qD02bJHlJDUwoowoQzIgcIiMAz629VHp8rJynfqWkwp5Jz0hU
MwsoN4yTPip2KkKoCgiBo8Muh/gx5PfVeuFENUdU+SgAQxyuU12n6Gxvjcf/Iqi0
YtMkCTT1NpNkNajDa9AedRfsDRxJFO0AZIl8YrIBaM97N3ylwE20+aCTze0efIJ4
dt4UZiBW74Pidy6dLYdFTRrIG8JFPLw612nTZtEF0Uvh9ury5diliRClJU/NKRrC
aE3rLaKQj/JXD2JKNrFhewRWy7GlLR3faQjbEWNWbiuPh2c54GXeJI7QnADBuee2
Wy4iuu1M+UjYm0Cls2ntjkvJHzmbSr++DCIzle3XrQ37y9Z1VL4uxw5HnEHBsuU1
HGHG+QSV721ceAv2yiMqhuViYyu2Oo+mvfzAHEG6d4Lh4kCC3SBMtqJ98geqQIk5
VndaHwKm/Fyaehn+fgt8wk5t2SX0i3zuJSWBkmk0p2Y9iQjrgiE=
=LQ9M
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--
