Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5224620281
	for <e@80x24.org>; Tue,  3 Oct 2017 01:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751019AbdJCBn7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 21:43:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54386 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750846AbdJCBn6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Oct 2017 21:43:58 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 86BA360D8A;
        Tue,  3 Oct 2017 01:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506995036;
        bh=TLetBxibtmNIaq8rnNoFZI/Q9fLURI4W1NNcR77ztU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YILPaRMvwxgx3A7klC5tUdeXn04KlHzbsNh7cEaWzltt/uMIPLKmgU9yzeR2jVrmA
         SOZ4Mssff7YByX8zAjVzNwjXOZqF9XODb8IGIO2PjZayIadnEo4q7+idxC0m/qUk/b
         nSJmJ9v6EqQaeOfU/c+Cqc8TgVQTCnzxLwH8OfKDjoV9IzK9Q00t+9sX5MnHXxNADs
         meqAI/SM3nkXviyoZA99fqfmENY/I0lSNF5xhDQsPbqmf7alV7XjNgbPxjxHtZnKzb
         lm4+GWH+Re7piderB4OI7Gf0lXjBGqELxrhLqbZbkJK8Q11PPjQom3nUpKtRWXkMDN
         NKnD3ZZiflwqfutp8hbm+tCG/xfqUGscYB4xLO4Agn/PQghctd/I8To9J8e2UfjWsr
         3Tq4EegAwM9wRlROoWS2QudXZhd3xB5Kmd+Zb6BU3Vm+Ge2/fRa2GNMwRgilA1aYm4
         YBzw5u9iaGcMtcFlPFGPNbo71cO1i0up3M77poEd1CgqmVgrdP0
Date:   Tue, 3 Oct 2017 01:43:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 00/24] object_id part 10
Message-ID: <20171003014350.yjjtrs5gxqdumuyw@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
 <CAGZ79kaoCEzc-2ZV60J2GEfxJwLMNg1fFZctEctMiGMVSU+74g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l6asvi4sgdlvns77"
Content-Disposition: inline
In-Reply-To: <CAGZ79kaoCEzc-2ZV60J2GEfxJwLMNg1fFZctEctMiGMVSU+74g@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--l6asvi4sgdlvns77
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2017 at 04:34:44PM -0700, Stefan Beller wrote:
> On Sun, Oct 1, 2017 at 3:08 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > I apologize for the unintended bounced emails that occurred in late
> > August; my mail server (previously hosted at home) got knocked offline
> > because I was without Internet for over a week after Hurricane Harvey.
> > I've since relocated mail to New York, so that shouldn't happen again.
>=20
> I hope you are ok. (It's not just mail servers that don't like water, but
> other personal belongings, too)

Yes, we got a small amount of water in our garage, but overall we did
very well with only minor damage.  We and our families and friends were
safe the entire time.

I've spent some time getting the damage fixed instead of coding; hence
the delay in this series.  Overall, though, the damage was minor and we
were very fortunate.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--l6asvi4sgdlvns77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlnS61YACgkQv1NdgR9S
9ouHbhAAhp9xgGzKoyH3MRQZJgjWtqlAdn0Z7eP5AKo7Ta46d8SBUWTOmZbcbzX6
+Z4ErnyLJuO1dcOpISbNfdna+qdFAMx0m8HpAhj7du3+GC1gVq/YnpeHY+Nf1MWA
rsSAVc6AnMSh2XCKXts9o0y9IG+BywKxcvyzIEqsVq5LtCa7DPawT/Q+8ojK5eWM
VBx4tvccxFwB1bVEl/mKR58aQyAaF2RTdYYnxqA5vHd4B+DQD1KToZy9DLhEY4Xr
uBau8GpDnGT3tnLYgrx4EcAP0upCv+1OFHMrTrhPZEMxM3ZIYmOCxcRPMNJA8ebK
moqhQFfm5uZtBi8ATFdTyR3pr+MJbQlX4ayvjbS1BSpqYNfV1DZZqRPW2vdRcvX6
i6/+JZunE/2kvKGOY4vQcfGOdGErJz0UlJjH2J4rfuRG20TFczJKvsWyGI6hsEp4
dx2fWudt4NIachKNDA1Ws63LJZOoVSsZWKD2o6DjrHCKeaX/3ks4rMk3jFNFwMtp
fwOdvRem+oeen4BZVdI4ZFiGa8hZlgya9FtjOhfKz3sSUO5NScScarVHTt9qW0dx
vLsv0lGllMSgaowAgLJptXe8w90xmCLiZp9lpglld1uiE7EiFKMCmBR03pToAZlT
FovQlh2O1LHQyy6PwndMtJZ0igIsY8ozfm84Int85tLKLuDneSo=
=o71m
-----END PGP SIGNATURE-----

--l6asvi4sgdlvns77--
