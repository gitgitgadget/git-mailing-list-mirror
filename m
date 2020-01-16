Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9E7C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 23:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D0C2072B
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 23:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HgmEXzIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391678AbgAPXfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:35:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40384 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391677AbgAPXfN (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Jan 2020 18:35:13 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4AD5E607F5;
        Thu, 16 Jan 2020 23:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579217712;
        bh=c//h4nqFUNHC0tZ9ugplBR2US3br0k68CgUd0OQm+8c=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HgmEXzIaXKDeHZJzaen1nGk+9P2KMIcXstgiv6KEmU52xhNeuc+3APk2oqs+piw/C
         oBIwGD1OA9JCokCp+FJ6FwDuh4JN0d1JjI/p8phNmE0QR7xhcO8rA3IHzGFgg7E4D1
         GNr8HpROd3AF9anfCeKYqsvQ+GE/7Bzb4RcG0W7l8oYdGUrf4sawiMTBJNlARPfxSV
         1VqNS71JkLyy1NnJK7WqLVcYZe1eSLVnOi/YIk6uD7MYLu2No2Mv3Qj1QeReJSqA0D
         PNm7k3iYvRrK0TD0dWhLV1iwCYYd4fyQ9ktBbNa53axSSRItdXzpP/nmrs2VwJAmOJ
         TP+qbVaaMR8oD2/LoUpn+emQ6jIFb/0+Z/F2TgiurWa/gqHGq6pxPZ/+mHcjJEuDaT
         KR/Ccyi+ZebihMOznps+e6ygFLP8EwJsgm+y9tG9JFdwjhCaFLV2Q8qRF+y648cHCz
         /w1hQ/Ivex+nBhPcY0iKGK/2h846laBypwIHRGMfrKbrEBQrgwy
Date:   Thu, 16 Jan 2020 23:35:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Documentation for common user misconceptions
Message-ID: <20200116233507.GY6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
 <20200116210857.GJ181522@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="azskX66S5GHWoEK7"
Content-Disposition: inline
In-Reply-To: <20200116210857.GJ181522@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--azskX66S5GHWoEK7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-16 at 21:08:57, Emily Shaffer wrote:
> On Sat, Nov 02, 2019 at 07:26:11PM +0000, brian m. carlson wrote:
> > This series includes four patches that update the documentation to
> > address common user misconceptions.
>=20
> Hm, is this still waiting for a reroll? Someone just ran into the
> user.name/username confusion in #git-devel today:
> https://colabti.org/irclogger/irclogger_log/git-devel?date=3D2020-01-16#l=
79

Yeah, it is.  I have one, but haven't sent it out.  I'll plan to do so
this weekend.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--azskX66S5GHWoEK7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4g8ysACgkQv1NdgR9S
9oshthAAq9cZsaIUhhR6HunIwMnPO/L2KN7z9tFgxe/TSuxEDuY8gs2apO2X23RJ
xV+AfJxqlnhvHH4AmVTpB6eGfNrsszaPzVfpspDvND/NcVLHFTqkwGn+1jgtuqWO
okz6BtrYna7wxoLD1jSQoi6l5eVj7ExjL8ArLK+zwO1q+imKcCM4ibVZNMSVNEtt
dpXNL00KaOxlR7JEAuI5YQGmWPZX+fbEQ0tdYwVY8gapeqSTYv0vmN4bf7umPkIw
DTsk6RNVHOUVy+hAMH3k3LYhGqq7FUOZWm/qruPYhJyEWrFMTk5Hz98GD4maDQxp
e8Me+eXWpFTEBVJrJPp0A9rc+RhrWLcdeJfkdt2m5gmB+gQFHCypJblU+ci26VIX
05/nOgq3PqefUYY0ewRtdXmGoy2sEteImf5Dh9CTbiqBMCDAgwCxR5cOp32aFIj1
BzdfWN5u5B/kaU2w/qe6abFjAEnTjf4cSCCuPJ9GJvslyprtbRNA5AQhXktt64ZP
vZnMZwyH+XwMDN2sjuY1L57z716u3qAUoLqycP17Swh1tJZRh5Pw8GT8trs4pfb9
jd+c9HtrMCaRD48hRqmy3LMP3CsreYARXeRu4vyq9/RphKe1v4BT0aD+QhpuckXL
yjqGjH9b0ynoGnFeGzx9i+URDM4UwqFwBaEJIBOjVo8/EIrKIQ8=
=DtEg
-----END PGP SIGNATURE-----

--azskX66S5GHWoEK7--
