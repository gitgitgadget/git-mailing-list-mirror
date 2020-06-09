Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C5EC433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 23:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA8712068D
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 23:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="rBjtkAbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgFIXON (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:14:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39154 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725468AbgFIXOM (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Jun 2020 19:14:12 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 255C160756;
        Tue,  9 Jun 2020 23:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591744421;
        bh=48iReIpVFwohrVjLsPH8BmN90TlbLmjxhcsxfUggwD8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rBjtkAbWUICTXbMBqsf62Xi+MiNLgqtGmHsZByCuAQ4ICmOyr6IQTP+T4+iFsw7ck
         cVHKesWqhbRo3SYWiimljym8tsyP88Nkb+qpMU+a0K9Lf7WeoryDZjRS/HDUzjxJKW
         jHGX6x5rEShMC0H8pGoPH4SBkYyEaTUCFy+4cZCwgrJb6j82yRpZDEQw3mrChSZ9ym
         5O32HMcvrmpzx9j1IZz6aazH3Cw/0ebRb0BTNQQg79gSTyhyZVMqlPzOf1AsB119XO
         mYy8m1t0ys/2c8o1F0o8uTR8Afn8R7/CarXGnPB7z1PQxUK5gVUe0O8e9jqCopNjVc
         63RNj2kCwhqQ0MLith0k3EmxMNbaC4DnQcxuVzu/eqVTVWtMyGQwkkHYozRp0Tu/v1
         aEHBstkx/nDqSifDQ3B6ER7/tCqlmzKyYSnB+hpfU9n4+WYho7eNivEa/gS8tV2Idg
         Gj4DT9EHoF2Kt6rZZCKRfOyaR8ou7X+1IGoVeE7rqh3VVsznCey
Date:   Tue, 9 Jun 2020 23:13:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: osx autocrlf sanity?
Message-ID: <20200609231336.GQ6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CACPiFCJKvnDL9Xj1Xs0RCvuhymjDz4N0hT42dNtBQxp+TLiPaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f4HxWLVbzokH9yio"
Content-Disposition: inline
In-Reply-To: <CACPiFCJKvnDL9Xj1Xs0RCvuhymjDz4N0hT42dNtBQxp+TLiPaw@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--f4HxWLVbzokH9yio
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-09 at 19:52:42, Martin Langhoff wrote:
> Hi git list,
>=20
> long time no see! I am here to ask for a sanity check. I'm on OSX.
> Checking out a repository that has an un-controlled mix of line
> endings. Mostly linux-style, but some Windows CRLF endings.
>=20
> A few tests.
>  - I set core.autocrlf=3Dinput globally --> a fresh clone doesn't have a
> clean status files look modified right after a clone)
>  - set core.autocrlf=3Dfalse globally --> a fresh clone doesn't have a
> clean status
>  - set core.autocrlf=3Dtrue globally --> a fresh clone doesn't have a cle=
an status
>=20
> This is git v2.23.0 from Homebrew.
>=20
> Am I doing something wrong? Can git work sanely on a mixed endings
> repo without having to fix the world first?
>=20
> ... I do strive to fix the world (and this small repository), as we
> all do, but it should not be a preconditions before git behaves
> sanely.

Does this repository have a .gitattributes file and if so, is there any
correlation between the patterns in that file and the modified files?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--f4HxWLVbzokH9yio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXuAXoAAKCRB8DEliiIei
gTHoAP9eqEvHL5BIgILqzYvhQt3NkxbyMIMkLwI2y6dEECYwvgEAhbgNMIHpaxym
CZ8z117bo6ImmC+wNZnHlXbN5qEWRgA=
=Wydx
-----END PGP SIGNATURE-----

--f4HxWLVbzokH9yio--
