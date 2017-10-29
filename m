Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A49F202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 19:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbdJ2Tdf (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 15:33:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55668 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751743AbdJ2Tdf (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2017 15:33:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 69C876044A;
        Sun, 29 Oct 2017 19:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509305613;
        bh=Rqs2C1cHQXsnUej6ikLDJ0CMgtNj7xPVv05sDd5crxE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bAaW62IwlPuv4/wfONzZIxFqOr+5nym988MYeCNwMPMvB5vt+kntkwsqYYYT+Lgkp
         xOmw+fBQWYDOYr0ri1jlGHt7rplHlzqKNv4Lx1kre3HIlUBGN8D+0WLZa6cG1Le5zM
         M3xz8D+T10SmRxbM/7ty0YiXtEh5FkTLNLB5iXbp/wh6yT7REK3owBK8oybGFQsZJ0
         NCHClh6jf2AJcnPI5TunxfQFWlEZ8CtH1kOd84Hubb1UlJ7Z5TT8Twp74/oaGGlt3q
         tfWNp7ZR7y7LbjXXhLU1YZhypVZw0qhzbNBHkPpnxa+V8W8i3obMT4pq+W3D6SRK+i
         MXu3Ikyw1icGkJdD4bYogyRx9ij8vlylN3d6hJZsdhsYuJyvLjPN9rvsTNPf/r4VYc
         rZYLw3dhy7OCHjiN5JxBEBnkcQ0otuOEyvUxknScDx5MdRjbnc1gfFy4aFIBuVUiTf
         xE4Sl7czmLRosm+Te97S/oxifXpz6XFBZkzfREzS2nuSWjM6zQC
Date:   Sun, 29 Oct 2017 19:33:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 3/4] Integrate hash algorithm support with repo setup
Message-ID: <20171029193327.uqkj6w3ypfwqwm7b@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
References: <20171028181239.59458-1-sandals@crustytoothpaste.net>
 <20171028181239.59458-4-sandals@crustytoothpaste.net>
 <CAPig+cTrAxWczJ5qX2qE-hqoo6hA2QCom25HYB7v48rVnPgTow@mail.gmail.com>
 <20171029175712.ijqirnghcgeufqae@genre.crustytoothpaste.net>
 <CAPig+cRtexDJYMCUR1rGZjJOBRuDbhxP==US2VdNPhSWzeL6LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q6jz6dntsdpwq7sx"
Content-Disposition: inline
In-Reply-To: <CAPig+cRtexDJYMCUR1rGZjJOBRuDbhxP==US2VdNPhSWzeL6LA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.13.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--q6jz6dntsdpwq7sx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2017 at 03:02:20PM -0400, Eric Sunshine wrote:
> On Sun, Oct 29, 2017 at 1:57 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > I can do CURRENT_HASH_ALGO or CURRENT_HASH instead if you think that's
> > an improvement.  I originally omitted the "algo" portion to keep it
> > short.
>=20
> I don't have strong feelings about it aside from worrying about a
> "current_hash" name clash or a reader misunderstanding what it
> represents.
>=20
> Does "current" need to be in the name? What about HASH_ALGO or REPO_HASH_=
ALGO?
>=20
> > Alternatively, we could have a current_hash() (or current_hash_algo())
> > inline function if people like that better.
>=20
> hash_algo() or repo_hash_algo()?

Those are also fine, and shorter to boot.  I'll wait to see if anyone
has strong opinions on the direction we should go before making a
change.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--q6jz6dntsdpwq7sx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAln2LQcACgkQv1NdgR9S
9ouLAxAAphdNnLVNUACSTjsKSgNOCAfl5fIIS31+UW/p62YCzBkQdUyp4doP+7f4
HLRJTZylHB4Xm21glLfVrk+y9OZ4QOUSkiM5N52QgV2TfwjKTHXL7NMGemYtC9Rq
L5d+6rYiQNwyqNRVcu9YdK6lw1M+66c40BtB/RvzjbVBnCQgtSpcN6khZYhDuI1K
dkL75BO4Pk4m+FxgaXx0fKtY7wkzlEWY79Da08AVrW0EDsAheapbsxV/42qz0Xo/
Zq7PKuphr1bv9NrecL73+fa9G6vS/nQzSUv9nW6h5OLEJmv1a28QhXrOH3xgkhEb
f4BrRZvtmHr+hfZBR8sPtABYYvRz3Tx5rh/6qV2oyCBwPRLLVOrRjEpoY3Jjt7m1
7j43T6UTc3sjKiZb5IJ7s1eYOr5j14z0CuXXaLFWQee2evyF9uhCr7DdCURKhEEs
IUELuPWcGaT0a6lT59AoWArv57QO2NcoEx33wTpsOBwonwW1gkfzE1N/XYn2oIuT
ruiwdB/Ky8FEbYhcAE2DMH/nF5z5AOZ/ScVI455HValbYXV/POP7x7kU6BsuP2f/
sd3FLmVsRoE827MiKELin/zLKHvDVwM8uADTMWuJAH1vEHP6phhS5zKlFY9FqITG
uPhSUNkQVW43IbHG4ZWw/jxD6Um3BmpcdRAER1zv0uEZupt+HVo=
=IY1c
-----END PGP SIGNATURE-----

--q6jz6dntsdpwq7sx--
