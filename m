Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2433FC433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 01:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4CF6044F
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 01:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhC1B1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 21:27:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49658 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230318AbhC1B0q (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 27 Mar 2021 21:26:46 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6187060752;
        Sun, 28 Mar 2021 01:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1616894775;
        bh=scO4EM4Nfd3yLgD4BqZ8UxP5sjI8VuFQ5P0SXj67usw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZezcIkPdaWX8nc4fycQdJgXpHzk56m7z1VqLlv59mA3n6Kk1qaV1NPMpsmMjMY9BR
         b1kjqFs+Dr1bi1obltsUfY3irc1C9uYL6SkPCIxoVCjKpUG7KK6R5R9KibJyMcdwfl
         TvTJ3hi6Xk4ih2bpr4QOUgYDxtt+B0UV62TQoy4k5ThdkBSPDBba8p1tqCdERgvRkz
         CQ4VaaD6HIMtgr8pmJE/SKdIZZBMLQK05YorMJIVLI/2KUQ4CExLud9aYkY/l8ltGp
         iN6XB4+Joj7fXSv+efq2yH1RfEAWEhLyGTDnHq6Kqh2TewYvSb1cp2XGzsd+15Zk+F
         XM18rUP/CAwymxp3pxMnHqnWGJzuHb294WovuGWKusq1M4thd6YpMp8rVXyway26jY
         CrGIwgdNa0p8uCo34u8vKX6YkvGXkS168iduN4/0/zZOgkjEO4NAv6vsoCa3VdEiy9
         1jj5yi+mF3hj+TD9N5nM7P3uLih2e+JLQfSbUnm1vfKGjLdCM6N
Date:   Sun, 28 Mar 2021 01:26:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git 2.31.1, Solaris and error: conflicting types for 'inet_ntop'
Message-ID: <YF/bMjJA2RguVguZ@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeffrey Walton <noloader@gmail.com>, Git List <git@vger.kernel.org>
References: <CAH8yC8nUpHP4iX-iQqMqX4wR6sMZO2MQv9fBVVTSys67_oGX0A@mail.gmail.com>
 <YF/RtL+TS6+DNCTk@camp.crustytoothpaste.net>
 <CAH8yC8mSMZDjhbidruAh9t7QFsv6Yxqi1poNEXBT=Nn9+sB2hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9aJ301K7KYwPEQ5e"
Content-Disposition: inline
In-Reply-To: <CAH8yC8mSMZDjhbidruAh9t7QFsv6Yxqi1poNEXBT=Nn9+sB2hA@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9aJ301K7KYwPEQ5e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-28 at 01:04:32, Jeffrey Walton wrote:
> I see what happened... I stopped Autoreconfing so the configure.ac
> changes were not picked up. The original configure is being used.
>=20
> I think Git is getting itself into that state.
>=20
> Without the Autoreconf, I was able to sidestep the issue with:
>=20
> if [[ "${IS_SOLARIS}" -eq 1 ]]; then
>     CONFIG_OPTS+=3D("ac_cv_func_inet_ntop=3Dyes")
>     CONFIG_OPTS+=3D("ac_cv_func_inet_pton=3Dyes")
> fi

Most developers don't use the autoconf stuff and just use the makefile.
config.mak.uname doesn't have NO_INET_NTOP set for SunOS.

If the autoconf scripts or config.mak.uname need fixing, which is
possible, a patch would definitely be welcome.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--9aJ301K7KYwPEQ5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYF/bMAAKCRB8DEliiIei
gUN1AQC0KSM/c5F34NYLLPUcnuG6cbG03GsxnGfwfChfNkckQwD+NqNaNxMbOPtc
uevwOwqUDdHL8DFdI9d5yNcvbu9InAY=
=k2+p
-----END PGP SIGNATURE-----

--9aJ301K7KYwPEQ5e--
