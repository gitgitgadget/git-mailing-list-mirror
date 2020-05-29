Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C085BC433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A258207BC
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ql4DnPd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgE2WcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 18:32:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38946 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbgE2WcH (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 May 2020 18:32:07 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BFFC060482;
        Fri, 29 May 2020 22:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590791526;
        bh=8Kzwq7k+uykNI9u4qwt+T6lsr+Uf3n03R1oFDAMk6IE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ql4DnPd0zoyYigKJFeh2uyrqCzPvDdSYwTrBUy/S6/nzCzceoWiCDq5hEk/GsbL2u
         xFE4PfOFJ2aLg2ruILS59kI/qdHRh57vyMpFoKXh/aLfUx4TVt5RvhoRfjF3nv/R58
         B0kKsoMWsZEeNjnKo8m5t3Et+Q/EMIAdI/RZEMqgv1/apb+Wlk2fEli2mFAhXuHOsL
         6Qa24PZ0aQrFyQvsRyb5Z+9KFz48AEQUIaYLcuKUu9plXXCUMAR0njwuf4S0Ow45Fl
         UIw/LDtvqkyXRBoyWYdh6t+dK+R8Hh7eCpO9OjdxAwYjvWQoLS3ZHnJUFXm1qKrzgq
         Rrk46IlaheZLR5CiswrG67PiNAK3BkQm55L9pwWh0NhDgd+oOoGW1I47KqRp3SiEPN
         /V8f1JG5feyDtjd22j1r9cBwBTamO+LqeyzQDjT1kATFWmdejX15eDglphbY+7yGcH
         QFocIIzhjsr33NGVkMu2L9B/DcxEjxIpBWzS60PI8scb2qo4rgj
Date:   Fri, 29 May 2020 22:32:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: symbolic links in Git for Windows v2.27.0, was Re: [ANNOUNCE]
 Git for Windows 2.27.0-rc2
Message-ID: <20200529223200.GJ1915090@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <20200526204539.6181-1-johannes.schindelin@gmx.de>
 <nycvar.QRO.7.76.6.2005282322580.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6TC23+W66xmFESAX"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2005282322580.56@tvgsbejvaqbjf.bet>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6TC23+W66xmFESAX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-28 at 21:35:24, Johannes Schindelin wrote:
> Dear Git users,
>=20
> On Tue, 26 May 2020, Johannes Schindelin wrote:
>=20
> > I hereby announce that Git for Windows 2.27.0-rc2 is available from:
> >
> >     https://github.com/git-for-windows/git/releases/tag/v2.27.0-rc2.win=
dows.1
>=20
> Git for Windows v2.27.0 will be out on Tuesday (or even on Monday if Git
> v2.27.0 is released early enough). It has a (last-minute) bug fix where
> the length of symbolic links that is recorded in the Git index is the
> _actual_ length of the link target, so that `git status` agrees between
> Git for Windows and WSL Git.

Thank you for this.  While I don't usually use Windows, this has been a
pain point for a lot of Windows users, and fixing it will significantly
improve the user experience.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--6TC23+W66xmFESAX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXtGNYAAKCRB8DEliiIei
ga8gAP4zIWmUHTRo7A1uFAsSZ6/wUGJ/gT4l4sycMYPjFFL+9QEAmhKQTNpSjJth
IzQ4wivvJRbUR6t0K4miMX7Y93wqvAo=
=sREt
-----END PGP SIGNATURE-----

--6TC23+W66xmFESAX--
