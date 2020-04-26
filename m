Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDFEC54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 20:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC1CA206A2
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 20:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="h4fvwy8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgDZUIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 16:08:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37700 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbgDZUIv (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Apr 2020 16:08:51 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2857D6042C;
        Sun, 26 Apr 2020 20:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1587931730;
        bh=76vER3/Kn3Pn/qmeh3OwHqHs1xWNsO/0P3YyfEQKQog=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=h4fvwy8ySTSNeB1MzWGlqyHpTrezq9EmwgoFkFJLwJ1FDYKF8Abm8/VEElg/0/t9D
         8yJQvos3qL27mbJ1U1ZJzFyJuMIdGTonmyHMDVxP/g4xmpkab5xczrCAJKA6exW+Tq
         sFh3cytB5vbeZHFNlNiyJ4dLXxbKfuNBhVb+wENYiuguUDph1V3E20OqMKVGYxwge+
         IRhDUR6XHZhjnsLi3YecejBAcBTJEpLqqoUZi0SZuooji39siPpMKR5mZguzKMEmYr
         83N/Q6f2b5x43S7rEMimMF40DqLjLVau8enGZ44QlOBaTkEMNw/99+c0SDcZGy46nK
         AdMzJh24xpkctaJWb0PkRFjj5JQd4bT2tyO7TQ9mCnhtgsWkBtpH0ZSazydmZvRDp7
         Dz6zmvvZeVUy2slDl7VZ8ROWKmgwBPZ+pPIzz0irgPnNV2w3hIi4t5t2IKknxQPz5X
         JDYNdfpptfxPzZBGDeHoKr+jSv1dK0lloh9aXz+cdW6uidlmpep
Date:   Sun, 26 Apr 2020 20:08:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Mateusz =?utf-8?Q?Nowoty=C5=84ski?= <maxmati4@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        mattr94@gmail.com, bwilliams.eng@gmail.com
Subject: Re: [PATCH] config: use GIT_CONFIG in git config sequence
Message-ID: <20200426200845.GE6421@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mateusz =?utf-8?Q?Nowoty=C5=84ski?= <maxmati4@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        mattr94@gmail.com, bwilliams.eng@gmail.com
References: <20200425235716.1822560-1-maxmati4@gmail.com>
 <xmqq5zdn9k3r.fsf@gitster.c.googlers.com>
 <5c1005a7-273e-fab0-0d0d-78bd0d3d13f6@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Lb0e7rgc7IsuDeGj"
Content-Disposition: inline
In-Reply-To: <5c1005a7-273e-fab0-0d0d-78bd0d3d13f6@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-26 at 19:32:05, Mateusz Nowoty=C5=84ski wrote:
> On Sat, Apr 25, 2020 at 05:16:56PM -0700, Junio C Hamano wrote:
> > You can prepare a pretend-home directory for the use of your tests
> > and point the environment variable $HOME to it while running your
> > tests.  See how we do this in our test suite for inspiration---it
> > all happens in t/test-lib.sh, I think.
>=20
> This is what we do currently but the problem with this solution is that
> it breaks other software that also uses HOME as base path for their
> data. For example asdf version manager.

I know nothing about the asdf version manager, but if you're relying on
it for programs, those programs should end up in PATH, and when invoked
appropriately in those locations, those programs should just work,
regardless of what $HOME is set to.  If they don't, that would be a
defect in asdf, since the Unix expectation is that programs in $PATH
should generally function without regard to the setting of $HOME.  From
my cursory poking around at the repo, it looks like it should do this
just fine.

So you can set $HOME to a temporary directory and still use asdf as long
as your don't reset $PATH.  Or, if you want to specifically load asdf
programs first, you could do something like this:

  #!/bin/sh

  . "$HOME/asdf/asdf.sh"
  export HOME=3D$(mktemp -d)
  # Run tests here.

Regardless of your tooling, you definitely want to reset $HOME in almost
every nontrivial shell testsuite, since many users have configuration
files or data storage that you wouldn't want to use.  For example, if
you generate a new GnuPG key on every run, the user won't appreciate it
if you import it as one of their private keys.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Lb0e7rgc7IsuDeGj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXqXqTQAKCRB8DEliiIei
gRaPAQDHGCfivMkty24HkEbYcEtAUHKzjFey3IY3WlXmUFNCywEAv8RPFfFCeVRK
5swaj4BV9P7Atyx/Se2Efl6Qtc38FwQ=
=gd3y
-----END PGP SIGNATURE-----

--Lb0e7rgc7IsuDeGj--
