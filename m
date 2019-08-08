Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56FDF1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 11:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbfHHLfs (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 07:35:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57354 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732302AbfHHLfs (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Aug 2019 07:35:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c831:5a62:6d5c:8da3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6A44B60479;
        Thu,  8 Aug 2019 11:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565264143;
        bh=aisX7zFdypzRq0+lIjpRUZd/do3mXOwEptlKOUejfDQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rB63cW8ayLAbNqEkZlH0nLrU5RLKaFVj9LSn9yjxVpd5wDHFC0j62gjQBpI4G4I99
         hNwYyyzTtvDt3hiumr6MLJljhKmu1fhKJwNoLfXGoaHysZyqH8E1JLyNiVkN2lf7g8
         WYNNwNTSnyGVKZA8dDEdmxHcZih65IDl6gwWUkatuVcYjQREXqnOp0feivdbeOpWwG
         4ZDT4+OrSDpl1xBUDAqlkN6oY9AzaWwAUsb9hJB4/ZWM7E+o3xDIv03BPoks/NN3m9
         p2VvuO/WAFjmwWCtJFJP3gnh4iwQ2VIFqqNPRqqef9TGh0T63I8spe4qubj3MIYHAw
         +l3XbVsxOBrZzZWBABAWLTEHRrIdTe6Tl05AXszXhm9teaS21lMadN+aPvIw2EffGG
         ZRwvPT6OSXE8yIYACiIMpWia8IQRPtonG8YxCr4ZC+NDWysjt1fkqtxVrlhOek6PzM
         +D4iog9HaJ1rNeHh4B5yXqrxrE7r8dudZT70sfILIThCBC1113M
Date:   Thu, 8 Aug 2019 11:35:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH bc/hash-independent-tests-part-4] t: decrease nesting in
 test_oid_to_path
Message-ID: <20190808113538.GK118825@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20190628225928.622372-1-sandals@crustytoothpaste.net>
 <20190628225928.622372-2-sandals@crustytoothpaste.net>
 <20190808065614.GA209195@google.com>
 <20190808093732.GA12257@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iEWWOZ/QYGWEaBRW"
Content-Disposition: inline
In-Reply-To: <20190808093732.GA12257@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iEWWOZ/QYGWEaBRW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-08 at 09:37:33, Jeff King wrote:
> On Wed, Aug 07, 2019 at 11:56:14PM -0700, Jonathan Nieder wrote:
> -- >8 --
> Subject: [PATCH] t0000: reword comments for "local" test
>=20
> Commit 01d3a526ad (t0000: check whether the shell supports the "local"
> keyword, 2017-10-26) added a test to gather data on whether people run
> the test suite with shells that don't support "local".
>=20
> After almost two years, nobody has complained, and several other uses
> have cropped up in test-lib-functions.sh. Let's declare it acceptable to
> use.

I'm also in favor of this patch. To my knowledge, the only FLOSS
POSIX-compliant shell that doesn't support "local" is AT&T ksh, so there
are a lot of alternatives that folks have (bash, dash, posh, zsh, mksh,
pdksh, busybox sh, etc.) in case they have a less capable shell.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--iEWWOZ/QYGWEaBRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1MCQoACgkQv1NdgR9S
9ou3wA//dRJQda2epEHia2pZp6qeH7QO61yD5Jx7XpncCMukLLhLKg1EOWswqgcf
qvKDIAUxittB+edBVDMgptfmZNQ82Ukad+c1uS57/d/g5oPbtswxrPxSFAQybdhn
W+6xda1HaUZQrSdzNbiQ6t/WJpcXBVr06f7uFAw8Dm0aBB+nQ30R0Ko69iuDfoeg
HsjN5z7GvWwimhrKpsSMzwph5W5g4P1S9LbGtoOFTqPeguIqF3kChj6EsJTEyBXG
8oaL4PAxq32tLVTztiGjZkgJ/zIVyrQzKvz5ylpX9spgQ3nE5X2KS3bATAWGuWTW
jMbpEgM6nYEA40cOhZMJ7putLcjDjuYjiQbh0o2QFmCuBpjs6zA0V34g9B0VoDYy
OCh8e7VcKgtxdcrJnEdAzZ8a6VKfBhtgFT2dYfOco6d1E9tSb7VbFYpQUE8LmYn5
F/SS96qqywMLFfSt8eRVHPw88VHLFrfBM6APW9lT6N33fAOtVCm8lHo1FacEP9Ib
nnniWeo9PpktG8zyI6jaW7ZxUvrDII7ilqsZ0k2YHVS6ZdgymmZMhEBHdN5c5Y1U
I44JLnozRzcFAMnl0tIliKZFDyUG7rLhMMUz/7sCQMctJpHN5Ll41X0FkorE0vHk
3PxSRxuITbUdytfG3m0vNd9ZF6QyfI9dZt8IMt+Ond9TDxgSC2M=
=xd9R
-----END PGP SIGNATURE-----

--iEWWOZ/QYGWEaBRW--
