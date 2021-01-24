Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FD2C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 03:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B93C422D2C
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 03:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbhAXDXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 22:23:10 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59524 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbhAXDXJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 Jan 2021 22:23:09 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BFB8C60D01;
        Sun, 24 Jan 2021 03:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1611458518;
        bh=u/MYHSd5Iwuu0yj/Q0RRq75rKzvN4260x/K6gATcti0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fHtkKugVoCRbbzAAPjykd09wIYNdsIKSQSlg0QA7Q9Gk+OJntWKwHq9flXAAdp4eV
         KAxmzNWjnYTxeBSSvrRP176obtxT2UipO4KwoU67eQDZghaEIP8dW6U3fdBDValJLt
         T4gzWJt7iffLb9nDY6YRU9v6pCwYNOrXY/W/8VspRs9LSsxbD0RMKjFEBpmJwm42xE
         C/ulJsygZQyMutBV8a4CblCpk3op17QzmKcZKCVa+a+MJrkrkQh21FJim941kShMHI
         D+3e8+OZ9kBx9jvL9d+MxpePvnKuwCcMm92jmOc4I4kd4Z7nCAFi0+2s3BqCEyPTuw
         fdQTMlydstRDI1Rp1MHV1yOvA/Fs3FASgskCBM6yZlTH3/lgkSrDgYJ9Rez7aa59Zg
         LKbIeZh4vbHl+Dd255sHYZWfhCNfU9ZMgRFDKAGwyhNCMESBZkgJ/UoJhfrFTpoF0a
         4kVVFBePogr5B/CmZMBRNG1v/QBvO3jncMvmNYhBY8B+AL+cI7x
Date:   Sun, 24 Jan 2021 03:21:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Subject: Re: [PATCH 2/2] Remove support for v1 of the PCRE library
Message-ID: <YAzn0Z+568rtF6rs@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
References: <20210124015833.2753-1-avarab@gmail.com>
 <20210124015833.2753-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vGXt1AHmaRRReSH5"
Content-Disposition: inline
In-Reply-To: <20210124015833.2753-2-avarab@gmail.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vGXt1AHmaRRReSH5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-24 at 01:58:33, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Remove support for using version 1 of the PCRE library. Its use has
> been discouraged by upstream for a long time, and it's in a
> bugfix-only state.
>=20
> Anyone who was relying on v1 in particular got a nudge to move to v2
> in e6c531b808 (Makefile: make USE_LIBPCRE=3DYesPlease mean v2, not v1,
> 2018-03-11), which was first released as part of v2.18.0.
>=20
> With this the LIBPCRE2 test prerequisites is redundant to PCRE. But
> I'm keeping it for self-documentation purposes, and to avoid conflict
> with other in-flight PCRE patches.

I think it's fine to drop support for the original PCRE.  All supported
versions of CentOS, Debian, Ubuntu, FreeBSD, and NetBSD have PCRE2 by
now, and I'm quite fine with giving folks using systems without security
updates a bit of a wake-up call.  I have no reason to believe that any
other major operating system won't have version 2, either.

So, essentially, I think this is a good idea.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--vGXt1AHmaRRReSH5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYAznzwAKCRB8DEliiIei
gRM8AP43moQvbDgfUDU3Jo9V1gu288W6Nx0udU3Xmu2vrK1GmwEAr3AQgZEeI8sl
GgqYgZ3leu8Plx7ZH7YpYYvT0gp32AM=
=JpOD
-----END PGP SIGNATURE-----

--vGXt1AHmaRRReSH5--
