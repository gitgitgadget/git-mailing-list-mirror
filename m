Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E93B21F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfHRUeZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:34:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58094 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726097AbfHRUeZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:34:25 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ECF80605B2;
        Sun, 18 Aug 2019 20:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566160463;
        bh=au5c5H6mpgJzTVuwZjPRQ3qo1D3oyuW8wi2oSPj87AM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Dy46bNCzPnjohqruoIWo0QwbeiNNenu9vbsiFgUeVVrotO0x1j9fBNeqmnKfhnzhG
         P3ZaNu6gMcRANfdN638oSzHmU3j/rYjeIrj2UilR/TjGQYGEhrmn1QvWNQlfmBOnpj
         tnaKuWyNxNIFGNdsWKqIDfVYHWlU7FELiz+Shi9qTlgcfINLhfwR8KfXtjSkAB2nyK
         Nhv5E5FH74ItMK2Ve9A/4acxf1vI98PE04ZcogPTgCF2iSlHQTsM87IlTJbQn4E3cL
         bXWXG5bard8PFvBgzFWZXv+0748TiFVGBvBbRAkUtXCB6FzPPKfdskPEbl7n5q+xMz
         l2lLLEhZbea/tFeDzOhbVyrzuAD0ENS5/C3Nlwe8Sd9klssrWPxEltO0nu7GCTlo2T
         Bp3cfGaP2kHYY1OmAo+Gtfy6mgdMXWzynD1WciPyYjXl7lZi7QuvklCBwsFntLstci
         Ho263jGKNsiiW3jSJNQtf/FBb9GAHF1F6vFOxmytjvT7V5B3+Ma
Date:   Sun, 18 Aug 2019 20:34:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 11/14] t3903: abstract away SHA-1-specific constants
Message-ID: <20190818203417.GG365197@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
 <20190818191646.868106-12-sandals@crustytoothpaste.net>
 <CAPig+cT6Depk8sJ48zOp6+AObVmy3_eXnXPEsZJYXY=daZqXXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4LFBTxd4L5NLO6ly"
Content-Disposition: inline
In-Reply-To: <CAPig+cT6Depk8sJ48zOp6+AObVmy3_eXnXPEsZJYXY=daZqXXQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.2.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4LFBTxd4L5NLO6ly
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-18 at 20:27:41, Eric Sunshine wrote:
> For safety, it would probably be a good idea to check the exit status
> of the 'sed' invocation in the for-loop:
>=20
>     for i in "$1" "$2"
>     do
>         sed -e ... "$i" >"$i.compare" || return 1
>     done &&
>     ...

I'll do that.

> (Note, also, that I dropped the whitespace after the '>' operator.)

Ah, good catch.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--4LFBTxd4L5NLO6ly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1ZtkkACgkQv1NdgR9S
9osWVQ/+NV4QDr/eR1kd3Ru5SgVDKJ7Hppa0h91efZ5DRb3RSBxmzE2zNjiVFMNR
JMcU1oq1uYd355RJeoiXKWRdUGtJIR4wNxny0PthaWfVn5iOZFZiru156fEKFF1s
c102xFAj7FZZ33J5q44KvKXa27X4n95eJUfGDLPQmnBC4JgQAs3CfLH3UtOG2Sy5
/E5yfTpnma6Jhd9Cd3pZZZ/00X0h9mpAgkEmYH02hhPQkLODrcgsw5GCNa8ZIpFS
t9pId6Pd23F2XOBBteBzcNIq3bus1LlDfN5RwsiXTKRxVoRNEaDhkP8lJ3ii/T6m
W8YI3d70raQrqMsBo4WFsDi+KZgFS2LLCpqiyD9/CH0jHuMvIeABt4ghHGrrwq8O
2xJbGzJgg4ibM6MB4TZX1GTPzKw2O5tUBAxNSOaxe3Dw5Dywbcb9CEjzT/1eWQ3S
x8jNntgdr3VkDgHpMDH7nLFxGOdKvXGpWAwzyPHaAK+hKgIaoIpbYePX/Yis7IS/
dVpY8Q2sHbBFDIJh9apu4HEnWeH1wtK9nN78grkGUNhZ2xa5Zs0moT42WT1j1V0g
qJw6H1kgShqy+lSAsuPKjG1ahMDcAfarYRYhvDSjeUzcYlABCVHkiTVHHQH3QJ8V
ZsDmi5WCl+H4QrVsAtbMtrPUalCABkso/L3uVpDE8tMW8yUKqa8=
=gIEj
-----END PGP SIGNATURE-----

--4LFBTxd4L5NLO6ly--
