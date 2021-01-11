Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E42C433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 00:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610D9229C4
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 00:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbhAKAos (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 19:44:48 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50572 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727036AbhAKAos (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jan 2021 19:44:48 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BED4560DE4;
        Mon, 11 Jan 2021 00:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610325817;
        bh=aeJicUQmapkZbvShHLlYxB3+k2cuEPiczv5SSO3D/O4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xHdYljyM4ddnImQk4+HWnAynKqp78gn8eziC+wQF4YAy1hj/vvt5S9aW4pZYmwWtk
         vwcwOM9eoID3bYwHNmL6MeQODP9yWcO0nAS46J3JIC3Qmx2cZ44dqggwBl+/QNJ0hq
         1FaC4PlnqscmfENDQ42BlP2Qe8WM00i2+0pbnUx4DyUZYiib6u7tWNst69Mc97COO4
         WJ1oaqFJX8GvBLyPKKVYDXUxUDE4vPcU9i1RboIogiLs4jEMSTRAxtib0nS0nUkbva
         pjMmEQUt+eS4B5B+HMtvE2xi/wwHgcRnQsHMNox31JTWl2tK4QCpd6GsGDK3XHG2fD
         EOsb0Palcw9JwOf1pb/S6iMZ4NXLRHPcqta7Wol0pG4SBpdazlGUAHAxwBhHi6n677
         JbeKN2gYnsI8qLtK4Rl76K0Ww4slk/PY2OYd+2dAtY11bB8LVOM4G1I+JUYThklzF6
         k9q1nOYi2MrT6pD7VS7qUa2uhKVTVRPI+o/7El65MMqrhC3k8TR
Date:   Mon, 11 Jan 2021 00:43:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] fixup! commit: ignore additional signatures when
 parsing signed commits
Message-ID: <X/ufMz0Xq2NhFKY0@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
References: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
 <20210111003740.1319996-6-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J+yhliL7u1aPMOwZ"
Content-Disposition: inline
In-Reply-To: <20210111003740.1319996-6-sandals@crustytoothpaste.net>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--J+yhliL7u1aPMOwZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-11 at 00:37:38, brian m. carlson wrote:
> ---
>  commit.c | 1 -
>  1 file changed, 1 deletion(-)
>=20

Please ignore this patch.  I squashed it in, but neglected to clean my
patches directory before sending.  My apologies for the error.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--J+yhliL7u1aPMOwZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX/ufMgAKCRB8DEliiIei
ga+rAP9Yz3VCdt6da1hJiecXENXawLZtDyjyh/FA+rmrU+FlxgEA/B3nH/TTP5nR
P7IpRA6BHXJ2H8hkOiEMWNxLDKIL4g4=
=pBiU
-----END PGP SIGNATURE-----

--J+yhliL7u1aPMOwZ--
