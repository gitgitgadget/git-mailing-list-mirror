Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D08C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 21:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D206128B
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 21:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhJUVjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 17:39:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38462 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232154AbhJUVjD (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Oct 2021 17:39:03 -0400
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5D0B560423;
        Thu, 21 Oct 2021 21:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634852206;
        bh=K9zpNxdo6zOlhjbft6rzH82VWkLJ0qYk4VGG4fZXFSU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=RP55PdLyrKOPs9291P74yRQPdVRZjKMQQriwOUZDbkSQ84z9OIaQYUDwK1QbPeyXP
         Thvr0spNzIWOTa+v2Sr2aBVarTy+CkWvdja93BvuFywjBzBF03taXqV4vvlIFuMsfB
         XQkBPVkyomyGwn1KcDyv9o+lsE3w/ETqZPq+Iy3stxr8KNJBThBg6Cpbw/XCDV76+U
         fzUEPlit1OqnBMdyExgTzod2QW8PvA6CXwktK0rkgUJMa1Ccu50io7XGHG06n+mPNW
         iwp+SerxmIewnfdTWyOlO71vRNO8N22YhHcVszMgB4wBygKFT2yD3EDZF5pNk0lynW
         vwjorIWxFHOzS+I3p1ruaz7J+20LsUAejfB2Sdqu+YlWoRmVKNoAUYk1K9elUlduGn
         hZFXYKJqx+NfZvbpCgyhFV9PP7UxIjInw7SAWmq4Gg9KHQvPLWZ0eH2QSEohYTIgU5
         p+3P0xEhaJMysEUsJew7mjXYESPYHdCVCDNevb7Mv9rbZ/eNIqN
Date:   Thu, 21 Oct 2021 21:36:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Kalyan Sriram <kalyan@coderkalyan.com>
Cc:     git@vger.kernel.org
Subject: Re: Git submodule remove
Message-ID: <YXHdaQ98GJiFj0OK@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kalyan Sriram <kalyan@coderkalyan.com>, git@vger.kernel.org
References: <0101017ca3e30c39-f111f739-4db7-4c1e-aff2-3ee50f546591-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a/UaZkuwPaFxynzP"
Content-Disposition: inline
In-Reply-To: <0101017ca3e30c39-f111f739-4db7-4c1e-aff2-3ee50f546591-000000@us-west-2.amazonses.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--a/UaZkuwPaFxynzP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-21 at 17:25:38, Kalyan Sriram wrote:
> Hello,
>=20
> I was curious why git-submodule does not have an `rm` command. Currently
> I have to manually delete it from .gitmodules, .git/config,
> .git/modules/, etc. See [0].
>=20
> I'd like to contribute my first patch to this project by adding this
> feature, but wanted to check first with the community if there's any
> particular reason it was chosen not to not be implemented, or if it's
> simply that nobody has gotten around to it - it seems to be a relatively
> common feature someone might want.
>=20
> Anyway, please let me know if this is something that would be accepted,
> or if anyone has any comments or suggestions.

I think the reason it hasn't been implemented is that nobody's gotten
around to it yet.  I certainly would find this useful and have wanted
the same thing myself, so I can't see a reason why the right series
wouldn't be accepted.

If someone else knows of a good reason why we haven't done this, I'm all
ears.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--a/UaZkuwPaFxynzP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYXHdaQAKCRB8DEliiIei
gaVOAP9wi9QO2WGrQ5S5BdHy/0qvKp6mDJ78z0Cr7J7jLKnD0AEA1v+vhv7GHjsW
AD7+QGwBdS2uytmoBNknHeG7xZ9I/AM=
=Wq3d
-----END PGP SIGNATURE-----

--a/UaZkuwPaFxynzP--
