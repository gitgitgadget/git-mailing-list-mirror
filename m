Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ADFE1F97E
	for <e@80x24.org>; Fri, 26 Jul 2019 07:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfGZHwR (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 03:52:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57106 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725864AbfGZHwR (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jul 2019 03:52:17 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 503146081D;
        Fri, 26 Jul 2019 07:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1564127535;
        bh=STeU2w5KdyVqELvFrvTA9r7bTXwQIW4DoYL6gNAlvAM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=PdWRm0aehqwad/2PJwiSiDpfm7D/FW84P1+hei545DK9sMOiOM3uOxXoenvNRxE3y
         dOnhv35IKDAW+hU2PvAyA92a+Op6k/nvpSot7/tnHnJeVTOUTYB31hDTvQIAJNRUbt
         ndTjYfpcV52mXVMb3QrqTuINDkZOmND5/1+uRh6x2uQSdFmRqJ2Ky0A+g9QKuhaTJG
         7KDZrJWpqDpe77ZY5ElebVaK3jE905UP4ieRp6AaZz8QfnBBcTPywr9ybFC9ym3zXC
         WrMMOUVbWJE3WD5tt2EZO/bW5lreTX5l6QyD1JUR6XLf1uAx+guWPGVw1CQpPNDi2r
         3LPC6MxeAUI8ittK2xrU5QW6T8hLnkrk54cMIrAuI0Zy3je9rTNQ2neIiBhsx3J9eS
         eLQcE7ok1Dt+sGjN+2dFKbh7r2t+pbEbE2TzGSncxx02dEnSSfXGUurjVf3lAPggBG
         bI2PBDbIw5nMxFLmBVSapXK6yCEQ84VZN4rYJezGI9ZleuXWymu
Date:   Fri, 26 Jul 2019 07:52:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/12] rebase -r: support merge strategies other than
 recursive
Message-ID: <20190726075210.GE9319@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.294.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Content-Disposition: inline
In-Reply-To: <pull.294.git.gitgitgadget@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.0.0-trunk-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-25 at 10:11:14, Johannes Schindelin via GitGitGadget wrote:
> This is the most notable shortcoming that --rebase-merges has, still,
> relative to --preserve-merges' capabilities: it does not support passing
> custom merge strategies or custom merge strategy options.
>=20
> Let's fix this.

This looks like a great improvement. I'm glad to see --rebase-merges
gaining feature parity with --preserve-merges.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl06sSoACgkQv1NdgR9S
9osUYw/9EOvg+dicnoVQG4ANerpk7fDzO64a5Chjcg2sPk4zMKIuBa1E++4OL3qp
xOX6nO+EcbziG1Z1BZ1beU5zA9kJmxWvLEXTZB+bY6tKwWcsWEmv8Vr/VQp1GlHo
wIjO2zdMeAwc7zO5YW6wWKa9U+/Mw2tXBo5TMkK2DGKAR9NN1gZxV43GpT1mqioP
rwMK/bDFF+3bskJQNUlpunJGJX9HtIL+yS6PA4dZ6uFOsDxkE6kT0QHFQoD9JkWx
dVbJgh8JTtZC8GzhMDbWmddVhTH34KEWfHtSGxbBtlFUCpO/VOiqQOWWrm8FlPU4
ZhwEjy1Mbi4rpAE0f7Y7TRd4vJjApRAjXhvB4wCljRujoqb/9iIt3TpL1muR5Kqb
9aNSqzExpmXAp+WPZcXhHnBV/qs3qA9RAHM1qk1EfXtb/Ukck3hZ4O7vkzcwnvxt
WyTe+/5MIdqxwaXiDLzv1+nYR8fu/YJJP6GyOmtJaCz5ZDVizXujX/zItOZvY6iz
x1BhbZQdeSzclCosd4sQUNX+yALu/QwQnp8PKQU3u17NvC1It9Gh3kcprlmR/16r
IRTtE8/Ilv0psl+oyRMQRvQ9XBWuhs/a/IjmLRx1j82VT6WsF1KzX3HOQRSkv7Sh
dYZwpNJJVqSPP2ft31ZrpItqACgihzspC3hK1lyxG53xygP7A+o=
=Tvu1
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--
