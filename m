Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987E61F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 02:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfHPCg5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 22:36:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57630 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbfHPCg5 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Aug 2019 22:36:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3071F60734;
        Fri, 16 Aug 2019 02:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565923015;
        bh=QGxs2lasd51vlvh7dZTiNiiA6UDaa8uF/lvV+jEHD1w=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=gbUny2CfsfPr6pdgcgd8iSYWuszXIRy6SY4rm3fj4q/kvPGQOMKPkKrZES/lP01D4
         iYSCB2lbW67ZXyC8vWa97boatIH2Zx7tXmM/GdGnOo8iFAb/zvGE7T/zIyTzcAjlGj
         TbidxkFwPMGLiSJwX0MYh+VKykzbIrUT2ptoipj2bcafNpuO3BCR2UX9R7/f6QG2ji
         qjqM12/KjdjuYOjR7ju6wsax0SjF2DOjF/gjS26fguClVGKi5Vulo5KrWA9kRcud8N
         voHsatMu6KzHwKMfRvdTaFeW9XWcfD/ij1n6mwquTZyIFQTzeUjdReajGYs7oB5gAt
         udS/XZfCzLP26em6f4BwO8AkOedz9d9mVlgZbynyHbBWcth5P3+edE+FZpSWC9B9cn
         i2pENV0yREs+BFUzmNC/d/ZUNlQ6lyyhspotMtFZl+Gvtw/zJYfVc8icvtVqIyWpZm
         qq4OCzi1WXD5WXttHQfYfGTiImt0Wahxax/Ny/NnvxcJXhIeRUm
Date:   Fri, 16 Aug 2019 02:36:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
Subject: Re: completion: checkout.* not being completed in zsh
Message-ID: <20190816023649.GB365197@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
References: <20190815185901.btf4d7c4ewsccxuu@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <20190815185901.btf4d7c4ewsccxuu@localhost.localdomain>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.2.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-15 at 19:50:27, Pratyush Yadav wrote:
> I tried looking at contrib/completion, and I can see that zsh completion
> works on top of bash completion, so I don't know why exactly it works
> for bash but not for zsh.
>=20
> I am not too familiar with how these auto completion scripts work, so if
> someone can point me in the right direction, I'll see if I can figure
> out a fix and submit it here.

zsh uses its own completion system which is substantially different from
the bash one and includes definitions for most programs shipped with it.
Are you sure you're using the Git-shipped completions and not the ones
shipped with zsh?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1WFsEACgkQv1NdgR9S
9osmTg/7B+Ja043pfoedSi8Tmf6KMJFb67YHku82Q/3Uyr2Cxz5LE4YM9qZtKxcP
3VLKeSbrgr4xIuU0NI85tXycFh3PaBkl3HvffJapdLL3YDfLzFpA+q3YQ2AAj7SY
LfCW2/cUMBpUHSzZYqy99SeOktNA3/cE9bmMC1l9hO2SIGq06eSkZPqex7czpRLW
AL+xf0YB8P86eezyobhPYo0O/F+wfrv2X7sgkDj3tKF55rDa0kv6H4mLTLVSkr0L
6QbdQdgvZy4d88kemv+o4hheelZ85f4ewvTV36UstXMyVDzUsmcdv5VtuVtYbwza
cRGIbVIxyOebejP7T/vN7NQt1zXxcjwulChOrw1YlE8V/R5t12qoUoT6WPI5N9Cx
/d/H9hkVpQjgQ7UFrAMsvKMh5mxOxRxOukI4H2egQepP0k5pENQq1pwPffUH5qRA
dXGDhZNcEpMnQl2mY04/2ShwNAjmfdZHuZx44AukW9GbBfvzl02PkwtVTD0DCUPv
frUbruBKS2Wy9CdqdQ/RTbKl1OrE4W2W0q1S/UAntdmDG2NZxkQFEFUmUtoEsEfx
/NrckzJJRDFzZtcjdA0Sl1g9b5EAEvojn2hs0onGMzz7sUlaQflpk55jak/d7GU1
Gx+lfYUuvC6k+AJx6fDGD/xizY95MLyXTikRSkt869hABhVlt/g=
=whcr
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
