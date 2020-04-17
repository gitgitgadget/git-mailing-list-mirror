Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F16C2D0EF
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 20:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15B920B1F
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 20:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IUu542e9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgDQUd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:33:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37230 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730903AbgDQUd3 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Apr 2020 16:33:29 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0679260443;
        Fri, 17 Apr 2020 20:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1587155608;
        bh=597FwRrV2HGiq33KsDH5bPuFFgXqCE6KFywmkgLykds=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=IUu542e9zBVnl9uMskhnjR8/A8hsSmtOt83S6dKjBYCQjMEX6FHG3IgjyHfK+i7JG
         +PEzU3anMhtJhai8DrTNhP0aDD94slsBGks29M4SZJh93NqOdosqIWmPg93+clevXv
         cvG7jfTMjEH2kelULEdZal6gDwQecjgQ4HocVTWraWjumQ9OAoKKJnLU7eP5fk2r8Z
         GU0ijcxb1OvLsJqrUJX+RUavovqw9sGHMBDLxhHG4H3lSQknD2JM/DhPCdWdnLDrnm
         tOpI3cOKskPFyYSx2VZ2JUdEJ/5GEGAubsmOJ02FZBL2oFH63+OiVttCD7Tm2FJg7/
         MKH6XjNn7oWX7WuRK/LpHcXFl3WDMyx48zy99lRcLpIh72pmEFkgn4uvffa9lHN4Xo
         kmnUhgBbyYEYVCgWjKUAtebFDO0W4RSAEwKQvxPsfRknyTSjwyD0deWzTFQ2gdx2I/
         E8nt4UGJzIh/Xrfi9m2uVNxfMq5Z+dk5DappV3XWoSTCBb/8rbn
Date:   Fri, 17 Apr 2020 20:33:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Guy Maurel <guy.j@maurel.de>
Cc:     git@vger.kernel.org
Subject: Re: a problem with git diff
Message-ID: <20200417203323.GK2751707@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
References: <65cbee30-fa37-1422-98f2-2c2b5aa094bd@maurel.de>
 <20200416225502.GJ2751707@camp.crustytoothpaste.net>
 <24a180f6-cc7e-fe5b-e810-0fc717d601ea@maurel.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+RZeZVNR8VILNfK"
Content-Disposition: inline
In-Reply-To: <24a180f6-cc7e-fe5b-e810-0fc717d601ea@maurel.de>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--x+RZeZVNR8VILNfK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-17 at 12:23:35, Guy Maurel wrote:
> Hello again!
>=20
> Using .git/config with
> [diff]
>         algorithm =3D patience
>=20
> doesn't work with "git gui"
> What is to do?

I don't know because I don't use git-gui.  If you would, please keep the
list in CC, so that other folks who do know the answer can chime in.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--x+RZeZVNR8VILNfK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXpoSkwAKCRB8DEliiIei
gaeAAP9NTnO9ot8Jn0wOJfurCWpT2Y5v/Vhdn989rT/d9de0sgEA+T8c80f/K7Tx
a9nh0xiX7g8jOh7FUIyqqADrfHpmeAw=
=z2y0
-----END PGP SIGNATURE-----

--x+RZeZVNR8VILNfK--
