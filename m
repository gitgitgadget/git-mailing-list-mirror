Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD3CC32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 21:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CBD22525
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 21:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0h89U/rV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgATVxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 16:53:31 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43222 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726752AbgATVxb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Jan 2020 16:53:31 -0500
Received: from camp.crustytoothpaste.net (50-244-106-130-static.hfc.comcastbusiness.net [50.244.106.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 83C9C60735;
        Mon, 20 Jan 2020 21:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579557210;
        bh=kIC4uQgTYqT5U32dOBgoh0Wb+G0aqkrbPaviXQdv1IA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0h89U/rVTc5A1nbYbK202lJifiSKshSZ9Y+qEd1gzF90yr2aVyvMhKuiehYeAO9O7
         zJxWFmryPz99ZdXB9BVb/U5kk0daEeLEjTCXGh/rB+KPsBLgVG/55eg+qhXZu3qRbN
         2b+oh0EhbFby/8h+6e7nOiO65Q0tt7rKt3mb3Tffs4ldmlzlYdAo2ryfAdFMiOHnF5
         IJ51AWrqko2kqgG0ztsqorwBGpBN1Y+sP75hfL4gcP13xsd17YEjGxH7NyCq8Df/T/
         30B+pBWPM+FvMEPLqX5kjSdLOOa4rtN/wRkLlcDUhKGhA/x5shwI9sVkvS5k4bg21D
         yJBxAN4L7POLFVZ7Bktt0DSyqu6GmDMfszkvom8ugNBI3BA5JnQk3q4lnF9YLzJ5Y3
         K2xBise5FGOEbYNRxCd/TbYLG6GVLQEArFWrNTkZreJlvRTxuGG+pDfDXpFlkBjIm7
         sFQ2SyuojgEf/yb8MDuJ95jjF2d68KIt7/xXy7XjmIpH9ybS/TG
Date:   Mon, 20 Jan 2020 21:53:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: use "currently" for the present time
Message-ID: <20200120215326.GE6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>, git@vger.kernel.org
References: <20200120212156.4109999-1-sandals@crustytoothpaste.net>
 <alpine.LFD.2.21.2001201633240.8488@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="boT9Oj39GmgPxYhu"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.2001201633240.8488@localhost.localdomain>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--boT9Oj39GmgPxYhu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-20 at 21:33:58, Robert P. J. Day wrote:
> On Mon, 20 Jan 2020, brian m. carlson wrote:
>=20
> > In many languages, the adverb with the root "actual" means "at the
> > present time."  However, this usage is considered dated or even archaic
> > in English, and for referring to events occurring at the present time,
> > we usually prefer "currently" or "presently".  "Actually" is commonly
> > used in modern English only for the meaning of "in fact" or to express a
> > contrast with what is expected.
>=20
>  ... snip ...
>=20
> as someone who is constantly being sheldon cooper-level pedantic, i
> totally agree with this sentiment.

As I mentioned, this is very minor and I can't imagine a native English
speaker being confused by it, nor can I imagine a speaker of most
European languages finding it confusing.  It just stood out to me since
I know Spanish and French and I thought, "Oh, someone was thinking in
another language here."

I've actually been sitting on this patch for a while because I thought
it might be too minor to send, but I finally decided to do it as I was
sending some other doc patches.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--boT9Oj39GmgPxYhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4mIVUACgkQv1NdgR9S
9otTCg/+Lv0ougJRyH5aor6Jt51J+R2+MV8PPiwZWiFL9f0r9Jg5sE2QBVL4JH/6
06YhbhBDHauAPGnnAuYZy7QHfvFMU9rqVUAJEavoZlMfCZRYNcoz5aKx6WcTsnSB
XIYFIG6mtQuYmwCNGcfgl7Us7ErAMCTJUGzhotCyI+LV1ubgM5eXEnpwTt8Pux3E
iiaV5BuaDY9DqDZm4EWMpRRrIswVHnAu5q+0qQR/2nhuOMmcl+4DPIymaCshn4IK
hiJ75+tmoFpX5rHZmen4zfY9FpxFphQJ/S1JqlX5i+w7uYBxxd+9vSaEDX2DRcPb
NT4FzRLbR0XuKln6swJl6UbZcvUhwJf9cj2lW/FTK+eqSMXjJ5ViB/F1S6jaa+GA
Drxy6karbrV22Lr/yldLlXGZOye9rI8iqlEZrakj/giBaJSGljM4TUektY6puk7v
Y5Xzw/QIjjtn989dvbWZnWu5oHfxBrxnDGLVetLjFniftYdxRVc6eFyg1wjms/wy
1VMICX6VfsndC92yi74DoGhf0/V/4PSbp0uKu3KS9MJZqaX3kpPmUl9wH5euzK56
RcAMzOtc4pjREbhyQi581VSSpUDjnUZkWr29sPlhifQjHLdoVFvUCoPXWeE90anr
sYTKkZEOUuP6mSAW8QTm1DhvuWp5ih/Xh06qYSZRWzdXsOdTMsA=
=3R5e
-----END PGP SIGNATURE-----

--boT9Oj39GmgPxYhu--
