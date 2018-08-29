Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F36351F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeH2EZP (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:25:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37156 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbeH2EZP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:25:15 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E2CC16046C;
        Wed, 29 Aug 2018 00:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535502665;
        bh=tJguhVjDIjnGjU7kK2CqI7l7jqKJKPsDqPYhIzMnU8E=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=s0tovPLhgQ4d+DDzWeeL4WVG4R8xyvOFPPI9fgWeFLLCvMLgqmRn5fI1oAR/Y+Wyx
         t2Q2q3ZWBp4YRzKFHujZEw94WnH8vtK9q5f7yBd2HIo6Ros0P67kD6EkwMqdoruDcc
         yz7wEysaBKGhi4qdujPhcrcevLxBIapAPzCaaO7HqmqXA/eA6zr0bVwKO1hq9dz8o7
         u2yc0YXbFwoNQMhqAf/AkQuH/lT4SEgTrac00kouPsRaaaRcI1v4+aaEoQZoyOxz0W
         o4gdvZ3U5hGxH8kHOsj3O7Y4yiDw5ztsyNbSKp8yIy0LbWTzWpCCf2lpulIgXtU5JM
         ebG14KMkKfF+cmpmlkQ7hEdu8ZplZP7ANRWI9CTD7QL8G2pSoBiB3oYp581BmGVlIn
         exave40uF2eFR0L/qHUiNuFKe8ZnxS0g9Hgt5zydpEdGUd9Ckl9ZBiqOtBskk0zPnb
         MplGj6am73NrKm1qWaQDNvWQiQ6258mhNRcpsR5qlNazr2+Mxfr
Date:   Wed, 29 Aug 2018 00:31:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Tacitus Aedifex <aedifex@sdf.org>
Cc:     git@vger.kernel.org
Subject: Re: avoid "Set preference list" during make test?
Message-ID: <20180829003100.GD432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tacitus Aedifex <aedifex@sdf.org>, git@vger.kernel.org
References: <20180828235355.GA10708@SDF.ORG>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
In-Reply-To: <20180828235355.GA10708@SDF.ORG>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 28, 2018 at 11:53:55PM +0000, Tacitus Aedifex wrote:
> While running `make test` on the git source tree I keep getting asked:
>=20
>  Set preference list to:
>    Cipher: ...
>    Digest: ...
>    etc...
>=20
> Is there any way to turn that prompt off so that `make test` completes
> without any keyboard input?

Can you tell us which test is running when you see that?  I suspect it
might be one of the tests using GnuPG; if so, can you tell us what GnuPG
version you're running?

Also, just for completeness, which version are you trying to run the
tests on, and is it from the repo or a tarball?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluF6UMACgkQv1NdgR9S
9otvwQ/8CnfICTvHWQRwuNlZVr4+M2tBCJbE1lHE9zOKH2LKFwz5EklY4o1xsNzs
luLb0qEtfJsfe3qGGy/hh4teE7D9/JtRf22awHar4bu9e/rUOBwDa8BWlFMEZwIR
x13OESqn4VgNCd7pCDop5e25OqkeUuxdObjxZfrkrxS8U6JYAQEiq+JBy0YVW9Qo
NUtsECJQg8hGmR/UWghPxSGfMiHdr9M1fb9vzjbK14Y8J3oayZVTwegyqnwqvpU4
XeWqH0mXR+5wiKMh+sqrF1bHpFSOPqG6B8plinWvCeiG4aNVfSo4bjfMC/yA8dI8
Wf1ZmncqchKQntLKP0eT9qo+KiYlGrugYEsjTY2yImd6vfCrmken6s0Iu0E7Sqdm
1VOjR3g5rEc+L9biEFWTLtVlGSpulMw7m/YV4YJ6bahlQOrTKYgMlnUOv6Y7iX/p
2kh78+r/3w7+T4updDFYHazGJC9B6Nys3TDV2LnljpWjyKYQY+YXuLv2Wq17pwwk
Ww5UW2noUeVnKVZoW/HvBo5yai3GOfxbw7YhRMUGmEIiFfKL6wYjW5EWCo5nlFEQ
4OEBeZn2jARHcA7Fmxu7qv7zXr7RytHwOyiMcBr3MJ9Jbj4xnQ0UyWLx5xRrlZZH
eepbcK/H13AZpblp1KcRQ1N2nIFwpVOwC5Kpmm/ZZl+rV+iKYfM=
=9uf9
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
