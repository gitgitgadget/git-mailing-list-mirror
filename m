Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C051C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 18:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbhL1Stf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 13:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhL1Ste (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 13:49:34 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508AAC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 10:49:34 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 18C8A5B21B;
        Tue, 28 Dec 2021 18:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1640717373;
        bh=3F0Net4D4HtXx20vHJKVgkJvzP93JecLtnxnpy42fZ8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=b0sgu7Ye1DjndZIMqe2jWcKYnB11Zr8qSWpx+KZLgEpUb70/Jz+e/4kXuOA3JBEs2
         veJtgzhnJwv50KZb6vr760vgE7jKf5cbx4yZXLW/J9JgQz5VrrTOnlW8ZNF/vV7NZO
         TCrTAdYcE8+OEFjaaOe+qtYhPwWA0AV3OIwsrznJ1ua4bwIpwS6BY/Jrl8tAzLFoNx
         PiX8ebok8xEj4OB6yYI5pMPbI/NeoNGDxjaK9Edu5QmHQJjh4aSQOw8xN2lxZEP/QT
         2TgEpbxP4cIEh1NEKffInOUVbuwjPXS3Vrq7/ljziN2PYAEZlZshw56+A4vwjv5fmi
         1+ALNb6Z6XG6uy9qFfvr8fePqvP5YPFk5qhNMB9Vfo+mCxxuPWxostU21q5zELty6N
         cKLaygSccS2gy+lSEYLHalp5JTyqcQsJ/eEO8e84F0pVt4psM6zJYZoHFCQGLRIby5
         LcnwkiVtdv58PGOg3yWdh7ZlT9mlur/nRZId+h0+vVORJmYrqpD
Date:   Tue, 28 Dec 2021 18:49:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     rsbecker@nexbridge.com,
        zhiyiren2009-subscription 
        <zhiyiren2009-subscription@protonmail.com>,
        zhiyiren2009@protonmail.com, snakamoto1975@protonmail.com,
        git@vger.kernel.org
Subject: Re: Quick login of git
Message-ID: <YctcOTeJUrBraa9M@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Erik Cervin Edin <erik@cervined.in>, rsbecker@nexbridge.com,
        zhiyiren2009-subscription <zhiyiren2009-subscription@protonmail.com>,
        zhiyiren2009@protonmail.com, snakamoto1975@protonmail.com,
        git@vger.kernel.org
References: <7w7c2MDOBpV9yIlD5yZZb801w-eaz0qhErkCN-De51h892xRFL14N-LCXH0O8wvDp_51A3hC86EMXonBkjNdoTZ-iy8xzoKLVecN6D6Zpq4=@protonmail.com>
 <004601d7fb3c$c9d359c0$5d7a0d40$@nexbridge.com>
 <J-VncZqqtXGSpnkopiYEtOET-oeVZX1tk3jBX9c3oSaOrcH1N_ciDdzQFvk50CkibrWFCboQNDeegBNMGZ247duUXwnPFY_0HbFvEWI0hVg=@protonmail.com>
 <000001d7fb3e$7c0e8730$742b9590$@nexbridge.com>
 <FKMNcEoH2PMBw4wcDkxzCDdl41kpWkZyh5SkiRlDi6seiVchbCuBbMmc38SFYR8gAgDhk_vo3xJSCiPSdYRIvhOQ1cB4uoZksClDYey2LXs=@protonmail.com>
 <000801d7fb5b$12ec49f0$38c4ddd0$@nexbridge.com>
 <CA+JQ7M94QXWbFnJfzewqecvETmJC9fVkFAb-+RHFuswj=FdnpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="avZjmRUEB5GbD15g"
Content-Disposition: inline
In-Reply-To: <CA+JQ7M94QXWbFnJfzewqecvETmJC9fVkFAb-+RHFuswj=FdnpA@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--avZjmRUEB5GbD15g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-12-28 at 17:15:26, Erik Cervin Edin wrote:
> > On December 27, 2021 11:07 AM zhiyiren2009-subscription wrote:
> > Why not add a quick login method like VSCode and CLion in git? Login
> > to
> > GitHub/ GitLab with one click, without privete key.
>=20
> I believe you're referring to this?
> https://code.visualstudio.com/docs/editor/github#_authenticating-with-an-=
existing-repository
>=20
> This is using PATs,
> so the same authentication can be used in CLI.
>=20
> I recall seeing a github login window when I was playing around with https
> authentication in Git for Windows.
> Not sure what happens if you login through that as I quit that window.
> I believe the default credential helper already saves username/password
> for https remotes.

Git for Windows ships with the default credential helper as Git
Credential Manager Core, which will try to log in to some of the most
popular services with a native token.

However, this is not a part of core Git.  Folks who would like to use
this credential manager are welcome to do so, in which case it will work
for some services, but there's no way to automatically do this in the
general case, because it isn't guaranteed that a Git server provides an
automatic way to get a token.  For example, my personal Git server uses
only Kerberos authentication and doesn't issue tokens of any sort.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--avZjmRUEB5GbD15g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYctcOAAKCRB8DEliiIei
gX+fAPwO2+NubctRvnEK9tkzppaRZuB8rpHdpbsYmPQeu8/0dgD+PxlHmXliny6i
7aIc8VGuR5Ovd5KYALa+cnHGbKXMIwo=
=CNKw
-----END PGP SIGNATURE-----

--avZjmRUEB5GbD15g--
