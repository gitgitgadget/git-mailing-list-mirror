Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1452C54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 17:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6DBD206B6
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 17:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SYqE+ksk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgDYRHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:07:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37634 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbgDYRHq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 13:07:46 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 175246052F;
        Sat, 25 Apr 2020 17:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1587834465;
        bh=G1cS5Zvzjw4EJTCfe4rC+26KduxNFuhfBH30SlkUIMM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=SYqE+kskjM65WqhAfr0fG6m+dk3WqR65VNYFIqGQXMSwEtHF4VCV9kci2MP+lwqd6
         xNgIamHZQujvsy5Ghz77tmRumiCaeFljBwELEAIOAXrkaTMK9ERPBrAhn39ttK+hVh
         T2HxXQ++cqSoHnaKBb82GBk9RKFwtZfaif0Fzk5cj75W8nU7ZrViecKBkw9zYx6xov
         takcq6iKwDOww9Eg1MSE/v9uT1X+unw3FuexTvFbUJQjIVBcHVTZZ8apXGtzIqUO4c
         41cINN1wXIwGONFQTdCAmpzkpqHM8/SQw3hZPLTyPtHpmn5jH3TLR8JDnk0yv6qutu
         KHczCakjYixTFnYUjgDODbMHc2GCrG8wcnu4V8ghjAtwHi/XJv5I5pA8Za8OKMDWXs
         eLmvIz1tug4FCHEt67nIXDofCX0hDRk0Lp4VRw8hRi18eBl9C6/Vg4g71vx5b3Utid
         hKhP0gkXQaNyfZ4mjSGusFe70YDpj7Pa12sdxa3EW9XqAUOPL+P
Date:   Sat, 25 Apr 2020 17:07:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH 1/8] Introduce CMake support for configuring Git on Linux
Message-ID: <20200425170740.GA6421@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <70ab1f03dd5413256166bf9db47be47b746ea6b1.1587700897.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <70ab1f03dd5413256166bf9db47be47b746ea6b1.1587700897.git.gitgitgadget@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-24 at 04:01:30, Sibi Siddharthan via GitGitGadget wrote:
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> new file mode 100644
> index 00000000000..73703bd321f
> --- /dev/null
> +++ b/CMakeLists.txt
> @@ -0,0 +1,528 @@
> +#
> +#	Copyright (c) 2020 Sibi Siddharthan
> +#
> +
> +cmake_minimum_required(VERSION 3.14)

I don't plan a full review of this series, but I wanted to point out
that this version is newer than what's in Debian 10, so this isn't
practically buildable on many systems.

If we wanted to add CMake support, even just for Linux and Windows, I'd
want to see it functional on the latest versions of the major distros,
at the very least.  Ideally it would function using the system packages
on all security-supported versions of the major distros, since our
Makefile does right now.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXqRuWwAKCRB8DEliiIei
gTbUAQDgNZ/Z2igvppyBrZHYTcVWObXgoBtYHPcvWTL/yGsIJAD8CXqeRSV8SPjK
6hXC8IKWXv1uQpQlYTUW3uKsxm9WfQw=
=Rwia
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
