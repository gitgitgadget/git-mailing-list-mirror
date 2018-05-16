Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31411F42D
	for <e@80x24.org>; Wed, 16 May 2018 23:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeEPXKf (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 19:10:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:48132 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751013AbeEPXKe (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 May 2018 19:10:34 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 66B1060129;
        Wed, 16 May 2018 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526512233;
        bh=Equ7Hg/ObtUWH7MuPnZZqLupjU+4kGHFf8WmcC7Q7zE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=po2ygWKPDbgXzUmk5MbbQg1zLmu0/4qQG3wKtRAtLKLV/nCvgmGZnlha03akeDCa6
         cBUy6swNjrFF/NVFxArX76VyPuck3+3bwOxdXgdYLsAnB5IVRsHsg7few9tx2rtdTG
         Ai1I0vHD7ynLvkZgs/5il96CcehHno/OSJCKMw5DfxPvHzj8Q6J2oh4UZ/NP941OT4
         IBbpn1QjHJH1rg3M+7mjQFaXBMi/2HSw9iW6DIfO1EdxjZ/V0w/24amPwrUmJ9qLUo
         xgQq0EJuO6iFVmnATa8Jlfp7qflxo3h6wdlhZH2WYFz4LdhpoPALuSOUoq5hJBVjN0
         PpeAG6VMNs+eTu/Wm2LhHyB6BWsoWLmLo5+R6807nr0k6lKGlb1V9moEGU8l3+eF48
         vLmyz9Y+5jKXPdU3nMN1HH83f7m6cA+n8Yyp2xNTYoBM/B2PP8iiRjqIPYFdtHNPT5
         rRt6JLr0GpilqIk4B/GMCsYHD/oxdDtbVH8/BgCPVq2qcKO53Ud
Date:   Wed, 16 May 2018 23:10:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 07/28] t1007: annotate with SHA1 prerequisite
Message-ID: <20180516231026.GB652292@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
 <20180516015630.661349-8-sandals@crustytoothpaste.net>
 <CAGZ79kZ3UVYgu6xO9OCT9ZZfarhmZ+iG+J0nMNzfnZ_jrnu8ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ3UVYgu6xO9OCT9ZZfarhmZ+iG+J0nMNzfnZ_jrnu8ag@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2018 at 09:56:33AM -0700, Stefan Beller wrote:
> Hi brian,
>=20
> On Tue, May 15, 2018 at 6:56 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> For the 2 occurrences above I think the SHA1 requirement is not
> needed as the check if a blob exists (and the id is given as $1)
> is independent of the hash function, it is just important that
> the same hash function is used in the git-cat-file as well as...
>=20
> ... here, where we create the blob to test without
> writing it into the object database. In a way we test that
> the absence of -w works correctly.
>=20
> Oh, the $hello_sha1 is hard coded, which is why we
> think this test is SHA1 dependent.
>=20
> But that would fit in line with the test_blob[_does_not]_exist
> being independent of the hashes?

These functions are technically independent of the hash, but the way we
call them is not.  Since we only look up certain fixed values in those
functions, they're going to fail if we use a different hash.

There really isn't a great way to annotate the tests independent of the
functions without duplicating a lot of the logic that occurs in the test
library, and I didn't really want to do that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlr8umIACgkQv1NdgR9S
9ovzpg//bhL7/OWk6Rta3gDNhs5LmDT7jHzSC3tZVKICVvLJ5l8LR3TbQpoDmhz0
OkCiYd71GiZBHgyuHj9lV5XC0wLp3a+kcRcZAgqcFUvpzpFsvFOImy28nYb3NnFu
W/aArNoUeQW4GLYwu49t0GbXxK7SAb7/YLhiBpFK8lafW3lvpquCUVzmYZpCL2Ut
my+fp+TSLd0vu9xAT2acSf1r22DCkat4G8GAGoxtjmJ6bCrc51R/4oIoFrE9eiUn
6J/qRtcXLSao2a2WNm0K+LXUyaHPMQVa5zKA0VjdyRdmKuyBK108U1U4ENF79yr2
c5ywOwjOa/uvtYj+XVaA3avCEPqn6gqJox/cWANZ0ZHyJdiWDKpHCRiHXnKiEMCg
U60sAvq54q4oN3b/Y0t6jgJeZSddyig+JlNVwLkoYWfR2B15VcaO91TiEh/cK0iC
BGijb/BtXzvb8zl/UX9zVrU8rwx4MhL5Uecg+t14n82YMFYizLLrNd4nIbSKTP+u
UUzfo7Cpq3snvi3vozDkq9owEP0snt+Nf5cfN38bhF3n4SSlFeuQkCTnyDI7wKB/
3QL0zzuo6DJ8rL8JfJLKdQFZK8cQbGqw8R8s7iAKdqOCFUb4r/8ZzgkAsYnS2det
CAPJbS62wZxbCdvVg9S0lwcnf45d1sCMnOqqRSYXTUwlVsfi4vI=
=6fzX
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
