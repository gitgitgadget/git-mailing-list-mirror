Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4296C1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 19:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfJHTbL (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 15:31:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38716 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729608AbfJHTbL (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 Oct 2019 15:31:11 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5A8B461C5F;
        Tue,  8 Oct 2019 19:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1570563069;
        bh=yY8nFRAsg9Z+dNyrIgoUyXVeZrjImmYyV7nuVoE7kPo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tY14RozZjAOhVRVEu2SoIAQje8Y52BWX2JlqaWkDDKMGQ3s3lDZgTp59yJ18mhraz
         bJFR55Wit9mLsyXvgfTiOZKEh8lkWVl1ChYqvHM+8lLnUXCvsYwa2n5d6+gxJNJZxO
         HUmOXb91e96vns/5/Fi2xXEqW8t16rjdgvcKHOriiHhXj/NxgEp9KwLaFuu5fM/VQY
         O2foONn8BSVABBWS/Lsv0P0gV3UymQIpRqts9tJHUXiGeMdvWpZA6T137pYkuXLlwm
         ECSk2+OsJNWKUUJgogAwEneKs/GHIoiNtfysdvZkP1yCioqIeKJ93t8UDTFSM9lYEz
         9aSeei3wYwKkZJfm4DeVJ0WUw4ANhugUPUhkiUUbww0wogi+APkVJhDiViBgdhKjPB
         p9bX5uK3oYJb0i1BcNHnJuEzTRQTJvy+iqlb3xqKVDPTAFgSKeQ0bvsYA1UVNTNFfY
         DIerU4C7tB6mpesG21QQLtJShP7H9gk7j2PRQCMCgdxR4rD/gGz
Date:   Tue, 8 Oct 2019 19:31:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/15] rev-parse: add an --object-format option
Message-ID: <20191008193104.xepgqzqvftsixkpo@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
 <20191005211209.18237-4-sandals@crustytoothpaste.net>
 <3cb91b69-7d33-12ab-de37-175592f95df7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rutvncovms5l2s5c"
Content-Disposition: inline
In-Reply-To: <3cb91b69-7d33-12ab-de37-175592f95df7@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-trunk-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rutvncovms5l2s5c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-08 at 11:51:45, Derrick Stolee wrote:
> On 10/5/2019 5:11 PM, brian m. carlson wrote:
> > Add an option to print the object format used for input, output, or
> > storage. This allows shell scripts to discover the hash algorithm in
> > use.
>=20
> Why put this in 'rev-parse'? Is a test helper not an option for this?

We do have a test helper for this, which is the first patch in the
series.  This rev-parse option is designed to be useful to scripters
more than anything else, and it will make an appearance in a later
series.

I sent it here since it's vaguely useful for tests and I also wanted to
make sure it was available sooner rather than later so folks can start
using it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--rutvncovms5l2s5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2c4/cACgkQv1NdgR9S
9otRuQ/8Cy6U22ds6VNp/PP9XSQcIMNqNulm5LwcGN2i/o3cJzn79GdN6jo0GiBq
BwGXafs1sWVLZSSGQFZrm//otXEc5vBgTk5SDuIX0slpHjE+aW3eH8hFKA122A/5
TAhbZfz069nxFxc0XPJxLBxgUmTyjC9xrd+2C2eD9t3ZK62I9BdcGh33SbjvxUIJ
oWS83GdqJxV/F0IqV3DTVVIEU3yjh+06jDLbDEKL5+z85HBdgYuv5Ptx90Tk2Jed
TTBRe3ehwkmal4MtQ3rxZULUx5iOQzc5v38n2HFEk8Thu989pVjizGKb4zzTVNpK
xhbWyBKv8fk5RLU0sx4FDAG1FckqNxDXtQ2FID+HOr+dXHz4Y5/KotS6BFiC3yPx
rOVOzEbM26mgtK2fJnbdiaBZ6SeSFXJEM4coB9bAL0YDUy7Mh0x905Aa2Lf9oLKf
FCr2NDTsmnco4MVbt/CGCAAMo3zLtmreKEhYVN5itCCKm8rOpDDA7oWvs8Gd/U+F
JJDByyyvKGM8azSdzl2PaY+GaA7zUzM0adpjgu70rjDfHRep19Aq3L6NQtB50bxE
8Ha7GdeymB+5sl9ki23ni6VjBe1iNBKRywY1oPl0aP8BE8OzrmZ/mjfSfDlADgBO
50ht53phRp/2Urp6JaTU5BMnKY737gFOgLecn8x3argsHDM4f8Q=
=tXne
-----END PGP SIGNATURE-----

--rutvncovms5l2s5c--
