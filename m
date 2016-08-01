Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AD631F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 10:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbcHAKlp (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 06:41:45 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:34430 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752102AbcHAKlo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2016 06:41:44 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:395:747d:98e1:fc48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 400AC280A6;
	Mon,  1 Aug 2016 10:40:24 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1470048024;
	bh=f7b46/zgu7A7u66xh2RIWvADssfwwMEL0/6B93Dgqrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7b+k7IAt02rAqnHNt9XdeFhaupW4GLBTD+7RaoKjE9T6sdxfBiWhTVOb9riAA4HD
	 61R23vtw+d8i/KqkB67RV02RnoPjojSDR2MSIgDCMMUqHYVrW3vwIHCbyPkg8cZXRt
	 TOkOKIOVdIRX7NCknWETiy0LacFuBjAWom1kOfoYvaPv53iXPEwzyY7iIOds4HpMYL
	 vaLCqxnYTuk5A3R3s6Mt4mtxq8ynyBhmwuybmwm8lZs6BQbiy6mI+POpuWapkfNBd/
	 rTLuS7CTP1vkt62W0URtXAHLovU3n/nLFcukCuwt9LB/UWhTJDmwguoAMZDsp9qFNP
	 UKd8B3IEO2/exDrtSUXyWAQBxuB62/+agvadASF+SkP3OjS/GtTFMUxd/R2H2UFT2q
	 ZdXC9paWQo8WZ9iG5JL7F8xAZx1NexrcmxpjsHJN0GN/155mK4f877rm6D8dOCiH6z
	 Ni9p9j8XRLwcKKIl8aofzoY/6abguBfzAZOcUwhdfVqe15YjD8y
Date:	Mon, 1 Aug 2016 10:40:19 +0000
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:	Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 1/2] pager: move pager-specific setup into the build
Message-ID: <20160801104018.jpebaum2vqkgzyoq@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	git@vger.kernel.org
References: <20160801010557.22191-1-e@80x24.org>
 <20160801010557.22191-2-e@80x24.org>
 <20160801014303.x5j3dqumcmrkyc76@vauxhall.crustytoothpaste.net>
 <20160801070037.GA18261@starla>
 <d4dc2061-afb0-baa3-f54d-bccfdf7658a5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nuh43izuutuifgqk"
Content-Disposition: inline
In-Reply-To: <d4dc2061-afb0-baa3-f54d-bccfdf7658a5@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-rc4-amd64)
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--nuh43izuutuifgqk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 01, 2016 at 10:57:02AM +0200, Jakub Nar=C4=99bski wrote:
> W dniu 01.08.2016 o 09:00, Eric Wong pisze:
> > "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> >> So it looks like this function splits on spaces but doesn't provide any
> >> escaping mechanism.  Is there any case in which we want to accept
> >> environment variables containing whitespace?  I ask this as someone th=
at
> >> has EDITOR set to "gvim -f" on occasion and seeing how tools sometimes
> >> handle that poorly.
>=20
> This is to handle environment variables holding program options,
> which are usually (but possibly not often) using single character
> options bundled together, that is, not using spaces.
>=20
> Moreover, it is about holding program options to pager.

I understand that.  My point is that we should consider corner cases
like how we're going to handle spaces.

> > Yes, it's only split on spaces right now.  While I don't think
> > there's any current case where spaces would be useful/desirable;
> > I suppose a 3rd patch in this series could add support for using
> > split_cmdline (from alias.c)...
>=20
> Is there any pager that needs spaces in options-set environment
> variable?  Does MORE allow option bundling?

We seem to accept GIT_PAGER=3D"par | less" and par definitely accepts
spaces in its environment variables.  That seems to be a corner case,
though, and I haven't seen par practically used in years.

We may also want to consider EXINIT for people who pipe to vi.  Again,
I'm not sure this is very common; most people would use an .exrc or
=2Evimrc.

I'd say if we can't come up with any better examples, I'd skip handling
it for now.  I'll try to come up with a patch to add it later.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--nuh43izuutuifgqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.13 (GNU/Linux)

iQIcBAEBCgAGBQJXnycSAAoJEL9TXYEfUvaL32wP/114OumHKv+sbyZA2EA+ey+3
JU/8AtWhoe5Wr2iScDXUaqZXk34gQt1XW1n9mPBnmzwimTb3JEupBqH/ZKSO4fiV
hUnt9Np+bLQpTs20h2+4ugHLc9fIl76zbaJdqgL5lbPg9EEju4lXVLtsaZsd7W5K
Lo9yDbnVy5D3tnczEbYfb7JVotG8PdcUundtJHsRph4410D39casQtF5cNwiFLNN
6ekGFz608S9aKTU1yt/lg76B1Q7attlhC/NwI1DzibZNfQeNoTvw0+meSV8E9Iis
Gnjcd5QpBhQP3SOULp0/60brEQvkRypN0rRBBZMr7HSBhdY4HquDlgqu+7viOVsl
2NKhA78Ct0yJiBc8fUgpvvIheGSU8hgYfSWQbgcU6MmgKa5Z91iGcBPD21RCTl/8
t0xntN41IJGmyEtPGioXbb7Z14IY/SUJovcjasniSMFMieRKFqtPZEDoyRKTEkGe
c569ztFllIyPccO6RBulW4/j0BNtPUHol07YqTmtpja15qyUAw6ZCtCgYIzaVLnf
n/BlgLTmGVygKhQ07Z3uGpdumLYDb1RtZRD5r9k0CcgfNCb+mcvBEHwSIfDxVJho
g6WwW1BpjE8Lse4S6YA3uY4+j5+sSjY3zbsy6VZwGwo/Iv0Ezg4g7D4jMdtMFwPy
dFg+QjYLn/l/d6JQHau7
=7ReJ
-----END PGP SIGNATURE-----

--nuh43izuutuifgqk--
