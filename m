Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 808D91F404
	for <e@80x24.org>; Fri, 23 Feb 2018 22:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbeBWWRz (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 17:17:55 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33704 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751648AbeBWWRy (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Feb 2018 17:17:54 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8FB5A6096B;
        Fri, 23 Feb 2018 22:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519424273;
        bh=D0CKNGCPlQ/sjGw6AQsrlngB/52s1LO3JaAsne3c0yU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CkvmTka+vzUZMrR/rwbPy0pN9Jws82voAGFy1j/DwuafmHxK25xpyYo0Jrg+ke0Rj
         aXFyPEkO6fDBEoDRO3jkq0n+x3BwcTZd0BWLPwxFG9y9Z1b32h3sq5cHRqodoJwvem
         JQNDtlmslpEoQY/pSGP6Z8GQcguhIav5IsMUdYLNzmGsIqKEU7IOeFQuVMi8Tnvayu
         QQUXUxJ9cyYKqC+eFXAeGkeiUxvkkHoYjJp4ty38YElbizYzPZa1gEGb/fbMO7Ls+z
         TsdbFB/9KiAHWPQz8oKIWrBYq42mYckv+MqGoBMyxdjbXJunkUmuA5kZUDT2wN3PXN
         ItqLPmGhkBvNzi3fUPubEWAPAAlmJWg1EBSiDrLsSm95dwVuB6P1XIL1EY3cBVMyPr
         disDaXxTSkGk7TWXVsrDQz0tR0jI6UFeKKRFAVs0x0HOkDMVcxS4Qei7/ogEX90WwG
         kMrGAalsqIdENb6sjTlgltbwPdgi9l4x9MbKIdOYh6GzqDeP5Kn
Date:   Fri, 23 Feb 2018 22:17:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/2] setup.c: initialize the_repository correctly in all
 cases
Message-ID: <20180223221746.GJ6619@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20180214180814.GA139458@google.com>
 <20180223095640.25876-1-pclouds@gmail.com>
 <20180223095640.25876-2-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TdMwOTenGjBWB1uY"
Content-Disposition: inline
In-Reply-To: <20180223095640.25876-2-pclouds@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.14.0-3-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TdMwOTenGjBWB1uY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 04:56:39PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
> [3] the reason server side is still running ok with no hash algo
>     before [2] is because the programs that use enter_repo() do very
>     little then spawn a new program (like pack-objects or
>     upload-archive) to do the heavy lifting. These programs already
>     use setup_git_dir..()

You have "..()" here.  Did you want to say "()." instead?
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--TdMwOTenGjBWB1uY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqQkwoACgkQv1NdgR9S
9ov0zRAAxv6Yef+fKTnbijq2fiCOau+q3fdrK7A645cyoYRN5uZPvyJpMNcbTyB3
3HsSetILdCSWzwL8R/7iSc6a3penQMFjUxOUm+7we/xfflS4oTOytZRiiAG9uMz7
pMZJvRhGh0FPBz9IO3VnXJN4gCe90EViQxDQ1TsGpbM2gxd6yO/DVqIeLWkJ/xQE
KZf2Uz6aMzYysO2f9mNBGx6swSv1Mq1cuU3ExJUPiSrx/PFLDPuang67U5dAoJoA
XWjiszr569amdBp+LG6sy3OsJxl+JrDaeAzDL7SkmyE689pkSnPMbrMtmbgCVI0k
u98/llxtN7OzlFslQppTPCGHzPEcUlwb6bfTA2gbT6B1tZWrQzj/5raB8DFB3F8b
16EgPPd4H3j/hmOjkTCWAKGqEkcf0Vbx70G7FCEYRXG0hMjG+2sy6fHeDlC8vP0u
j0cjMXZAdGTN/GvM1a+Zcj3JWYQdBGj4c0vH+34XSYL8BorKjve63GFj0N79NecH
9iOn35e5cwCI3bQKuosGEHOGfzCAjRKBUJau1jnKi4l803Rm92GmbdYQwmMLlmPR
jW4OUsTwScdHKBd1e9J1IA20b7I1KQlHOMCPcxQyPv1G6HJtq9E+QxdCEZFwrTj0
yy36ptNnQ2HB03OJGaQuTc+P7mL9lIr0M4eCkYJaFMqT69AJyI0=
=mC1h
-----END PGP SIGNATURE-----

--TdMwOTenGjBWB1uY--
