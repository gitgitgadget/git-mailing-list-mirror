Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83D8C2055E
	for <e@80x24.org>; Sat, 28 Oct 2017 17:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbdJ1RRZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 13:17:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55542 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751230AbdJ1RRY (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 13:17:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7580E6044A;
        Sat, 28 Oct 2017 17:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509211041;
        bh=+BhCbmYeYjNx4YOR3XA1/AP39e65gvYy5jOc2X8Yt2Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HxZPzk243VBbTES/9RB7FdQD1JsknFMn320tBDvGemXOFmzFHI/A22v+BdzgJCvxD
         C4IC6oy1TAVlL34apdPxTvfhC7734PPo5l4FKppzcLqbqgfbF2S3oqdpZPtTaFwUe5
         y8y1XbbLJtWPYE43yydhd11YOSEgOw9fnC60m0Doen0aUFtghkMFlayOs8ovAtnY1U
         aw9lixq0u7iqFhZqmbvCXS5oyLhgvd1LvJJakwZ2Mwq7GLbz3Z8cFvSpptvnAZjOqF
         8WBxwUGl1aO2aFdqmO595CrO4KDtTjg/xL0g+0Qp0HfTpEzI7P1nFOLfbv+oPB3adz
         5Y/h9J2xO+FowgNJA6bkxlvy4CzvGKZ1S2OISefnk1MObg29RdXI7C1w1j1jDkjIkI
         WfMsluPkyx2gQvo4SCeaIU6HM694RHVWjNcwcnuKvv3lIWQReej7pQyschchWnK0zj
         /FYZHXU2eKyY5vjX9y90XCEwjhyqbKoaEb7TH+/1hXhCYusP3JZ
Date:   Sat, 28 Oct 2017 17:17:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>, git@vger.kernel.org
Subject: Re: [PATCH] tag: add tag.gpgSign config option to force all tags be
 GPG-signed
Message-ID: <20171028171715.42uka4w2x2zm6pit@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>, git@vger.kernel.org
References: <20171026195516.3354-1-tigran.mkrtchyan@desy.de>
 <20171026205509.2ydjd3bai2l6pqxi@aiede.mtv.corp.google.com>
 <1113033991.3307260.1509051676201.JavaMail.zimbra@desy.de>
 <20171026213337.kbmwnaxlsyubat4w@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nlse3wujsmluh7q2"
Content-Disposition: inline
In-Reply-To: <20171026213337.kbmwnaxlsyubat4w@aiede.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.13.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nlse3wujsmluh7q2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2017 at 02:33:37PM -0700, Jonathan Nieder wrote:
> Now I'm even more curious.
>=20
> I don't think we have the full picture to understand whether this
> change is needed.  When adding a configuration item, we need to be
> able to explain to users what the configuration item is for, and so
> far the only answer I am hearing is "because we do not want to patch
> our build/release script, though we could in principle".  That doesn't
> sound like a compelling reason.
>=20
> On the other hand, perhaps the answer is "our build/release script
> does not have a --sign option for the following reason, and this is a
> better interface for configuring it".
>=20
> Or perhaps there is an answer that does not involve the build/release
> script.

I think this option is potentially quite useful.  Say we have a policy
which requires signed tags for auditability reasons.  Shipping a
standard system-wide gitconfig to all systems with this option can be
very useful and is easier than relying on individuals remembering the
required options.  Otherwise, somebody might create a lightweight tag
(or an unsigned tag) and push it by accident, which would be hard to
undo (because tags aren't overwritten).

In my open-source projects, I always want to create a signed tag, so I
would find this option useful.  The only time I want a lightweight tag
is in creating ephemeral repositories, and I can script that into my
alias.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--nlse3wujsmluh7q2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAln0u5sACgkQv1NdgR9S
9otBTw//Qv6thwM4ko1M5seoh7Eh/Fp6//MzlQQQJY+14X3VtGBvlnxM3TrlMYM6
8XwD9G4kpHBA3O5vNm4U6ezE8p2Yuf08vO/lfScYjxme4O+KgG90YOyE9tHQWK7m
IMyzN+G8NY9XXOWgXqQAuPhQzlryMKiPjX54DSSLXdTCdMXzqgWr5uSuysNVJF0B
WFyrdUxzlK6NRrA5zUgmy9S7zbGAFmRcWQqREGaxXaQYDpK1mj9+fSeltPaRjmMQ
449QNECG3r9l8GwF+NX3otNeAAndeROro9xnAMXcHMgvsILNEso1TLiDzN/63DbI
gl+w0t0FezQl5nYVnZ+IKSEIV6xQjKZ00ovKuXAADO+BCK32oeBKMwqxJZ4pFA8V
sIk3TTbJnyiqJkuyIUmxSjgQw2n9rIgQpd5Px2a/PndZc67RjtQsEsWe9UmwI9S6
rf6V4wOCeq39GVu/3/sj3ZKyhU5BDwBn7tAJQvmAVR476EPUinPVgu+/kBLwTHvT
LiqtI/KBZ5fPFW01a0o8jurWexjfBEAT3zNf4NWkMkKyoRqyQFEMFC/LW1AztsXL
K3vgjx9qtaYfZ+pJzBghdqSfqzD2nk17We1JrbGD1abywLOjttC/F9AoiXHoXJkJ
L+a9lcQ2iqbCFyj1urqb6HQXVoc4tqRjWVHTHN3njkQNlzx5hhI=
=pa5P
-----END PGP SIGNATURE-----

--nlse3wujsmluh7q2--
