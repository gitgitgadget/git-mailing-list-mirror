Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54309C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 08:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiDEIZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239229AbiDEITz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 04:19:55 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2F57C166
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 01:10:31 -0700 (PDT)
Received: from camp.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 806105A3DE;
        Tue,  5 Apr 2022 08:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649146230;
        bh=TWKdl3mC1i/HY4fmknk25Og6ddcqrcvuyFn8gelsHi0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fNbhzlNa2gh4oFUYLQfMcakJv58c8yFMocQFbfqtX6XWaltaxZGVQ7yNBk4gXJJaj
         qjD/knvR7KU4QWwrm0T40UJImV2z113bbeHAFraadGzkkozQQsXFb/jRLaMu1dHgWs
         jhAZvFBQqgb2fI29vxHie940iWCi2k5xcDt7MC2H1KX7FFgNTYweZUFteSOE9AbSdP
         IbOoVnhKL7saJTA3e/zXnzYzGf+406oiT3c3o8ABgcuOOEMxMo6Riypf5R9qlBTQMg
         O2H3w1FsjT2+ltvGOMt8dCPBiCyVCYDkqL0lAwJJ3MpWWE0GooJnaJ6ab1RkJHRfef
         sNMcy/U/NeuBz2bGtv+5kVJAA0FpSXfl9wWnibpCBNQFf6KeI6E7q5FuZekQKhK6tG
         9u8McDejYs6/Ema3LxcbdfiLRP38WUEsxSvGCZjba+9nlcd07fRdA9Ux+jLwNxFdjj
         8w/WmPu6ysWyMd3Oa/J7hnr6GMv+iqlsXu4SSSglKFlv0/rK5QF
Date:   Tue, 5 Apr 2022 08:10:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
        'Git Mailing List' <git@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
Message-ID: <Ykv5dCEv/gl7aHMq@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
        'Git Mailing List' <git@vger.kernel.org>,
        git-packagers@googlegroups.com
References: <034101d84873$993f96f0$cbbec4d0$@nexbridge.com>
 <CAPc5daWSDYSexkSeUUpfYDyT-M_F8d-rSMko5pqw140iLwBc_w@mail.gmail.com>
 <034701d84875$030bfb40$0923f1c0$@nexbridge.com>
 <20220405002610.27sgjva5wfryrcio@carlos-mbp.lan>
 <20220405005418.3s2zayr3dmpxg45q@carlos-mbp.lan>
 <035b01d84899$3cdc5b20$b6951160$@nexbridge.com>
 <20220405042826.56vyilttx3lo4scv@carlos-mbp.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kKNL1QRAZwr1rBOv"
Content-Disposition: inline
In-Reply-To: <20220405042826.56vyilttx3lo4scv@carlos-mbp.lan>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kKNL1QRAZwr1rBOv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-05 at 04:28:26, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> Subject: [PATCH] git-compat-util: really support openssl as a source of e=
ntropy
>=20
> 05cd988dce5 (wrapper: add a helper to generate numbers from a CSPRNG,
> 2022-01-17), configure openssl as the source for entropy in NON-STOP
> but doesn't add the needed header or link options.
>=20
> Since the only system that is configured to use openssl as a source
> of entropy is NON-STOP, add the header unconditionally, and -lcrypto
> to the list of external libraries.
>=20
> An additional change is required to make sure a NO_OPENSSL=3D1 build
> will be able to work as well (tested on Linux with a modified value
> of CSPRNG_METHOD =3D openssl), and the more complex logic that allows
> for compatibility with APPLE_COMMON_CRYPTO or allowing for simpler
> ways to link (without libssl) has been punted for now.

I didn't consider the case that we had NO_OPENSSL=3D1 because it seems a
bit bizarre to say, "No, I don't want OpenSSL=E2=80=94oh, wait, I do want
OpenSSL!"

This patch also didn't seem necessary for me on Linux when I tested, but
of course it might be necessary on some systems, so if it fixes things,
I'm in favour.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--kKNL1QRAZwr1rBOv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYkv5cwAKCRB8DEliiIei
gU3PAQD/EPMCId6lWtS+XLLyU9Zud4xTAwKG3RKHyQvJL+VJRAEAyIHkoVHbdqnz
8jWV/WIeOpWX8hh3TuFeGqSMsQ9dBQI=
=qTLD
-----END PGP SIGNATURE-----

--kKNL1QRAZwr1rBOv--
