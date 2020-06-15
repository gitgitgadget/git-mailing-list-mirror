Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76C5C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 23:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 738B12074D
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 23:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1MsBKnQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgFOXYb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:24:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39332 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbgFOXYb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Jun 2020 19:24:31 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7594F6048A;
        Mon, 15 Jun 2020 23:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592263469;
        bh=7NA9lTMHOudrn6BueyP6CWFZb+a3Xa0+NDyjYNBsbdY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=1MsBKnQ3ScvFHA9pDBGqC+6apYfH0V+ubaItzX5VOnPHWViQbT67n9Q9SjMlGzFW8
         pPJbjwoqbl83CjO0BDP8LICcG8/EAanF67ZHWl1KnqolURlIvsacgKBr56AYGAF/+q
         Iu+4RTRuvia6KwgSTgpDWWsNvk96pyGJgWwj6id9bppE0jiaqW2wDC+v04jnoObeCI
         9Cc96ww2f01dxnh199zVOaXKAC4VdkKca+tzpIt0XvOEn6ERBa7r9CR46pxhJa0M/L
         clNRxDqYLT8gcnzi2FlPA0CxFG37E1TnWmdWUHf1eMVgPaaHNpwdnG6RcVW40cAybJ
         EBeL0gi5ckM9etSTkLlu3dzhF+OLC6F02lHJs5cJybNqEBtYH4d5jyexY1KJOT74IR
         VdKsfzdPEGPvwDpatdSQBsVD7Ys1b3oWdA8yMjYWgqiP/voYjRU/QhIynz0hoXQk4Y
         oIQLKLJLlwzc0TpJKx5Gfe02GmsHINPbzfETOQITDxk8dvdSCLE
Date:   Mon, 15 Jun 2020 23:24:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        James Ramsay <james@jramsay.com.au>,
        Bryan Turner <bturner@atlassian.com>
Subject: Re: Consensus on a new default branch name
Message-ID: <20200615232424.GF6531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, James Ramsay <james@jramsay.com.au>,
        Bryan Turner <bturner@atlassian.com>
References: <20200615205722.GG71506@syl.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ni93GHxFvA+th69W"
Content-Disposition: inline
In-Reply-To: <20200615205722.GG71506@syl.local>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ni93GHxFvA+th69W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-15 at 20:57:22, Taylor Blau wrote:
> My interpretation thus far is that 'main' is the planned replacement for
> 'master'. Consensus seems to have formed around this name [5], but if tha=
t's
> incorrect--or there are yet-unvoiced opinions that you would like to shar=
e--now
> is the time to discuss further.

I think "main" is a fine choice.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ni93GHxFvA+th69W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXugDKAAKCRB8DEliiIei
gRMeAQD1oPWKKdGffQQh/1YNKWTz5R91JgFFfIy6zUgp19H+UgEAsK5SdA7hHaSv
RrQ/S7xl8pgutE1++PupI934ryo7AAA=
=IlJw
-----END PGP SIGNATURE-----

--ni93GHxFvA+th69W--
