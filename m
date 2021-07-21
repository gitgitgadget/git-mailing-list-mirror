Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75596C6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FFF61261
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhGUWSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:18:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40264 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230397AbhGUWSE (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Jul 2021 18:18:04 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 016256077A;
        Wed, 21 Jul 2021 22:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1626908320;
        bh=6/YcFIaH6z08JPHYWOAq4dJ0z9DXJ/l43GVIdlLm8tY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=llJgCbuBBQTbrCjJMSGf18+3BvjL8aeHyfYDRbmulDnzl9ypbbYS07mGl5x/3lsOV
         eA0ic6fSXWdQI68QnPu8dwHg8AUv0WDVlUpHPnnJYi7G/Nlkr/RWMhr3JyCo3BBj/l
         piXv2HhNc/yCg2136m4v1NHbV+i76bmYfsX/vKUSIXqu1eWuqf3yfdLtZfwQNpQ6uJ
         jnhj0tzzpSdiTEHoOdKHYN+5d8JLAFI9XFgG4BsfWPOfJXwJmlff0TpEb4McgHtXEh
         W4SVdmjULlfk/r4194nEV6OmXeaxcx3WU6SQbSOLfunfdftRPhp5krnPTvB/xOQ2B7
         kDeQ5L2HGLgy10T8YUrUTiZVlz91zRvAuziAb0vo6Mx2md+/yzcmsSJCWDmVGi38Cv
         YOjH/wX48mhSxp756NXUFSajqe6Rf/r2Ru6/g3rkZIF70rLPnViloTRls4E4o+KUV3
         dPOvxlPk0XHowDiWuCob4oxPha3CTE/ggWRujZVP0MbgN37CaQO
Date:   Wed, 21 Jul 2021 22:58:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Tom Cook <tom.k.cook@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: All git operations fail when .git contains a non-existent
 gitdir
Message-ID: <YPimnEtNgKD32r2o@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tom Cook <tom.k.cook@gmail.com>, git@vger.kernel.org
References: <CAFSh4UzCWMCpOGZUYnrxwK79F6jN3irdNs=J7O6RMCeJbBxFBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XsyrhtvY32FGbriE"
Content-Disposition: inline
In-Reply-To: <CAFSh4UzCWMCpOGZUYnrxwK79F6jN3irdNs=J7O6RMCeJbBxFBw@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XsyrhtvY32FGbriE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-07-21 at 09:17:36, Tom Cook wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> Add a git submodule to a git repository.
> Overlay-mount that submodule to another place in the filesystem.
> Attempt any git operation in the overlay-mounted path.

I'm not sure about what you mean by an overlay-mount operation.  Can you
provide some specific commands that we can run at a shell that reproduce
the issue?
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--XsyrhtvY32FGbriE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYPimnAAKCRB8DEliiIei
gQTWAQCutGXzlEeDm44TC0uoOXVJ9BuRQeqkVXUM3XCmyNGzKgEA0QfN5IQ8dVIm
QNzoWSQsYlB7Bn99YBALTxygNuoegQE=
=7LQF
-----END PGP SIGNATURE-----

--XsyrhtvY32FGbriE--
