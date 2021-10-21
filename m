Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881C2C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 21:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A2A96128E
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 21:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhJUVf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 17:35:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38460 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231529AbhJUVfy (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Oct 2021 17:35:54 -0400
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 326FF60423;
        Thu, 21 Oct 2021 21:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634851987;
        bh=Z5Dwj27OkydR/PjhIg32AHUZLur6+mHsA2HNZMxL3L4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=J23OxYez3oeRSGrIadB+XzBRYgu11zKeIa20EDw6D6/fI4Ws5zKFtq4ehkiXExEqe
         LLzkqpJaoQ5hKJOjGSr+OXB1oWViMjCNEEo9yHpZSjc0O807BBv6YjeZahDE1bX/WT
         89wAhFfywFuCxZ+MoJbB9jF8FdBHDWzNNraayJrBVR71HCoRSvYLLFlcirs1cG5NuB
         Orbd5B2y/Ec4/UDR/plM2ujs4Bn86i5XZ1BL+n7YnN+iA6CVMewhF8JLVkFKZR62zr
         8AqEFVQv1b3qBvCGB3lbgu+RCdKkR5kZ4XR4/nOfZ7pNOlvio46OtuPrc0tszUe1Y3
         1MgvT7Z5ofDH1daXetBSJdu9t8EtkiDunGwa0D/bow/hglFk4psTyEizGmkenUgslX
         HG3DU9GehuqAMr6Fv8Mx/MfxVvgP65n0gdNwC/Yq70DosN6gLXHtBshUy3kMvVsxkU
         UYYIIHZkvoLrtueEFdN0YztRgGo8dE/CU4nAHw8rLtp2JDCJHuu
Date:   Thu, 21 Oct 2021 21:33:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     git@vger.kernel.org
Subject: Re: git format-patch --signoff
Message-ID: <YXHcjbiE6GX6zJHk@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        git@vger.kernel.org
References: <YXHaAu2G51vy5H8z@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GYuv7f6Yx6FOze63"
Content-Disposition: inline
In-Reply-To: <YXHaAu2G51vy5H8z@qmqm.qmqm.pl>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GYuv7f6Yx6FOze63
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-21 at 21:22:10, Micha=C5=82 Miros=C5=82aw wrote:
> Hi.
>=20
> I just noticed that `git format-patch --signoff` adds the 'Signed-off-by'
> line even if the exact same line is already present in the commit message.
> Could this be avoided in the tool?

Just so I understand correctly, does it do this even if the existing
sign-off is last (or the only one), or only if the sign-off is not the
last?
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--GYuv7f6Yx6FOze63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYXHcjAAKCRB8DEliiIei
gfRKAPwPOYGCf7QzTwcDoIy2/Rv1lpoKHqlPJL3BP1Up6i92ZgD+O/i0LP5NueEI
Y25qUprWVI+A7eQewy3W3vqXrwRntwg=
=wnhj
-----END PGP SIGNATURE-----

--GYuv7f6Yx6FOze63--
