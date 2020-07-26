Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E085BC433E0
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 22:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAB302074F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 22:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JmJGoy+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGZW4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 18:56:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40802 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbgGZW4g (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 18:56:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E07A2607A2;
        Sun, 26 Jul 2020 22:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595804195;
        bh=b4i1xLwDCqEU1LLT1s6YG+iHg/b6enSYyNX3FYCnH1c=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JmJGoy+Ty4uzfIzry36gy45jatZwf2GyDM1IYVE++GFVUS+ZLE8ZAn9KZYKDJbKHx
         CBvdp/4Ni4iQq/2tQsIoKOwCAhQwaynFu0xIJ4GMgSBFVZxSnkV+jP9ip+0p/HuvI3
         Jkfb9EykbYP1KKZ79N8BgWxPvABqg2sKRRAYeanqT6Ysyl2ivNIinNm8uTZeGRxRv0
         i63l2lkK2ABETSj61lT/lxkr3ijG954O4NEhopvQj6WkKtZSQRR0TVJMPr4rFQc108
         RTuiVoo/iJi6I1hx2fOTgcVBDgA2WabQXEGWbFmV50Wlc5xlhbb0ke0TC0I2qhHd6l
         6gNcoKc754DaeHPrl0gxZ4I/gMF+dfc8gESiJxrNtDvTw3dmohyIRJS18O2yhvk/l7
         NiOB892S6KLKKmYweq9IA/sITdp33oQttxkbikEobXMleFBAWrkZfzjK7MDnn6WF+N
         eXk/5qwxwN9M3UXet2sVv/uQyQbNa8zsG02EETfSfgc9+TCRdSm
Date:   Sun, 26 Jul 2020 22:56:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v4 30/39] builtin/verify-pack: implement an
 --object-format option
Message-ID: <20200726225629.GC6540@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
 <20200726195424.626969-31-sandals@crustytoothpaste.net>
 <CAPig+cRUj2RGz1=+3EDr5G_Mq2sXPnztCr-iPDGH+WycQ2iwjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <CAPig+cRUj2RGz1=+3EDr5G_Mq2sXPnztCr-iPDGH+WycQ2iwjA@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-26 at 21:29:46, Eric Sunshine wrote:
> On Sun, Jul 26, 2020 at 3:56 PM brian m. carlson
> A few comments below... use your own judgment as to whether they are
> worth a re-roll.

I'll do a re-roll, since I think there's enough issues that one would be
worthwhile.

> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
> > @@ -7,21 +7,28 @@
> > +static int verify_one_pack(const char *path, unsigned int flags, const=
 char *hash_algo)
> >  {
> > +       struct argv_array argv =3D ARGV_ARRAY_INIT;
> > +       struct strbuf arg =3D STRBUF_INIT, hash_arg =3D STRBUF_INIT;
> >
> > +       if (hash_algo) {
> > +               strbuf_addf(&hash_arg, "--object-format=3D%s", hash_alg=
o);
> > +               argv_array_push(&argv, hash_arg.buf);
> > +       }
>=20
> Rather than bothering with a separate strbuf, this would be easier:
>=20
>     argv_array_pushf(&argv, "--object-format=3D%s", hash_algo);
>=20
> Doing so would also fix a secondary problem that 'hash_arg' is being leak=
ed.

This is a great idea.

> > @@ -31,9 +38,9 @@ static int verify_one_pack(const char *path, unsigned=
 int flags)
> > -       index_pack.argv =3D argv;
> > +       index_pack.argv =3D argv.argv;
>=20
> 'struct child_process' already has an 'args' member which is a 'struct
> argv_array' of which you can take advantage instead of creating your
> own local 'argv' in this function. run_command() automatically clears
> the built-in 'argv_array', which frees you the effort of having to do
> so manually.

Great, I'll switch to that.
--=20
brian m. carlson: Houston, Texas, US

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXx4KHQAKCRB8DEliiIei
gfEqAQCW2BEfASBdQPVXqmB7+gofZXLlUxAljNLg7o7c3vN+QAD8DapDLhFqcuL0
A/RjkOFS5ggMWWJo1KugI2INZk63HwQ=
=q4UR
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
