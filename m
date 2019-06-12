Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46E5C1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfFMRBp (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:01:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60048 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729565AbfFLXbv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Jun 2019 19:31:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:4429:e8a6:430:6b59])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5A12D60435;
        Wed, 12 Jun 2019 23:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560382308;
        bh=Ht2alDa7bYrI0RI7S5MjU1nhO/+FVsgMQr81GsaTrAE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Nsw/aLHkDNHc1RdS64y0B6XV34t2CUjKi7NaCSipqBWEWF/+PttydAFcF8TZJQ/yw
         +l/H+bSQnfmpfI6FQHfpI7Bd+75iTwVdC87WwDc0hyzTfDY54mRfNJcOVCzdtd73m2
         XHggkK41Q+dmBjxwx9pzKXuFBonjMaQz+riN0U3SnjJ8Q1V48YZS0KI3SnNmtito/Z
         ebdR3EcK/7Lb+EigNHuiBvFSn/+aW/v8VupZzfENnLwzMsJ7u5XUcqdHAt+G7YZL0+
         YxiIMEsN6GzR/YDf0lbZDRfXiAoI3Jrs2+oIZ98tKqip2cvZ0+nUJHagZkmZFqNaR5
         u6668Wz8raTCnT2k2awI507FNNJ21uJl5uZy1wrZOa+80SS+KSp8ER+5ZpPSsP/HRk
         UFlcaHQDLykdl7cX1p2ccOsNvIQ96cvigd1U2Koiyhnqn/A6P3h+c/pY01LAh73Mhp
         FNvELM0Z/GevdyKMV0l2GfN9dGXQeqgRX2Byke2GUIhbeiIIyQk
Date:   Wed, 12 Jun 2019 23:31:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     Elmar Pruesse <p@ucdenver.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Reducing git size by building libgit.so
Message-ID: <20190612233142.GC8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Paul Smith <paul@mad-scientist.net>, Elmar Pruesse <p@ucdenver.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <21f1f334-755e-3283-d0da-ec0ab9231cfc@ucdenver.edu>
 <20190611234815.GB8616@genre.crustytoothpaste.net>
 <9c488ce8c1e1e6d6d4c343b0b40c8a64c8147a7f.camel@mad-scientist.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xd7ZVmXU2EjaW0+X"
Content-Disposition: inline
In-Reply-To: <9c488ce8c1e1e6d6d4c343b0b40c8a64c8147a7f.camel@mad-scientist.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xd7ZVmXU2EjaW0+X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-06-12 at 13:57:43, Paul Smith wrote:
> On Tue, 2019-06-11 at 23:48 +0000, brian m. carlson wrote:
> > Also, some people install Git into their home directories, and a
> > shared library means that they'll have to use LD_LIBRARY_PATH (or
> > equivalent) to run Git.
>=20
> I don't have strong feeling about .so's although obviously less disk
> space used is always a good thing, everything else being equal.
>=20
> However, the above concern isn't actually an issue.  You can install
> the .so in a known location relative to the binaries, then link the
> binaries with an RPATH setting using $ORIGIN (or the equivalent on
> MacOS which does exist but I forget the name).  On Windows, DLLs are
> installed in the same directory as the binary, typically.
>=20
> Allowing relocatable binaries with .so dependencies without requiring
> LD_LIBRARY_PATH settings is a solved problem, to the best of my
> understanding.

This is possible to do, but it's not especially portable.  People use
various C toolchains to compile our code, which may or may not have easy
access to linker flags.  The proper syntax also varies depending on
whether you're using ELF, Mach-O, PE[0], or another object format.  And
Debian tries hard to avoid RPATH settings[1], so we'd need to be sure to
have an option not to set it.

None of these are intractable problems, but there's not simply an easy
solution that we can magically set that will work everywhere.  If we
were using autoconf and friends exclusively, this would be easier, but
we're not.  So someone is welcome to attack these problems with a set of
patches, but I expect it to be fairly involved to get all the corner
cases right if we want to make it the default.

[0] AFAIUI, Windows doesn't have RPATH-like functionality, and from what
I've read, the same-directory behavior may be going away due to security
concerns.  I don't use Windows, so any solution there is fine as long as
Dscho is happy.
[1] https://wiki.debian.org/RpathIssue
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--xd7ZVmXU2EjaW0+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0Bi14ACgkQv1NdgR9S
9ov77A/9E9Yc8N2EzIGdnRFwB7U818sXOyfs2n1SUHElK8VIDBJhBgX+Haxp6qIa
u3j3h0WQKSKjE3Vt+5WATA8AAnVC3JYo9nwHy3aYtNEL7OVG9IDMLem0+jEvA+mv
Vb/rPvH+ky/7SVk0mFbBHwVzYTITXND1Zf5h2B4ynvUiwMJFHJs+lRXgVX8njEDR
f9vAFH8cfZwRut+zyMsXmP6PINSs5nKDpMmG75bpNsy+iQtEwOEm/jWF3XgGn888
2qOXXbCXl4NYmjrvzppeaHl0pLdqEyHuiEzRsNhMPWB7/WbgWugGVnGYr2TAZFz3
k8Fk5psGvBZYJheEhw1ecCMmV1pTgcrotoW9vbjVZ2RMfa/EoytvUju7QtZQ9vDQ
P4zs+7ERFyCegiUtyhI1Kor+/qtRP44qTZZjbXT2lhS9Raf02UPryJvWhrq7f5f0
E6GKdez5LHInQdc3/0pljEb8aQbbrltRzh20Sia2nItL2Ojg3+vEMzqdGe24ykv+
fmfU7j/dRy9/oA1YS8Mqqjiu61M+75peVsx9yc2iOdrZGCkQ+kWYM9RoVar8D068
FVoJOmCYjFyPA12XCu69O7RwUsphAQiOGwcqavKKHcADiQalbK3D7/rP+hFCtQoz
lN9R4ak8k1koIadRmZPBmbpp2D4ck6t6TLIav0G3nTZyagyCr2c=
=6el+
-----END PGP SIGNATURE-----

--xd7ZVmXU2EjaW0+X--
