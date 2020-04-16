Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02D8C2BA2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 22:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78779221F7
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 22:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lYqmdmVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgDPWzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:55:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37224 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728497AbgDPWzj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 18:55:39 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 47DA060443;
        Thu, 16 Apr 2020 22:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1587077707;
        bh=ojG2tPjsxz7GGC0E7n8FFrdhYzPY/RyVQ6Tt/IyEL/c=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lYqmdmVZaJRB2vI/4kNZGqkbG1Pi9Qy8lrEDYa4Q9IF1eUI0O0Css8kMsYAz883d3
         upcr3qichO+yfNLq+AaqHWVFzNBu7gtySmK7hOXr5YMF8AMqiKJflETGL3/OzQhw2t
         HhgtB1fEfaYSVYuK5645Zc7hXcw0+HNqYHUSFztYO3+z812BXn/t9pD52OrZOsCDhq
         r3/GkOldqBpFAbIe0IHxRhrSkm0na4EouNq/oswQMzHuIyZ9gQr5Osd/Qd3kvqlAUk
         K+3AgPEVmvVRT5pCUjeDevz4e4zfrIeeR+1piKlJwXYM5yetNpsb54VhE+LoUwxpc0
         K/AzxhRwgVuz+xKUPZVF7cg/JqjGm1l+yffdKOLiFIXlNAlivvwvau9H9FFRJ6BpG3
         q3+xJLV5EkZ7l6IKaGpR4gZPT41nOiAMLC6OeADyj/xmmOj+a3lUdfwKmG/f2pE95n
         58LKbpzcoAx601mZdPv5fKOMzDb4NWtYIDCa4vGJZhsR1lUSWwY
Date:   Thu, 16 Apr 2020 22:55:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Guy Maurel <guy.j@maurel.de>
Cc:     git@vger.kernel.org
Subject: Re: a problem with git diff
Message-ID: <20200416225502.GJ2751707@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
References: <65cbee30-fa37-1422-98f2-2c2b5aa094bd@maurel.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BEa57a89OpeoUzGD"
Content-Disposition: inline
In-Reply-To: <65cbee30-fa37-1422-98f2-2c2b5aa094bd@maurel.de>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BEa57a89OpeoUzGD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-16 at 16:43:40, Guy Maurel wrote:
> Hello!
>=20
> Using the appended two files:
>   git diff combine.cpp-2020-04-16-A combine.cpp-2020-04-16-R > git-diff.d=
iff-Y
>=20
> doesn't show the same differences as with:
>   meld combine.cpp-2020-04-16-R combine.cpp-2020-04-16-A
>=20
> Have a look at git-diff.diff-Y at line 210:
> -static void process_returns(void)
> +static void mark_lvalue(chunk_t *pc)
>=20
> which is NOT correct.

It looks like there's some additional code that gets inserted before the
process_returns function.  In this case, the diff is accurate in that
applying it to the old file will result in the new file, but it's not
very helpful.

The reason is that the default diff algorithm, myers, looks for common
lines and finds them in the blank lines in both process_returns and the
new code above it.  It then writes the diff as a set of deletions of the
lines in process_returns and an addition of the lines in the new code,
plus a final addition of the process_returns function.  While correct,
this is, as you noted, confusing.

If you're looking for a more helpful output, you can use
--diff-algorithm=3Dpatience (or diff.algorithm=3Dpatience), which results
in a diff output that more logically matches what most humans would like
to see.  You can also use the histogram diff algorithm, which is based
on patience but has some additional heuristics.  Which one produces
better output differs depending on the circumstance.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--BEa57a89OpeoUzGD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXpjiRQAKCRB8DEliiIei
gR64AQDZuCY0iz2loj4K/ZLamqreaqt37HKVQGnep3eSJnVmfAD7BDmKocfJesFV
oss/DJFJc+WHCu9Ha7TC/LVtSCoLnwQ=
=ODND
-----END PGP SIGNATURE-----

--BEa57a89OpeoUzGD--
