Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06B5C07E9A
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 00:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF2B6115B
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 00:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhGMAN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 20:13:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39540 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230099AbhGMANZ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Jul 2021 20:13:25 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E5D006044E;
        Tue, 13 Jul 2021 00:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1626135036;
        bh=sPUwMKZOer6PkycXijnLUo62WTNYX1Qm55wGHVBzj1w=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=B0TRPPF/P9cuhenMHgZhjbcjtM/XtNinRdx7zTBGa20CO8vv33kfQE9YiptZVluN/
         ccVy+gNLNIvqs8GO4eifT1q6fwR0rwn/7LeVC1LTCWpm9P9b+DVgUsOaCnhuXc48pz
         FPXXQ4UAT/HWuWAE3EhrC+v10Z5z9/nJ+5mk1ldXUPeRcMDcjDEGZU/eSn+ICDz8+9
         BLEktIObrz4QQSe8iNRqe3Wd9YCYNT+oHtVg51+T16HcKQm5iZHWp19mJ2+hX5IAPN
         0kj1G2GbdACvHyi6gG4oDJcjn6+eN1OXIngm8fgh2Xv10cDd/+9rXXzktRV4vOITgb
         rBNoO4CIoeMlsBSaPZg8+uvCJhPIwItgUnv0bTlVQKsDEzzIo2tSS9ruDEDqKRsDfq
         evhtWwu8vn/S1xY9d4p9lOajFPwYWgmgfmLbsSQR5B3FEgGZkOCOTaVYXXAHJArrhQ
         mhB3oYGQ6L/TaMoPzUwcxLHPlCSX+1JNghuzYA3TPeGjBQS6wtn
Date:   Tue, 13 Jul 2021 00:10:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] rev-list: add option for --pretty=format without
 header
Message-ID: <YOzZ9Zzv+NJu7Wo8@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
References: <20210706224321.14371-1-sandals@crustytoothpaste.net>
 <20210711215510.191626-1-sandals@crustytoothpaste.net>
 <CAP8UFD2BVba_vsXaTPkXgYDGg28xApoyDrrT2fdTddvM1_3CiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pxkkNHJEzz6ckKS5"
Content-Disposition: inline
In-Reply-To: <CAP8UFD2BVba_vsXaTPkXgYDGg28xApoyDrrT2fdTddvM1_3CiA@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pxkkNHJEzz6ckKS5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-07-12 at 07:30:33, Christian Couder wrote:
> Usually we use "option" instead of "argument" for the flags starting
> with "-" or "--" before the required parameter. For example:
>=20
> $ git rev-list -h
> usage: git rev-list [OPTION] <commit-id>... [ -- paths... ]
> ...
>=20
> (Yeah, I agree that [OPTION] is not very consistent with what other
> commands show, which is usually "[<options>]".)

I can do that rename.

> test_pretty() accepts options like --no-commit-header, but it's only
> used without any option. So I wonder if you forgot to add a few tests
> with some options.

I originally intended to add some, but decided to remove them because
the --abbrev tests fit better elsewhere.  I'll remove the options.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--pxkkNHJEzz6ckKS5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYOzZ9AAKCRB8DEliiIei
gdHwAQDnNZDiLCN9U61/5hZeCg6eaGS7Vppivu3pNymWNtMC9wEA6Chla+7n+Bat
313kCJX7pzoG6OXYbj7+bplOGNkPIQA=
=alXh
-----END PGP SIGNATURE-----

--pxkkNHJEzz6ckKS5--
