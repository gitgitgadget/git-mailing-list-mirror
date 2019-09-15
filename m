Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC6421F463
	for <e@80x24.org>; Sun, 15 Sep 2019 22:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfIOWO2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 18:14:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58736 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbfIOWO2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Sep 2019 18:14:28 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:4d4d:a9ce:2c0a:3d66])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CAB206074C;
        Sun, 15 Sep 2019 22:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1568585665;
        bh=9+sy7Jd3LoqBbfzgCRW8sVqwW1ELSB1RkEB/d7mepfc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=PXUzGXGnKV5ZJpf6i8b0qm5jdDCLuHcV5eaiMPQKdCPRgrhbyL4tmMylOj2IDXvXe
         FUzRkxYU24nhzSL0E4Nw3Fb31KmCvGmSiXQ4HNqvSJ83cnUdiEXku2G164Hdvp4s4i
         GuqBArQzFjkE3mqlouTtZeIrwmos+BOqqjS+VK309wLnwuLgPwPavjFlzywQg8I78M
         rqYVQJKoX1kprg5ukxg8UlEtLIu8Y0ctu6xMZmhfHT6fVp5cjQJmqg3sA2xjyR2n+g
         yCUC2Wtfj0j6vsraZicRXRRVatAxFO91TmQGOeRfgF+48aaHkSMvKWU5vDpcZdO35q
         7aIZnsl4sh5pss/cc2MSkNe4/29mZ1MI/+JpOgkZh/vrE+VyJhZuOoGldIObSlOoYT
         LfvJZhKltWUngvEQVKgBB2AsKwUG2khXOtFWFPI0QpZNdovWLauAoEOpnQBbUybdsF
         tdHUyGD6/6pbLaG58pSace0KzQOAlR8Ly+sVCwbmgeFEX59YHoY
Date:   Sun, 15 Sep 2019 22:14:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Documentation: fix build with Asciidoctor 2
Message-ID: <20190915221420.GW11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190914194919.748935-1-sandals@crustytoothpaste.net>
 <20190915095952.GA6190@szeder.dev>
 <20190915212621.GV11334@genre.crustytoothpaste.net>
 <20190915220555.GB6190@szeder.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zqkt5x/gGOIVPcL0"
Content-Disposition: inline
In-Reply-To: <20190915220555.GB6190@szeder.dev>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Zqkt5x/gGOIVPcL0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-15 at 22:05:55, SZEDER G=C3=A1bor wrote:
> On Sun, Sep 15, 2019 at 09:26:21PM +0000, brian m. carlson wrote:
> > > > diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
> > > > index d49089832d..b3e76ef863 100755
> > > > --- a/ci/test-documentation.sh
> > > > +++ b/ci/test-documentation.sh
> > > > @@ -8,6 +8,8 @@
> > > >  filter_log () {
> > > >  	sed -e '/^GIT_VERSION =3D /d' \
> > > >  	    -e '/^    \* new asciidoc flags$/d' \
> > > > +	    -e '/stripped namespace before processing/d' \
> > > > +	    -e '/Attributed.*IDs for element/d' \
> > >=20
> > > I haven't seen this latter message in the CI builds, neither with
> > > Asciidoctor v1.5.8 nor with v2.  Do we really need this filter, then?
> > > Where does this message come from?
> >=20
> > I see it and it definitely fails on my system without it.  It comes from
> > libxslt, which has been patched in Debian to produce deterministic IDs.
> > I suspect we may not have seen it on Ubuntu systems because they are
> > running 16.04, which is likely older than the patch.  If Travis updates
> > to 18.04, we may be more likely to have a problem.
>=20
> Thanks.  Indeed, I kicked off a Travis CI build using their Ubuntu
> 18.04 image, and that "Attributed..." message was there.
>=20
> I think this future-proofing is a good idea, but I also think that
> this should be clarified in the commit message.

I can do that.  I just noticed it failed on my laptop and added it,
assuming it was the stylesheets.  I had to search Google for the output
to find out that it was libxslt.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Zqkt5x/gGOIVPcL0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1+t7wACgkQv1NdgR9S
9ovvow/8CQWgxWXO7VHasorTESJnPPQ/J1EGPfhFymrPMK17ePP4eSY84LNfur2R
QJHN4ErB+eQoRYR2sIf4/q6MWn4AUo0iHGvdiSr2oYdzzYfyp5xu5xXXVxU2eGOk
nlA34Z5yRnAfdJf7X/XTQZaQT6Pe4ydlK0ka/HiWnENk68zzgB/CUHYEgiGzqFRc
jvor9RBo7p+XP0UJjvqyhQcqVwNQTWD25bRh8OnbPjKxwhmodxhSDdMW7ivOHbbU
Bd5BlWiiN82BZGcGSLvV8TuPJrDFp5VPQq3IVK/ovFdxnJQAjcrRU7YGggnCbwH/
rrWP5IWVHdvfXcq37mFv/3a0NkT1sO+iZFx8YVQ1NEoJixDFwpwRQHqKwmim4QqD
m7fOD7gzjOYggXm5eF8h+IP6aDC2zVLSxHT2ZZ7rvEBMI6+e/OBAgWSl/ZZ22pVN
ato237yxTUcjRhhBb/U6ZaJI5CvlzwThcSlt8l44K1L8mVh2lRmSFcYUDFOG1ieO
i0s5fZhKshR3z6FZ+bcGGIcM93NDMeqDXK612tiWFO7NE5Qap906s/TYDKAT0iIj
nYuQl4JQekCsmTU6h+x4J+9Y8s343Im7SiPZ9hF2So9xDk2pr7Jc/CCOZp5OOELt
KY8hC2kwG/BnLTV9n/xpj8oD54xUQH8yeGmfdFCxRy7mFWypY8k=
=1BmI
-----END PGP SIGNATURE-----

--Zqkt5x/gGOIVPcL0--
