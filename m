Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF43FC4724C
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A80AD20735
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="P3Hj1sWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgEGX5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 19:57:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37986 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726480AbgEGX5G (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 19:57:06 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 386906044D;
        Thu,  7 May 2020 23:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1588895825;
        bh=s6uN6xtrk337SjXj4DtznICZ/ASiNtnQ5ADrbHvgKME=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=P3Hj1sWOpGqZcMA/Nc2AP6+soEJJbrHtkZgBblOOTXjGDmy3z2mictHGtxfjZoAry
         9bJAbh2l2kgwMpwS7C0FQN51SSq437wr/RKokG5Jhj21N/EDF4BDQEJTLuttM0h1B9
         x2xlM7nUzYorlWC85EoRaDdPPMGSRbPd7/vxGKJnXdsNm15tOPyGAss0WHdHwyCAhO
         cUcHNpFvdGM0mafEE4E1gv0CJXnpk8aBV08tuZS8IHX8qbwsrXeNGnH7U4pk6oBkcA
         ZWKWyI/usNioYVNXU2bN7WSkzuQLNg331vjOrQME6TUtPk36AbZndBWDbFHikVHLhN
         fsQh6fwZtjGzO7CKeFf4svrCNG5ChThMRAm96z01v9XLCbE0u499MXm4LpOoLREQhs
         fMvpZ2Xm9niaWbhhyQYKjZVOsvd2fFvnotq1dolPR6j81uC92caJQLb4vyZ7bSHkDt
         hIEaod+pF5/6UpN/e5M04SXaHv/HPpMsDkPcKxDTBcruyhz/9t2
Date:   Thu, 7 May 2020 23:56:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     clime <clime7@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: tags sorted by their depth, *committerdate, and taggerdate
Message-ID: <20200507235659.GD7234@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, clime <clime7@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CAGqZTUujRh-f-83A8NYokbxLGZ-bnvGrtguzJsMdg9EX04NsGg@mail.gmail.com>
 <20200507194224.GB25306@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Content-Disposition: inline
In-Reply-To: <20200507194224.GB25306@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-07 at 19:42:24, Jeff King wrote:
> On Wed, May 06, 2020 at 08:16:35PM +0200, clime wrote:
> > Is something like that possible?
> > Is something like that possible even with git 1.7.1?
>=20
> You'd need v1.7.2 for --ancestry-path. You could just use "$ref..HEAD"
> without it, and instead do:
>=20
>   git merge-base --is-ancestor $ref HEAD
>=20
> to cover the case where they aren't reachable from HEAD. But of course
> that's an extra traversal per tag.

I believe git merge-base --is-ancestor is much newer than v1.7.1.  I
think you have to use the old style, which IIRC is this:

  test "$(git rev-parse "$ref")" =3D "$(git merge-base "$ref" HEAD)"

If you'd like a more modern version for CentOS 6, I think Software
Collections has one with suitable support.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXrSgSwAKCRB8DEliiIei
gTCoAQDb8muC/+Y2x9Azzd36mFdyaedJHeiekPPKwoJn0G/7iwD9EKoSGlFNwA5l
UzH0RV37N/KSXO+jbKIkAh21WkZ4ZQ8=
=QKiu
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--
