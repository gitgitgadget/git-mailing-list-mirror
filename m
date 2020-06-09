Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1CDC433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 22:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415D72068D
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 22:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="m7Mwoglc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgFIWgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:36:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39138 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728108AbgFIWga (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Jun 2020 18:36:30 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B516B60482;
        Tue,  9 Jun 2020 22:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591742189;
        bh=RPhcphWZzKSkU94kRDtFFjvREl5q//aNa/l/lJm0PAE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=m7MwoglcUileJWf87VsVTAbaQ3X7j7o9ibPz9yhFdBzywI6NAUmS9riNNow+yyHXz
         n4tuCgE9+qG9OLW10TrQrVcb/5D7tqKecS4n+MUBPgkHBCsCKLdxS7sHhSIyhaUVFd
         RCkW4xjahxNhBE0Kxtv6DizbRfTdP2CsuobTK9us8ccs9sRxUp8GyZuuryCYR1WaKq
         g2Xyy4qEm5vOUskkZq7rhNrQPGFhixgB9XMNBpyKxGTkcB90P1Ey5CWGeT7tq0dtbA
         Pa1PxYfAj0YLMdSLfY5cVwZ5Om9Fnqtk5fWtb8q8T2DqlCaOnY8maqmLDEtXE4Liv0
         5lHJ2tPcpMzdBZNJQUZQGSasnMifzVG8pt9MTLFeGtRIFJVxR9Fc14raIjRpPw+TgZ
         rcnQlz4ch7jka4JPAMk8pS4s0dIaNZI40jW5VMBRXTaHOx9laJm7+Ji+OmpPiyzwcK
         o/csWTQ/f2kwclg+UzSgtAnt+CuKYJYjBABcGf3ucPS0878tfiL
Date:   Tue, 9 Jun 2020 22:36:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Simon Pieters <simon@bocoup.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200609223624.GO6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>, git@vger.kernel.org,
        don@goodman-wilson.com
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net>
 <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FilwpOHBrTVNlmJ3"
Content-Disposition: inline
In-Reply-To: <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FilwpOHBrTVNlmJ3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-09 at 15:16:57, Simon Pieters wrote:
> Thank you for your encouraging response, Brian, and the research of
> what the change entails for git.
>=20
> I've added Don to the cc, who started to work on implementing this change:
>=20
> https://twitter.com/DEGoodmanWilson/status/1269931743320182784
> https://github.com/git-for-windows/git/issues/2674

I'm familiar with those discussions.  As previously mentioned, I'm happy
to review any patches that come up and contribute myself as time allows.

> Although I think it's reasonable to move away from 'master' regardless
> of its origin, today Tobie Langel pointed me to
> https://mail.gnome.org/archives/desktop-devel-list/2019-May/msg00066.html
> where, one year ago, Bastien Nocera made the case that git's 'master'
> is in fact a reference to master/slave.

I agree with the assessment that we should change regardless.  If it is
a master/slave reference, then that would be even more compelling as a
reason to change.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--FilwpOHBrTVNlmJ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXuAO5gAKCRB8DEliiIei
gScoAQCOgYh1NjK54XIp9pgx7IUhx5Y64NPttHMGGm6QTRFaTAEAl+f63uGE+rS6
YjzSUHRCzOR83NCZas3pDynBU0TEJww=
=nYk1
-----END PGP SIGNATURE-----

--FilwpOHBrTVNlmJ3--
