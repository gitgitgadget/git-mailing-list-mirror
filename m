Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA821F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbdAYXTd (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 18:19:33 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37922 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751255AbdAYXTc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Jan 2017 18:19:32 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A06DC280AD;
        Wed, 25 Jan 2017 23:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1485386369;
        bh=J5wNHWDngW/98nfdyd5tBSnQqrYUiA8OGMYyxdx6BIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZoqDoRyRH/urB/fLSRshKyCd2EaTtE9sOKdnflA8fK9ifzo8dIt7W/sEGw3plUYh
         KNHt04A7n/3z26JRwBu/r6EyipskWU9eptf+9Zs6SnfUDf/EsNk8YXHo3DybBKZE+J
         44giyCyvi3fS8CS7Wj6GdsTt4Um4tjfn9b7qgryCH7CF0NoUKZUlNNbUB/WOLjGEpM
         zVjjppZvRL+Hkroi08ZWjwCxXOXY8H491uOeN8BcQdHf12DIzMPMJF4bGoP8rYD5vr
         ofrQEvKVX1NzXZw90xYpHMfYevlpvx49ugpyGDLuuIx8ADK5mCt+8i8wDTl+B5wEmJ
         +0hafFMA0z/kE+n5hWkzP0dCiL8NmoZpjaQsUg5Ud9hvDcQv+g4IWVOQkFDpXp8kuj
         YYie9GnfKKZz4aZR4/aTWqpYLUnG/JiCOEmj7hxwMfnxGUZJf6/689xXmapSvGgS/H
         qnbL1xY2tZeQs0txFMDL6g61IKsA1OgHW7jEcLpLSL8gnRjAmWf
Date:   Wed, 25 Jan 2017 23:19:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Macros for Asciidoctor support
Message-ID: <20170125231926.usufhlugjotjw5zw@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <20170122024156.284180-1-sandals@crustytoothpaste.net>
 <alpine.DEB.2.20.1701251425080.3469@virtualbox>
 <20170125213544.eelk4pjhrhshi6zh@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ncjxcf7vvxmsd4tk"
Content-Disposition: inline
In-Reply-To: <20170125213544.eelk4pjhrhshi6zh@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ncjxcf7vvxmsd4tk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2017 at 04:35:44PM -0500, Jeff King wrote:
> On Wed, Jan 25, 2017 at 02:28:55PM +0100, Johannes Schindelin wrote:
>=20
> > > The need for the extensions could be replaced with a small amount of
> > > Ruby code, if that's considered desirable.  Previous opinions on doing
> > > so were negative, however.
> >=20
> > Quite frankly, it is annoying to be forced to install the extensions. I
> > would much rather have the small amount of Ruby code in Git's repositor=
y.
>=20
> Me too. Dependencies can be a big annoyance. I'd reserve judgement until
> I saw the actual Ruby code, though. :)

I've sent the patch before, but I can send it again.  It's relatively
small and self-contained.  I'm also happy to be responsible for
maintaining it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--ncjxcf7vvxmsd4tk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAliJMn4ACgkQv1NdgR9S
9osLZA//YpM2Jl9cvEIL9bkjRzRBFzfFU9OGY/XUE025uhkoFjbNtXq+ResFRUbY
IwP4Ol9whHsCmejRKCZkTXLEYNbCwv316HyoJM6W1mQtwZErsk6qhhyMZ/AwldnV
lYymuT7LflwuOgBcPIUKBj+7qsG3TYCZwkZRc924nnu215X4iO0/X8ByLGN9bjAv
haB5lWr23GWpkvhA2+T9rvveCSVowDTsWqh+W69gEGQzHqGaekz3i/aJqiKG7eG1
vWmrwNKQ7aGecpnlVHa04aXriWCoBhWhzcUrWrH69yRHQbYXrNGpXlq4n8PYkjYt
sjxww8iC4RC9OWsGPjdt0IIeVkW6fWRo49B5pEnQtkX2Z4xtXm5i9eMY8MJJgOEh
3qVrM/cPB/PigtwddTyGpXJ8ik/5Rnl2Vp47W6jPJw4S63631F06IyywSVpMYgLH
DPnH5UfRfzuyOWPSzF7c7f5AJSgR5pTEmvSNJzv5sZ9nkMzpDTC7imu+050sdlMB
b2o+peNjH0uLgaNbnCBHOPP9IU0TnnVCNznGXNrR4qK29HSEW6apgEhEGKbyvEhy
vcSpdQXPAK0NVpEls/5by/OBhopDOc61boPw6KArL0JisaizhVZWwYtZpFWVEKnH
iHO6tzKNHlV9svyCPJ9S7a4xS52tdYn2CZazIop6eQP6p6rdvCg=
=XYnQ
-----END PGP SIGNATURE-----

--ncjxcf7vvxmsd4tk--
