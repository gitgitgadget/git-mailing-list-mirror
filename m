Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F22C35280
	for <git@archiver.kernel.org>; Fri,  8 May 2020 00:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E332082E
	for <git@archiver.kernel.org>; Fri,  8 May 2020 00:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nWly/nNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgEHAGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 20:06:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37996 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbgEHAGO (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 20:06:14 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1DE196044D;
        Fri,  8 May 2020 00:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1588896343;
        bh=+HZ+92ycmmYK1OpuMRg+25yH7ot6Pg8P5s3GadQ2xyE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=nWly/nNH9jEWzHkbCnlUTyoTr0NzIhp/8uN4z/ci9vs4BXgKBxR1Xw+Z/nB4P1b/D
         Nb7RlBL2NQFctTO+BMJTXp82wt4r1/mxcKO6Y6FhShcgyaWtO/vAbskwty19khAoNJ
         iceOJlAEbSRaHLBuTggSFLs8uOK6FcMlGdMAx3R37lQaM1877SHkD6mnh8J0qSvVSy
         fvQ4AHsoIBpCFUZ4ZWRGsM6nJY8c0JFNxJOWsuuQaxpyITBvDAK4xGE6b1UxLnbJzJ
         rQXiNjwAnpTOXdUlMZk65eJyqDAo3QOz5cVp/VyuL6mwMUEEo71sAxH0zgX90NLTH8
         NUR2c3fhttMkH21eM1JDQJWbE1DLAB+UamQ9+WLfyvIZUODCwBc50g8FEceNBE3m76
         LQNRl9fk4jDqv/ewlF/+tTSDvg5n7URp7z65I/vy4V5HGM2+McU1qfyhxPzLfyED7p
         kbL64FEtdfK5yA0aA24S4NQL1krf9UvxBsxCNViLrCTNOPYdIO8
Date:   Fri, 8 May 2020 00:05:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Solomon Ucko <solly.ucko@gmail.com>, git@vger.kernel.org
Subject: Re: rebase -i: quick/inline reword
Message-ID: <20200508000538.GE7234@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Sergey Organov <sorganov@gmail.com>,
        Solomon Ucko <solly.ucko@gmail.com>, git@vger.kernel.org
References: <CANtMP6oKN6Ueu=fqFYv2VhUP5S-ifbSzPTARvbEg4eV0pcRcHw@mail.gmail.com>
 <87imh8m346.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Content-Disposition: inline
In-Reply-To: <87imh8m346.fsf@osv.gnss.ru>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-07 at 10:49:29, Sergey Organov wrote:
> It'd be really nice if it were possible to, say, search&replace in, or
> spell-check, interactively, all the commit messages (including titles)
> of a bunch of commits to be published, all in a single file handled by
> single rebase run.

It is possible to do this with a bit of shell scripting.  You can run
"git rebase -x" if you want to check every commit in a certain way.

If instead you'd like to modify all the commit messages, you can use
something like this:

  GIT_SEQUENCE_EDITOR=3D"sed -e 's/^pick /reword /'" \
  GIT_EDITOR=3D"some-shell-script-that-modifies-its-file-argument-in-place"=
 \
  git rebase -i BASE

I use something similar as an alias to automatically squash all my
squash and fixup commits without needing to open an editor:

  !f() { GIT_SEQUENCE_EDITOR=3Dtrue git rebase -i --autosquash "$@"; };f
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXrSiUgAKCRB8DEliiIei
gZyNAQC8MqThf6lzrmBqfLFgAF1JKmtyTpNao4C4dYHqsAnpcwD9GaDhJ9aDflft
6RqoRlJodYIW72uPp9XJu/4Z3f2z5Qg=
=/+IL
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
