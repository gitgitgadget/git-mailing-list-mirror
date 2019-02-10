Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64AA21F453
	for <e@80x24.org>; Sun, 10 Feb 2019 18:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfBJSOj (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 13:14:39 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34060 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbfBJSOj (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Feb 2019 13:14:39 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4164D603C6;
        Sun, 10 Feb 2019 18:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549822475;
        bh=Lo50ldsBuVlEuHwm+imZT7Ek3KA9OqbV1KuzwpLbGIE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hRv3jOS4CusMTHiuGWyBi0s/rz93S5IvPaJGH5miqbiEUhQVimAEQvpF/v51mQKXZ
         2HBrVa4e4RWtQnacQNDxR3t8hqd+elS/4QXzYeobEvbRGNU9U/GDPgX1ssRXZ+StXe
         hJ6dOV6MMI3G0VCvEtFk7R52SQVu7lwooy/phamW3Q5YJ0lnhxH2XbsxxNN5LxC787
         rMtjW1pcREfRzYHRbx9rjspaQ8wtL1z14ktEZGwj56EgzIf7/9HOVq2YmqRXMGAkMB
         By95PX5X0Rtb+hBzri+8RLkT7ifs+17AVsOMV9JV9ulBCr+QNxn78mrp6uKm9cEknp
         /Nc90Xkv7PXSKxD8aRMLHM8SWFTLRD+HLgiDp4qUXqlNsHOFQgyXujCSOEj0jejeus
         OLFZAnhiBvffmBTn5uQJVUpbgXKwxGy7dRj5N2G2LpevunB/bTdIrDBl+TvuzVuAjN
         YSAcbhLwObxpb8HncUuLmye/MTOTAo5XHzhT5dXOZENvVfkaU3U
Date:   Sun, 10 Feb 2019 18:14:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] utf8: handle systems that don't write BOM for UTF-16
Message-ID: <20190210181430.GA28510@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Rich Felker <dalias@libc.org>, Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>
References: <20190209145732.GA14229@alpha>
 <20190209200802.277139-1-sandals@crustytoothpaste.net>
 <CAPig+cRyzZMOM19ztgR_wqvk68P_1eNNVBBj5pbY=MhQm08WAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <CAPig+cRyzZMOM19ztgR_wqvk68P_1eNNVBBj5pbY=MhQm08WAw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 09, 2019 at 08:45:16PM -0500, Eric Sunshine wrote:
> On Sat, Feb 9, 2019 at 3:08 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > [...]
> > Add a Makefile and #define knob, ICONV_NEEDS_BOM, that can be set if the
> > iconv implementation has this behavior. When set, Git will write a BOM
> > manually for UTF-16 and UTF-32 and then force the data to be written in
> > UTF-16BE or UTF-32BE. We choose big-endian behavior here because the
> > tests use the raw "UTF-16" encoding, which will be big-endian when the
> > implementation requires this knob to be set.
>=20
> The name ICONV_NEEDS_BOM makes it sound as if we must feed a BOM
> _into_ 'iconv', which is quite confusing since the actual intention is
> that 'iconv' doesn't emit a BOM and we need to make up for the
> deficiency. Using a name such as ICONV_OMITS_BOM or ICONV_NEGLECTS_BOM
> makes it somewhat clearer that there is some deficiency with which we
> need to deal.

That does sound like a better name.

> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > diff --git a/Makefile b/Makefile
> > @@ -259,6 +259,9 @@ all::
> > +# Define ICONV_NEEDS_BOM if your iconv implementation does not write a
> > +# byte-order mark (BOM) when writing UTF-16 or UTF-32.
>=20
> Not a big deal, but I wonder if it would be helpful to tack on "...,
> in which case it outputs big-endian unconditionally." or something.

Sure, I can add that.

> Stray blank line before the closing brace.

Will fix.

> It's probably doesn't matter much with these two tiny functions, but I
> was wondering if it would make sense to maintain the &&-chain, perhaps
> like this:
>=20
>     if test test_have_prereq NO_UTF32_BOM
>     then
>         printf '\x00\x00\xfe\xff'
>     fi &&
>     iconv -f UTF-8 -t UTF-32

Yeah, that sounds like a good idea.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxgagYACgkQv1NdgR9S
9ovQnhAAuJxo8ja7oULEdAQmbs8CxnSYfCuIcNm7L1ur2F9QW6DznvhwvPZXWaRe
bQqbb+3fcYYyvnxJHmwp0eAQiUVQZg/6Hl1HaU18keWSkABERHwFg2twcVA1UzRI
BuC+0bfHPOy80Fh04CpHQfn+Z2AMvq/lBROeVgYVjrnBVJOw0gFqaphThfxSa4y+
ekaL983dQ36wVrsCpn8bezQpU82LZTsCvBUktI1D5T1uwaQK6yLgALu+PCxGEYxi
AsFQpWH5jaB0W5oP3eoMdsWJsupowxrg2A8yGjkO3bFvZdVfi6uIp1FeTg5zeN2f
4si9Y157InerEVBAJlT1VnRncjBbHorq6WLv9m9OR78KqHRaUlamE6RBZpsuABkG
rOmReeLI5QnDDoEfICmOJjy17TRaMDuXWlD0KapEHrkzzyfWSD+rqdm4TglF16K0
LC6vIMI933CeYcHvghXB7EIz/YbIq12B2KeN5D4KVkyb4kMLrfzqk2HMkJHc3gfj
DMhlz7Le7DzDlKlJ8RyNKzHwpvENYAmHyV0atjohnfKIYpESEDmUqxDfirmvWG2L
7tth1Z6Y+exnQhPqHD2a3l17fEFwrDcRCR0l12mi4sIjwCidudpMAkK9paWwbEMw
Og+/68giJHOep0i6B2wsOJfzpx3cXKtSjyZx+mdN702OWi8Mmj0=
=9P4G
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
