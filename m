Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 972D81F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 23:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387478AbfJXXJK (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 19:09:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51740 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388186AbfJXXJJ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Oct 2019 19:09:09 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 041D26044E;
        Thu, 24 Oct 2019 23:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1571958548;
        bh=7zG4Ks3/KXJV9qSTxBpMF2IgyTS/TF2elR3hNkSDzWY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=RvvM1+09yzXWHz2VZLwWKFxkSQSiUVkUvI05E4Q/GK+HjUJA1nFTw9xZfCxvZeSiT
         ILJ1/LPW53ulitwb4MvVtXo2bhybvm/anOTwZum0yTm6q7Z8Pzs75dnXI6xO1qZp8V
         Yzb4ryjX3Cj7MEjoK6peTU3TSV4oANq1JdYh5seZWBz93POLwnsiAA4DztnH5sG+Eu
         t4U2iR2KQsE7baDqTX+QcgohObd1L4mq9OY+v+79yCz9Z4XpzWmJmaHuwhDahaqQWR
         xqZcFMTgo1+h4zTiD7V40SUDd+dB/0TRc4s4IIPAdUUHDv339Wafs++zwB9GPNtlqW
         B7LXlGDSDYkehYaeQEfYJ0vVzZCYA7MYlNnFH8w9UixsdEZnrC7ZmGwFf6TiIEZEiW
         u41n0kEf4AVsv8AaEDYO5q+NlalmRAbWTJrW5ZXKU0QIicuNy5YzSLtuyeRBcFLQL1
         NdIljBCSYawOgqiN64mnQek1hsUXxbWusdob/jCxyYAFQ5+rYZf
Date:   Thu, 24 Oct 2019 23:09:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2019, #06; Thu, 24)
Message-ID: <20191024230902.qdy3fv3dh5lvrcz3@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqd0emfzrv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hbu2h2vi3fekghml"
Content-Disposition: inline
In-Reply-To: <xmqqd0emfzrv.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.2.0-3-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hbu2h2vi3fekghml
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-24 at 06:01:08, Junio C Hamano wrote:
> * bc/hash-independent-tests-part-6 (2019-10-06) 15 commits
>  - t4048: abstract away SHA-1-specific constants
>  - t4045: make hash-size independent
>  - t4044: update test to work with SHA-256
>  - t4039: abstract away SHA-1-specific constants
>  - t4038: abstract away SHA-1 specific constants
>  - t4034: abstract away SHA-1-specific constants
>  - t4027: make hash-size independent
>  - t4015: abstract away SHA-1-specific constants
>  - t4011: abstract away SHA-1-specific constants
>  - t4010: abstract away SHA-1-specific constants
>  - t3429: remove SHA1 annotation
>  - t1305: avoid comparing extensions
>  - rev-parse: add an --object-format option
>  - t/oid-info: add empty tree and empty blob values
>  - t/oid-info: allow looking up hash algorithm name
>=20
>  Test updates to prepare for SHA-2 transition continues.
>=20
>  May be rerolled.
>  cf. <20191008194012.4s35pbwbh25rblhb@camp.crustytoothpaste.net>

I will indeed reroll this, and I hope to have a new version out soon.

A reroll will also be coming for the documentation series I was working
on.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--hbu2h2vi3fekghml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2yLw4ACgkQv1NdgR9S
9otBvBAA0EQv76xk48WS+K0lCdBOeT4592WyfIGK39ZKaHocf3dDTfRpQBgtcE09
UcxCwnR0IV1vvV505XIsh61hfClFRXTeZ3aGwcerED7dl2slbucUUcsgn7fMzDta
QfClR57ai4ce/2nArDYWfqghWCIW1oMLnOgrPWa7cu5KOXXG53gGzMmyVwGVpzHn
vsUM2L4hqQk4SoP7GQpsn3EVFbabkOGncOp/Uqo7YZHZwIpzjJtd/OPCa78hKM6h
uoejCmj2mepwnhNyUUMaIHouIm3wgUrHLd8vtGFGb3UFNndOqcCBVeMbbL2NK3FE
b3w7+YJH8AT2L+MshOEOc4SuJuMjzQje/g1rxbth2fCaGOVTKS95SsrG3vz3Hiai
vjxqJFvHwpjnVFFweKSZN7oijvrsMFRBNxz8guKtdG/ZUzv5dEW1n8YhhI8KDTVQ
j/60O1ELt9Ij0o0ZsgAScJunfZi9By8Yp5ey4EYIdvNaDqUp7arKMjP3dVr00cqK
qwliGI6BuyZTuXtLoWphbH3IgCZupxU+uvR+ne0hkeRD/JjzR/gfx28LmXi4o12a
5NN9Ylt7nVghDnlfesnWFSNdI+wlXl2FEe3O9p8hHncrVT7PbjwBi6Foj0P1eDz7
1pb6yb7FijoXZY7gRM7uCLZ+KkYr6e7OpwU7+AOjrwh8IQaEr7I=
=ACQF
-----END PGP SIGNATURE-----

--hbu2h2vi3fekghml--
