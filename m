Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 860FF1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 22:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbdEPWKv (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 18:10:51 -0400
Received: from kitenet.net ([66.228.36.95]:43510 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751680AbdEPWKu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 18:10:50 -0400
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1494972643; bh=FeHM0ekGJlwvKsldF5HEo4BwmcQ3ZW04HkUmHYmALuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9+LWQm2Bdz+PP2f2W11roZFTnXd8taGOZHZ/6iXL0e9BmPm/bSPj5KWeYUt+FsFc
         dU4Dn+znzu4Lu6+GeU5Cqp/V5q5RieUfsrCTEc/veyKgJhr2lbvvYVvX+5MiiU1/3I
         aWPduX2LlS3ZY3jbgVBhX2cfVs/S3eYJDBNLg3PY=
Date:   Tue, 16 May 2017 18:10:43 -0400
From:   Joey Hess <id@joeyh.name>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] tests: add an optional test to test git-annex
Message-ID: <20170516221043.sgnieijh6bef6izm@kitenet.net>
References: <20170516175906.hdwn4x5md7dj7fo3@kitenet.net>
 <20170516203712.15921-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="prtgbo5ubhjzcwib"
Content-Disposition: inline
In-Reply-To: <20170516203712.15921-1-avarab@gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--prtgbo5ubhjzcwib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nice work.

Note that you can export BUILDER=3Dstack and git-annex will build with a
known good dependency stack, which can be more reliable/cross platform
than using apt to install its build dependencies. That needs
https://docs.haskellstack.org/ installed. Also it currently needs
GIT_TEST_GIT_ANNEX_REVISION=3Dmaster since I improved git-annex's
Makefile slightly.

--=20
see shy jo

--prtgbo5ubhjzcwib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAlkbeOMACgkQ2xLbD/Bf
jzjclA/+K2JKkrjeDwP3MmTbmBHwSTNe09/fU91XhTOAsakrockJMyh0urJ/SI4X
yqaXhMv3BF8M+OrYNt4EsELNy1RygOBYk7yqsCQ1tUwmqgsRj4L7IQ6x4X/sPKq4
XzW5/gO3uUM5dc+YN76nLlj70KXYIKbievtH6f+edb7N07GJjcV1eJpxJRdZrkdm
CBuxOfYIcJUMZnv/Bwh4tL74vTkorGWYieIW5mjI78BODU/QztT6KqMCmKKRC/K0
kHyb7u8wOCZnZZHdc8h2Rhns8em4zMluRAxX6BmfKTr1LzaiK1wmnxLpvgmUYeWl
ja4XvRvDyl/FufmYl9m1ApltH89BuPloHBri96be74rME7Rb2p9F195TgK5+iaih
LzyqUM4hhAUU+bUPfN95puhRSdftRdiNbMqYN3wjmBaVXVRq9KOQDZSE7deCwMph
y6YZIYjOgI6HxlX6xa8NY/pbKkioFmR9kvWk2QKxSc2RCZyCUEYVRgFy1/gJ4Dgp
MCOe5LIrJekso/gefNPO1dtMNpWfqbav9XjRBqUs2dpv38EJr1Ad1kn19tWsRVaa
F2ew28EACN2CqMOoyFqi/ppaHFFTqv1wC74zQ+/nZn0eeSxRCHzBTFQOr2+FuS2S
9pPIjMog0Pt77RUcaF3E7X8DR/fRIucgE/PRsaM+kqNIdKbgfpE=
=vdHx
-----END PGP SIGNATURE-----

--prtgbo5ubhjzcwib--
