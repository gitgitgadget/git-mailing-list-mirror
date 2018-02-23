Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 866381F404
	for <e@80x24.org>; Fri, 23 Feb 2018 22:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeBWWr6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 17:47:58 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33726 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751607AbeBWWr5 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Feb 2018 17:47:57 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 943056096B;
        Fri, 23 Feb 2018 22:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519426076;
        bh=AD3edmPHu3ipmn8WtfDtXM8QVWJhnOaTKOxZqPtn2Xc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kIpPPm4rJJBIQT+8+owH4rnu5DiIJ3Ros/jg44GuvGUnZmkOvCJ/HD2Zkm+MOldas
         R5JEZFypmrS0QgDC6N/J6etRFDzNIulXbuJAR3kXxEUm87I34NReJgpPHf59EQsA/z
         AwiY8j9ysGCg2hNV64WDPNp36EOrMwZY7FUWvnoOBmcRL0m4CCd9lPIqXbotAAy/8N
         iRMDbhKu06OcPZI1j1VpWIYwipeLxKrLmOr9iZldESTGblI6wTYLDp3AvC2IIq40J9
         Xu1SV7TViuewX4IALFiG+4pPiAByI4hvIgxUBYAqzixo8zSpIVikY6cP0C28A4EKCr
         /WWdadrWyrH1G1nQ+MVW1Z4jtcNjVM+ETB7l80eoVMrlWZPeEJaOV3XF0DplyU2Mg1
         VaG2K+p3g6T+/NLq7Dnn+hWARRSalvCALQlgQIeI7ZYt0skK3PWMnwzcTgkFxDSXZb
         MVk0PklQTszB5PFxrKC99b/BNfsg/opS+Aoi+ZyS7z+VLQJkvxF
Date:   Fri, 23 Feb 2018 22:47:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/2] Fix initializing the_hash_algo
Message-ID: <20180223224749.GL6619@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20180214180814.GA139458@google.com>
 <20180223095640.25876-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6o78gXsyQHm68LY/"
Content-Disposition: inline
In-Reply-To: <20180223095640.25876-1-pclouds@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.14.0-3-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6o78gXsyQHm68LY/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 04:56:38PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
> I can certainly try! I start to remember all the hairy details in that
> setup code.
>=20
> The first step may be something like this, which identifies all the
> "repo init" entry points. This is basically a revert of e26f7f19b6
> (repository: pre-initialize hash algo pointer - 2018-01-19) and doing
> things the proper way, hopefully.
>=20
> This is on 'master', independent from Stefan's series. I have another
> patch on top of that series to remove the use of ignore_env in
> sha1_file.c (and things seem to work). Basically whenever you have to
> initialize the hash algorithm, there's a good chance you need to
> initialize object store as well. But I'll hold that off until
> Stefan's and this one are both merged.

I definitely think this series is an improvement over my previous patch.

My major concern is alarming users (or breaking scripts) with the
warning message.  I wonder if deferring the use of the warning until we
have multiple hash algorithms might be a better idea.  At that point,
the warning would become something people could act upon.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--6o78gXsyQHm68LY/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqQmhUACgkQv1NdgR9S
9ounkRAAwEBfc3VaGc0tTNhXtiVNw2jtjMTYXIC9a5aD2sMtVa4lrazWhoue4O7L
0dhMIC14fmwdcR29wUj193Xy/xRTtlaveubtzl0UnsccCyXW502/DsG5kqb3+4ix
urNW5FMU3VtVGy4AS2vc24QqnecFmYrSJ49HIDex1JEjw0P3CCYaapLC9FxskXrK
KKjBL5WoTQFrUTyl4JhehDyT3hOTq9jRhx9AlHvjCSEArEsgHSxMCRtWfkXsB7sC
aFqfTdT4gn0/AkkR8wVCbGLUfEk02baN6e8D59cFUE/wRevsOpNIt8xXNxSwCL9S
XygXlqpdp5tbVYp5GSHufQx1biF56XiEBUmsoU+NVbEpkIivsLD4KIZGIlgK29gU
XClraGjHKc3kXgCsZIjYkcfZ36T0YYWJcyvG/r9eWV0zf3u6RnhDIeGe8aABNAYX
KkM+IgkM/N8vaA/mjXmWpMsmO/ELcoDoC5+C94C2NNLE2wYiPmPGxshVIqUSrqfA
o8wcuuvHKVZzecw/CfvxCrbqv2Q4jhGBJ22pjyFuhtKQzmLA5OtO8ODUxBG/Pj+r
9AmwCAOCJC2VjSJyHk2/kxAXRD/DmlbNFcPLYKkrc7qvZN45FM7C6x0FxTNMFu0M
bHrEzXqTU3twBO7eDkispPKJ3Oeu6+aeXvVA79/FRWTNdC11tXg=
=rued
-----END PGP SIGNATURE-----

--6o78gXsyQHm68LY/--
