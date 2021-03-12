Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E3FC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 21:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D08664F2A
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 21:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbhCLVFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 16:05:01 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39254 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234960AbhCLVEe (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 12 Mar 2021 16:04:34 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3920D6048E;
        Fri, 12 Mar 2021 21:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1615583043;
        bh=Wku73K0awNyHqVTp6h+VG3obx5btSxSedDg5Fo+X6+E=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=O/zA5FvIIpNd9zmP3kTtzMQhjkUwCR8q1jpApBMT+KuqX133X8qMfiRHGZLTzfWsX
         UJ0WmhNCOCZjX3wCBfpasWPqOn4Q2zPG3hwXC/ME+1+Ddmnne1WMWORIcI51Yzva6n
         WVzgV7L2eIqquYGYMtBz9BPW2x9igCo7t3mBTtIeZ6VawRB+sIkImSRqo9heKrOOwE
         dkOmRHzv41qkf6neh39PS/1ne9eX/0tWE6dVT4QjNxS7VEOXNEChIpvDl/jX6m+ojE
         zFH1pnRHY2CbpN02GuS6w1pynF8XqXj3QMkTx6Ir3sA2mlyGZ9b8JUlHO2pff/HCGY
         gGmw5IGfZdh/Tms/P8CP9MdO2M8ZXA5uN/rHaTXYUPOJt+2hZf0sOTd3Bow5LMzhbj
         wGtQqKtGXAUF0ZrAvh8tKf0N/dzqaoD14I3gjpQ8/Di2MKvicDnzEYDpeNo9SYBseW
         OB0bJivrYyBcJO4ixrtFKdrHIjbI+eB5rDAqF3TG5FI5uqTw+eM
Date:   Fri, 12 Mar 2021 21:03:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     John Szakmeister <john@szakmeister.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2]  http: store credential when PKI auth is used
Message-ID: <YEvXPIYbXeTvWhRz@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Junio <gitster@pobox.com>
References: <20210312024027.33418-1-john@szakmeister.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pgsoQosHP3RJsnz3"
Content-Disposition: inline
In-Reply-To: <20210312024027.33418-1-john@szakmeister.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pgsoQosHP3RJsnz3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-12 at 02:40:25, John Szakmeister wrote:
> Essentially the same, but rejecting the correcting credential this time.
>=20
> John Szakmeister (2):
>   http: store credential when PKI auth is used
>   http: drop the check for an empty proxy password before approving
>=20
>  http.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

I looked and this seems sensible.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--pgsoQosHP3RJsnz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYEvXOwAKCRB8DEliiIei
gY8fAP9SJUzGy/7mMe6Xe/JbFZDgbNLV48dRKee5BvkwNwf/2gEA5nRjZSUbFYQ4
wcJ3zpE2M+rLyrFpLCuDWrISzl1G8g0=
=KBBk
-----END PGP SIGNATURE-----

--pgsoQosHP3RJsnz3--
