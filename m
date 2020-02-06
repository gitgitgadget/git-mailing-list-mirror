Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD79C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 23:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D722821775
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 23:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="u+f3ZRdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgBFXcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 18:32:03 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55442 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbgBFXcD (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 18:32:03 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3B69060456;
        Thu,  6 Feb 2020 23:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581031922;
        bh=t8RiE3nnbZwXNgk781bffmw/lCMa5ZCPiDW817aKrkg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=u+f3ZRdLUSpIbffLqCHI58QHd5y2UqcNTjrcwX6+sWAiWrZnEU85jdfxNHCaroX8M
         pcNum4B03AFiZPFxgsFrosxIApFABURvwvrsRHIFTwHzicXPbMOcAsRwjw/AUEMPJT
         06Qy4hIAitCmSnfmlde2f7/sBXKfAi8v8GtSCWvysCE//pXp8WpiPVa3OSra6Yc2RS
         n5lrkL5ZIRkscXxo5kSZJ4KTUDtl9HxPZo1G0k60yfJy1AWOHxo6Kz/y5Mc4+vPgEC
         fcWkyjM2Gl++QTlHttMeVcCUYvCwQB6XMcgi42pgCDPQsUYwxB5zFkw+4PCkT+xAW/
         f4Dedpt6i3BcRLcqkjWRRfuAJJ/PDpcoTNyVoy9zbfL+N9uARF/xPUh/6EJawg1A9k
         Go0CcsUYjmxcMEMIB+a8WqwsNWD6dfF1EyZaShrlmK7ZrTUlXn1KHTej3wA/FLhdFL
         ATklhSGRHS3smhRN9uo3kOxFjp0a0VDSdEAwJ58r72lQADgqa8y
Date:   Thu, 6 Feb 2020 23:31:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v4 0/5] Reftable support git-core
Message-ID: <20200206233156.GD6573@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
 <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
In-Reply-To: <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-06 at 22:55:51, Han-Wen Nienhuys via GitGitGadget wrote:
> This adds the reftable library, and hooks it up as a ref backend.
>=20
> At this point, I am mainly interested in feedback on the spots marked with
> XXX in the Git source code.
>=20
> v3
>=20
>  * passes gitgitgadget CI.

It's interesting you should say that, because one thing I'm missing here
is some tests.  Since SHA-256 support is rapidly coming to Git, I'd like
to make sure that this series works with SHA-256 repositories, but I
can't do that if there are no tests.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl48oewACgkQv1NdgR9S
9ou/oRAAqBLP4w32nHFNVuv6HBfsyEbVuS+vYsSg6KHpm8BmQfbN1rDVc38kQFa1
5LHrcPqVKbYbLpSnTt06fJtJOw5TKT7AXExvhICWeng3p1H0LlvGZYsnjrqXLOYE
UYEclS2q3SgPdGDDmtcbSTiS6nIVC8uY4Hx5//jIqKXzCnjhBHF/GNG7Y/fYlP2g
sqlQVyvcPxnSIVNSr7mvQJtn4aG3hTCJcSUgVoqIPq4I6Liz2HV04msilRn/rsew
3g1k6sKfSEbybVmm5MzK50cGDXseFTg5uGbHeWYArsiIGrbXLwKLg+QjkedVy88e
tishpFnrSsGVKkvPJlg40PAafjlDHdiFLvpBIiLYc3nem3hm4CasWWqvlJWYe0CX
pbwTnalPHk5LnCHY82xtB3/KqCjyJFcuBupVh5geHSBSEGLNl21OepjYj8tP90PB
WnrpHfr8PpizaYe34lRKZMGTXhVRpeWoW0qNM4Mdyux01YxL4oGuT4lWgvuU7j8T
Xr0GmtpQX9nWhzs4YGNReoaYwvQ6kY4NDn/V+BNFewdghCZSN8rSqOzrQ+uRP8+E
z9ku8cH07eWqY5+ZwbR356UVFuOe5WSZyxeyxf2zv3Q9uq0R2zhkxKhcuSj0rRye
KHsTnW51RtHahx2MC0abShnsPANIlIFvjRicCAzQG3iPjbuSIik=
=18p0
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--
