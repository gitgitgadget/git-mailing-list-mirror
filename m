Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9AE1F4C0
	for <e@80x24.org>; Fri,  8 Nov 2019 01:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfKHBpZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 20:45:25 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35100 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727024AbfKHBpZ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Nov 2019 20:45:25 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A08A46046C;
        Fri,  8 Nov 2019 01:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1573177523;
        bh=CGNOU9lfHZZ6VtDAiBLjEUGgLx9JeVA6yojcZf4bSdo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YV2iw+Lw9F5QGMXZVB2GC0R9827e41Qq9vJJPG0zSIXNOx6qX19p9kArjezxLbmLT
         5krUhtiSN3p/BogqKq4ftL4bVJQJLE72XTytMb0zfuI5P/zs9xZf/2E0LR31/s+l6U
         pux7McufV96/7u+Wv0uUaJ28BJczmWE+x8Mgc+XPOvd3YVRsj7PUopHS/31KEmPgvb
         3p2iexdJ2Q8LPLqK0g+WKmlaKyWs4xDryFwq2RzGN24gvJJ2/NNI6UcbKkHiWMT+Xp
         7rIiWGPv0mH/8dH9NhthT2ZQ3IjfpZQZcl+uYuLJIOBM8gPS1/qiXOjjiHCTgIzfv3
         Jff5NdMeIkQkQT2DJq6BbmV7ZmmNk40I9LdpxKkBrMwaH4SXu4vwoPnkuYT5jrf394
         X/FKQlNKtin/jOEylbEpiEtxpZMSsOnFdQ3n6QCp8IurJnFITgZ+Dt6YJVKLAwJNI4
         fwS41LGZ2zXZmnw5e6BIxYgsQLvPXugIVAchthjBRu1077+s+rK
Date:   Fri, 8 Nov 2019 01:45:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Benedek =?utf-8?B?UsOhY3o=?= <betontalpfa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Improvement] Separate protocol and path in gitmodules
Message-ID: <20191108014518.GH32531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Benedek =?utf-8?B?UsOhY3o=?= <betontalpfa@gmail.com>,
        git@vger.kernel.org
References: <CAAMvNNQyzMwAhizT-vBpbwfzAAHS6Ycx2tCLZ_eND3SK8WdTGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cW+P/jduATWpL925"
Content-Disposition: inline
In-Reply-To: <CAAMvNNQyzMwAhizT-vBpbwfzAAHS6Ycx2tCLZ_eND3SK8WdTGg@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-1-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cW+P/jduATWpL925
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-07 at 13:52:28, Benedek R=C3=A1cz wrote:
> Hi All,
>=20
> **The issue**
> My problem is based on this post: https://stackoverflow.com/q/40841882/25=
06522
>=20
> **Use-case:**
> Git can be used with SSH or with HTTP. The usage of SSH is easier, due
> to automatic authentication (ssh-key). But I have to use git from a
> public PC, where I mustn't store my ssh-keys. On that PC I want to use
> https's user/password authentication.

You can use the url.<base>.insteadOf feature to rewrite URLs, which will
do what you want in this case.

For example, I could set
url.https://git.crustytoothpaste.net/git/.insteadOf to
"ssh://bmc@git.crustytoothpaste.net/srv/scm/git/".  That would rewrite
the SSH URLs for my Git server to an appropriate HTTPS URL.

It's designed for situations like this, when you know the rewriting
rules better than an external system.

> **Suggestion**
> The root-cause of this issue is that the protocol (SSH or HTTP) and
> the path of the remote repository is stored together (in the
> .gitmodules file). If they were stored separately I would choose the
> protocol easily.

The problem is that we don't know that a repository is accessible by
both of those methods, or even if it is, what the correspondence between
them is.

For example, my personal repositories are under
https://git.crustytoothpaste.net/git/bmc/ and
ssh://bmc@git.crustytoothpaste.net/srv/scm/git/bmc/.  Those paths are
completely different.  There's no way to intrinsically map from one to
the other without external knowledge.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--cW+P/jduATWpL925
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl3EyK4ACgkQv1NdgR9S
9ouwBg//WStJAHuG8PzlND+feJqrHqFMQyRvZVdjy6kbmortBbvGUchri7J0/i2E
2JoN3WEOEFqWlBETlXvviq9wLYD1fHGU2/qZazQjUzD9mcQ0GxvUpfJSAy8mA7QL
Ny7T0uGXcR4qvgf+MeuCDmayFBvlbS88fK4mWE+JCpRj6qf8w0Xtn+Uz+x8TuvEU
ICHtKaznG8kGj6rJkSBXXHRtfqFLqdeJu2XjPdNEYr8adhMrBLazqNgfYVw99rou
TZH7RVPlTQVtwqFdLwRYqf9Qo7qnXvmX4oIW+Nuj7XEUMsdQottOqRU7Q6D18wzE
TUOY3I/2NqYvooFuHuoOVdS/K7cUXlIakeKGKvvhKJT+j2+8bayrpsdR92LWzK5a
BJcGCMaphpv2N0Pq28xzi18JRtEjP2RmdJRw4L7/D97AFx8vymr48ch8gDv/j3M0
4Lafl6Kzet+zj7Y53uXjYoMsU+w4eAj3Rrfd+Gmv3oP+7QqFaG18SxZ9W8FmTZdE
ky6wfK8p5gpQtonS/iqXoI7t1tFKi3PJBa2rxbh7UcXxs6ANIo+zKNMyZuBawCRI
LCTcBISRJQ29BqTeFnPxFKqJK1dJHj9L6AMnlTOGqoK5hR7LDW+tD2cQ8N495h9y
3meqVGOl5XZhTHlYo06qCe5tb9kgwEuGV/+WBPFyuaJbt72zs88=
=ZU1f
-----END PGP SIGNATURE-----

--cW+P/jduATWpL925--
