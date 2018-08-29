Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EEB01F404
	for <e@80x24.org>; Wed, 29 Aug 2018 22:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeH3Cvg (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 22:51:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38348 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727328AbeH3Cvg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 22:51:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E3ADA60428;
        Wed, 29 Aug 2018 22:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535583147;
        bh=xVz4uFezddWUYbTziFXmlknchKtElMxpMkiCd67Da1U=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dukszwkHX9Hee0TLusYmemQC8mCDhuuiYSMa40iZndK9Po6KTZsJitzzS7j/4F7QG
         BjetZCMX+jr9WSkYHS8Pq8SGhRDFg2IP7YlXLgPVhGD15LqTpQwmwYDKg17Y49gBuV
         rbfAg8fidEHAlxCryZ94fCpwuQQ7RdWZggnJlS3AtrF6uN4p85uikZOrZTfol09rMx
         Xj7mCm4Yp8/kzpy9VaMqdHVAln8Vov02FdKMu/qwaGNzqBSvWKJtSqDxH+938qwSQO
         NVjNIKH7twCMCVjmDWlPJ94HjAq8Txlw8a5bU0FiN4NdPfgQYc6JvKExfX8/WoLgbr
         NFGWvVnXLAdPvehkYvYZ8VczNWbWq/FycxYVmryXN9dXyNGQrw0GadcjOrMpoNglTx
         it4/kbJo0QODYPdsnDvSZr8N52snwQyqjTWqlCLo21JRkmqSkmkpb+viVXXiYambYh
         Qg13oSLkx+oBshzwLP4W2WPWxeNwRVzmakW9Ca1YAoqDLjYjWaU
Date:   Wed, 29 Aug 2018 22:52:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 01/11] t: add tool to translate hash-related values
Message-ID: <20180829225222.GE432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
References: <20180829005642.980617-1-sandals@crustytoothpaste.net>
 <20180829005642.980617-2-sandals@crustytoothpaste.net>
 <777ea296-005d-0408-1197-178898399593@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
In-Reply-To: <777ea296-005d-0408-1197-178898399593@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2018 at 08:37:48AM -0400, Derrick Stolee wrote:
> On 8/28/2018 8:56 PM, brian m. carlson wrote:
> > +	rawsz=3D"$(test_oid rawsz)" &&
> > +	hexsz=3D"$(test_oid hexsz)" &&
>=20
> These are neat helpers! The 'git commit-graph verify' tests in
> t5318-commit-graph.sh should automatically work if we use these for HASH_=
LEN
> instead of 20. I'll use a similar pattern when writing 'git multi-pack-in=
dex
> verify'.

Thanks.  In the future, test_oid will learn about internal versus
external object names, since we'll have what's printed by the UI (which
might be SHA-1) and what's under the hood (which might be SHA-256).
However, it should be easy enough to update all those pplaces, so if you
use them now, it should be easy enough to update them in them in the
future to refer to the right thing.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluHI6YACgkQv1NdgR9S
9ouMGQ/+MzUdXh81mnaqZBb3rY/U6uefb+5fDGqoTsbqiVMaWHbkIw4pk1TXyTFr
TxCl8OeTeSuStwk/EBVyGI1egHAlIOjm0VhT65T/ZKyqbgER3vT4Qqc+4pPX3sqa
M4OgtJuVzHRGufovBe0YE7Pl+8axeXAfq53Y54QsOvHHpJR6X+hwDqmLKiL+V74D
O+ixJdrLH1B1CVuAOcumI2HpX/EFXNy617nRetjCFcrvCEJ6/fjxA97CVGcpUnz1
HXoImr90IeDXv9X1siw/5C0RD594Z/8Iu9IsuAoA7gs0/DUU+NlwjzzpFQ4qKmik
f82Ybr3CHHjiRRHBBySO5iDilyD0ctQSKV2KgjVstS9atwZk+J0GBgt/w5H0Ba5O
CkcKW+o4IbszS5Xukr4f3sxEQHcHoBv3hdn6jKJvvlKQLR852EfdWvr8/t0tudwi
Yw4r2YTVCu+pCMMC8/EFBBuhw/msgUszBksl3N86ugTdTuwanejjYjXK8BVrQgte
/EJgOjyvQeGrjKX/KZvGYbsXcC4GWXa31dSRkjknjv2zUNRIeVsZOmdEpzM5j6b0
PYPt37BOBdqHgjTwLIENQrS1yqmC9VpCz/LhIIT0k2V7PU4sILofZHlqEP/3hk7G
/hjtpjoEQymfxt858I9r3q64TUN0JNpVP3JchuD+IX6OsVjh8IM=
=1Eqm
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
