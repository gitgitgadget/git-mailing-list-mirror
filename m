Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7C8C07E9A
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 00:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 109B2611CC
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 00:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhGMATA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 20:19:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39564 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230099AbhGMATA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Jul 2021 20:19:00 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 535CC6044E;
        Tue, 13 Jul 2021 00:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1626135340;
        bh=3b67rB+Mc7Ls/iVB0vQX0AEAmJ5HwlylROhwPzTsejo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oJ2hRR3LuW/WrSCLRqY1BIOA6KuBwGO+IvdJdmuAhstvKKVENmlc4N4eA7+DxrHqC
         1BwvrLuM6INpXUoyjKgcrU9G8GJwk8vygHG41wzCEb5aPg/NOJ1YILk+8wHTOs2ifc
         +9ygLbBneq8C9fr/a8pYFk9ksY99IitSrRGG+TR+RJ7n7MF2sqlAluob7yjtCsWRm6
         ogn6XPWclBnKx5QhUaJtOnrq/NAbvmL3I+xoUUqzdNXnRk3l90CXkEDlRVi6kdAdSI
         VZ1dZkKlf1LI6HIAicyqZv3Hxmv43GbG6LIHDKojUwrhauXRTTorXDjQPVGPT8TIFD
         pHb5rJ01F2yvXM6GaYG67G7cNTu1YQ4FZsiSXXrP9FwjninESu+x1+d3faneTjvbrs
         sNCVHC+kVuP6S75GUIRwLp6B/BDaiZpI+Q1DcJgZgsITOdbkW/KEK9YTeuhiWPPwte
         m0LFaOSo647BVdAt0YJbtTvaspNrRXVTYiVUZbtMo7oyYps8rsU
Date:   Tue, 13 Jul 2021 00:15:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] rev-list: add option for --pretty=format without
 header
Message-ID: <YOzbKDlBkLniOwjB@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <20210706224321.14371-1-sandals@crustytoothpaste.net>
 <20210711215510.191626-1-sandals@crustytoothpaste.net>
 <YOyGYs+uDr7tYxON@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nrFJgP5g3RawIAu9"
Content-Disposition: inline
In-Reply-To: <YOyGYs+uDr7tYxON@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nrFJgP5g3RawIAu9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-07-12 at 18:13:54, Jeff King wrote:
> Thanks for working on this. It has bugged me for at least a decade. :)

I figured this would be something you'd like to see fixed.  I'm just
surprised that I'm the first to send a patch.

> It wasn't immediately obvious to me what "custom formats" meant here. I
> don't think we use that term elsewhere, nor do we seem to have a
> succinct phrase for the concept. Maybe something like:
>=20
>   only custom formats (i.e., `--pretty=3Dformat:`) are affected.
>=20
> helps without making it too clunky?

I can add that.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--nrFJgP5g3RawIAu9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYOzbKAAKCRB8DEliiIei
gVnDAQDobGwsRCYM/fPCVhixwv2Rrk02CjQ6Bbv4uz+d9+ihXAD+NdzWlOTEYcvc
j9f8yO4k31M2SlxplK9Bn6vCIZxJ/gs=
=KZDG
-----END PGP SIGNATURE-----

--nrFJgP5g3RawIAu9--
