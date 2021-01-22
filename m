Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0AAC433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 07:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 096B2230F9
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 07:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbhAVHch (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 02:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbhAVHcd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 02:32:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04B8C06174A
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 23:31:50 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l2qv7-0007Bf-9k; Fri, 22 Jan 2021 08:31:49 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l2qv6-0004AN-IH; Fri, 22 Jan 2021 08:31:48 +0100
Date:   Fri, 22 Jan 2021 08:31:48 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Range diff with ranges lacking dotdot
Message-ID: <20210122073148.e3vfiq56zivdygep@pengutronix.de>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a56bftk6pd3gksas"
Content-Disposition: inline
In-Reply-To: <pull.841.git.1611267638.gitgitgadget@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--a56bftk6pd3gksas
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Johannes,

On Thu, Jan 21, 2021 at 10:20:35PM +0000, Johannes Schindelin via GitGitGad=
get wrote:
> In
> https://lore.kernel.org/git/20200306091933.mx2jmurmdnsjua4b@pengutronix.d=
e/,
> it was reported that git range-diff does not handle commit ranges like
> rev^!. This patch series fixes that.

Oh wow, great you picked that up. It still occasionally annoys me that
the range parser of range-diff cannot do $hash^!.

I assume you will fix the stuff Junio pointed out (or argument your
patch 1 is right, I didn't try to check). When this is discussed to an
end or fixed I will happily test your series.

And by the way you also made one of my coworkers happy with your series.

Best regards and thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--a56bftk6pd3gksas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAKf2EACgkQwfwUeK3K
7AmliAf7B40jC1CMV7LPsiSS0oqPaEx7gq2XYgze0YVF2dUdwJcO1aJ4RZDzeAx3
dV32y1CBo6gMuDlfprKgbbRcly4WUdZbgcxEzGYL6x/NIOVQG+bzK+fWg+nYaCO5
2+rtDerBPLw9ZDzyyI1BtdTHpRAEAqOw+zOay1+DOMKBvW8uBzIlq4JZj+QGfQKI
2FK9m0OMoKXqw74hxXEccHe0Vc/IoaY3b7CvNON6yfivS8XaRw7G06GcqBHC/rgj
IQk0Gn7W7QsYi+WmbNxaPLh3bUUSj2aE+KUc8SdfJ7prv9dwPOkQHU79gI6BTUiU
PUcZnCxCCZRxnVobHnYXGBdwwhGxow==
=FUiQ
-----END PGP SIGNATURE-----

--a56bftk6pd3gksas--
