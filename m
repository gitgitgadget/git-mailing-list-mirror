Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19486C433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 01:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB98161246
	for <git@archiver.kernel.org>; Fri, 21 May 2021 01:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237941AbhEUB5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 21:57:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47376 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237361AbhEUB53 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 May 2021 21:57:29 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 081DC6043F;
        Fri, 21 May 2021 01:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621562137;
        bh=Abl6MdBsIy8XXbicSNnTzfZZvlRQTLEDlEp1FZB3ji0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ax1G7IH66IXg58oWFQrKb5fMWsA/aOsKkNfz7w1LSNls83ugHnw87Kj2mKshD7NY6
         x6X3DOX7qyxjJO+4/7tDPBHL8ln24gM/ZNwEoubBAKS5hkVpI7QUAhFcTJZjyjaFY8
         lV8lcHnNjKfBZypYB0PnrlPPsZrvlMq59R/kIm62Jn5WzUpSkxmze67ys15TZn/ft6
         i1TDQ39ruiz1TfoavszsqehOeXywRaVXawEz0EMYf3F9QsKR3yBE6P1NYcQ8C1hzOI
         zykyMi5AOFFjztcPYHecHAWiF4D2sXUzp0FWdJ+iXTw9barCv1S7iIeWO0auMS/81I
         esk/8+02BNqcgXYZJTFoO2oHHxbx5XtS54S4v/yyLLWTVz8Ty8uHHAxnq+VoqAXSF1
         w+HzKa2PKdN4Pux9P/QncQXye24pmfcTPdF4zt9MacPvVydGYZReZjejMDjZz22A03
         879HVF9rqbQ4rbNFl41qTKgM1MSjBhA2hdqpVDBo6mq16E2xluv
Date:   Fri, 21 May 2021 01:55:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Siavash <siavash.askari.nasr@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug] git-credential-netrc.perl is not built and is not
 available in `exec-path`
Message-ID: <YKcTFDgW4etXFpOR@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Siavash <siavash.askari.nasr@gmail.com>, git@vger.kernel.org
References: <87k0nt3f8i.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0K+beWlKuICCS+MR"
Content-Disposition: inline
In-Reply-To: <87k0nt3f8i.fsf@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0K+beWlKuICCS+MR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-20 at 09:51:25, Siavash wrote:
>=20
> which is located in `contrib/credential/netrc`.
>=20
> If I'm not mistaken, it's because it sets the `SCRIPT_PERL` environment v=
ariable here:
> https://github.com/git/git/blob/88dd4282d949cdafff516650c1be8aaf4d67983f/=
contrib/credential/netrc/Makefile#L13
>=20
> But the Git Makefile un-sets environment variables here:
> https://github.com/git/git/blob/88dd4282d949cdafff516650c1be8aaf4d67983f/=
Makefile#L587
>=20
> Also credential helpers in `contrib/credential` are not present in the
> output of `git help -a`, is that a bug?

Things in contrib are not built by default because they don't
necessarily work everywhere.  For example, the osxkeychain credential
helper won't compile on Linux because the requisite shared libraries
are specific to macOS.  You'll need to compile them manually and install
them in a suitable location.

Note that that location can be someplace like ~/bin, if that's in your
PATH.  For example, since the Debian packages don't yet ship the
libsecret credential helper, I've built it and placed it there.  Now
that I've done that, git help -a shows git credential-libsecret as an
option.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--0K+beWlKuICCS+MR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYKcTEwAKCRB8DEliiIei
gVglAQC52nmV3c1XI27LrXIEt9hwQLOsMYS8XdeLIMI/Y6rV6wEAtekM1f36QJ8X
wCaXfcxvyEhldI0bK7DHrHFntfQ22Q8=
=GomW
-----END PGP SIGNATURE-----

--0K+beWlKuICCS+MR--
