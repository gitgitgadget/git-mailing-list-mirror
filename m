Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68373C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 23:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FFE32065C
	for <git@archiver.kernel.org>; Fri, 15 May 2020 23:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AeCZdnO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEOXcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 19:32:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38386 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgEOXcG (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 19:32:06 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B4BD460443;
        Fri, 15 May 2020 23:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589585495;
        bh=w63G212bCopxQ1N3oLnxQeF23Lpy/LMe1XyYT0jk4G8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=AeCZdnO8u9st9TXtD5usDfvwgrrnL28aLkjPR4xAw4cPi9Rxckkm1SSV8RXWkYYq/
         oVOdSoL/TcZJaFmn0BYWmPoyN6mRweD2lgIc6RjQCig/eAuBVW9JI8WtR6Qy3qWRdi
         22KCVGRoUhioUYR2PKORG45sGi64LeMsABOYuWYpV6gtDRrbsHTv4BdYYMzy4zeQsY
         mWwQTXOXwmGAcTZsVsOuNMy7YXYC6RSvsPy1Or6pKqWnYYy4+Vn9M0IPJfanKrnxnD
         WP2esUWhiVSyhfrDLMF91sa72TSdh35ol/HeFAXpr/0XE2RGL+1mKbCj+x0nXr17Xt
         4eHm/GjiX95VSKxNUe5GmTVTgA3OIitcS0+u07BVY92l8pb3BfOlcCsLO49ae/3XwL
         ErTIplVJ8jn2+/Klfzy1zVhX26iO3tKkCWNOyalTSg1IIKh7PTAO+yqVdqdsqmUg7g
         J127yKg4jOh43kno23cQy5+7n3nwMTFxM5lurjGSKINFkh8zcQd
Date:   Fri, 15 May 2020 23:31:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Laurent Arnoud <laurent@spkdev.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff: add config option relative
Message-ID: <20200515233130.GC6362@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Laurent Arnoud <laurent@spkdev.net>, git@vger.kernel.org
References: <20200515155706.GA1165062@spk-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <20200515155706.GA1165062@spk-laptop>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-15 at 15:57:06, Laurent Arnoud wrote:
> The `diff.relative` boolean option set to `true` to show only changes on =
the
> current directory and show relative pathnames.

Usually when we implement configuration settings like this, we implement
an option value, such as --no-relative, so that users or scripting tools
can disable this feature if they need to.  However, I don't see that in
this series.  Would adding such a feature be possible?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXr8mUgAKCRB8DEliiIei
gTnGAP42l/QWlZxzhPum/+TVV0xnp7SqDb1apZs43k0a6i0GBAD+LEGuc+b+Qou5
FkqGX6/nyyQKXMoKfEaJZfzcvEhnTQU=
=eoMo
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
