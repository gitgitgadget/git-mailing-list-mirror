Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80DAE201CF
	for <e@80x24.org>; Sun, 21 May 2017 16:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756622AbdEUQ2Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 12:28:24 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41676 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756561AbdEUQ2Y (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 May 2017 12:28:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C854B280AD;
        Sun, 21 May 2017 16:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1495384102;
        bh=g8a4nG0Eq7vd5d02ci4emS2lRMsfhwYRIXNSPWAaAd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZywGp1OgIjiAHvZ2sMDwQVZMM3sWltb8WOirhBhpxS9ehefw/XJY4t2I6CUsJspE
         gdp4SzTRmvxEu+nkgFf+jSJp4YuoKn5ve3Bht8XR6+D7AyjOwxXVo3QYnbfQPFnR2d
         vf1U332SI6nzwJJYsPpVZVrOWY6eMb+4+h3x61HZUWZ0ECO8PvJftDQYLWnk6hE1HS
         6rycbuvFPP00/LdlL8dYzVE9HnbQA74OGDuhkAEGgDrBDZdeG2Z6hY+r1L6354UMSw
         Y8FYwnP0GtU1LrLZbly+/Yt7vCBXqSyE+wzwezQLt9xWEMQ7BBRzHb+JXwR3yNpNrX
         4UnjuB9WLy+sh37IbOnqtIM8AEzoDLylnpE2tjoAxdbu/Kaz4fGBOqAtwsKDdaDO8O
         BiH9gEM1QWs2cbwmfuYLc/SxGDU4f8noZd1YiXPDQEKo027pcmuWrjYUWDOk5p7VVx
         uvPPa5kzlfd8fAXuLfJ5hmpdBFJTeM3biaALSBP7faSnFODMea1
Date:   Sun, 21 May 2017 16:28:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com,
        peff@peff.net, sbeller@google.com, jrnieder@gmail.com,
        pclouds@gmail.com
Subject: Re: [WIP/RFC 00/23] repository object
Message-ID: <20170521162816.xio7ttltdrlqmb6m@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com
References: <20170518232134.163059-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="piyrfyvo5lauhv6x"
Content-Disposition: inline
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--piyrfyvo5lauhv6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2017 at 04:21:11PM -0700, Brandon Williams wrote:
> This is still very much in a WIP state, though it does pass all tests.  W=
hat
> I'm hoping for here is to get a discussion started about the feasibility =
of a
> change like this and hopefully to get the ball rolling.  Is this a direct=
ion we
> want to move in?  Is it worth the pain?

I haven't spent a lot of time looking at the patches, but I like this
idea.  I expect that moving in this direction will help us avoid a lot
of globals and move us in a direction of more re-entrant code.  I can
think of a lot of things that could really benefit from this.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--piyrfyvo5lauhv6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.20 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlkhwCAACgkQv1NdgR9S
9ouzrw//bvl2sWeQqf4D67WhFrJRxFbwV1bnz+eDAz29JZ89Q5UGfozGV36rLGJc
mj1WEGADr/LMRM35dFUSoTNDBTrUz8z08OEQtjJQyz+WgDwpeofJdWqGbbmE0ANW
LMYiHngx/pET39f4sh07+HuPF1ee5pfzceUKkJFfsxBbMOElUYMzFEWXa8oyPkcr
BaLg/A9rtWgHpO79hHxv5HFE1sEF2RwZcD2CB+CBE5wmKslJ4YJtzmqhClZ2AMiI
dMV0+wgDCP6TmN5q2Sz4jZwz2xYBLTkzcdlqiYFY0yPL2P3NReD4purhY2hHh7oa
+kSzn5Ra/jlvZvKo4wmEnFkkC5Pn1mQPH7PQDS0VAkyQzQdMjPNnvb0AHDIFeu6t
GzXttYX28KEcdZ2dpSMnXU2VEJc/98Of+5Wlv9P6RCBXJDQkUGFjFB9oxJ9g5zFL
K02mtRk20BDel9/kmeDnqBK2FK+khs0Bpc09mTIWIisqYllz5Pcr80kkLX7lxCmw
brxF19dmjTh817r6lRJ9xKnpTLEy7mwnQ5XPS6J3DWplxlyy58YdRTeuT9FrOcID
j0RXxw9oJ//X9iDFspyC2Jx5FlvNlQgTRn135apRsDT1MRcDe/mVRGzBOnUgfJLB
6l589vtTIpXrifW8SHUyYyL4QbOasx4ertzQc5zyBPFltN0cXjs=
=ubxu
-----END PGP SIGNATURE-----

--piyrfyvo5lauhv6x--
