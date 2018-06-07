Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FE991F403
	for <e@80x24.org>; Thu,  7 Jun 2018 01:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeFGBZ6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 21:25:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34544 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752456AbeFGBZ5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Jun 2018 21:25:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EFF0060129;
        Thu,  7 Jun 2018 01:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528334755;
        bh=yQMgU09mIls9r6KjRbT0wxvPRMRQjaIV33QZDlKzxJU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=udzRxZ1cjIhjs3ys05ySp5Qn+ou/WIRQHkXIs5y6u+JnM2uD5dMEzrybDIQdnX5ZA
         Pu4sIYPzG89XWDzf5KXHoyRWgDQXsbboOlNt1yK+S4lU0TlXl7APfjGUBGid5jB64x
         Wd3G0QI/+iJLoRPws5EnN/H/JFjMwL3VhpX1cGiLgTG9CyxsWoqxeum+1gGOSxwNPd
         ocN26npbdyu3OuRHEnGwaMb6ABcdFN949mlKw9TJQuTgidYXH6X0/0T5MHqsElmcDM
         M5yTx8/bXJz9ua6LHuvZs4c96EbYVX/O5C1cZcSLtRbPuvcA7HXvwChiJ2gN8AcpRL
         aalR10qLAxJ7LKaWgPjbjJP7RVOTS782lffYiInea+Tdw6dobbB0w8nv/czy23B6fj
         d38DcFDrDApExONw2uSVMSkB3C7KvR0h+ykhUvzJo+ItkYEXBjr/Ac/1pWPhokjyQs
         p+B7HSiPQ6Kd9BEHuVTM3d6aXfDvIiJOIO6+lMk2BD2ztKQ98H9
Date:   Thu, 7 Jun 2018 01:25:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 04/10] t0027: use $ZERO_OID
Message-ID: <20180607012549.GB862596@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
 <20180604235229.279814-5-sandals@crustytoothpaste.net>
 <20180606070222.GA11992@tor.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <20180606070222.GA11992@tor.lan>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 09:02:23AM +0200, Torsten B=C3=B6gershausen wrote:
> Nothing wrong with the patch.
> There is, however, a trick in t0027 to transform the different IDs back t=
o a bunch of '0'.
> The content of the file use only uppercase letters, and all lowercase ad =
digits
> are converted like this:
>=20
> compare_ws_file () {
> 	pfx=3D$1
> 	exp=3D$2.expect
> 	act=3D$pfx.actual.$3
> 	tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp" &&
> 	tr '\015\000abcdef0123456789' QN00000000000000000 <"$3" >"$act" &&
> 	test_cmp "$exp" "$act" &&
> 	rm "$exp" "$act"
> }
>=20
> In the long term the 'tr' may need an additional 'sed' expression.

I'll take a look.  That may end up being a more robust solution.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.7 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsYiZ0ACgkQv1NdgR9S
9ovo6RAArXHSIokzJ1YKRptndy0pntI998qE62++apsWBnVw1g3ZJScqCY1jM/Bg
3nu/3l5wk/M9SdBGYAOZjXu5fI3E+IgllT77K9F1NammggI0L4uxLxgfPuCiOsAS
mlJpJkzMbWu7B4W+f5MdwIBzp4FOSgetSVumKlPwNKNg8ZZvAulLgccCRYxcCFur
0dtw+CC/jcFqWX7l/SnRBoKvUmldp2/+fOwrY8JbPJcveGhM6UyOZv2mc10EeVsB
Mn/Hvx0dFaeGt4XsatwnwpKlNodpef+CzAJ/GL07IifJtyfFoe8fXKdtQs5LlDnm
YG7HJMncn29N/Gg7ci5l2W2KE4YImxyWoqXBDl7LxkUWys/Odm+Z0xgEzsaaD8oU
m91dwOgcJvXvAx7VVMYa4dtw/FUnFs8GMyaossmXxf3NpBcDRH3dwN09cebvidBU
BoH+xcuWxQfBNw6R0q7eGl0nkOFbmv4FbFTBK0K5CpKXRNSCiQfopV5pl2Z9RDpP
fogYKRrhIM1VdRDTySuXZEv+4K1HgxzpDS0IauW/HI6FeDyHETCgNtt4PQArPLv3
Jf6GV7EZB9tNLHGBPI2uroh6IYaaJSyqsT2KtouowCFPod9HuyXaM5dKEImlqa+m
i8uICABNlp9LrvuzhcvfgRazjN73W3GR9Ic+7KlmuqUdige4ojk=
=5FxT
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
