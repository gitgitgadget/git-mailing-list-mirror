Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EADC433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 22:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B4361052
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 22:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhJTWYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 18:24:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37714 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229695AbhJTWYh (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Oct 2021 18:24:37 -0400
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B358660734;
        Wed, 20 Oct 2021 22:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634768541;
        bh=maCu552bN/qPlI2GbzOc/vfkiBIxczweMUJlyHh/cxU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=M5cXe790PIuIV0MClgG0I8NRd5N94VRzOpaLf8rWXnhXh0+1pgwNm/3kBBcTBhTJC
         INkrHXeHB3ry7M31qiRYmYPe54pJrEJwWFN4hM+xqcQirDzJXRPuxHV7P/DXayTFEA
         v/IkwO6etZRApSlcD/vfvu9sDCOJu4Cit2eppBy+IECBM725ZyopQemAoEw3cIiXq8
         EtKO0BHyiW0h7nVwTZ+evPSOIU/PixPYcz01epdBdjKH77Fzi+mjosylFB6T6XhTvy
         D6+BaRoP0cCcKyUZJNuTOCFvZLKgUh55s/gK0tpAH4rd0yQIh9tvDrCO6QlPmXlNN8
         7VjAcu4aIRx5jEwxctGsjeogZLR/lCUxlXwiD0oGbaEfF2/wUIE/XZd5FNML2SKF3L
         z407y1QgFsp8nS3e5mIkVdpxtaMo2EBndugjGFlgE7O+0UBwn1mkaMD794OeTQIHWC
         jI8WvTnuz1OoLt+YXUW+7HojYMpB9IHYv9PKFQIj+LGGdokCkuC
Date:   Wed, 20 Oct 2021 22:22:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] gitfaq: add advice on monorepos
Message-ID: <YXCWigr6TovYXgbb@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
 <20211020010624.675562-2-sandals@crustytoothpaste.net>
 <557fe5b8-36b4-a760-d2dd-02137746a37b@iee.email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ac+khOg13MrkJayL"
Content-Disposition: inline
In-Reply-To: <557fe5b8-36b4-a760-d2dd-02137746a37b@iee.email>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ac+khOg13MrkJayL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-20 at 14:11:09, Philip Oakley wrote:
> Does this need some comparison, or link, with sub-module methods and
> issues? Such as the nested sub-module problem, the distinction between
> active sub-modules and quiescent sub-modules (e.g. libraries Vx.y.z)?

I don't think it does.  Some projects choose to use many repositories
with submodules, and some use many repositories without submodules.  At
work, we do the latter, and it tends to work just fine.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Ac+khOg13MrkJayL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYXCWigAKCRB8DEliiIei
gYLVAP9Y3RLFCttt4AeBcdXfa0JYbpsF+geN1QrWKMGUWJlhxgEA4rf97uUTyz5I
/hLyrxgFzelyhD+BTfwuCwOCv6+kxAo=
=G1/y
-----END PGP SIGNATURE-----

--Ac+khOg13MrkJayL--
