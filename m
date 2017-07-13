Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B37202DD
	for <e@80x24.org>; Thu, 13 Jul 2017 02:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750959AbdGMC0j (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 22:26:39 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59042 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750933AbdGMC0i (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Jul 2017 22:26:38 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 52039280AD;
        Thu, 13 Jul 2017 02:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499912796;
        bh=dM2kA4vWgUXoQQWcJRk6PgHU0N3IutUwDew3S3Rl1Gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DndEHfwBfFPxC3viJbG4A9bKc82s9M6UE802ITu/qwgKd8jQzpAynzEBXflYHbxJX
         XUhiuYfSpxyR2tm7LyuKs0z9ja1U+1Wf7xXoakdlOsxqtPLaXnJLHMKqaMFf7+0tD/
         jEGC13Q61E0DUrgpGhiObGUHyOcai+QaA2RwcFaBwheVidx36z6YTGPCR56/Rg1wKE
         2jnV2EfmbRc2lOpp/bIz9tv2mridFx/K1aQuskx7qyFu0/ePC4lsT19/w63VUlme23
         jsGtnOaiovUqc5fnfu1++DHxcZjwYs0rNfDEQHgCv+DV/S5HGXyhURYM99jZFiq+g/
         nDUP1gd3+fJE9Q0VYbp4Supv1rlB2ay/RrsmNbZXhcY1QSNxAuGvpLm0QR3GQNtkgI
         wyIT86LQpBpjEoYJT44/uq+7a7hHqHgmiRICOj6Y5UlfXAqaTQtzKvNa0xlH8Sahd/
         vZrMqInJVv9EjlKXp1oDRZCeDUDC9VSGL2RA9QeDf0x4KVNIGQq
Date:   Thu, 13 Jul 2017 02:26:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] commit: convert lookup_commit_graft to struct
 object_id
Message-ID: <20170713022630.o6ioe6xnoe5wtllf@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20170713004415.5051-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ixfgpo4ao7k723qb"
Content-Disposition: inline
In-Reply-To: <20170713004415.5051-1-sbeller@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ixfgpo4ao7k723qb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 05:44:14PM -0700, Stefan Beller wrote:
> With this patch, commit.h doesn't contain the string 'sha1' any more.

=46rom a relatively quick look, these look sane to me.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--ixfgpo4ao7k723qb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAllm2lYACgkQv1NdgR9S
9osU3Q/+Jxt9DIIa0jzHxTIkujxnmR3GtxD8HZbvH8Y5Up00xvwUGuR2PRG24C0f
p1F9xY33xNIsqwWsQaVh1VuCRsxTvS3IWNGYHzZpzzdtY11NNdBdr8A6V4KWJ0hz
QWW90RieQ1KBEB8ksFGql5GFYYpgI6Kac5A2skik7nRw6snmOP6HxqAGHWUST90u
2GesSkx9Ynw2k/A7UHY2R5WXs6jG0yeSkRKasD1rIgZV4sAX/nOs6bIAs2pT/6W6
vwoBsm9LU4WQjS4wMuOhXceIrgOyE0WpFL2Rcl95WFNisKMO2V6gwK5zNWZSzT/S
ycmUZpx+bUTEmySMr4BaUW6QTV6ALKd9xoB751ngaAhlTszagmsMoGaWeQI2cLOL
uO+9iXNynE2/Ovb9LU7IKZu/J3x221EbX3Bw4qA/Ivq1SIGzM8JYdXLNTQMrZpEj
tjPknvOkw7Sz7E4lojZ40Hq3zvsIDuuvYVL5CYcD++ySMBRAXKWOBxCe9dh+uFGd
SvbWKKl1KOO+sg9dHZ34OOtSE46Ok82zVFZDYjPP7RksHtGWCDUKHm7sTDzQsNjU
7oxbmPAJ8hp3UWKhmuGeNerd2pIl/AdoZKG41oggpe5gLrfDXFbQ65Dd8hNi5CnS
WUzTXIHeouU/CFl6d9fXDgB2i1/ZkA3sND2JPqspzM3jmKeNvIY=
=22pa
-----END PGP SIGNATURE-----

--ixfgpo4ao7k723qb--
