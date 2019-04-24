Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9BDF1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 22:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfDXWt4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 18:49:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35686 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727146AbfDXWtv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Apr 2019 18:49:51 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 300D860FF7;
        Wed, 24 Apr 2019 22:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556146189;
        bh=z5ZZWNfruJdfot+6AVexggeMAacioXqVnGCRqV5CfL8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rwz/Z/ZBIZMfYXaa3z4F4OarYIwxEfCHV1fyFIjK6PDMXGUC/FbiFPIJILD+oWVj7
         Qu00f+JSF8PZ1TnqQ7yOIK/cR0J/57PcqLlXl3Zzf46qwlDs4NJ7+79tv+qW+aIwYr
         sFH9H/YKhORBUvsh4yOAEi9yOW+sGcYwmxFYEB7iC0W4u4Ql/Tt31m2ex/9S/p20oQ
         G0QV7GhAYv83U2SGkmaghqEnHqy8wUtheqht3Ebuju3ZYJq2C+G3Jqa0KbYuMKarOJ
         0J0WE8GxKFaT09osyY+7mlQqogoGfl6PKE/GlzDhjjtW0dwQqv3YU3ZXfEhe7g2oxe
         nJO+5GGNEZahVUwbSWqoscQ5ZNiE54CEAxEDDJX9iohwKcmzWyzWnwmaltjYoPDrbd
         y9a4y9LO7XtsGwVmjSJoBTMQ/2fXqciClWZInPQA7++vwOpHJbHovTfZaVI1R72Wpg
         6Wm6QHBrPsmnF3VQ6zwpk8sD64f0onJtGIHm6PjIBC9HCaNyjHd
Date:   Wed, 24 Apr 2019 22:49:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Multiple hook support
Message-ID: <20190424224945.GK6316@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <CACsJy8CKwiNknEkEH_-DxuXYiBmpYvfdRAZvmSJCcqko_OYnTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RD6GsZsdEJvsf78O"
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


--RD6GsZsdEJvsf78O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 04:49:54PM +0700, Duy Nguyen wrote:
> Heh you beat me to it. My config-hooks branch [1] has not been updated
> for half a year. I only skimmed through quickly so no useful comments,
> but I went with a slightly different design, introducing
> for_each_hook() instead (see run-command.[ch] in the last patch).

I figured this was a common enough request that people wanted that it
was worth doing. I'll take a look at your series and I may steal some
code.

> Back then I wasn't sure what would be the right policy for running
> multiple hooks. By keeping the hook loop in one place, we could change
> that policy much easier later (e.g. continue anyway in case of
> failure, or stop as soon as you see a problem, or even run some
> special hooks at the end even when there is an error earlier).

Yeah, I think from feedback elsewhere, I'm going to roll it into a
single function. The nature of callbacks in C makes it potentially
messy, but I'll try to see if there's a tidy way to do it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--RD6GsZsdEJvsf78O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzA6AgACgkQv1NdgR9S
9ouoJA/7Bo2wI25tGWiHKV0FX9naDR4edlCWSIZPo+EqkFWzo0H1BCSc1Aetur96
qZRlayeqoA9Ni7jPM2w4ACH6bTr5/pIm0ek+YUGXVy7ta5gBq8T9tmZOCxNb4tPf
gc5vZfvrBuHag5yz0tjrDs5UVOnhmAYXN2FJUesWfYbvjdxAnXbJoJjihkjDmWi2
ZxNJqlwBNnN48i0ylOoPbn2ddQsMOeA9aLYw8FMeHU/76Wvn9h/H+ji4RZvxBdoo
PlLEQRbQVKnyE5Oj7If/N0lGoWQXz7EX3xSDXwoS3/50ChyS5UnWHcOGBFgmZMkv
miYZvHHZaIg7Jih0Tcho92hVxaBUYyqBMDZby70jbD02vFjiGQZn/MrdzNXNiMBJ
hR/TJ8hJnR1oYvjc15loYjIZ+chtcUKVrPAJj85QSaFOqSEWy7mEVRTAd9ToJUnc
uG/0GqJyMbcuhaAyM8d5qidUA7CehjsTuBokgLpnCGl28BFNdYgbDo4nq5ODJHdl
p+L++Q31FLaA/j5I7CMubcEVjU0t00KJitw2fa91zJ56LW2d4pNJ42vnd6EpFsun
iWJ7BtISwBgKaG7uskGfcc0oNam2yOTPrblU7QnBJe1DnZ0gYCIyRtTrJsbEaNfh
o+iG2RoYX1nt7wuTnVcLdeca0P5yaGj4jmHZy9OuUAUKyGBt4bk=
=lHrZ
-----END PGP SIGNATURE-----

--RD6GsZsdEJvsf78O--
