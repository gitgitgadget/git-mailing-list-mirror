Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69E31F404
	for <e@80x24.org>; Sat, 24 Feb 2018 22:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeBXWjW (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 17:39:22 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33762 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751449AbeBXWjV (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Feb 2018 17:39:21 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9ACF16042F;
        Sat, 24 Feb 2018 22:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519511960;
        bh=wQRK0eluLf/9hhYvgwfZFvwvdgNKrJ6GD25G2z6F+Q0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sO6paGlJgp/EeHf7gdykJsumv4M1+nHV+SIDSDp8gBSENhd/kaQ9vopAOsOEzMUjj
         j7iz2I03iFBYVBWPCxFpfgOMaQnRqqU/xVb9bJHsd1sc0L3oM8MYl9nBJHXdHthyhF
         Lx4aK6HUjDk2nE2HdiV9MeEKCgSR7x/yfnLQeRXOrZ4Q2rWKcs+sjJkX1PQ3b5A6FX
         iTFGG0Aq2Dh3lgzFK4vibx6Q+O48GtUNCOapKnwj5Hv4jVRFBaQaGb4N/DVDczH9gT
         vaIyZyjUJQsOA+/VvPOiNlxXzYK68Qd/34Z7g8MeXh5cYXGw4qujGnnYqHQnh7IfCf
         jpiKRdnkUlfUKSG1AEs77UT7uv91aSzUaWC8Ux/xTayeNXFKutzdX9RnyiCnfkMlMK
         7NLg27I7hM1ZPttmEjjF5nPSKfwj/K3d82N7a1fFkiHf4xCb+dSrg033YIBv53XrYG
         0xB6F+ciGczKb/QPUl4wao7LzrjVteeR563SpJuT0VtfpzBoynE
Date:   Sat, 24 Feb 2018 22:39:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 2/5] sha1_file.c: keep a good name for "unknown"
 hash_algos[UNKNOWN]
Message-ID: <20180224223915.GB4620@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20180223095640.25876-1-pclouds@gmail.com>
 <20180224033429.9656-1-pclouds@gmail.com>
 <20180224033429.9656-3-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <20180224033429.9656-3-pclouds@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-1-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2018 at 10:34:26AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
> This is mostly for displaying the hash algorithm name when we report
> errors. Printing "unknown" with '%s' is much better than '(null)' in
> glibc printf version (and probably could crash if other implementations
> do not check for NULL pointer)

This is a good change.  Using a NULL pointer with %s on the BSDs
definitely did cause a crash, last I checked.

I looked at the comment I wrote in hash.h, and based on that, it is
indeed very likely that someone would accidentally write code this way.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqR6ZMACgkQv1NdgR9S
9osFIhAApIPsn+gsAhHSpbaj0Yr6I6v7l7bDsN8AMzWz7bdCwDSUvlKbLOOq9ikk
Mw34Vl0fWXWVKf5FuC/KIMN/wMnC11uNPpYP7WVvYK66PQEWIAP3WISlCC1Ya6lz
AxhQcWremaaCNOD7UpqmkHBQEU7QEKuoeYCfxeghWEqW24NU1jD09BM6LdRbvd1d
mju6ELKpDH46MfCiFehC577zzoGG1++8gwrSiRLj++pYxmexA3JbehzXkbA3bEoN
9KVlZUH/TNwlDdCMt+Zvf7oR9xCEYQFQ3cW7ZFuCkn2WiESQ58a7h0r26wRO9AON
dHSv44CRBAdJgSf1QNPIdNzCam0qgArplqydw6eud8murtxG/FnTE07dRzO6z864
95G3+Nvvf3CUPjRqVDD6GbRdsQK2CqqZDXXV0cDHpRTSI7uVjjWcF2sKxBoe+wpL
RmjBq06ZU7FQ8EB6csTLfwyTsGa4vyW256TTOnZRob7Q1HQ7lIzQkZ61EPQUoeIK
rH7hGZh9QAUDMiYkRaK5IEU2hV9OwG8gqeCUNeG7ST3aswjKzxwzMGp7OGpYn4DZ
YDyeUCzay1Yc5hTesIAj5+McA/nBF9E4utf6qochkpv8xYEAGxs2kNiaE521weAQ
IPAuvGmzcr40TOxJL5ywaLBmbjIeffIDh4zhPLegPwIdK8SMwkc=
=Q9GU
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
