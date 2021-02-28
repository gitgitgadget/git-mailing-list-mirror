Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371CEC433E6
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 18:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F41E764E99
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 18:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhB1SVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 13:21:10 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59640 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229715AbhB1SVJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Feb 2021 13:21:09 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 122F560DF2;
        Sun, 28 Feb 2021 18:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1614536393;
        bh=/7QGYPAm/qbYXHNLmY20PdDInfAEXMbegZDTRWFfbuw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hgoCyBxVCQj4XbexxmBZooEGc3pXOLwPakQ1JDhXBSPUzzmZBZOD5n2PkMqda9+kG
         V/4P+zZ7N0TOVP/+M4zGKplGSGYgnB3SzTX7AikERkCpyRbWBGOMpfwcVrIC6Vydo0
         4a0w04oYGfijdmWqxzXlgta+iMFOAFdsQiaNpzhJsIe4Ap8RGVBnLEnEFOTpmdMym3
         C7rff7ugUKVIChfUKuqAEJgJzQQ9AuFkMhcI2gdcof7/+2SDPN4IaBJuBTq/4haDaq
         fDsA8kDB3H9bdPkZF2oPaP48olZVTPr07XNt5xLejIJg35pn76zbt0JzdlkZ2Axc5A
         to029BSRmzI2HJmEPzCDHeiu/1J8eyJtVI7+lmwbQFqAITmaMrOS2MNBpcH4k/y356
         FqqbKJZd5nfxQU8jgBs4zYFjZbwLnYJACQOiNL4LuIwoxAX45S64jyYXxdIJTP9Ltc
         vVe7aj48JF3dKUqVY4YtGpUI1CHZeFt4vt3d55MLyUdeNRxTiAM
Date:   Sun, 28 Feb 2021 18:19:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jason Pyeron <jpyeron@pdinc.us>
Subject: Re: [PATCH 4/4] docs: note that archives are not stable
Message-ID: <YDvexO2NFM0KZ1Jo@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jason Pyeron <jpyeron@pdinc.us>
References: <20210227191813.96148-1-sandals@crustytoothpaste.net>
 <20210227191813.96148-5-sandals@crustytoothpaste.net>
 <87h7lwl5mv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OJ+qv9uZTX8cGaiT"
Content-Disposition: inline
In-Reply-To: <87h7lwl5mv.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OJ+qv9uZTX8cGaiT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-02-28 at 12:48:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Perhaps something like this instead:
>=20
>     The output of 'git archive' is guaranteed to be the same across
>     versions of git, but the archive itself is not guaranteed to be
>     bit-for-bit identical.
>=20
>     In practice the output of 'git archive' is relatively stable across
>     git versions, but has changed in the past, and most likely will in
>     the future.
>=20
>     Since the tar format provides multiple ways to encode the same
>     output (ordering, headers, padding etc.) you should not rely on
>     output being bit-for-bit identical across versions of git for
>     e.g. GPG signing a SHA-256 hash of an archive generated with one
>     version of git, and then expecting to be able to validate that GPG
>     signature with a freshly generated archive made with same arguments
>     on another version of git.

I think something like this is good.  I'm a bit nervous about telling
people that the output is relatively stable because that will likely
push people in the direction that we don't want to encourage.  I might
rephrase the first two paragraphs as so:

  The output of 'git archive' is guaranteed to be the same across
  versions of git, but the archive itself is not guaranteed to be
  bit-for-bit identical.  The output of 'git archive' has changed
  in the past, and most likely will in the future.

I'm not very familiar with the zip format, but I assume that it also has
features that allow equivalent but not bit-for-bit equal archives.
Looking at Wikipedia leads me to believe that one could indeed create
different archives just by either writing a Zip64 record or not, and if
we store the SHA-1 revision ID in a comment, then we would also produce
a different archive when using an equivalent SHA-256 repo.  And of
course there's compression, which allows many different but equivalent
serializations.  So we'd probably need to say the same thing about zip
files as well.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--OJ+qv9uZTX8cGaiT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYDvexAAKCRB8DEliiIei
gbtEAP0YNxSdCQH9OdUQY9PtlD/M0PZPkqjdbdK3KTH70WgigAEA2wO/qVD7gTMc
I/NO+COsHIXhyLgjb3oKEOsIp5qKZg0=
=qYle
-----END PGP SIGNATURE-----

--OJ+qv9uZTX8cGaiT--
