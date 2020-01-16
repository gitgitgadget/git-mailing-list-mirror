Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C92FC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 23:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E51C2073A
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 23:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cFh6PVou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgAPXyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:54:18 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40408 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726884AbgAPXyR (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Jan 2020 18:54:17 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1A12660787;
        Thu, 16 Jan 2020 23:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579218856;
        bh=fQ64BYiljvjuixOySOJqekExyz9JFbnvuUFIk9SJKwQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cFh6PVouQ9VPuGkxBGQjhhYMgEVE7LVZrpJwcZyVpXjgN3oM6rSQQQT9xoEYi8JhW
         qcwyZkHveUY8098x/CmEtXrQio3JQVAZMuS3ussnf1EX+mJQqL1FDhxznIj/TvuMgl
         XUiFDHZQTkSBPbYhJW9xmQ0Q75gQjJPpDg8NVElrr4YXJfU93i8+RuC2bslDpgaJ7N
         9rKPpHcTwaoM11Q3XgFSOPrPI3EIf1XFllUbox/l8p4VgWt21cBhh9J/MwznHPCOvk
         jQxJQucG2R9VHiLHiOKJt+OHLmZfLHE1xAyVE71KxQWGUeIsrddGAl8F9toF3p1JvN
         R6PgP0YgDjdgh0QlSqt0Tikkwz2GhCjPcO1pE5jel1xJbJQOwj+qr3WUYffTI17wuZ
         sPnNNWcigwCS+auE47PNEXnQHH/XZMbbsIvlbjbFV3fhbtK700YDEDxdcj+NM0rB2U
         4t1fsmMA0WJxDTHsA1UfF3vPjJqJ5wgAcDXtmpkjCOEUWaxxlIj
Date:   Thu, 16 Jan 2020 23:54:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Re-fix rebase -i with SHA-1 collisions
Message-ID: <20200116235411.GZ6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/w6WUUxYkubDgwa5"
Content-Disposition: inline
In-Reply-To: <pull.529.git.1579209506.gitgitgadget@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/w6WUUxYkubDgwa5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-16 at 21:18:23, Johannes Schindelin via GitGitGadget wrote:
> Triggered by one of brian's SHA-256 patch series, I looked at the reason =
why
> the SHA-1 collision test case passed when it shouldn't. Turns out that the
> regression test was not quite thorough enough, and the interactive rebase=
=20
> did regress recently.
>=20
> While in the area, I realized that the same bug exists in the code backing
> the rebase.missingCommitsCheck feature: the backed-up todo list uses
> shortened commit IDs that may very well become ambiguous during the rebas=
e.
> For good measure, this patch series fixes that, too.
>=20
> Finally, I saw that git rebase --edit-todo reported the line in an awkwar=
d,
> maybe even incorrect, way when there was an ambiguous commit ID, and I al=
so
> fixed that.
>=20
> To make sure that the code can be easily adapted to SHA-256 after these
> patches, I actually already made those adjustments on top and offered them
> up at https://github.com/bk2204/git/pull/1.

This series looks great to me, and thanks for fixing this.

As mentioned in the PR, I'm happy for you to drop the SHA-256 patch into
this series if you like, or I can carry it in a future series.  Either
way is fine with me.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--/w6WUUxYkubDgwa5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4g96MACgkQv1NdgR9S
9ouVXhAAwMl1vy8nQxbIyAnq+YIm/SkwvbPoK00XHJ3KlS8AR70d+RoV6oq8RchO
Swzo/54QYaP0/Jn3zCQv3p/OD7CLLA3Aq7ln21XvZKn7DW8eu0h8ZgN1dE5uuHjF
voFEJT3v7/p9jTocOKIR5XBh7dFiYa++mAswnE+IYENXp727fm+qnFqUj6ZvXliV
AmC+Z/MzK1Ni1ivXfRkHfS6H9Cv4Lz84GgTKUOkStjvS+DHT4HK6sXSAwnL9dlzd
qeS7Kldtez4uVEzFE4CaVJLEO12SCFJ9kyq9m1Hx4cIrTnFPnFBirgp0z7aGR2qk
HABzuFVT5i4m4rSuzBwtLJ+m8V+FqbZCd/j5xInHgI3+XY2y1N/RsB5B3QEDMwQt
Yn1O/agpYDc1BTHnUdJq1CI2Rl4hSfV29f+PBMzPVUHx4+M9AEH7BjQci6ensDKr
LR675U37A6OzkuC2gqpDp3utWI5pa1YsUX5eYi10TviMrJ7Um7OUsCV442NsggeN
S+f859XQzCDcvevWBh4vp4kJ7BSLzatVXYfSVDUnXIEzAVWE0qMDbFd3QqwYRP3U
xa/0TTQX1+izNnZ9wPh7gNftvACTj4HVfn/9iZ439Aqjt2Uej5w0cscNzq3WGFgt
CBKbWB7Wvf3qRW/KBvH4fA1MTJhZ1oZdPutPjwj8kt/rUcS2aGU=
=oprG
-----END PGP SIGNATURE-----

--/w6WUUxYkubDgwa5--
