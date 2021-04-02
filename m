Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17F5C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 02:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8456B610E8
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 02:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhDBCLL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 22:11:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52830 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231836AbhDBCLL (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 1 Apr 2021 22:11:11 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6D83A60426;
        Fri,  2 Apr 2021 02:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1617329470;
        bh=b+v6k5VPs4VsqL94FtcrODR11Stss8Pfa6O6FA4XwPk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fYIewvL6idTUbtkEsv4PMipbhQnZJeJowFLbaW898N3/M7NH9YrelG6GmTxYjKblL
         JqSEkDRwM4G+RO+zKxfnj+jzN3dvADoYzHrDnOfo7HyxHxMxEcVyDKDX5QZ9bR7WMO
         AtZZVNwtgB10rGZ9PL5wu4L9HFgk0iGm16zg7QZ/dyROtG9+4JqFFaW44enss1gDK8
         LtDF/sh8GrwbZdM0axDtOPBk6fyBnA4H0IfMQwyCtjUF6Zb52zcy8tacJB02sgxSj+
         yPc5/QEB4BCGrck2YIkeHJwItgB1z8KmX9sfAdaSQ10xqCieLRkZckiKFYTwRnwSPx
         r0sLJVZcANMP3jRsAKcv/WEYHs2hZECSS4sYmyv2yiLyu/Zp+wDhVKtjYYyBR10GAd
         YbTIPUw+FuJHc49vgpX50TwZj9DhEdoX09C00SEnF5uYRPxt07+qQbCAzhfV2u5C/6
         q21rJHpGU5n8nkKBcnGllyUOdWkIjV+khYy1B8HjQ/jNV4czlTt
Date:   Fri, 2 Apr 2021 02:11:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Peng Yu <pengyu.ut@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to mirror a directory of a repo?
Message-ID: <YGZ9OOf+cr5JvMwv@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Peng Yu <pengyu.ut@gmail.com>, git@vger.kernel.org
References: <CABrM6w=wmcDqL5shONB-fVXcOb60DKHjA4cqGoYn95EBTOiR+Q@mail.gmail.com>
 <CAEV-rjfAW56702Vkj-AiXA2WVqFnMjh0Ox-jyv3E1P570GdX_A@mail.gmail.com>
 <CABrM6wkbvC4AvFnbirtRDAr0VBPaueoSP2PEr0W89evG3sPqAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V8h2QPDiO0M7xt3W"
Content-Disposition: inline
In-Reply-To: <CABrM6wkbvC4AvFnbirtRDAr0VBPaueoSP2PEr0W89evG3sPqAQ@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--V8h2QPDiO0M7xt3W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-02 at 00:49:50, Peng Yu wrote:
> https://github.com/bayandin/chromedriver
>=20
> It seems that the above repo is a mirror of one particular
> subdirectory of the main chromium repository
> https://chromium.googlesource.com/chromium/src/
>=20
> https://chromium.googlesource.com/chromium/src/+/master/chrome/test/chrom=
edriver/
>=20
> I don't know how a repo can be partially cloned. Could anybody let me
> know how this is done? Thanks.

There isn't a way to clone just a single directory of a repository.  The
protocol doesn't consider that, and even if you could get such a clone
to happen, it would be considered corrupt and a lot of things would be
broken.  Partial clone can be used to do something similar, but not
completely the same.  In such a case, you download stub objects that are
filled in by a connection to the server on demand.

What is most likely to have happened is that someone took a script that
extracts the commits that touch a particular directory and created a
new, entirely different repository and synthesized commits there with
the same commit metadata.  The two repositories are likely completely
independent in terms of histories.

Sorry there isn't a magic cool explanation for what's going on here, but
it really is essentially a copy-and-paste into a different repo.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--V8h2QPDiO0M7xt3W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYGZ9NwAKCRB8DEliiIei
gZhPAP41Cf+H7RfZhWsXGVctbHh9qsW33Z4ysTNNLVBh3P77qAD+ICWCLSfiArAQ
H2SLEj9biwRN0yI8QDnGW9X96Tp8qwU=
=E6l1
-----END PGP SIGNATURE-----

--V8h2QPDiO0M7xt3W--
