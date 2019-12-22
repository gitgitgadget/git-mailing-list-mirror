Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7157C3F68F
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 17:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4812084D
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 17:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yH3iEwZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfLVRr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 12:47:59 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42786 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbfLVRr7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Dec 2019 12:47:59 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 26EBB607A4;
        Sun, 22 Dec 2019 17:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1577036877;
        bh=0gI0GjnwGY9bk8b+eztGcxw4iGczD5QHvYnZa31Ejm0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yH3iEwZXS1UrGpC9Vd1/TFR9P4XdBBFV3xUy6mCL8/UiDCwRHkN2rQWbj5KRXqZ9c
         gTCR2V2FCn6Mp9LoRw+qB2rLWQxqlxaVuafwBciR4sBpko2mIQ4d0bp/y50KIQUNOW
         8J4HVOjDNnZm/XG4YXClm04fODAb1J0d/+SlvtRjYpfzidtjeFStRH5zbRoUt4fSUG
         LCQFmzROjQOiQrvxOlf+bS04LhumGMXFzLYP9Bh3Tof9OylLoX7n2El6EzJfId4s35
         RmjthJLZ7WwXtK3zBREdgaYAefZTiOUZx8caaNKjz6/a9qiFVRg9prWfUxg4LtlC6Q
         jlo8hogMGOfYXEgqMikcz1tCguJvufObx8CpGMgJDzUvIk/XPapdYgyWMLLpY6a6yV
         rdlCiLH0CYYWfS5xVm2oEvp9ee/gEUOJ+Mv13AxkBEAy3AA4+6SuB3v8QmunrDusyC
         Gr8aOSNhdwdKZbCK2DbHRfXOGZSjbaarwpijXFIjyLWlfN+5Mb9
Date:   Sun, 22 Dec 2019 17:47:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/20] t5319: make test work with SHA-256
Message-ID: <20191222174751.GE163225@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
 <20191221194936.1346664-11-sandals@crustytoothpaste.net>
 <CAPig+cRtAZs=OH8GphXpy-TU7B28iW=VM2XPdJ3K8drQdoaFFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Content-Disposition: inline
In-Reply-To: <CAPig+cRtAZs=OH8GphXpy-TU7B28iW=VM2XPdJ3K8drQdoaFFA@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-22 at 00:06:47, Eric Sunshine wrote:
> On Sat, Dec 21, 2019 at 2:52 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > This test corrupts various locations in a multi-pack index to test
> > various error responses.  However, these offsets differ between SHA-1
> > indexes and SHA-256 indexes due to differences in object length.  Use
> > test_oid to look up the correct offsets based on the algorithm.
> > ---
>=20
> Missing sign-off.

Will fix.  In the odd case that no reroll is necessary, I'll include it
here:

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl3/rEYACgkQv1NdgR9S
9os1qg//SA46GlPkaN5wYtqkfPpmm35qjViEGo61KxAtxNn4GZv1+wcVFJAeaps4
IbmBKmzjwFD7Z2b+2gi61B60GcK7WyNCg4gzI83doiBmmJmrqwevKC89jN/vySzk
h2X91jrhbTLsrAJru1SBf7MJ6Kcn4WYjyolpA/KFZvx57h2+7Hxj0oX0/pYyiLud
I6Yf5FE1M+uYNXd5S2Qm/ZU/Ag4gAGufTTwMvvYPP8c1yIWAlwuxwmOMicKURJyE
EtsQYbWHGlAEx0b/yuRsqIQLr6v7hDIN1q0hTDhBQEfgmcpYm6Nr7Go+ea1IDh07
IRjf8Efti2mvbxNFTbRxupjMYPNOI0a3/g9/6mkSyTz/6jjNFv48M4d632mlBTw8
V0qEMfI3dc/9pqa49BVyY3nqb0QkZiRzZWO/dYsNRo60u63vKZdbSGfhzaYcmD/j
J19Fl+TFG/qXjsIcGNPPCakBEE2jJJkaFaZ/kX7adqf1kGG7bhLv8Bo9AKwmgDuE
UnzHlw1Kl/VWbyZWpVlynN1otWE/0LfNC5lRShKxnvoAQKHubjsH7p0y4c5ks4QV
YAH0w23UsxO8pa38P72JbIqrFSNUh922oahBn9DlNZtoGu36B2IZanf7EqSSKZD8
f9XkQVxcTlCY7UexwXEwWZAbnOdlwihK7CVaQpG5rS8Ou4yqWiI=
=92cv
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--
