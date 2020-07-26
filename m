Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E146FC433E4
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16C52070B
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="e/SNX19U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgGZXll (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 19:41:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40812 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbgGZXll (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 19:41:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3D824607A2;
        Sun, 26 Jul 2020 23:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595806900;
        bh=Z/VkdLsj4oixw7BT8+m+UUQcNDKcANEmbTfl3SMRMIA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=e/SNX19UFVFr5CodnLHujy4VtkjQiO2h03ct7pZXG7eIzoI3kXOa7VK9+qUG5xE5G
         BGTEYnFDR9SbzgRA1+PzR1m8oRRLv49dX4T2xRrHyPYBKTWW7WMFiLyj3M7FxA0AUJ
         4DciVrI2U+/jmHMYNBcN5UhA7MSqye5hPYrw6XTiOrk8O7kJHW9X9S+eTtCmgAZoTZ
         +j3V/Z/nCkxlr8JMFlt9X3Vvr1jvZYvaZCQtrc3yKXb7Xyq+qatZ51ETZ1VWs18pvW
         alF0nnvT/sqcIG4amQQnI8covirgWH0mRqUaGQzJSrlwPRD2Mkp5wKz1qwdIyE+9LX
         CAi5vIfc5CE5IQnnXLDgVdlROsw+JFW0iCyrt7EdHkexxh9jYDZrXaf3zWPIZuU3i9
         AbUzHopXc7V3xSc1+tHUZAHnKrHFIzLR3SJWH5wW5fDoBUwYl8G5N6QSlyWnTtLtJX
         /J1QOYV7qqRFak5NjeqxZqyJhXosOi7vRJzKtIvpNWT18x9V9Mu
Date:   Sun, 26 Jul 2020 23:41:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v4 32/39] setup: add support for reading
 extensions.objectformat
Message-ID: <20200726234135.GE6540@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
 <20200726195424.626969-33-sandals@crustytoothpaste.net>
 <CAPig+cSaqwwtOitm3_3kF+q9TaputNAnz78qBb-7PfrZcqUDVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Content-Disposition: inline
In-Reply-To: <CAPig+cSaqwwtOitm3_3kF+q9TaputNAnz78qBb-7PfrZcqUDVg@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-26 at 23:34:23, Eric Sunshine wrote:
> Not necessarily worth a re-roll, but this error message could be more
> helpful by providing additional context:
>=20
>     return error("invalid value for extensions.objectFormat: %s", value);
>=20
> Notice I also capitalized "Format" since this is a user-facing message.
>=20
> Also, should this message be localizable _(...)?

This message is actually going away and Junio's merge into seen removes
it entirely in favor of Peff's solution.  So I'm going to leave it as it
is to improve conflict resolution since it won't live much longer than
this specific series, and may not even live that long depending on the
release and when Peff's series gets merged in.
--=20
brian m. carlson: Houston, Texas, US

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXx4UrwAKCRB8DEliiIei
gYLMAQCVwfb8Q2T42Gm/kCc8lubmQwbEI8eJJWSefiKa3Qxq+QD+Mq22NYTRBW4g
pLawilD9HkPiPs5ELeqD3Iwr424BMgI=
=pgxo
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--
