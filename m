Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98000C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 23:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA3B60F11
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 23:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhHKXPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 19:15:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41116 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232470AbhHKXPv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Aug 2021 19:15:51 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8729760752;
        Wed, 11 Aug 2021 23:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1628723696;
        bh=8CWj3/HlB6SiBAzDTwBuzO5vce7Y1x2UI5zARjG1RLE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=iFFBeG4bA3RJMDJdigcwxsc/oJM3Vsia+WGvFTGr2HoblT1uxvC8yYxfliY66DkdZ
         rRJgcLZKWHB6iK+PXOxIkg/h/PhTItauJm8dOwC/WvG/MqqRGyn4jyquXmYP4FH5y+
         PvYgIQM3tLk2LoxC8x50DHZuVYHkrykgIxddjwajNBC8a7R0BMfdPoILzPyhjRUC7W
         wQjg1hjMpn7/bNDLIIVFOlJWk7OXZ5fqJ6yRKWhhsm8Xud+U9A2Q5X47i9XntNYt+A
         g1Ys4sI61mljDPRTD8kO7UB0LVQ0vgcKCLxUfZM5jhG5hKF/wWQh+onwieR64wBAsO
         dLBLGv9yQe/sUAipEXR60amYBUakrz59t55EF4x9K1JSRZOG8L/gubiQhxCvE2tcaF
         JvADUhYcrgmoTYIB5LtzD6AR+v+P1xysZttOrsPKV8GkaK+B+EREMM5q63Rr+P0tjb
         wrh2Gz2YHhS/liDKZarXqYdkPb4lKMahRwnvOSLTQJkehQxirZf
Date:   Wed, 11 Aug 2021 23:14:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Son Luong Ngoc <sluongng@gmail.com>, git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: t5607 fail with GIT_TEST_FAIL_PREREQS enabled
Message-ID: <YRRZ7E6W+xV2f/CG@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Son Luong Ngoc <sluongng@gmail.com>,
        git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <CAL3xRKcMAkfaoAWo5VfQ_Q6nYkR94spSN4Ko6xfpSRKa1cEuAg@mail.gmail.com>
 <YRPYrXYwmwVnligD@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VmsbGlzQ/bFrPr8O"
Content-Disposition: inline
In-Reply-To: <YRPYrXYwmwVnligD@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VmsbGlzQ/bFrPr8O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-08-11 at 14:03:25, Jeff King wrote:
> On Wed, Aug 11, 2021 at 03:02:52PM +0200, Son Luong Ngoc wrote:
>=20
> >     git/t% GIT_TEST_FAIL_PREREQS=3D1 ./t5607-clone-bundle.sh
> > [...]
> >     #               if ! test_have_prereq SHA1
> >     #               then
> >     #                       echo "@object-format=3Dsha256"
> >     #               fi >expect &&
>=20
> The problem is presumably here. If test_have_prereq lies and say "no, we
> are using sha256" then we cannot expect what the built binary does to
> match that lie.
>=20
> Perhaps that is a sign that test_have_prereq is not the right tool to
> check "which hash format are we using", but I don't think we have
> another convenient mechanism to do so currently.

We can use something like this:

  if "$(test_oid algo)" !=3D sha1

> I also think that the FAIL_PREREQS system may be mis-designed a bit. We
> had a similar problem a few months ago, and I think Junio's response
> here points in a good direction:
>=20
>   https://lore.kernel.org/git/xmqqblbgrwkg.fsf@gitster.g/

I take no position on this, but I'll send a patch to do something
similar to the above in a few minutes in case someone feels like picking
it up.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--VmsbGlzQ/bFrPr8O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYRRZ6wAKCRB8DEliiIei
gUjvAQD/mtfBmQMIweJMojjCCl/g3wAzbPtkNNkQZM2XsYX5kQEA6ly6eG3R0U47
nvFc6vQC4GHutvL7C2x/zpi5JjtnhwY=
=pyrQ
-----END PGP SIGNATURE-----

--VmsbGlzQ/bFrPr8O--
