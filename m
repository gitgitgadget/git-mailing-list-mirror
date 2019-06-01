Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 550F71F462
	for <e@80x24.org>; Sat,  1 Jun 2019 00:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfFAAlu (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 20:41:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36856 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbfFAAlu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 May 2019 20:41:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1504:7263:609b:f73f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 960D860100;
        Sat,  1 Jun 2019 00:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1559349707;
        bh=RtFsUFc8yGPD7QTr5YkXvItQQUF9mxdkYowtJmlvjno=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=in+XQrB4pWlbvwLvPE4Tm1W6rj8jhB3xghSbmJvAHLKBv6ImRiTyrBYbS7JZYHKuS
         9HcdSBzL/SsDXsL9bu5QqQ/XgnEtQ1n6/5IYSio8cBLd3NcGw2z9duXw11pujUKC+r
         pH2KtM4vTpun25L4k4R/keCI5LZa7b52ym+IdasUhvLD8JQqu4bBzNSzcTXttBjzbX
         4E+hg1yGHfU+fZRMpy6A6u0u0kkuqvzq2Jy9jLh/RoLVwZ3sRdoxmco7pxjbXrXKmG
         yL0WcyoVsxQBp/oWHssfEIM2xpUPkPSPhMKp57k25V3Ag9KaMih0tlcZpghCOkAdfs
         7b29s6EODtfTLSXTBhZlCHXvPVT0M4Wzj6RBGv33dpRRt31/3rAeLd2E45jqi/oEAu
         ICs0RZCKIOmZmWWnYg2d35yfIbpD3rCMRaQr0/YdSJVaqZqd0p6Qkcq+m/KcixIGMU
         FmkkiG/5BmwoWkn5m2AJfbVXbONE4rSE1UNgD2K1mzUNdPvEOiy
Date:   Sat, 1 Jun 2019 00:41:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: Travis not looking so good
Message-ID: <20190601004143.GN8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
References: <nycvar.QRO.7.76.6.1905302125190.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vy1A5eXR7jld12ZH"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1905302125190.44@tvgsbejvaqbjf.bet>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Vy1A5eXR7jld12ZH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-30 at 19:32:41, Johannes Schindelin wrote:
> Hi G=C3=A1bor,
>=20
> do you have any idea why Travis is failing like this in the macOS/gcc
> job?
>=20
> > +case "$jobname" in
> > +brew link gcc@8
> > Error: No such keg: /usr/local/Cellar/gcc@8
> > The command "ci/install-dependencies.sh" failed and exited with 1 durin=
g .
>=20
> I usually only look at the Azure Pipelines (which gives me plenty enough
> to do, what with pu's individual branches being tested individually), but
> couldn't fail to notice that *all* four branches (maint, master, next and
> pu) fail in Travis' macOS/gcc job (and only there, the Azure Pipelines are
> all green):
>=20
> https://github.com/git/git/branches/all
>=20
> What's going on?

I'm certainly not an expert on macOS, so I could be getting things wrong
here, but it looks like we don't ever explicitly install the gcc@8
package from Homebrew. It may have happened to be installed
automatically by Travis in the past, but they may have upgraded now that
GCC 9 has been released.

I suspect if we want to use GCC 8, we need to explicitly install it by
using "brew install gcc@8", or we can just pick the latest released GCC
by using "brew install gcc" if we like that better. We will still need
to do "brew link gcc" (or "gcc@8"), since I suspect Homebrew won't
auto-link it since macOS provides a gcc binary.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Vy1A5eXR7jld12ZH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzxycYACgkQv1NdgR9S
9ov+RxAAp6bzkU43ib9MVbCK1wP9/FcVVGot+zlrT00uQ1rZwKMJTm91zBen/SuY
oBMwGQFWItb9ubeK5xJZuMbCuQMKFBaTwS1q4aF7zLYX5dcbTwMR9Tt8nDavp4Rb
2o6FWZK8kMiciobBro07pWLeFQA8zaMdOIHBU/lRWaQLLa52Sn3mAInpf7ZbQTuW
30ipdd7l5/uhFTAb51vSX3v7KcjwOMMopvkqSubzlcJQ6NgWtX5k5rcHO/JZO+nk
8t3PR0V4pLI4AInqHsgy/8tPBJZrKq63BAnuZVg5VW1A2cfjBkkJvsmO+146BumE
n7aRkWlFRfJv6gbO+zL3h23FZ6hoRWNzhpC5MxfatjLzynksYQdNwEqyDWg2benU
2CJcVvGz1ieoRn4+6TbzPVfBmTY5mQqrjCzWTYHvobqKWie42B4CFpSsksQHKupg
7dixg3v5h1cvhMUWaGo0Mhpj7sHBKgQEhx351j7YXr8NWh4wfop4ocvbsQMl4Fs1
Ku3UWBhhWszDRX3tBKhZ9y1UZxJC06MCRNwHTiLqGgv4NCC68SmjSabLrVJO8qbn
N4U2UMSpgFHjFEG+kWKkuLPnMdj4ZBsNcvCpc1sc30Eet+2uB+R9Axakf220EBkQ
Nbe8F1IZvL+36QszPIuGhpg9gOhpDTDzQ4yy3VzcHEyba6Jyr+Q=
=dYQ4
-----END PGP SIGNATURE-----

--Vy1A5eXR7jld12ZH--
