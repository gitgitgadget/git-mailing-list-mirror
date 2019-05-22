Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEDA11F462
	for <e@80x24.org>; Wed, 22 May 2019 00:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfEVAss (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 20:48:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36686 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbfEVAss (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 May 2019 20:48:48 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CE35060100;
        Wed, 22 May 2019 00:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1558486127;
        bh=GFyDXZTnPvelzrDJJvY05CZ4uzKaW4pTybHJ4cdpt6U=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QUg2JmfFO4i6W/PgoFdSbix+iY3J6EqCkP/EsBJqscIKjx1tDsiNEbFSl6N4xmhHm
         oOclDHuDDZON1xzOFIGEphMNB6BrDcgvHrQA+VPnyaM7JiTzGwNbdwELRhmKJAv5ry
         wKPgX7Zedsiw40h/KN2VbPBIL99NuN9sTK56cc5MiFu5VrhJyNDWTtN17FUt9HzkFT
         TOFBZV0G3WXJd/+Mw5aBZExlrG/wh/FnRvZSyUOzxpclRiFFR8IHp5IERlB09t3Sc7
         agvGa9QRjAIkDMoI+D6FtA8Gjbr/8mGd9hAmwoiYixIdPY5qqdw11p36MlGDlBQDdz
         tyzEqpVMHNAItyOasz885uzZ/tf/k+H+S09M73oYXGwKq8TyGF0ksKEu1gezydxotX
         8ddfY9KxVq05YA+Kyey/dd+fmg+sC1zZrVjusW9TZxCPNKLMBn1tZsi6QqbqeyNXKZ
         m9VP1tTIZm2sGzTXrz0uUEC+AW3kjUzP97fEzBXoiGUeK0NKopi
Date:   Wed, 22 May 2019 00:48:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Git Mailing List' <git@vger.kernel.org>
Subject: Re: [Breakage] 2.22.0-rc1 t5401-update-hooks.sh
Message-ID: <20190522004825.GC8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Git Mailing List' <git@vger.kernel.org>
References: <001501d5101e$db98dfb0$92ca9f10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <001501d5101e$db98dfb0$92ca9f10$@nexbridge.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-21 at 21:47:54, Randall S. Becker wrote:
> When running the test in isolation, it passes without incident whether or
> not --verbose is used. So far, this only occurs on the first run through.=
 I
> wanted to report it, based on the inconsistency of results. This is not t=
he
> first time tests have acted in this fashion, and I realize it is difficult
> to do anything about it without being able to recreate the situation.

Does running git clean -dxf cause it to be reproducible?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzknFkACgkQv1NdgR9S
9ouGjxAApLmdAFn3dskO12AEL6dA4VX8KtHwu8IYMJ6KBEzeXc8jI+wHSx070K5C
LzxCvK6UxVL4fqOq8Xek+piiilyFIw/RA3xoeJg+j9P9gnXvHJRg2NKUvj7qfUAU
CmcdAlh1CbRocxcfaJb9TrVkP7HcAElblGHTpqBlLQhk/XTRtADQplfu2eyVCgv0
7hJoZEV7/llaL5psOvnoodPdfnGwF6rV2lPOtMGtYsOIZ/5r+jpLgPqPX48tNo5X
8/o0BYWCBPcFvrtbJf/rraN2ecwDXW6Adh08Q/zvBkQIzsRcXGKCA75bMoGzEyho
wR6quLoRm10oaKbBfS97HpzeQoR6pZqGbNkGqd+H0ZekQzPvctGOlUWFIW8+JFd4
lbD2VEuGEtM/hZLEFhrotsfz8NA1vm90ieOh11QTNLtict3ColK3lSYyR6Ahs/Vm
2MP5DwXoLw4CT3q+ss142Brci6lx7esDAn80NojovjMZLYAUa1VIJTJCMAt2bLXb
k+VToMRYrVq0XmeSLE0SvQhbsuET+LrmhQST8ERhlcel2Q+/Q56lWG9/rfTJN+Ir
MkOeEJ4K1zF6l7yrSIAPs3REQts/8KICfjabzsyniamisRnsC1S4/zaWyGbajGep
hYT5CltQdQconoEi89IfZx5mk9NZYckzJEY9xhEHTWV3Il7Na3w=
=TX/P
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
