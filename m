Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD47C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 22:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346516AbiAKWkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 17:40:52 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:33514 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346382AbiAKWkv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 17:40:51 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 913475B227;
        Tue, 11 Jan 2022 22:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1641940849;
        bh=Ve2axJhfyjE8snJLY0dwoARujS/rdtncRGojCpXPzzo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BQh7cxBzZ6dT1v9U5AEuvIYWzblRocg2kGRcQZpJNtdeqWaBA+ER7CaThA1BBq5ji
         qc9NwtCS5OSNXfJJoLyUamszrLMphb8jzkbRWaPDdszInO/YsUlofpUbYu7IaklMdw
         j3seNpnDWOf4xtyvS2iEfniibKTKS6xYPnXhAn8jt/iUJ3h80kXGrxPvqxzyamCPSx
         2uNHG3rjgz4eFXWvjX6EvhWmJTBE3UzvA5szdSbrgAxj8a92nM6wzdX80FHhSJ2hrX
         KJ8GlgQz6a0MkMj3Ew601MkZrv7nWaGunqCFNpCzJ6Sxs3LXNQ3JUhypRyoebU1yCF
         lT1rxQrWZOyvr6YPncBPxJ69BMKCe3GMFCf3/tHtHSylqXbfzvjbzJt/PTfps37WvB
         dzfoHc172mX48WHHR8NE8ZU7oLeS15OhPWTiqVsZn47mSfUh+lKAWx0e3DJpv9L5Vd
         Y6zRWMhbVrY+i7mZcyi6DvL7c99+PjYxj2UbueVwx0EsEGDos9e
Date:   Tue, 11 Jan 2022 22:40:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] docs: correct documentation about eol attribute
Message-ID: <Yd4Hb/bxvJZkJP7P@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
 <20220111021507.531736-3-sandals@crustytoothpaste.net>
 <20220111183003.g4fch5d2f47it2hg@tb-raspi4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5D9Swc945AjHa+uR"
Content-Disposition: inline
In-Reply-To: <20220111183003.g4fch5d2f47it2hg@tb-raspi4>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5D9Swc945AjHa+uR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-11 at 18:30:03, Torsten B=C3=B6gershausen wrote:
> Hej Brian,
> thanks for digging into this.
>=20
> Could you be so kind to send the stackoverflow issue ?
> (You can send it to me only)

I'll just post it here publicly, since I think there's value to folks
seeing what questions users have:

https://stackoverflow.com/questions/70633469/what-is-the-difference-between=
-text-auto-and-text-auto-eol-lf/70636508?

> On Tue, Jan 11, 2022 at 02:15:07AM +0000, brian m. carlson wrote:
> >  Note that setting this attribute on paths which
> > +are in the index with CRLF line endings may make the paths to be
> > +considered dirty. Adding the path to the index again will normalize the
> > +line endings in the index.
>=20
> I think that this can be loosened as well. And, beside this, the "dirty"
> warning about setting attributes could be written as part of the "text"
> attribute as well. I dunno. Here is a possible suggestion:
>=20
>=20
>   Note that setting this attribute on paths which are in the index with C=
RLF
>   line endings may make the paths to be considered dirty - unless "text=
=3Dauto"
>   is set. `git ls-files --eol` can be used to check the "line ending stat=
us".
>   Adding the path to the index again will normalize the line endings in t=
he index.

I'm not sure that's correct, though.  The problem is if the file is
detected as text, which it might well be if text=3Dauto is set.  Or am I
not understanding something correctly?
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--5D9Swc945AjHa+uR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYd4HbgAKCRB8DEliiIei
gb0DAQDNqRSYfw+KmY1df3i+aLfg32IAuU++FId39Z/gXSOCjwD/W1kFsMfpND3b
QzWWG038EVTchQjy31O8//lrtd+LUgQ=
=c/yV
-----END PGP SIGNATURE-----

--5D9Swc945AjHa+uR--
