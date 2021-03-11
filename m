Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3A5C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 01:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F6064DE4
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 01:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCKBzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 20:55:21 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38122 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229467AbhCKBzL (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Mar 2021 20:55:11 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9C4156049C;
        Thu, 11 Mar 2021 01:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1615427711;
        bh=g5bempo3ydOdYyr9cXyA3psCVtWRCXWxrVFsdkIIoeY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vpgW/MvViTnUn0hPxl2mAvx85pCszlEc+0IcHvnTARb4s1BmzYihgANd9pOgRYqme
         sy9yF4fe00ukGw4oUTOyU6iffZe6l+29l7udJaE5psQtIv8QLyusSY4/i2RFaHKf1G
         qoQpzTaoPyzEkc1m1HbxdEqzvJop6BwiaekbG+ihNKCdkOQ7GmGLyvJnw5CxOpQOrt
         ZuVVBMODzPOt3sPJK6aGtBvsCyTnPvCvvPnvIPfd7KeBxhQt04B8y0yy1Ewu1FyIin
         y4LapMaNxMoyXQ9vNL3FvkfA5fR+OCe9z1g0i7fxjbqeBGmB9n1aF/wR5/YyhposVa
         rPdyYDdSwG3wqmIq9crjATeN+yIvrBoTXZPq1pDGdaDgo3441JeDN5bIP8RDpKHXYu
         8aJc/yVAHJChCeXvQ7KnCoE1UwMRLdq55rM+H202Twr/77GMN09kTlshfumQaqxdXX
         9KC4xNRvvb5fxlF5cbKBqBaBoHzp7Os0cgu0iLyMV489QNzlhSV
Date:   Thu, 11 Mar 2021 01:55:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/3] t7003: test ref rewriting explicitly
Message-ID: <YEl4eAR+rsayCpfT@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
References: <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
 <YEj8x5fQl1fyLGNg@coredump.intra.peff.net>
 <87wnueh7nu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LMUJkzaoudKzwQIg"
Content-Disposition: inline
In-Reply-To: <87wnueh7nu.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LMUJkzaoudKzwQIg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-11 at 00:10:29, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Wed, Mar 10 2021, Jeff King wrote:
>=20
>=20
> I've read it all over, looks good to me.
>=20
> > Note these all pass currently, but the latter two will fail when run
> > with GIT_TEST_DEFAULT_HASH=3Dsha256.
>=20
> I don't know if anyone relies on that. Probably fine to have this as-is.

Our CI runs that way, and I always use that mode.  Are you saying that
these will always fail in that mode, or that they will pass at the end
of the series?
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--LMUJkzaoudKzwQIg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYEl4eAAKCRB8DEliiIei
gZHGAQDx8tSQAPBYj8sva/x+GFLVJgi4kxYyeBymlErBxYuuuAEA+EcPV93XUTKw
XCmbLLN6ycjDeXgckRedJAovEVmtggg=
=MqMW
-----END PGP SIGNATURE-----

--LMUJkzaoudKzwQIg--
