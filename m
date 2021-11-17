Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A33C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 02:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6700361B73
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 02:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhKQC4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 21:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhKQC4d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 21:56:33 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D32C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 18:53:36 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 68DF85B482;
        Wed, 17 Nov 2021 02:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637117615;
        bh=+wpHz35OTdL6Qmcf/takYls0TTjitR5wnio3Ve3jxog=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hXfgz1j0w5Tb+Vi5Q1YAJ/gPo6xO29J9hXg1HQEUIXDbZM0saApNTdIi1FpzWkGU3
         lCPuwTbmh6q3kvKr0opObFwdIkO9v/M/qzlElCDWGre2tmQ+rMuP/92gd9nsGPJK0A
         1uh8jSz3j7DMt3OUw/ErK9xsn9j0Y7IenU6O7BkztPTaUZcNqvbPes4YABPyNP9EwD
         GTcVKpSxsqS9ZpyN5cLh7dq5DAJQ0x1PfTGGFXxqnPcysteSbGeB55NZgP3FQFyvsN
         fMsasUF7llBmTjKj4lfi2/oaZu4DIJ5Unlaa2tfdtLU4hH1ppjxF4w+sCLssh3Kkjk
         QKd/GVu2bPx9CuNt51pA6ZejOujHL9c9XZoeuHqZ3zVYOfA9Sf8q9oBQM4pAY4W8X8
         cAXhNCrpp9a1B4ELD66EveKAx2XsBiq4ddWlU2uzGzlLSdto6C20DFgGWAOp3cFG8l
         gIOlRcyoof8HYZ5C6ApGs5Ilgkb9+/3ZPVx2XQ+ndD6dPi5ysfM
Date:   Wed, 17 Nov 2021 02:53:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH v2 1/1] git-compat-util: add a test balloon for C99
 support
Message-ID: <YZRurUdyB/cGL6Y3@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-2-sandals@crustytoothpaste.net>
 <YZOh370ZMMqSADUE@coredump.intra.peff.net>
 <211116.86pmr0p82k.gmgdl@evledraar.gmail.com>
 <YZPGKHYE/9km1rH5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9l2RPmCehH9YeR7S"
Content-Disposition: inline
In-Reply-To: <YZPGKHYE/9km1rH5@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9l2RPmCehH9YeR7S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-16 at 14:54:32, Jeff King wrote:
> On Tue, Nov 16, 2021 at 01:54:27PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>=20
> > But IMO this whole thing of trying to make this work on every compiler
> > etc. just isn't worth it.
> >=20
> > Let's just start using C99 features, and if anyone's compiler breaks on
> > something like CentOS 6 document that they'll need to tweak a flag
> > somewhere. We already know that works for all the other C99 features we
> > have, there seems to just be this one exception of the ancient GCC
> > version in this particular case.
>=20
> Yeah, I definitely agree with this sentiment.

Unfortunately, we cannot do this without some sort of patch because our
CI will be broken.  I'm fine if we want to drop GCC 4.8, but we need to
be explicit about that or we need to add flags to make it work.  We also
need at least something to make Windows work.  Dscho will not be happy
if we just leave it broken.

So I think some version of this patch or something similar needs to be
adopted.  I'll try to get a v3 out relatively soon that fixes these
issues and drops -std=3Dgnu99 from CFLAGS, which seems to be the approach
people are most desirous of.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--9l2RPmCehH9YeR7S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZRurAAKCRB8DEliiIei
gQvFAQCkU5n908HLmxjcPSWA5ko/OLwmDHaotrudd4kGAsLAzAEAlA5saL/TRj7m
whMo3tgdnCj2/LJUkCX0gY7fjjo8sAI=
=UGwu
-----END PGP SIGNATURE-----

--9l2RPmCehH9YeR7S--
