Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CE9C1F461
	for <e@80x24.org>; Sun,  8 Sep 2019 17:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfIHRSR (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 13:18:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58590 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729996AbfIHRSQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Sep 2019 13:18:16 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:2895:5875:49cb:eb31])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7FE9D60459;
        Sun,  8 Sep 2019 17:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1567963094;
        bh=bQKA22k4v4+gNkQk9QMJsZUlR0zcwjMnTST1IX5V+Qs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=o+F3lWbqoLT5Fk0WxC675wPcIXonV9ciXhd6cZXnJG1htmSmvKOGFcAJjIYJkDwmi
         1oP5lAUlWYQN1x3fYQluDxYYPRdPV2Ktp1/raFLtzz3xcd96nzO8tMwY3F4lFV1qW8
         EQ5mTVu2QLcqjkoYbLfS2aIHcWjWAq8s+h6uCWyNTYYsNs4Roniz9dSxSrX0cojPiC
         BPuhhM/J57/AUcTilxgFXVNLID8aP25FVVo633WaD6QfK2uLtA+sX0yIj66y5ikEMb
         xZwrAIRv3D2+dRO1k7K6PpURehwXZKTb1/nTE3XfFgM+5kNypNTFt12Y04geYWi6aq
         OaF1xEZRF3wSsyRHLfXctpGhRVQxoBzUwbPQVK2ZNGScJXzkJu5plgmY+5WtGE5Grh
         R7RHhpNvKefVychCa/JQUwqrOI5feJVTGd0REIkGnCca55zP3tXqA13V4YH1vwhqiF
         8YFKeg3kGIGWpVyQu5lgmi/Brsylv56z1BxdHieQN2ytEujErEM
Date:   Sun, 8 Sep 2019 17:18:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix build with Asciidoctor 2
Message-ID: <20190908171807.GL11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190907170746.273984-1-sandals@crustytoothpaste.net>
 <20190908104833.GE15641@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lHuqAdgBYNjQz/wy"
Content-Disposition: inline
In-Reply-To: <20190908104833.GE15641@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lHuqAdgBYNjQz/wy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-08 at 10:48:33, Jeff King wrote:
> Some of them seem bad, though:
>=20
>   --- a/745f6812895b31c02b29bdfe4ae8e5498f776c26-asciidoctor/home/peff/sh=
are/man/man1/git-am.1
>   +++ b/303729d86b69657777222bf4b3a6f95932e12648-asciidoctor/home/peff/sh=
are/man/man1/git-am.1
>   [...]
>   @@ -175,10 +201,10 @@ DISCUSSION
>=20
>           to process. Upon seeing the first patch that does not apply, it=
 aborts
>           in the middle. You can recover from this in one of two ways:
>   =20
>   -        1. skip the current patch by re-running the command with the -=
-skip
>   +        1.  skip the current patch by re-running the command with the =
--skip
>               option.
>   =20
>   -        2. hand resolve the conflict in the working directory, and upd=
ate the
>   +        2.  hand resolve the conflict in the working directory, and up=
date the
>               index file to bring it into a state that the patch should h=
ave
>               produced. Then run the command with the --continue option.
>=20
> I tricked doc-diff into doing a comparison against 1.5.5 without the
> patch and 2.0.10 with the patch, and the diff is similar.

I see the same thing in doc-diff, but this issue doesn't appear to
actually render in the manual pages themselves, even with MANWIDTH=3D80.
I'm not sure why, but it doesn't seem to misrender in the actual man
output.

I also tried with the DocBook 5 (docbook-xsl-ns) stylesheets, but that
doesn't appear to make a difference in doc-diff.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--lHuqAdgBYNjQz/wy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl11N84ACgkQv1NdgR9S
9osx/w//WhBJC6iSfwY/Tc67en7LPGDxxJPJmLhVklna9DLKMIg5ULLTJVjN6GTk
qVdOGbWLIGd5K0ofpAyZ1Mpri+/bNS99XVopvKRnvg0KSPkKuUuRFWBaSwQFeqan
XYMPtJ1GbqtR20jwgBaxHSnArumS8TeRlX8VlrJ02i/GrVKMyPm9UWCRlqfhh6PB
u3zrolg7BbdCfPqsviFf2MztL3JvFE+Ji8DA+3epXKjYnxO1uPUTUuRuIANzTnqI
TP9U/paaY6I69RlTjN6fzznGGX3MI06aVF9r6MtcyDl5yIRI4iCsQFNbfwsS8Ggv
CCp0fbIkO9q19xMIS8RAg9rzgFAyi23we6OTAppQ+nXlESeqdQ0agO3KZM3WMPD8
llJ/pHvbV/Rf9OUKfjmU/ZifpSNy0RTLhBcciYn8JwAENpikrNU+IpyWtffg18BV
zpgaGZ3GF7Dk0eFJCtK5OO/HY3Y+mx2g2k7II5royCP5tJbPvtHEHCYKBC6kcl3I
OOjQ4RB2gJ8cMpWHV5OTgNfL6pGoWkyo6HPXK9u52jDOTpTeohu37/ExnLJNCzTk
QyHboiiqNkiGB+7sUHxi5DPsV4KZfD5JTBbGMUKKVmbZkl7MH4QdlfUYX5IzO9Oo
quJTwnB570y01mTOqL25ElGZ60zKNBY7hEF4ouwukJyWF6dml84=
=Nfck
-----END PGP SIGNATURE-----

--lHuqAdgBYNjQz/wy--
