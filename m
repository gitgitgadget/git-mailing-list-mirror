Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AC111F453
	for <e@80x24.org>; Sat, 29 Sep 2018 14:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeI2UgU (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 16:36:20 -0400
Received: from feynman.df7cb.de ([195.49.152.168]:50854 "EHLO feynman.df7cb.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728221AbeI2UgU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 16:36:20 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Sep 2018 16:36:19 EDT
Received: from msg.df7cb.de (unknown [IPv6:2a02:908:1470:e5c0:76e5:bff:fef3:7e00])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by feynman.df7cb.de (Postfix) with ESMTPSA id 42MqwF2rNrz3DyF
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 16:01:33 +0200 (CEST)
Date:   Sat, 29 Sep 2018 16:01:32 +0200
From:   Christoph Berg <myon@debian.org>
To:     git@vger.kernel.org
Subject: wishlist: git grep -r
Message-ID: <20180929140132.GA31238@msg.df7cb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I often use "grep -r $pattern" to recursively grep a source tree. If
that takes too long, I hit ^C and tag "git" in front of the command
line and re-run it. git then complains "error: unknown switch `r'"
because "git grep" is naturally recursive.

Could we have "git grep -r" accept the argument for compatibility?
Other important grep switches like "-i" are compatible, adding -r
would improve usability.

Thanks,
Christoph

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXEj+YVf0kXlZcIfGTFprqxLSp64FAluvhbsACgkQTFprqxLS
p67lyg/+OtztnVal3ZFhkpKxAIovBiD/Gon4AZjQxF20dNNuz4s6QyP6lw43XRlS
Gk7UtNuX7WM/KHrvmUKEIuuFInK1fDlgJ47vTuxlGs3ASz+mzQDFwypFSRjxL65A
Tm+HZqcOibVVbtndiR6QyG+bVrxgpBrt8UVRQ/p5Dya1MGrqnyVefaDuhEPSEdnS
TT5L/Ugq0K9xr+sNCZMcNUaN9MqplVrUTZDOrMtCiKdAywA3uiwR/2UKuK5qaDHu
oXGcCfflWuIAau5/kdt1fuAr54bSxGCvy2oWmaluaaB+uvrEFjB9SFcVbLdXudCN
d2UpNB4jQxNLK3lmDAuPp9C4l7aeo0fzO0STj+3WJQBAKdhspuxd/2uLQZMBoi8u
5v9kQhNteE6GfdhMXShjKg2Fbmf3zbWyt/SayLynyICwOVI98dVPZaTupxuB3HyS
mzOKG6yxkHcZa9dDA4ZaHf/SI0NGNXSCNxfbTYyJmNcBwEarSxf6QkiA9Lmc2aLb
LgRa9Ldr+eftdUwKExs3o7MOS6haG3LF/5bv7L3M5wQzE4eN2cMrrxf1g8/us10B
Y5GN0uj+A0aBwnpaFb1pC/H7i+BfKynd/0E9g909jY+z0X8Q8SCBMV8+AYsP5O5D
yMiTv4/IamOA4F9d8nR/aQC4xkYmlwtk3i+xlE0XFXhdktN4bAM=
=UF/0
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
