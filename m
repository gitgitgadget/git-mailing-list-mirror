Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1A6C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 03:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994FD207FD
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 03:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="G5kstRX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgA2DqJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 22:46:09 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49208 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgA2DqJ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jan 2020 22:46:09 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6213C60482;
        Wed, 29 Jan 2020 03:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1580269568;
        bh=nNZ5YQs1FS81uN6BIY6kJMCerxkoTkuLqCNwj6rtjbQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=G5kstRX2sbdN6lo2T+MRWvhQ2rooj/m4IRM1C2nTiav+kygyU19zIwoUoiB+07I14
         KVYpgrgithOHhiTTxryIM8p9FMJkS6HLwSx7UfOOkKoaCe1aszQv4D+WsbvYbxM/1x
         qb+4v2wb6IJA7cJer1MxWdK+31HLHqbnU1CfqsKqxdWV4QETrEUE/hkdiJqyuM+Gju
         Yu/pE+T5ZRzpmKPLRYTpHtVJC59KBQcw75GuxL79sBpVLBEKCqbc8gjL/ZcuwG3fwI
         7XPjPbMEHB4gsPUoPYah6SfEMZInTpux1MGdh2OG/+kTzoa2O1RcYeXuAqfAdIkJx8
         0MMpZE+bzqvt3SvuufavTOOdbWlD5oerE8Q4oaayTxiqd0Kc85/0zb7+ehO5mzmOIj
         rxqQo/0vk4vC0QyntRlZPp2jPBBV+G1dIQWf7QGFk1WYNRYF1xd8ecgPcZ6u3+b995
         hQqGW3525AsXTWeY9PbLots7cpGkGD81M4W0+qWWM7OXf2MnE9K
Date:   Wed, 29 Jan 2020 03:46:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 18/22] t5703: make test work with SHA-256
Message-ID: <20200129034601.GK4113372@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
 <20200125230035.136348-21-sandals@crustytoothpaste.net>
 <xmqqblqn8kjj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M9kwpIYUMbI/2cCx"
Content-Disposition: inline
In-Reply-To: <xmqqblqn8kjj.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--M9kwpIYUMbI/2cCx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-28 at 19:09:52, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > This test used an object ID which was 40 hex characters in length,
> > causing the test not only not to pass, but to hang, when run with
> > SHA-256 as the hash.  Change this value to a fixed dummy object ID using
> > test_oid_init and test_oid.
>=20
> Has the above part been split into another patch?

I think it has been.  I'll just squash them together, since it doesn't
really make sense to separate them out.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--M9kwpIYUMbI/2cCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4w//kACgkQv1NdgR9S
9osaHhAAjb52XF4IEnKX9YcQoliWsYdBH1dkLOJ8KHOd0URUd8VclpXSlyqbBalK
9OWlOZbGAVGdKErGD48yPXHU38IicQobXUpmNZFm04c+l0oiPYYvSpADrZwdNsN6
pg2RBz6vR8IcgEVZCMb1bBpyARbXTDQ0AjHKEqpRQzEUAhPL07ae+yV/Tnoh3l6D
6NyMES0zp3I/l3aOSVZgLlRL9/ByR85474URii5jp/E5TY2/0xFi7rXlla6SORkY
e6OvDYuHfd26WE6hg/RgGyPPczI6UokBxUPRaTBff1o9Lx+U5bgnZxDQRmnLgtBw
sVF37zwlE9BHkvsi7mYGrypSznoM8bRc0/hOGzCFRueYbESbNFgd1Gjco+uP0nvF
AL0I/Ki2wexdgNxi+H2Vi/HQP/jCtFPS6js4RtuHCUL3MU76tFCFMf+HsGt2d4oc
dWo4pN5CYD2n7JbEl9yFXxFkiPP5EYXNxXtQzIdTxP0itzfXjdiZrhNEZb7cM687
hMxrOw9GIdBnQLsVYnk7Lxt0eJaAKIUw26aqH8E8mqYNeUNmWflwGEJGrfn6mHfK
oF5pPkEjXx/PPhO04jxQpt2/ELj68lWY5E+OoYeQbp011/Xbih6BPALKzN5bzGJ9
80OblsWdm+qCnCPN0MoGAdXXAgYkZVgKrNMROgJg3vWe8KFHJp0=
=8mFC
-----END PGP SIGNATURE-----

--M9kwpIYUMbI/2cCx--
