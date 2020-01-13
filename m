Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E969C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 23:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695E8206DA
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 23:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Yr1Tu8EB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgAMXOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 18:14:38 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38148 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728794AbgAMXOi (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 18:14:38 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D8FB460426;
        Mon, 13 Jan 2020 23:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578957277;
        bh=6sM+Z1ev+uId+4oqk6WO6u5wWApHsomT995EsDxJbbQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Yr1Tu8EB5kjWddIzlwY0fjnKKaijsSUrSxmFSFJOtXpJPnWoGGrr1O77MdVqfKKHi
         HdENFa8ihFmtCS5jb1zrciTnBZQYA1tS1YeNJbkL2lPBlcHa4cNv+0Ii60fO2hS2Ru
         zTTJXW74BhvYEZyzlB2f4E+AzbXSoxeNXlPnTQOx97etr31B7SRKhLgYtk+Bq0E36m
         RYPtSqQ8WxhN7b89BbbHbZ1saj32ZbDLp8gq8CeNxMDmGsWwVMTox1r582shbPFNaY
         mt4uJjuR3dAWhMl1GhhNK0Rb428HJulX2v5vaQIHvNzTtuDxe8rOzjNtJTG1wWF4sO
         4CkvaFPZwFZwq/XwqfvUC4Wz9pvpvhGL4UbIEFIOhO66FkqznjOAL1E1/TfxWiyRqV
         8qWrcEMm79FxB83pUbHGhM3AGIgKk/ZkUW7LmyzaNb9JJFNoVBM2crHtBdM5P/hYxk
         i76oEGvvK5cU9nRJ2IcVpLfnCFGq7utsZrzfJNvQmzX8BnwWa6i
Date:   Mon, 13 Jan 2020 23:14:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 17/24] t5318: update for SHA-256
Message-ID: <20200113231432.GS6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
 <20200113123857.3684632-18-sandals@crustytoothpaste.net>
 <CAPig+cTZKQ_0eZuMSYbaL9u0k0SJGeuh-N0uJxALTfyzP9Ab1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k8r0khnpBuGu0wUi"
Content-Disposition: inline
In-Reply-To: <CAPig+cTZKQ_0eZuMSYbaL9u0k0SJGeuh-N0uJxALTfyzP9Ab1g@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--k8r0khnpBuGu0wUi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-13 at 13:50:01, Eric Sunshine wrote:
> On Mon, Jan 13, 2020 at 7:41 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Switch two tests to use $ZERO_OID to represent the all-zeros object ID.
>=20
> Missing sign-off.

Will fix.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--k8r0khnpBuGu0wUi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4c+dgACgkQv1NdgR9S
9otNnBAApZHZ3GBdsyF1th+Mj+4/ZSnyx/LwdV7YCjhoom4On3PYCuQbMD+TuXxt
0ECiGcFuwn2nA8fLmJ6BPPs2HBc4AMd+/t81PcoKsaHCg2o+Ldxd1vVTiF1246YS
xpBbFUjBsZcgCenbkaMfq+jU9XuqlV/xR/jGUASk0UZ9tw31zYozeM4zAAkBjhjY
vgaqOwrT6EfX31suF3+0zusPZ1+J5UWOLXekXb9zafDhGvEWcCx8kTxCht+cQEPv
bMAUfqQN7WzzOQzeA9bZm7NZSrFxjBncJ3aS1/i2UI1XwYq+jTd8C19MMJNgFHU0
41KhSlyjFrwoR5E1iClp3wFelR9n8ReNb3iZFZEiMzstzvzqnTvA3UYlx5G+9/we
ZVL+mE6MGylVjLIN+RExYOYMTdTfvYgcG0GQHpzfUPNBxOAOX+86Ub2togo8BB/w
dlPpUExX3AA0rsMEniltPtmeG1mT2/Ldvl6B5BQDe3aUtstmGLaCOnZq6quFMUkM
i/cxY6g9YRRlc6vcojY91iLbkiZvVlCptqZgrXJwrYo2xuEBx34i3qNZJA6gljIB
ppANoNpgO1fDxXpfiMkV9+QPnxaMpENL0NTHqvqkQcCw+V/+Q0zcPW2wgOuj0agN
ULeaHntsAUDLXOYkNonU2xdJxei7bZ/qzqSsMxg2SE0hELvaymA=
=HBzp
-----END PGP SIGNATURE-----

--k8r0khnpBuGu0wUi--
