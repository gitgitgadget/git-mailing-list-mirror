Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C35CC4332F
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 01:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbiANBiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 20:38:14 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:34166 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbiANBiO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 20:38:14 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 2439C5B227;
        Fri, 14 Jan 2022 01:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1642124293;
        bh=aWfgIRRw3KJyWuX/tTuIqKcb/y4qP06tlonqlfInUng=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Gwo8onPm1QrRAe74uOMLCGZDpR9PUYDg1uLxCm4ZRdKrfqIGUeh8bvzi/spYjhieY
         5LgeactTydAH23IZHmkTJDz0z1LyEc/RWcYWnECY4uUNfXRc7e3smvoQ4UcgitDkrR
         4N2ONoyGbjqY1kcOOs85W3g1aiGQR8dPWm7lT3edy6IYGsfcOWpDQdasZ9bP+uinap
         Vh8YljQK+QR7t/wIdxTY6VhJRZWJ0Sts9i0TR26+tgamzvqMomKhLVLplUAN5xVejK
         hdQTHE5MK18nrJFgAdYaFkUHbSxgWrHZs5NXsPG4VmDzhkBrYWnWEHjoaD5jQ7grS7
         rlCbOWPQFPdoGGQ9mNM3FrsoCZaBzVNzNo8c+Ts+ymlAezzc1ZGzWdL5FX7HIzR/cC
         FRAF4tDw39PFP1VDGz3ZsFw5atPDcvFZ5b2FfuQRgDchT1PxeLi/eqZNUB/xyjQEFe
         unw1CMLAiM7l04ZN6eV/H1RP4YcBjwMWT/NYC43itJkYDFyTOMs
Date:   Fri, 14 Jan 2022 01:38:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Subject: Re: v2.35.0 DEVELOPER=1 regression (was: [PATCH] config.mak.dev:
 specify -std=gnu99 for gcc/clang)
Message-ID: <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
 <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
 <xmqqlf0w5bbc.fsf@gitster.g>
 <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
 <xmqq4k7j68eg.fsf@gitster.g>
 <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
 <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
 <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
 <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WPKwYqHENhlpWZ+c"
Content-Disposition: inline
In-Reply-To: <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WPKwYqHENhlpWZ+c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-13 at 10:45:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> [I'm aware that Jeff probably won't read this in his sabbatical, just
> replying to the relevant thread]
>=20
> Something neither of us considered at the time, but which is pretty
> obvious in retrospect, is that this new -std=3Dgnu99 dosen't only apply to
> our own code, but any system and library includes that we need.
>=20
> Thus e.g. FreeBSD 13.0 which previously was happy to compile under
> DEVELOPER=3D1 will now die because its core libraries use C11-specific
> code:
>    =20
>     archive.c:337:35: error: '_Generic' is a C11 extension [-Werror,-Wc11=
-extensions]
>                     strbuf_addstr(&path_in_archive, basename(path));
>                                                     ^
>     /usr/include/libgen.h:61:21: note: expanded from macro 'basename'
>     #define basename(x)     __generic(x, const char *, __old_basename, ba=
sename)(x)
>                             ^
>     /usr/include/sys/cdefs.h:325:2: note: expanded from macro '__generic'
>             _Generic(expr, t: yes, default: no)
>             ^

I think we had this discussion about FreeBSD before and that's why I
specifically dropped that option from the main makefile.  We can either
drop that patch, or we can set it to -std=3Dgnu11 and tell folks setting
DEVELOPER to use a system released in the last five years.  I think we
can be a little stricter with what we require in the case of DEVELOPER
than we might be otherwise.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--WPKwYqHENhlpWZ+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYeDUAgAKCRB8DEliiIei
gWUEAQDfNb3dB9IOavlX6dcx+9FiqXsli9UEJQs3QwTvTX+2yAD9FT0fDygOMoQc
OmYx4oHJxkHijtt/r41reqfg6UUD3gM=
=i375
-----END PGP SIGNATURE-----

--WPKwYqHENhlpWZ+c--
