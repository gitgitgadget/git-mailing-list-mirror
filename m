Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948B5C433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B5120720
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Mixo+yUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGJC4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:56:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40498 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726615AbgGJC4R (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:56:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8D41C6048A;
        Fri, 10 Jul 2020 02:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349745;
        bh=iAUSSVZTnv2arp4XaucBMuUmapTeODKCDaiouYUsEJQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Mixo+yUCgKEZJ2/GuZltBUdxmy63QtGku5tvxYlyGXrKK0w3KXXDBjReY/XOBePvh
         1rh+I/O72M4p5VV9HWKYmgRlNW/3gsosu6q5IymOAA/kKoPeyUQOGaTAiDvoF+6RrM
         WAq8jeg7Ioq2SRqp9ZgRfSnBq/QdN5g6EQScxtVMDh2AHGhjFgIxkqVwwPE7/OFLvk
         ObQ7fKIAryjlmftMuSdjDjEw7ZfM1+iFfdUwp6XLsHqzkFGXq9u73qMTQIV4NHwrBc
         mUEc6dER0jDBzpxP+Q7P3Hjny2bFtGHPfyuX/7tZXkoR5ndeOFSIFANg4+z02fO4HN
         dgsoBnACTg5LSlUBjNki/VYCk/Z0c8+6Sl/8V7bwO9DcMPWAMMHKmCnbzYdFXjvF27
         1pPaGe13JS8Se1Z544kYa9F44jRVhooFslBzXnYwLmfJyTtTHR3ZU/wQ5H6fPpQxUe
         V7fQ0Gfg6whiT3uDf7sMYB890JozicOzHxEuZa6eZS/oHOd34un
Date:   Fri, 10 Jul 2020 02:55:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (v2.28.0-rc0)
Message-ID: <20200710025537.GJ9782@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
References: <fcc3f6da-2b6a-239d-c865-64378ba31510@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yhze8HlyfmXt1APY"
Content-Disposition: inline
In-Reply-To: <fcc3f6da-2b6a-239d-c865-64378ba31510@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yhze8HlyfmXt1APY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-10 at 02:12:26, Derrick Stolee wrote:
> brian m. carlson	ac093d07 remote-curl: detect algorithm for dumb HTTP by =
size

I've noticed that I appear several times on this list.  As is probably
apparent, most of this is covered by the SHA-256 work, and will be
covered appropriately by it when run with an appropriate test option.
That won't fix things for 2.28, but it should cover 2.29.

The relevant series has hit my MX, if not the list, and if there are
still additional things outstanding that are uncovered, I'll send
follow-up patches to cover anything left over.
--=20
brian m. carlson: Houston, Texas, US

--yhze8HlyfmXt1APY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXwfYqQAKCRB8DEliiIei
gRyTAQC+JhzCHjVZBcicztKBuv8308hKIBCyTTKceBQxu2+y9AD/dKKPf0lyAlV0
BUbaZEKZ24wHky2nwNYZgFduZ9Qh9ww=
=0r3u
-----END PGP SIGNATURE-----

--yhze8HlyfmXt1APY--
