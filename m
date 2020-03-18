Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FB3C1975A
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 00:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6EB20663
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 00:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="rWgLAxkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgCRA0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:26:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56230 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726965AbgCRA0h (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Mar 2020 20:26:37 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 397526077C;
        Wed, 18 Mar 2020 00:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584491196;
        bh=H42EuHM/hwIJCGZE7/VslqFkTvp/I2xH8kAJkJzUpvk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rWgLAxkxR22a3kBzKZnMMOO6BqQeizRWNNEOqsarmAWY0SvFhJoHyiT/iq5fk2KWT
         mTCWh9V5Vex96ygCi4j9aMkT3ZqOihgDU3/h6YE5ld579NnnXt97IXYVxo9ilFgQ6u
         MDHnuWU5E8tSNJ4295eRKt17/J0dvL6LuAGQeiQiTRUwHTt158A5126nWSfccCe29Z
         GPqW0gk1y8yhhwR6/G1Z/rFtu2CSPhzttM8BmF7L6lxOPJ99jcMUgM1+X2yvec7wTP
         G+481RnnL7JnL1lzmifi2TA4L7iD2hys8VQ33vgjFvNUfZrK6j8VLVJAa5MYXB5oIN
         Ia0A/SS5+VAAx4k/Ko0UHs5vfzb99u7N10jgbRvHFAv3fJO7ka/Q3WFanS6dbaoPwD
         d2sBYnOxPatcovhlz3XeOAsrFI+VFL+zOII2H+KPIiFwVylBNPeX893Fs1Kmku8EfR
         7ik830bM0x2y59VZAl9x2SodALQMBU/IiCkrHqnwq3NpqjF+k5t
Date:   Wed, 18 Mar 2020 00:26:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Benjamin Shropshire <benjamin.shropshire@economicmodeling.com>
Cc:     git@vger.kernel.org
Subject: Re: Relative url values in .gitmodules confusingly sensitive to
 clone via ssh vs https.
Message-ID: <20200318002630.GA366567@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Benjamin Shropshire <benjamin.shropshire@economicmodeling.com>,
        git@vger.kernel.org
References: <CAAjm7Ga5JOJ2w=01o1-x-80HMGVaYQQy8SBBb-zJ6MOQAe4SxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <CAAjm7Ga5JOJ2w=01o1-x-80HMGVaYQQy8SBBb-zJ6MOQAe4SxQ@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-17 at 18:34:09, Benjamin Shropshire wrote:
> From my perspective, this is a bug.
>=20
> If I clone a repo twice like this:
>=20
> git clone https://github.com/user/repo.git ./https
> git clone git@github.com:user/repo.git ./ssh
>=20
> And if it contains a .gitmodules like this:
>=20
> [submodule "x"]
>     path =3D xxx
>     url =3D ../../different-user/something.git
>=20
> When I `git submodule update --init --recursive` in each, only the
> HTTPS version works. the SSH version confusingly seems to try to find
> something at ~/different-user/something.git or some other path in the
> local file system.
>=20
> this seems consistent with the URL parsing resulting in different
> segmentation and thus the ../../ ending up in different places:

Looking at the code, it appears that we don't let you go above the top
of the URL, which makes sense.  So we interpret it as a file system
path.

(And since this SSH format is not technically a URL, we don't have a
root slash, which is probably why this is a problem.)

Does it work if you write the following?

  git clone git@github.com:/user/repo.git ./ssh
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXnFqtQAKCRB8DEliiIei
gXW0AQCYcvW6zmY7o1EXAf1+XeSbBwboBoSUhXcyvqBZEhpHwAD/e6aMSCHMFH7a
BakpDiCV/riqY/jm8GDdbc1Vbi4VEww=
=FSMl
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
