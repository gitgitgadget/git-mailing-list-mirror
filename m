Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D421F453
	for <e@80x24.org>; Sun, 10 Feb 2019 18:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfBJSzd (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 13:55:33 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34076 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbfBJSzc (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Feb 2019 13:55:32 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A8D02603C6;
        Sun, 10 Feb 2019 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549824929;
        bh=rp2+nrPzNAkFUYfJpGzN3KFiIBefapxjjuRrqA84wWQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=f4ShnZe2fNEcioPwyTPXXtR6In80kEc9VWYGjRa18HfaFqY+5ruYIkq2WnA7X1aXj
         MCfkuD6vZ1mPvXxjXMNhrf8OHJmOmS6pWvrbV/y8fjQlAWpzVAVrpi1AWrVVA5rvG9
         dZWiZ7ZSiXZS6V7OIP/tqqoUIPY+EspJUaR2cwTOoPeUKtpONa6UuVt7g1X6lXjMlc
         wRaFBfG2jj7ApwOYuUSyCGhC1wf7Wwi1V2WX2T0TU9d13rakMywUxn7Z+fA83xmfh5
         dtqnda5gngfK0wj3mNjNIm+0rXyHlg/N2HQzLY9G8qlpLGQdnRv9ukps33NU0vducB
         KDvBM+Cu1l61JNsPT9GDv7DUvbbnST3z6UGa0uQ6A5VOXXScAxydaKtY9NXRt9uZK/
         NcLRpB0qm97tV/2glpF7eqqUel0KHb9cx67IJW3wwXWecMoZ9fHT1pf7VKgsRN0PWX
         7uXD75eqHv7jKiTPM8RYz8pb5ZgJOKMVxo5pWPv/6FhiaoKyTmO
Date:   Sun, 10 Feb 2019 18:55:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com,
        Rich Felker <dalias@libc.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] utf8: handle systems that don't write BOM for UTF-16
Message-ID: <20190210185523.GB28510@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org, larsxschneider@gmail.com,
        Rich Felker <dalias@libc.org>, Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>
References: <20190209145732.GA14229@alpha>
 <20190209200802.277139-1-sandals@crustytoothpaste.net>
 <20190210080413.u56vr3fgoejjzjfm@tb-raspi4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <20190210080413.u56vr3fgoejjzjfm@tb-raspi4>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2019 at 08:04:13AM +0000, Torsten B=C3=B6gershausen wrote:
> On Sat, Feb 09, 2019 at 08:08:01PM +0000, brian m. carlson wrote:
> > Preserve the existing behavior for systems which do not have this knob
> > enabled, since they may use optimized implementations, including
> > defaulting to the native endianness, to gain improved performance, which
> > can be significant with large checkouts.
>=20
> Is the based on measurements on a real system ?

No, I haven't done any performance measurements. However, swapping bytes
is a (IIRC 1-cycle) instruction on x86, which would be executed for each
iteration of the loop. My intuition tells me that will be a significant
expense when there are a lot of files, but I can omit that phrase since
I haven't measured.

> I think we agree that Git will write UTF-16 always as big endian with BOM,
> following the tradition of iconv/libiconv.
> If yes, we can reduce the lines of code/#idefs somewhat, have the knob al=
ways on,
> and reduce the maintenance burden a little bit, giving a simpler patch.

No, I don't think it will. libiconv will always write big-endian, but
glibc has a separate iconv implementation which writes the native
endianness. (I believe FreeBSD's does the same thing as glibc's.) I
think it's useful for us to know that we can handle UTF-16 using the
system behavior where possible, since that's what the system is going to
produce.

> What do you think ?

While I like the simplicity of the approach, as I mentioned above, and I
did consider this originally, I'd rather test the behavior of the system
we're operating on, provided it's suitable for our needs.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxgc5sACgkQv1NdgR9S
9osjXhAArXn9aSeThWhZPmlIuQpSBoHoPafDIv0V4df5yxJ2Rx5ph/50LiJzkMhC
WSApVb/1NYZHJfcJnD54OMFWfmVYEEznIHhchAWfTyPmko8r3709OywXJAlweU6T
U1250CCH+blOJ1vbBAX+GGYrBzNo/XkbkEPh2eFLu2exCbYLoBKv8m/d1pJ+aPAO
2/+a6XzAXNqRMu0qu4flVu/0t0F1tAUM01f0YWzzLTQtT6dDO0TeqGgu4FUNePkX
7Gjipqzupbig2N9Z9vHZ1AvzYXapKaRgsfam/h7sYHC+ih4bnu+tiocy6b5v9Fpr
d5272RpbzblswD+dn5j+M6gvXVOjFRwXn3rquRnblGm94b7tT+RKkjZY8yNy02Xs
WvD5fS7cbdZeHLIuUFEwwixbv/olY41N+TkLUTv0dTN8UmPvvt/hPOcEpCJPOrs4
OUV2PXN2aFjQDJhdiRlN6TwX/JQXkiNjTjj013o1163OqG6LPYCJJt4dhswWCZ1h
Leac3axpZ3zFe+8D7pQqcrZ7Qw7w9CGgEwqI2tGesjbELDDdes/uIYRllfy8fPxJ
wzX27GJm40T1T+E4F+Kt+Vpcs7y52ygqfTDqf3CxH37KFpPwSGvEeEYtjRec8G8P
ordNBcow5cdHg2CS3iqKstoWDBjbcHxRO1lGolYsDt712now3X0=
=MFJG
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
