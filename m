Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1953D1F915
	for <e@80x24.org>; Sat, 14 Jul 2018 21:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeGNV3r (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 17:29:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58174 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729637AbeGNV3r (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Jul 2018 17:29:47 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5D4DE6047B;
        Sat, 14 Jul 2018 21:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531602562;
        bh=Q4DPRs/rqaZFeUXgJvvVN8tMRalzXJBE76EOokZTQcI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OCL9l1Ip/Pc6ogMi7B42dPJlhg1ZZ6jf9S4vipNLy2uwU4qIYoCCGf/4zcmZgsuwX
         5sFUljWGv8eRJYnc6ttz9Mg98FwHOYvw/wbXXEIX46bTObXGBcFlF+4KczifOSZ09j
         8iNB4tOSNE7yx35knTsEnruldkJClOudb0SHsVB36JHz9YoA6WASEjz+GRfGYpBMwy
         dbEqCi39BqEpEBh8tiWrB4d7h9pQy0EZTz3WOLDRYbIFE5+2y2Hpzpd1Bo6eLsZrfB
         KcU+Q7UuoSxm5DG52+BZNsMIl98Kx7wX+UyWEcG0O/sgiZmWsb2MBFj48pIQzYbou8
         E7l0mlb+piBAEWkKa7dur/wPK6Zf7l/GfBJykdksbSWP3Ml5WzFm7EeOYOMsssPpq0
         8yj9BJT5sYIdC2QEuEJNnuLGHT5loqWmUhO+AZcw6jyiV2LjWn0k6dPCHYiuVqBVP8
         PCuKTKMozUBrN7HWK7zRnIVsFrWzpsdntXaFDUdqXc7oQJFcS/Y
Date:   Sat, 14 Jul 2018 21:09:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Vitali Lovich <vlovich@gmail.com>
Subject: Re: [PATCH] sequencer: pass absolute GIT_WORK_TREE to exec commands
Message-ID: <20180714210917.GI1042117@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Vitali Lovich <vlovich@gmail.com>
References: <20180713230548.GC1042117@genre.crustytoothpaste.net>
 <20180714003505.67650-1-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1807142304340.75@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3eH4Qcq5fItR5cpy"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1807142304340.75@tvgsbejvaqbjf.bet>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3eH4Qcq5fItR5cpy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 14, 2018 at 11:05:34PM +0200, Johannes Schindelin wrote:
> Hi Brian,
>=20
> On Sat, 14 Jul 2018, brian m. carlson wrote:
> > Dscho, is this test going to cause a problem on Windows with the forward
> > slash in the grep statement?
>=20
> It passes on Windows. The reason is that you are asking *Git* for a path,
> and Git will always try to use forward slashes (which work on Windows
> under most circumstances).

Great, thanks.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--3eH4Qcq5fItR5cpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltKZnwACgkQv1NdgR9S
9osA1Q//Q2q9uQzQwtCcP9Ha3ncq92xwlVRPJzzesqIsgzPBAAM19/dxog9TuFos
eizXWmSCb7pYZ6ZLAUCxhb01AheYel81yUQJnM9wpLTJSsLm1CH7JjvLvMbH2xGe
e7lqygYiNT8J5p7STlm8kHiisD8wVFPx9QnrJRPVaWKY3bws2aRzDhAYI5kgQSFq
OMqX02zYSgZkpqcYgexNDmvnuvDDgNHFZ9GBnID/UwA0B47itON1dbfboIAE1bDa
g0lCH7Do0KGyYhtWUi5X1IZ+prYxEgoVK3x0P+o6gdkYEljIX/syONatg+Y7VHbp
99CVJzvBMU5kXzMYi+fPS33TRas7KvEJy6lMot6RTXmnCqseZxxbndc4xI09r1kN
s4CeI81RMI5P17cUsO73CRGzrsG6WjIWr3ZZrLniJ7DfOJLLW2Zc3sjq+uHaIUPg
8xum+blofeFSRfCKWhsKSPej4zVKqhQ20x0XyCrrjxXLVXdj484YOJfNeRbMYzLA
jN70e212gxqDx/xDdpuTajMR5inqEJqw48pqF32RNtOeDoovyki378ZAMN7tkIf/
GVEd4MB9NUITW6E5hYZ0EKO80FjRiOxHrs9ugIL8nL3vakFL2XaxSqkpW7lPa91b
Jdgws62PQ0UmF1t+Bf5cnjoI60LnUUZNiRxKRiEtikE87yZ+k4s=
=NN1j
-----END PGP SIGNATURE-----

--3eH4Qcq5fItR5cpy--
