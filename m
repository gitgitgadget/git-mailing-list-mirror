Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B034C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 14:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A2F61260
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 14:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352704AbhDGOAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 10:00:47 -0400
Received: from cressida.uberspace.de ([185.26.156.202]:37794 "EHLO
        cressida.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344022AbhDGOAo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 10:00:44 -0400
Received: (qmail 20477 invoked from network); 7 Apr 2021 14:00:21 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by cressida.uberspace.de with SMTP; 7 Apr 2021 14:00:21 -0000
Date:   Wed, 7 Apr 2021 16:00:17 +0200
From:   Matthias Beyer <mail@beyermatthias.de>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: signed-off-by not overwritten with GIT_AUTHOR_NAME...?
Message-ID: <20210407140017.5m523lua2l3cluk3@hoshi>
Reply-To: Matthias Beyer <mail@beyermatthias.de>
X-message-flag: Mails containing HTML will not be read!  Please send only
 plain text.
References: <20210407134201.kxijiev5sn346bsy@hoshi>
 <YG25jNZH9ATfwlMu@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fcc26d65zizqkpaf"
Content-Disposition: inline
In-Reply-To: <YG25jNZH9ATfwlMu@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fcc26d65zizqkpaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 07-04-2021 09:54:20, Taylor Blau wrote:
> [...] if you s/AUTHOR/COMMITTER in your example above, it will do what you
> expect.

Ah, awsome! Thanks for the explanation!

Matthias

--fcc26d65zizqkpaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEUJGUus1GMTrRclzcEKWX9Kitz80FAmBtuu4ACgkQEKWX9Kit
z83pjw/+JdK3+yksr8G9NU46a2zwYCSD/xkjLZCObT8i5Topp5i8zHD6dhqLzc0T
U4t0wh4o0cpVxnyJtP7EYr8vpUGDoVCnCer9nS5ThJHXw8rpk00YX1UZUIuPDtiB
y2sTHmSRAMTHaWJVbrtghaVnRrkigGNYb8lNwnXWmQI41GA9q+cCRtGWMvPaCvD5
z6O/MXA//v/vBkpi9E3Rbuk/Lino8OSTUcJfQuwiU3s01d/BCnVlzqXl2tzmOFo8
bTR3nB2/EW0LH/MLJ3Trwy6HycdSzZRyxkqvL41dIfbUDL5epdlgSKFiV1m4OgPC
7s3b/Pmig7kbnBpsqx0ZbaBhf2aZWpFs1UJlYrd+HeHIILlP7pBLYViavO1G3dsA
VNYihz39PTBNmwFyI95CoMbJnYJtTN5WgtYn1xvUwuEW5zKzCyjSvpvIKvhyp/4x
t6reol5ivRifmXR9WbBvGLV/ti+aAhzazPfd/6BRNM0CJnoKX7SunGQnigYjpppv
xxfopzNRZZQ94t6I8SaATZE36f6scTFvatcxuVYAJ/xH5+M2gcD/2rahO4gv098T
fz9mc86SEYn+7dEMgqiWx+BvIgRajqGRNBFqI8znYDpwkfSlCyu+qOq3OzL2q3XG
AFXXoW+8zh6pgzFmCK/552eQ0CxiYrmpSBoKr/UHaNpZqlBwZNc=
=GiZP
-----END PGP SIGNATURE-----

--fcc26d65zizqkpaf--
