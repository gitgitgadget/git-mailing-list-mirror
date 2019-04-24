Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABF021F453
	for <e@80x24.org>; Wed, 24 Apr 2019 23:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbfDXXkw (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 19:40:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35708 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728571AbfDXXkw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Apr 2019 19:40:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C555060FF7;
        Wed, 24 Apr 2019 23:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556149250;
        bh=PBqo208ReAE2afokLTW37u8rVi7Xes2QKrA+tIilENg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Et2XoBXo4ninMEaSjtoaEDjeof5VFpnoEJLji3CCBlD9SB73XyFF/GObZ5jmNsqzq
         k5kTu/EsFQ714b4arVS8dgECCmGkx1RZtPkR2Y6CqQYzwIGoSHtlBXuK7gE8ubOWcD
         sa6lp2qslIGgF3ZZ38j1J3o2L0TwIOxBeF7ViN17jdz4oOultJoVBOOmqFFCgUgGvZ
         GVBiGLDt/6U0pDAAJ3Lsqu3lStLk4SulTrKW4Vp8ZFWe4oZooRcTJ8KmKzavwaYvTQ
         G0maN5xPwpiq6WcsASMeCxe5PvPmZYXTJiaPMueIbsVHmyDN9KtBWrPx0k4JO88poz
         5G4/uUz1BzISqytJmFX6bnBuAA9HtwewU6AE99RFexJ/l7EVuYLO8qwTz36R11obf8
         TMaF3WGkzCYYu1hdH98r5CuN8hMuS0OXDqH0255lfT8f1wW66KXAPmMr0ZTz2u8fMI
         CaH7VQ8vVbSkJboLkSuZ30+MrOvh00ag2jGW1UGnuzdjiCT5pJN
Date:   Wed, 24 Apr 2019 23:40:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Multiple hook support
Message-ID: <20190424234045.GN6316@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <CACsJy8CKwiNknEkEH_-DxuXYiBmpYvfdRAZvmSJCcqko_OYnTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ABYnUdqoGSokwVM+"
Content-Disposition: inline
In-Reply-To: <CACsJy8CKwiNknEkEH_-DxuXYiBmpYvfdRAZvmSJCcqko_OYnTw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ABYnUdqoGSokwVM+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 04:49:54PM +0700, Duy Nguyen wrote:
> Heh you beat me to it. My config-hooks branch [1] has not been updated
> for half a year. I only skimmed through quickly so no useful comments,
> but I went with a slightly different design, introducing
> for_each_hook() instead (see run-command.[ch] in the last patch).

If I grab code from this series, may I apply your sign-off to it?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ABYnUdqoGSokwVM+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzA8/0ACgkQv1NdgR9S
9ouZSg/+MMVLarxUbi/H+vN9vwrEasyERz6D3tnjqjSeMdNGKY9btQiDu6XvJHto
WgyoI05VLwQCXeFHqYyJv5S9h2ppNho57zs8O9j3kkjCqb/4KtmqnqsEO3h6gofk
WChGu4t5VVI0YFQE1+g2U1avDVx+sI5evXd14jcRv87QycUpufeYpInP0LOXv9Cs
3NckXcnWgcDmilj2UTIRoze11IlIqBMc9TLg46YY4xUALIhIFHifelB00fzFzgVA
FOvE+jsntZjf87fEj+MBAKKvcRvqCFEDmGCAAzjD2P7kwQ6XklutRcxpLxKi253A
fFBlHwLm+Bp1RAwFbNBw9EMzgxQyr7HRfE1fhzKASnKHJLQRwk2cTGL0/X6GW4C7
CRyjQ8fwMH3QPsikGrBL8BV3n76oXpIeIc46xfoEygCEvX5de0bcV/vrQjdz5MV6
pzIW/F6qsYQ6kT9wGc9wAqlzAQ4ovvIBUODr9FvXbgF+LhvdrnmLRgROBmxA0x/L
TYvS7feqUCBM2Y2MAlcqC+Et9N3DNWvACUU7dzjpXT9cntADcgtKJsi45mF52liq
iaYN4Slun0rsecj89vQcpuX9dCNI6PPZ9fhmKXVtPbjAfFRSfvYQdLXxyFgEFkET
CKEWyoJQ6vIhUXxlfn/QMaNperGrO3iylQUIb3WM7pvkAR+dE+0=
=woQq
-----END PGP SIGNATURE-----

--ABYnUdqoGSokwVM+--
