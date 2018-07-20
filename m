Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EB9A1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 22:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbeGTXFn (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 19:05:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33882 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728459AbeGTXFn (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Jul 2018 19:05:43 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f1fc:eee3:60de:bdd8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6149560734;
        Fri, 20 Jul 2018 22:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532124928;
        bh=mta26nbC4T75e+flgZXkJCdIhzBaLVF3lY/279Nw/qk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Y2sEPSTo4ZVh46taLgJOYOIQuBj6kUQyJsxEy7Mb34dHfGNhE0V8YQuGkj55jqtYV
         2HhjJTWtUy5fP/wubzO2NQECLdjBQs6hbUAdEpaKNL/CaQG+oj65k+GgmXa2ILVwaF
         lJT53lzmbNnmznChOlS3bGTzKq/BTx244GTHEaKjVqZakQJWBiEAvcibvZ32w1VkGi
         Zmd/8enkhub1q9xjHAQVMXFdiXG8+i4L5vUSdQyO+DfL9vvT6HhNvG15rWe14gl6Fm
         qDbmOagX8o7/VQYneJZfH6UK9uZo0GQA8meAjCq8fYeSsPt4evQs2OPLSFi3WLJKaS
         b5mpRstlOzB6NAQ5K6R+X3iNM1fZeWl6M6jCY1cFBKWYWfbPFW36nNSd4lzfGvz2hs
         q9FFWlrEomRKMvMZ0eAiwQphBnFyattwjkmepVTj5WiTuv25cD5kgI+wJU3ITHrmfa
         tUk9fjHAt0dj2bxqNY98+r83/i08z6kZRNDMq9B1FM3kvO/lc3m
Date:   Fri, 20 Jul 2018 22:15:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v4 03/23] multi-pack-index: add builtin
Message-ID: <20180720221522.GD18502@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
 <20180712193940.21065-4-dstolee@microsoft.com>
 <xmqqva99bwdw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline
In-Reply-To: <xmqqva99bwdw.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 20, 2018 at 11:22:03AM -0700, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>=20
> > diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git=
-multi-pack-index.txt
> > new file mode 100644
> > index 0000000000..ec9982cbfc
> > --- /dev/null
> > +++ b/Documentation/git-multi-pack-index.txt
> > @@ -0,0 +1,36 @@
> > +git-multi-pack-index(1)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Isn't this underline too short by one column?  My copy of AsciiDoc
> seems to be OK with it, but do other versions and reimplementations
> groke this fine?

I believe AsciiDoc allows a two-character grace (either longer or
shorter) and Asciidoctor allows one.  So this should work both places
(although I haven't tested).

It might be nice to fix if a re-roll is needed, but it should be
functional as-is.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltSXvoACgkQv1NdgR9S
9otqgw/+IY2DGXURkgL3Xl85gYQleffJn9vmixEzeowHo1I6Rp+tzVMbjADgC4P0
sU/3rGKGSoGcU9U0GmvyJw5L3PdsSCtdpCi7GlY+QXCalu4s50n3yOvQqs1GdtG/
ya+vvwrtZ4AjZE/s5AYauoD57bfWP29NpQwfS/jJl+v/CwMxCfyYKEoCx2cPVr7A
2ApiItmTC2pnURU7jdDfESrU9jecte30DswnE7ErdxgKk3IG7xyc7xNs+N46IvJ/
vfT++5bv+EpaxRDbp6/haDkPaJQ6v1W+REHOfEJ8yjBM8X3xRoIYT++grUI1YIK/
us3bQy4pcljWTyoNZ0hb6p5BFFC7/iP5G0hRTSi51AL3BdXKntijjWbKdliVDQoi
Ulk0HzXEOb4LW8SzGBVjBA98leieI/ZmE6ROxj0dJjPxDM8mNvSpBhGLLBU+Xoia
JHPjH6TKwnXf/nBlVXWNcocXGlaa1eTitBo6aRmRUjNFDsfKHNM+slYoDxwJuRxh
lI+b2G9BNW+oje0KLl5dE5Lvm3i47FqlZv1Uq/ju1AcnEky2tCj+M1pUo5ADT317
6e69hcv+hu4v/x8UM4RLp4irbjF4+osTeBrQ2cQ9KFxQKPHsLPnX5/SxgV+qyNGG
unDHQGjcv5sG5bdk3vV4uL/QH8RVtD8iyT4uIEk9adFQYsLo1GA=
=sWsk
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
