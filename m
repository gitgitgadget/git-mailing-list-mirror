Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 921171F403
	for <e@80x24.org>; Thu, 14 Jun 2018 10:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754978AbeFNKNw (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 06:13:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39126 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754927AbeFNKNv (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 Jun 2018 06:13:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b0c3:20dd:704c:b59d])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EFB0C6046C;
        Thu, 14 Jun 2018 10:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528971229;
        bh=Peua7IpD8gwcoCWUsI3rZiCNk6Pw7u4EFEJfsxd7//Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lb9ewWFqZTrpR5LIZGtI/UiDUXauwn8c1seGKbFZ2s637TD3XJ+4NbScbKlwSKs5B
         YmtvtrTu/dwUwnnQYqV+5D3nCy9P1wh5hmQ6AaGFJZfr55Bh7VP4QZFiu9F28GDTKM
         vo+mq4hfY9QxZvx8y+9tFaqo3Zs30SJdzrbOiDw0n7oFOh/Swq0yQ84ho/LAYGn3tS
         upGvqaBZ0rud/2moXyLHNxzFf4W/TS5y6lOmyESDZqjCEaOJ8yerZWOaeTjIAVfCo0
         qRWqdBnBQVgbVM+19dotEuZaROdFzitdEr5SjOrAJNiGDq1jJ8KTdlOhdsDCFWDmhj
         J3crK3hjDncwImshFxLQqLa3OKYMuo4FToeTz+dQGSeOLxRvLwpR5GkXFWbcZkyweM
         cBaGW5QdKub2OjTT/Xn4zcZMMimK15yA9kFZPSqI3jYXt7Dt9+4PBa4fHoi4KqbkUt
         J14rPeE9199RuHXXR7OKw7Z06zQ3r5uXjqU9IJDc+WOI5Q5vvXk
Date:   Thu, 14 Jun 2018 10:13:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Christian Halstrick <christian.halstrick@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: OAuth2 support in git?
Message-ID: <20180614101342.GO38834@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christian Halstrick <christian.halstrick@gmail.com>,
        Git <git@vger.kernel.org>
References: <CAENte7iUYcLX1ym1rdiYT2L8yLSWforf8kUvfHKLvhi_GhKQvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SavPGzlo48F1Gxyz"
Content-Disposition: inline
In-Reply-To: <CAENte7iUYcLX1ym1rdiYT2L8yLSWforf8kUvfHKLvhi_GhKQvg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SavPGzlo48F1Gxyz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 10:09:39AM +0200, Christian Halstrick wrote:
> Can I use native git as client to contact a git server which does
> authentication with OAuth2 Client Credentials Grant [1]?
>=20
> Background: We are running gerrit based git servers [2] in a cloud
> environment. That environment supports OAuth2 authorization for the
> apps running in the cloud. The idea is that clients (e.g. jenkins
> jobs) talking git over http with such git servers should be able to
> use OAuth2 tokens to authenticate clone/fetch requests. We would have
> to adapt gerrit source code for token handling/validation but I am
> asking here about the client side.
>=20
> I know that other git server environments like github support that on
> client side by allowing tokens to be used as usernames in a BASIC
> authentication flow. We could do the same but I am asking whether
> there is also a way to transport tokens in a standard conform
> "Authorization: Bearer ..." Header field.

There isn't any support for Bearer authentication in Git.  For HTTP, we
use libcurl, which doesn't provide this natively.  While it could in
theory be added, it would require some reworking of the auth code.

You are, of course, welcome to send a patch.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--SavPGzlo48F1Gxyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsiP9YACgkQv1NdgR9S
9ouqEhAApPuPjWw6qgxbLDbuLWvIA4zHTOyJ5Vd28k9XfNxiv3kDB4UvUDfbdlv9
alGR3b2Bda1TUpeNoTbgXRl7+WPQ8itPJgWGuvD78173NimblEU9M+KZF3Ph8di6
9/QVbIYCoXBsOSRhBZ7sLhyXShMubOKTWz6usdRydEuFPEMYwHNxmc4IPgiL3s0l
HzSHa/PSLy0oCIvG5Bx8W+qZob3fdM16t3a8ZQgSIFaHeyIegNgX6qQgYVsBZmDg
IjxrOEZ/UYNjDX3wKmiWEf9/GYYpY1YYE1AZ1dHz1jrSXgQu7xWulEyTOd5S08/l
N2gY/mOA6XyuY2AXGfQH7dXxyhn2LRe69yp1Gl9+Vkos4bENDeKpp7pt/yf5x1lO
16mFh98mfTyzH/onAKUP/M7huRCh+QPFz9IKo0fbf+3Teq2rxrtEzVVLMI9VnJ7i
I4FVH3hkK+SXGHRUAG5c2PNihcvTbaSWjP/xKVtjOKBnVeKQnIE8GGjMK7Ig0SFk
HJu1qaW43xzjfMh6rJ+tIkUR6znhT12NAqSATr05jfRfKHl3+gYEERmQnGyYM3e7
GIX0jdxws+SdgQPaQEzizO1lMmZ4ZNUeAcKNW+nfFJ/r8y4163o/XhLTdl5dUa59
kQNFr2oYF3qiWbcWFtyAAViGjj1tVbawp+IdgYjmtjKpS0zmOw8=
=ihQa
-----END PGP SIGNATURE-----

--SavPGzlo48F1Gxyz--
