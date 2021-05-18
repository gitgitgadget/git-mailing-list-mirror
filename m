Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008FAC433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 01:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7974610CD
	for <git@archiver.kernel.org>; Tue, 18 May 2021 01:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhERBVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 21:21:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47262 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240732AbhERBVM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 May 2021 21:21:12 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D52B260751;
        Tue, 18 May 2021 01:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621300789;
        bh=/Mw9RKJfejF9s36gt36ifL1KVd1XBdmFl5XDT1jeaAA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=IXnxQFLkLCev6N4ZQjZPvM5kqHK3c/U9hJKlAjgpBYS/IbbE4Go7JTRfVc08LQZlx
         6u8BL/4i3LG2CsR5rrYg2U6dmKGmtSKoPlMMoPT6m+b2eCTC6q1VMtWWMYYS74OH+M
         E6iGAkVQC/kLydsucCPeKZ3C2jm5Qq83zCyVwtlfwUQ3Nyo8IBeLdQ0ZBxKiEaySNW
         qwM7ItTftIN6rmNAJSwKWSXG7OPvrVs0X7e23ggm/2bNuCiIsU3j265f560z48QD8l
         CJERvpwPC8HQVYON/oHB7DSqM2tcaKuS2zjU/gUececK2Nn2NFZqu5aVCAz7d45Mzl
         pmCwVh8bPQfUoyYAY1LrbbRFmwzfqu0jsz68O4TOpfH/GLTEq1j9MLKPc1hmjkBrvp
         87Q3miuGHNY2OHuD5RqnQ+2ZXQDmVc26E4+x5i/XqWimjMWXfH9+iDKND/AtWgobsU
         oPSGi3ziIDD712VLm8P28pZW5fYd1Bc7g0gnTXQ0+C4zSmjCyBS
Date:   Tue, 18 May 2021 01:19:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] help: colorize man pages
Message-ID: <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h9lQOoyg4am2+x3j"
Content-Disposition: inline
In-Reply-To: <20210518010121.1350327-1-felipe.contreras@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--h9lQOoyg4am2+x3j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-18 at 01:01:21, Felipe Contreras wrote:
> Our man pages don't contain many useful colors (just blue links),
> moreover, many people have groff SGR disabled, so they don't see any
> colors with man pages.
>=20
> We can set LESS_TERMCAP variables to render bold and underlined text
> with colors in the pager; a common trick[1].
>=20
> Bold is rendered as red, underlined as blue, and standout (messages and
> highlighted search) as inverse magenta.
>=20
> This only works when the pager is less, and the color.pager
> configuration is enabled, as well as color.ui.

I think we should let the user decide whether they want to set this
feature themselves instead of setting it for them.  For example, I have
specific colors set up with these environment variables, and I'd like
Git to honor them without having to configure Git independently of less.
I expect other users will expect Git's rendering of the manual pages to
work like other instances of man(1) on their system as well.

Additionally, using colors poses accessibility problems.  I know someone
who, due to his colorblindness, finds terminal colors distracting and
hard to read, and prefers not to use them at all.  Even users who want
to use them might find some colors to be too similar, and this patch
doesn't permit them to be configured.

In my particular case, despite having normal color vision, because I use
a transparent terminal which often results in a grey background, I find
the standard terminal red to be difficult to read, and so this patch
would result in a significant decrease in the readability of the manual
pages for me.

So overall I think I'd prefer if we didn't color manual pages for the
user.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--h9lQOoyg4am2+x3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYKMWLgAKCRB8DEliiIei
gVDNAQCXGSzykixkEckYLMDvLUS/8cCyn345jNIm1ha2cIMimgEAoTTnjxlWKB5r
a7m7Gyo1TtVb+4+60BwDlF91eicdyA0=
=QY/3
-----END PGP SIGNATURE-----

--h9lQOoyg4am2+x3j--
