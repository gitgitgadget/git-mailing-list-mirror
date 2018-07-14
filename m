Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A24B1F915
	for <e@80x24.org>; Sat, 14 Jul 2018 20:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbeGNVL6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 17:11:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58148 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729849AbeGNVL6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Jul 2018 17:11:58 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 703516047B;
        Sat, 14 Jul 2018 20:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531601498;
        bh=2BHATrWpS4+rM1Sx9wXXw8FZ8Fg1SBVKT9hoOszc/ko=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0F6ldoDP7f+ssiLwwePJbpuQVBNYvb75X1tshgbHc6LzXCUEyre7XwLe8B+0lLtCq
         bgqwqH+1e4UQ18KbCcjADHIZ7gjPjn30zkClahsPJ8fXHPxVayxlmf1KWoWFGb2Ifi
         7qneFcX1lf3ztdGJUr5r9y1lt7JK2i0KlvJcBHMMF7NjM+mQc9HBM/W+XHlfKTKYRI
         qknzSPK2wxbX5Tm2C6Cz7yJZ96lMSavY2yxydXp+M2JYgAeLXjoCdpsnMJDRRkuHD1
         1367J1Xpgu5emkQH4nKgo4o0oyCI3tRhUxyUyhGlvAsLJkwiUUB+cMqBsOvZjl2pZt
         LVFQ1bIw9QI5AacWrbDn2oCKyVijFWOKDuP5xthySzcW85ePN7RjB2K4jIA3Qb1Xsq
         wfDhGOrneO6ien9G0aRpMQymepQqoeTxNPFSJ0s2JibxNRs2eQyPw1FMz5oAVFNLok
         RYb8o+GrOnJVuYqSISUnkKi75BMeiJYC734LxYXil3hLCZ/hle4
Date:   Sat, 14 Jul 2018 20:51:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Perry Hutchison <perryh@pluto.rain.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        paul@mad-scientist.net, dnj@google.com
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
Message-ID: <20180714205132.GH1042117@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Perry Hutchison <perryh@pluto.rain.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Johannes.Schindelin@gmx.de,
        git@vger.kernel.org, paul@mad-scientist.net, dnj@google.com
References: <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet>
 <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
 <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com>
 <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807082346140.75@tvgsbejvaqbjf.bet>
 <20180709195822.GA9000@sigill.intra.peff.net>
 <20180710035635.GA13459@sigill.intra.peff.net>
 <5b445ca6.TkV9Dj8T2KFinxZP%perryh@pluto.rain.com>
 <20180710140310.GA9246@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MGu/vTNewDGZ7tmp"
Content-Disposition: inline
In-Reply-To: <20180710140310.GA9246@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MGu/vTNewDGZ7tmp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2018 at 10:03:10AM -0400, Jeff King wrote:
> My point is that aside from RUNTIME_PREFIX, we don't need /proc. So
> somebody who currently builds Git with a static path like
> "/usr/libexec/git-core" and runs it inside a chroot will be just fine as
> long as /usr/libexec/git-core is available at that name inside the
> chroot. But if the build starts relying on RUNTIME_PREFIX, it's going to
> regress their case.

I will say that at cPanel, we have a configuration where end users can
end up inside a mount namespace without /proc (depending on the
preferences of the administrator).  However, it's easy enough for us to
simply build without RUNTIME_PREFIX if necessary.

If we turn it on by default, it would be nice if we documented (maybe in
the Makefile) that it requires /proc on Linux for the benefit of other
people who might be in a similar situation.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--MGu/vTNewDGZ7tmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltKYlQACgkQv1NdgR9S
9otYvRAAi3CgUhNB5vy1qvxVCYaiUnRzKcYcZKmoaDYCguDODFJunBjozRyCZO5T
Sh86KUbOqH7NdhCytsdIvnBEGyEscG3LoW8+o0rKl/nCTeqRRgfH/mcaKc/bXARU
Lry0ugl8/dsADHB66pT7hkPhWYyhi2Whl/B/iUXE8lBvhlsve+d8yHf0GGgPAZxE
JJ9Hh1lxC45lC1q1V9DB6VLfjOlvPCjHvmKk1yc3QP5T9m0nGUlIvM2X3tN5X2MW
ASILOwGLwLCHl6/+eSq9MaSVkOL5Olw+L9NiFrtaK9RI/JBIXDlaMcULWQ9lkQME
d314MzqaeNvQIQU/lsUDhT59G+IfuM1v6HaZjsN70h3FgWU/GlMHGhT9+zg1k/e5
bvI+iSDUvAUG8mluqUmTamWW23HHuIXbdd75wpEagMB4aBY593teQAgQd5RYraLi
bWKX6BtgMrNGD8FAPNdOtJPcFxmtKuk/FdCEyy+X4JZnKIcEFS2K5P+s2M9M68z7
sv0e8qjEfyZYOfK0WxBhxKh1VQenSsIzSmj8/X12YzbPb3NHohklhb2w5WB6PJMo
pojEhpuMwEa20MbSNW5RbDwL761jGfBQUmOBxY3yZIXr8c7VwzL6AOrYnLITTxqw
5RhsbD/G4mDpXiqLI6w4CGERAsuvEDU5LgebXe3pQwprhvB9fZc=
=oVcZ
-----END PGP SIGNATURE-----

--MGu/vTNewDGZ7tmp--
