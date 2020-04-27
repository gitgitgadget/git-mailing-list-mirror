Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177F4C81CFF
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E00D92075E
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UFVN7qx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgD0X0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:26:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37732 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725968AbgD0X0g (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 19:26:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 377E76052F;
        Mon, 27 Apr 2020 23:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1588029995;
        bh=qMLbgdWLKwVBpvbo7ii3dEuGR4YdF6WZ97uXeBGZD/c=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=UFVN7qx9fURTEOLzZ7viOo1Up0yMEnI+kV82FNIaQF+umcc1o87LpGFMBeiT2qwC9
         VGuhKw1Ht2Xo+Kh4dTW51cUHTbtit1NUqZhk72eogGnKvpA8t/yYxyDy70HyDI0NZw
         Vvo1bSK3glmSEe0VYtKY34WOMrZ/SgLSNDlAnPq7+HpI6muz0nM4BxyJiHzTju9yp5
         +GLNqcMRmF5mcSyj/WQuWRtWLmTrMgOBFQ9bc792CtlDjFxoxU4bP/Ytrz0Rjgf22j
         kNiV/9HFUdx89YWmLe1q69SjwW7yMJdpb6b+zuV1bl1LoxPP9E8Ppy07ld5PC7oD9M
         Nbi/rqiniB7WH9ejmIVpquCHU0GYMt/UPlsg9j727Of1/MNQOiT82rU5tpCXLHEaad
         LEMNw0ACTpVNRO211hou7Cv1CJBuhIdNEUzUTBQ8VOvzxjGiSFBjzknAaP8TSYaRZL
         WwtfzCZxQnyeZt2ChTeE81+93nmrMf0Rup/szCc9u+z00oefPPB
Date:   Mon, 27 Apr 2020 23:26:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>
Subject: Re: Compilation errors in git.pu/refs/reftable-backend.c
Message-ID: <20200427232629.GI6421@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>
References: <575af27b-3823-2db5-ad3b-3c6cd7a95faa@web.de>
 <CAFQ2z_O7z2prvnE+v-0nzC3=2mmUBHgFVF+iRqRn-7QyRQxOqg@mail.gmail.com>
 <20200427131312.GB61348@Carlos-MBP>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VIOdPewhitSMo36n"
Content-Disposition: inline
In-Reply-To: <20200427131312.GB61348@Carlos-MBP>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VIOdPewhitSMo36n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-27 at 13:13:12, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> On Mon, Apr 27, 2020 at 02:05:12PM +0200, Han-Wen Nienhuys wrote:
> >=20
> > I don't understand why Git doesn't enforce this, though.  Couldn't
> > -Wdeclaration-after-statement be added to the Makefile if the compiler
> > supported it?
>=20
> not sure if that flag will catch it, but from what I recall, that
> specific feature was only available in C99 while git's codebase
> targets C89 (need to build with --std=3Dgnu89 as some GNU extensions
> are already needed).

I think we had chosen to preserve this behavior because MSVC didn't
support C99.  We may wish to change our approach now that MSVC supports
a reasonable subset of it and GCC and Clang are available for almost
every system out there.

I don't think it's unreasonable to expect folks to use a compiler
supporting a standard that is now more than two decades old.

Of course, that doesn't affect the present series, but it is a thing we
should consider.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--VIOdPewhitSMo36n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXqdqJAAKCRB8DEliiIei
gWAmAP44soTb2jdqX5TgZLGYgFhS4goyYcOmg+HFhrrVpZZNjAD+K18dMI4PP6SP
L0ZWVzm3kEywyTO6hRiGqrf4MIGynQs=
=2eX+
-----END PGP SIGNATURE-----

--VIOdPewhitSMo36n--
