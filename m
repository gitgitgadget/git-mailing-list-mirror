Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41EAC1FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 02:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755055AbeASCrr (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 21:47:47 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58098 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752855AbeASCrq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Jan 2018 21:47:46 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4AE8A6052F;
        Fri, 19 Jan 2018 02:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1516330064;
        bh=UDtd2ULKLIkycv9icRhS3TzeNsdKc2X+wv6ZWapLAfg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vuTFkVHoVYVGHjotUmmf4bvUK/P5JJcHwdj6jpKqgJPiqvD6VdSDU9g4R1/1jHLi9
         3vTv/8KNR4G4ZPOBpqo/8giUnU3+FwTxbtsz8EXAynrnZ1mTiVLPn2HX2yrzuwnX8D
         QT/IVtrvaJy6+aj9LLUEjwqhpulqKSeTEquewH8sb5OESQOXy8nmoEyeeupV1Yz3pV
         CkAo3AVg74GamvEhGfUW/kn2V2Chj6Ba24VlPaM7659tIvjJZMBjiI2yPqwaN88+2Q
         SVjTkSf3LHneChL7L+KLLKoaJiG+cr3UQhhCzu/P1sl9apzl7gEGQFwimsoGRQr8rQ
         S5fPU15oVIQ2j4pc0bWlk4mYw2VhxBIvfso/4bkjVKXeq5mZ2JK+1p5oMfj6tMxWnL
         6uDH4uqAZQRe9yfWz3gITT1m0UBWcfNl+KR0zSfrljoRq1eOsJIeYrAm60oVqDUTnK
         rm7prduazZRjnDTEVKCeMI9rCD2SN1VkX5Epcd7rPezCJxejy0K
Date:   Fri, 19 Jan 2018 02:47:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: git 2.16.0 segfaults on clone of specific repo
Message-ID: <20180119024738.GA222163@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= <aleks.bulaev@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
 <CAPig+cTkBEGyoS93GYCtoDgccTF_UixqBkVTExg7Zf0M1J7KRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <CAPig+cTkBEGyoS93GYCtoDgccTF_UixqBkVTExg7Zf0M1J7KRQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.14.0-3-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 07:15:56PM -0500, Eric Sunshine wrote:
> [+cc:brian]
>=20
> On Thu, Jan 18, 2018 at 3:55 PM, =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=
=BD=D0=B4=D1=80 =D0=91=D1=83=D0=BB=D0=B0=D0=B5=D0=B2
> <aleks.bulaev@gmail.com> wrote:
> > I found that git 2.16.0 segfaults on clone of vim-colorschemes repo.
> >
> > (lldb) run
> > Process 25643 launched: '/usr/local/bin/git' (x86_64)
> > Cloning into 'vim-colorschemes'...
> > remote: Counting objects: 1457, done.
> > remote: Total 1457 (delta 0), reused 0 (delta 0), pack-reused 1457
> > Receiving objects: 100% (1457/1457), 1.43 MiB | 289.00 KiB/s, done.
> > Resolving deltas: 100% (424/424), done.
> > Process 25643 stopped
> > * thread #1, queue =3D 'com.apple.main-thread', stop reason =3D
> > EXC_BAD_ACCESS (code=3D1, address=3D0x48)
>=20
> I can confirm that this crashes on MacOS; it does not crash on Linux or B=
SD.
>=20
> git-bisect places blame on eb0ccfd7f5 (Switch empty tree and blob
> lookups to use hash abstraction, 2017-11-12).

I unfortunately don't have a macOS system to test with, and I've
compiled with both gcc and clang on my Debian system and, as you
mentioned, it doesn't fail there.

I have a guess about what the problem might be.  Can you try this patch
and see if it fixes things?

-- >8 --
=46rom 10b690241619a452634b31fbc5ccd054a4f6e5ec Mon Sep 17 00:00:00 2001
=46rom: "brian m. carlson" <sandals@crustytoothpaste.net>
Date: Sun, 14 Jan 2018 18:26:29 +0000
Subject: [PATCH] repository: pre-initialize hash algo pointer

There are various git subcommands (among them, clone) which don't set up
the repository but end up needing to have information about the hash
algorithm in use.  In the future, we can add a command line option for
this or read it from the configuration, but until we're ready to expose
that functionality to the user, simply initialize the repository
structure to use the current hash algorithm, SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 repository.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/repository.c b/repository.c
index 998413b8bb..f66fcb1342 100644
--- a/repository.c
+++ b/repository.c
@@ -5,7 +5,7 @@
=20
 /* The main repository */
 static struct repository the_repo =3D {
-	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, NULL, 0=
, 0
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, &hash_a=
lgos[GIT_HASH_SHA1], 0, 0
 };
 struct repository *the_repository =3D &the_repo;
=20
--=20
2.16.0.rc2.280.g09355b536d
-- >8 --
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlphXEoACgkQv1NdgR9S
9ovo7BAA0hnds7ibPmQSGIie+CuOsCGc+Qo/qLcTfmv9tFd53c9imLWUxYPK3Ut7
JuR13Ud5CXVe2ZkomTffEw0A4ayoBqkO/NwQ/Ir503YW341o4JDWNiAIIDheYS8u
ce5jGuPcVXHw9C94k+7EhzKO727liFSWfsLFnfITEUJrF31NwT9FPo9uOJ4z5x2j
ZAa3oCwtncrkXvFP2uiu5dIl/23do5k4gjrR4KUczmR1rBk8P1T/ykKAGirRJGg9
qcxrNZk1qIxCQCj1i5xdkgfXr7BK76Swv5ytkQrc8dFOVBJQqiTv7gyAxJO8sP8l
TcZNTHSqzI4dvGf2ee6xgyYi/2Sfg/o3fDjSEsI6DOUKfyfvgtnFOREJroYsWgIU
lvj3CQ2w9/RL2ypahD30fmAQTNW2tnrQ1eKxL3zTxpz3/buLsxMow4VQWIOYig4k
3XrBrL4LtvXCztaHzFQwQ+VuJSgdOzmPoW7CeLqXVXkeUxv8GRNloRpNk7dzF3ry
OSF0OGkJhiGWZ/PvNQS9D24yOc32unVV4lGbtZBMddLVIAWKqX9XtxRndpCjIfQ3
slOckf7odhoSUFcMMrrtlt+9VuJAtAYa0VcB1AL+87Kk0pOOPhY+HgQPdLCw9RyT
OUus1ePYvA5oU2QytwOBeeTVWi9+ZHwonA16RDdG+FPdOXsma7g=
=va1E
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
