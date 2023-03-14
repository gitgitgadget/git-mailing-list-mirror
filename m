Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E334CC6FD1D
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 01:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCNBRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 21:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCNBQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 21:16:59 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7078D50FBA
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 18:16:58 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 99C9E5A215;
        Tue, 14 Mar 2023 01:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1678756617;
        bh=FUL8k7U6yKqQEJslrEXtrQDkOkF15SCDXqcynH7iuFE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LD0wopnKkfd5ckHbMw9MlrY0Mu2nB4UtIcBFgBJWDleTqgYR9i2eVZYn2iRzoO2lp
         sHENYUQT6l8XDz/4upb0WlQ8ACluoma7a4soS8ZAROhdjKbNLdVYdNMry9IfWanQtN
         5TzrhDigwKnL3pEVVS6JYQHpL2R0rgDWh/xOJ8SEhcfe2MRPSaJ2Pyu28NDlUZSy2Z
         k5rUA73A6YXmdQJylCtXe2re0Q9FNCcNUH77FlzzmQGqIONDubkxUKVHzLEgn9cAHV
         04HNOltiUpSSodK6VRbUscMX+rM1tSLjln73HL2ZQZIoJ9QSzLyxVefGziPs0RJGXq
         pURrWJFJWjEapNdACcOKZu6/Je29tjQySKtB7hY2sGgfAAkiLjNLIdJQHWU8DQjo7J
         dORR4umGZm2QIfXp/9r/XqX7Dc41DR58bDd2qgFHoYWqMRdTXRpTPRMpWtW0XRNXRy
         HZoMJFTduUV5Bs0jEG6FpQoY3V9FYYhjn8M/fR9LDqPOmCnmTdj
Date:   Tue, 14 Mar 2023 01:16:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Edward J. Ouellette" <ejouellette@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bugs in config of Git-2.39.2-64-bit.exe
Message-ID: <ZA/LCF7R6GUeW2H6@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Edward J. Ouellette" <ejouellette@gmail.com>, git@vger.kernel.org
References: <CA+A2caFjpWZ_UqZx8YOOTxsYDWWxrXfapPBaNdQGdEX+m9GEsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8w9pfRwtyZVgug03"
Content-Disposition: inline
In-Reply-To: <CA+A2caFjpWZ_UqZx8YOOTxsYDWWxrXfapPBaNdQGdEX+m9GEsw@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8w9pfRwtyZVgug03
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-03-14 at 01:05:47, Edward J. Ouellette wrote:
> Hi,

Hey,

> I just installed Git using Git-2.39.2-64-bit.exe on Windows 10.
> Windows' OpenSSL was added to my PATH, and Git was NOT added to my
> PATH even though in the config, I selected "Git from the command line
> and also from 3rd party software" and "Use bundled OpenSSH"

The Git project doesn't distribute binaries at all.  It sounds like
you're using Git for Windows, which does.  You'd probably want to
contact them on their issue tracker at
https://github.com/git-for-windows/git/issues (after first verifying
that this hasn't already been reported), since that would be the best
way to get this fixed.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--8w9pfRwtyZVgug03
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZA/LCAAKCRB8DEliiIei
gc/TAP9yfgxkbzIH02tyGzfNme8kSHKhH0R424zm2I9OGl/vEwD/U4sF1g1MKO0v
mKR6C28tHsZUJ5byRy0Av1+fCEda/gk=
=3NaF
-----END PGP SIGNATURE-----

--8w9pfRwtyZVgug03--
