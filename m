Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98A6C433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C000C20732
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KkrF3Wke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbgFVVKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:10:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40096 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728378AbgFVVKB (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 17:10:01 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 452BB60436;
        Mon, 22 Jun 2020 21:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592860200;
        bh=1BZrCktvsZZK7zmUk4vn6M/8/Zc72FpMeWXSWTkEsCY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KkrF3Wkeheri3xebdpzA46q4ZQ0LWpSzAweXLCYPGy7jpAiN+y+jCNJRYU2b1PB9d
         y/YuhF/Azw09Rynv3lg7qM+LwWVh8J/Wlc+WXrovXIjsasK49CU2cTuC0R5FEl0pn4
         EfNGxK8tNDhZde972frSPqrHVB7GEu0SwugJ8QVo2pnuDUiQZJQbeV7gABAm61GI5u
         WUxwIC5J6R0+qry6Na60FEQ1PZ7xa9kXiVcvNfDHRFbnCKU/2SQhH5G0zX8WJB5pmP
         l82s2VGglVXnyQHiHtALQuMmoekDP7py9MyJqgwQjrUnACETSIEd9MmIQgErB6Ff3Y
         bervu4by8IXz+RSKwd5a9aOA4xtXqdtoP3gI7qBGlwChLjmh7xhDSAw1FV8MJi0k+3
         3Bv6nT/o/OBg+317uDd+51VSoIKMXdrvw+AXPaUKOpdbl7KrefzqnUgHmrAZSuKmib
         jXQDtWq1WtQHeEeE3Q7WPPP2wyje96OHHF3MefeH5HrrqLuxf1F
Date:   Mon, 22 Jun 2020 21:09:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michael Ward <mward@smartsoftwareinc.com>
Cc:     git@vger.kernel.org
Subject: Re: Git 2 force commits but Git 1 doesn't
Message-ID: <20200622210953.GQ6531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Ward <mward@smartsoftwareinc.com>, git@vger.kernel.org
References: <dea24348-770c-1228-115d-23153fbecebd@smartsoftwareinc.com>
 <20200622202122.GO6531@camp.crustytoothpaste.net>
 <a42d038f-bf14-8f1a-927e-7488796e7710@smartsoftwareinc.com>
 <20200622204346.GP6531@camp.crustytoothpaste.net>
 <8ad16219-2426-6127-b41d-bb3007a9b993@smartsoftwareinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SlnaBQtdWG0gYnqZ"
Content-Disposition: inline
In-Reply-To: <8ad16219-2426-6127-b41d-bb3007a9b993@smartsoftwareinc.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SlnaBQtdWG0gYnqZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-22 at 20:52:50, Michael Ward wrote:
> Using the steps from my original email for how I had the repository set up
> (any user authentication scheme works), clone 2 copies from that reposito=
ry
> (call them A and B). Make, commit, and push a change in A. Then make,
> commit, and push a change in B (without first pulling). With the 1.8 clie=
nt,
> B will prompt that you're out of date and need to update. With the 2.26
> client, B's commit will be pushed and be forced.

I think we're going to need a more specific set of reproduction steps,
because adding the following to t5540 succeeds (starting on branch
"dev"):

test_expect_success 'non-force push fails if not up to date' '
	git push origin dev &&
	git reset --hard HEAD^ &&
	: >path3 &&
	git add path3 &&
	test_tick &&
	git commit -m dev &&
	test_must_fail git push origin dev &&
	git push origin +dev
'

That means that this is working in at least some cases.  If you're still
seeing this, can you provide a set of commands (e.g., a shell script) to
initialize and create a new repository that triggers this, provided that
"origin" refers to a suitable remote?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--SlnaBQtdWG0gYnqZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXvEeIQAKCRB8DEliiIei
gWJEAP9yMzdlBVTCTjayF87wlVirbufi80yykniyFrQdONZCzAD/ZEmcTjpPtMzf
ILWQYP6zTLyEdcWmcnzfHRSv39/B7Qs=
=UBJI
-----END PGP SIGNATURE-----

--SlnaBQtdWG0gYnqZ--
