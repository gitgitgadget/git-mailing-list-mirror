Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D3A51F453
	for <e@80x24.org>; Tue,  5 Feb 2019 02:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfBECPU (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 21:15:20 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33728 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbfBECPU (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Feb 2019 21:15:20 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c489:9935:372d:73bb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8BF71603C6;
        Tue,  5 Feb 2019 02:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549332918;
        bh=IJMPQlgkspxj4uis9AqnVTD7sGtdQYdugUTUxtSkjns=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=pEdEFxrKUvu99zNM8BIYkJN1OE/G2B6Dsxrn1z8VTzRPcLiffoUJ55hAinWV7K8sa
         XpG0Dm6VbdAmHDkZyYgKL+Msmu7S1LnjGDhc0vBdV0gUVca10RQg/E8vJWjfSl+a/M
         bLlvynVTrcbk+PgWo2yXFPpuuLBJnQPilr58Dkf5XzbIdyfw5X6EjnILbVwLPUcPwu
         vI854qViSAEEeZS+741lRVorUIhIO8cc5CdBFwEA3lAkjRB04USOMXYarA62bcDqZg
         SIbl+Ypj67Ubwjdukx38bmQIQSGifP7hilYLHiaJymor8MccBonbvpQUAbqNTxq7J3
         jVUmKXKYULPh+/l8Zu3/CgOKxbLHS6f5R3OesQbwUdmyuSSYDxfEKcvLZX6yzP+qzR
         dRcANbhYEMHpGPhLts0Yhz1uGMV7iN4q7sirv8pCpKAqHKgQJ5r3ClHnrj7+w6n3Uf
         +On5LLFeCR640zIEHwbCvHUqDno5Xq8LyTVot/GRHX5QeCZpbr9
Date:   Tue, 5 Feb 2019 02:15:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Larry Martell <larry.martell@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: hook to get info on commit, and include that in a file that is
 part of the commit
Message-ID: <20190205021513.GC527887@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Larry Martell <larry.martell@gmail.com>, git@vger.kernel.org
References: <CACwCsY5xU0pUaPZDJMqWNB0dz7DjTx3_b2Lvrft0NjA6cnPvcg@mail.gmail.com>
 <20190205015506.GB527887@genre.crustytoothpaste.net>
 <CACwCsY4fwr6=2S5CHe5bH7=7Hukq9np+eT1VO+kUDyBtMLKPcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
In-Reply-To: <CACwCsY4fwr6=2S5CHe5bH7=7Hukq9np+eT1VO+kUDyBtMLKPcA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 09:00:42PM -0500, Larry Martell wrote:
> Thanks for the reply. Any suggestions on how to achieve what I want to do?
>=20
> The use case is that we want to have a file that is part of the
> install that has certain info (commit id, date of commit, commit
> message, etc.). and we'd like that to be generated automatically.

If you want to generate a file, you can certainly do that in the
post-commit hook or using a Makefile target. You just can't check it
into the repo. Lots of projects do this as part of their build process.

An example of what you could do is "git log --pretty=3D'tformat:%H%n%B' HEA=
D".
That will print the commit hash and commit message to standard output
for each commit. If you want just one commit, you can use "-1".
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxY8bEACgkQv1NdgR9S
9otPGRAAtk0674RNV17P5vPQdripZMwI1gVRJw3U2oRAT0RfEHYJRbeV4t87BtM/
8b1aW3k16Jxz79/ZRVv1TGBoVmFihsMseEcGhVOJz1NHd/7LcgQHeSs6tAEiIShp
mnm7qIzjtE9n+s1WpNdION4SrPSaiJk+gBFK7dSjKu2vns3mlTw6bbG5Tu6IotgU
V8GozKdSmP5suTPjG7QUHRe9Yy9U6/lQN2733MLxdmcZ3mgcGEZcveBjuYKfjisP
yUOt9LLZacYt7edY49MxqX78Oo3x+DIRx/gnLukpqGR+40NTJSnqwut0ePKyRIqb
IMmNcmSWqY303EPFnjidESXFe+abceiA77xzVfwaw11YVBQZUwkIXuKXkdX/8YeS
kWu/tfvWpOYiKfgdtavcC7N9QHozRw6gv8bOVnpur90u4I6aL0Hp+voTiqsP5hzb
jlYcVWkITdD6Y+O3N8txsKJmjQRha5rb6DEB4t19toKWsoNAQFBehBe/3PsNBdbq
es+HDUJy3GAuILX6WeDyLhXqc3XszMCpvwLd7Sq5MsZ94Z2TdXzjGB4arJ+8GBEA
nK+kkVjqWAg4fCBWxHSxFLCEBxCQSFLuesPTxN9kf+ZD2o773pIIciUe4QDiLrVB
JEmHUnwwr3sayxF/TwEQZLdUwC9T5xCB3O6ow8kahkeJwDVohrw=
=+WEr
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
