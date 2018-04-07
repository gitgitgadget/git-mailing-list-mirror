Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4C31F42D
	for <e@80x24.org>; Sat,  7 Apr 2018 19:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeDGTUe (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 15:20:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50496 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752552AbeDGTUd (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 7 Apr 2018 15:20:33 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9D1946099B;
        Sat,  7 Apr 2018 19:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1523128829;
        bh=/1OV1nViy0tTcnMZiqpywn04NCT2Ha6Kn4BQQaICWJk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OBtvDuy47iGF2lcI5FP0ihPpWSSKIsf9LjvD56rd73B6nuqcCmNDRXO9my97iZCW0
         bvjDqB5yMLYJLHaTj9W8EgVXOBtmq8qaNn01DW99hG9YewGp+MHXAC55QW0vIbaphp
         YJHVVb8vXAckBMG4zBKh51CCOlmqo/+wlTj+QF9hhPI+mVZooKhIZ2yuEbddQKs1FI
         xjiGSkybVfQwR9C8qELb4GGqP74Zlrjcm+jdLOIs0614SKiHXrl2voSIFViy7MWU2Q
         ZavHTXTWjOpFlpS70AYjHqGa0FfrirKprWuBYobE1RG17SHomnd2kMbdrls8ChmheE
         tE5qiA9UAUxS+tcvw4wijwysU/x5S0LMgtBKKRP54E5LSN2ER/lk8UkyLl3gTnscwj
         I2c/+7+fQJyzmhRCOSvhJG0lbp7lPuXxc2T4aCPtxnyomoFl6gAFhrNumhJoCEc8Pl
         CkopST3stm5AKOgKghncDeRL3kwTaYiS85CXyizktR8AgGRFIcb
Date:   Sat, 7 Apr 2018 19:20:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Joseph Mingrone <jrm@ftfl.ca>, garga@FreeBSD.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH] git-svn: avoid warning on undef readline()
Message-ID: <20180407192022.GD9954@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Joseph Mingrone <jrm@ftfl.ca>, garga@FreeBSD.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>
References: <86h8oobl36.fsf@phe.ftfl.ca>
 <20180406131514.740-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
In-Reply-To: <20180406131514.740-1-avarab@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-rc6-amd64)
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 06, 2018 at 01:15:14PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> Change code in Git.pm that sometimes calls chomp() on undef to only do
> so the value is defined.
>=20
> This code has been chomping undef values ever since it was added in
> b26098fc2f ("git-svn: reduce scope of input record separator change",
> 2016-10-14), but started warning due to the introduction of "use
> warnings" to Git.pm in my f0e19cb7ce ("Git.pm: add the "use warnings"
> pragma", 2018-02-25) released with 2.17.0.
>=20
> Since this function will return undef in those cases it's still
> possible that the code using it will warn if it does a chomp of its
> own, as the code added in b26098fc2f ("git-svn: reduce scope of input
> record separator change", 2016-10-14) might do, but since git-svn has
> "use warnings" already that's clearly not a codepath that's going to
> warn.

Thanks for this patch.  I ran into this earlier this week (with git svn
fetch) and had intended to send a patch, but you clearly got to it
before I did.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrJGfYACgkQv1NdgR9S
9ov/LA/+OGblNHvWiLfrqmIIlEoyO2yyGRl+ESwiUxaoZyK7R/aX+rgOcm6WOYQY
UYdPffAIs7PAwhAoEPx8pLDlt4HNgDnZArzhn26PrT8vuEWbGncKws2G8nIFoC/7
O1VgRKRzk0s8KxSNRLCRiWEuGzFpcv9x61Kp0l7Ce8mmSXsKgdf79qaRq3tyRTXi
gJ77eWKHfgHfGBBdoqTAo4a794QL9dHlX7k9uvx27NWdzMM9r3m+V82TYyP+iFak
bNkjZRH5LctPcHknZCvsY6SqvnFYIRTz31R36/MlyaRiSt0MIm6gLRP2MooGYOTE
LPw6GNeOC2drHwWEppQxnt3C4zaEDji/ZZIZLRcxIG5Nhdt8yHNCsfip96fvUsLH
6WYaMZ3m5a++ED7gEFpX//SLMMzdUQ7DRb32u2fKBbkGvRDy+26PCzdcnGT7/Twe
3ha5z11TvZOREixzqcscFeYgJez4c8exRwk9dUJzNWRUVMBm/OdLTcYKQPW1fsJC
yncofzzyoyQpAhIJ+eJwHiZh7riYveeWs1og27zle7YfT9wauQgotZuGXY9pQPJf
SoKam7SWrq3LPlNTg+eOZH3QfcCykSAOng5ajTU3UPzReiBXyNdNXk38uLWnl1LC
Tcs1hNRe3XVktdiBgxIJnlaK6zH3icE8L4otLWpMsRqSx2Lgtes=
=3MkM
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
