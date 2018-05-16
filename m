Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623561F406
	for <e@80x24.org>; Wed, 16 May 2018 23:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeEPXqz (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 19:46:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:48158 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751273AbeEPXqy (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 May 2018 19:46:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1616560129;
        Wed, 16 May 2018 23:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526514413;
        bh=yGVqzmwXm4bpVCCBp+XzQH7+zJvdI/vOqjRlx6uJydQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=O+aKnYl8ffymNMEXFELkYYhNFiESj2FWQsKEx6lz0oOp/3deHhw2jzfyQXs/lsuTY
         kb0wqXXziQfDdy3ElkfSzA7yHBBQBLGPCsaZn1HCbeCSHe268hke+7cFH4niN+Qf7p
         MQDl5HVlZkbNqc4IapYMJuVYuYGFjvVksWE8qAhXmfQ4lPwb1c2v9JHHdYRTuYKfAc
         TWXYM/DMNYxVCys6UlMdakz0I1ztK8OfX2QVqD0FJV6ShoQyA/cZUVBWslnuTETonu
         3yn8X1WQ+PCh50x3nsrOQL3sscqXq3s228u/EGVrHQ3z/IjrVYXUs0zuDp1d1UuyxR
         MkI04ikQo9kCOL1tPJdBbU390/f5X8FOuLphPSpaQU3WfxceqyjLDRPWGdop9sWkPt
         pQo5a4zLcpsI3OO685UopKzt3FImnJrzuibZtfVTAcc23jDE07+VXqrtBlnJ1Yk/Qx
         f1myjBFwaO075XHFM88iUuyvybCQUHXXP0JGGuAQiMeWdb+NtrM
Date:   Wed, 16 May 2018 23:46:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 13/28] t3702: abstract away SHA-1-specific constants
Message-ID: <20180516234648.GC652292@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
 <20180516015630.661349-14-sandals@crustytoothpaste.net>
 <CAGZ79kYrDDGtSSViUwqOaJCTUUcUaiJe1DQHGSqS+3SCYnEv8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <CAGZ79kYrDDGtSSViUwqOaJCTUUcUaiJe1DQHGSqS+3SCYnEv8g@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2018 at 10:18:33AM -0700, Stefan Beller wrote:
> This reminds me of the way we test alot of the patch format already.
> But there we use standard grep as opposed to egrep.
>=20
> git grep egrep doesn't show a lot of hits, but all commits
> that mention egrep found via 'git log --grep egrep' mention
> that there is some sort of portability issue for using egrep
> specifically.
>=20
> Is the ^index a problem for standard grep, i.e. do we need to fix
> other places?

I think this is just me preferring a more careful match, but if there
are potential portability problems, I can reroll to use regular grep.  I
don't think which one we use matters much one way or the other in this
case, or in general.  We don't tend to produce a lot of potentially
ambiguous matches in our testsuite.

I think the uses in the commit messages tend to point out quirks in
command line options over specifically concerns about the use of egrep
itself.  I suspect the implementations that want egrep over grep -E (the
latter being POSIX) also lack many of the POSIX options that people want
to use, although I'm not aware of egrep itself being broken anywhere.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlr8wucACgkQv1NdgR9S
9ouogRAAy2cg5IKUVeHV92qn3VrwOYM254R8MuIbR9S1IqwaXIrjNKrohcoP9ydn
QhWjHQHaTa0IMfdiwBEU0S7RUYbev0LHd05dMcoaoNP5hMAJla4oH1TuInlb+IKs
utdq84iJZWecOL8xGwJsgdzTrty78Po6anwlCDQxzJWvHpJCUhf6pkjdomlRrHoS
oDH5VcBAPeShU+wIAynjMNlx5ouLwGNRy5/CN10tH7Im3EOmia1237xgwhEiFZqu
Kj0S/I6pHRLFJYw8eI4AKO289wpCzoAFeUXf63NkQOVN9wjb+CRWnQ0F+nzSDiH5
pgyhXP0O18ZSmWIIZK6UuFIKYCB+i2HapjGlBQFZp3rB9at4rkoIt7lFMnef8Py2
LYKcGKScaAoEG0RIImyHyl//bWH0AzePKWHsgAsGw8UAVZejuxsvEr/aSVLaqZZ/
W6b8D6pPVrbiJ2HvVTrvXXvgruQtU3LZes0uazDoUN5aQBWOeTUyYE3bKvkPGthX
d6VZcHr7Qv9j8rPHoUuxtCuU3Gyp8F+EtWgeWSSoccFO3VpRLOwO9NUQnhHW7waR
HTmt7MPy90aF9dlqAUUG3gcTc5yN/wycJqRX+5/QmcG8jD6lu5/rbUiqppMaZGvc
2aK/I/V7xC4YugDMOch2UDYLhiKmMnrALcg4Ocj0y0VvqWJdvc8=
=UpeT
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
