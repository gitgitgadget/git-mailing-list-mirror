Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CF4C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 10:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0252B64EC9
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 10:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhBXKnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 05:43:21 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56742 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234846AbhBXKnS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Feb 2021 05:43:18 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5DEC560DF4;
        Wed, 24 Feb 2021 10:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1614163326;
        bh=K+rLUrpRvEFrg65RgKdcMmTRYdSvmiiWPK00qn6RQVw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qBE5XObNS2x7+byVzBaopG5eF4dxHyXdxqv+vV5umpudVeqTbGIEdWL5hoGEhLCsq
         QX+X3jAtpDW3uGCEPnx7CNqPRO+021hVQ2/jbyOPzUN+VMF7IkUeASpcXgwmHkc8Bo
         DszGJGRpjsh6cx5aC/4U+RbPNEMjdtKslqB5kpne2eM0P06oHaty7XJ+QpYzqC1iy9
         0acBmdoFPK1WQL7fwIi73MS+Kld/3n4lbN2YvsAiX1iI5ONytsj7e9ACesDcFEVZ/O
         dhjIRwkBEgMEMtQHs1lQzk/627Ga+vI1BmdVm50C7kIq+LjSiJY2VxV7Csi6mYiezC
         xUkZPsj49rhnqcuUBwsLtpeLRPq7Fqi1SXyfswJ/tn0Kt1QUdBSHT2qUrSVRvG2X3v
         W8QHGQLFrQbtsVGiPvngqrOkJRESauKWmM+tMLEGfO+FNw6M3TPZ+j5XL/tiCBFt/B
         bnORJaH+aC5SHIt1rFt2CLgDVmj+td3SNCPqlyheYOB1J3rw+ei
Date:   Wed, 24 Feb 2021 10:42:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Kerry, Richard" <richard.kerry@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Ort-merge: What does "ort" mean?
Message-ID: <YDYteUnxQZuPIAML@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <AM0PR02MB4081D3C17C53DB5CD9021C5E9C9F9@AM0PR02MB4081.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vb0IWG1a822B1Mu6"
Content-Disposition: inline
In-Reply-To: <AM0PR02MB4081D3C17C53DB5CD9021C5E9C9F9@AM0PR02MB4081.eurprd02.prod.outlook.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vb0IWG1a822B1Mu6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-02-24 at 10:05:12, Kerry, Richard wrote:
>=20
> It's now been quite a few weeks, probably months, since the
> "ort-merge" work has been going one.  However, I don't think I've ever
> seen an explanation of what "ort" means.  I know it means "place" in
> German, but that seems an unlikely usage because git project generally
> works in English.  I don't know of it as a word in English.  So maybe
> it's an acronym - ORT.  But what does that mean?
>=20
> So, can someone please say what "ort" means?

I believe it's a joke.  One can use the -s option to control the
strategy, so you could write "git merge -sort" to use the new
implementation.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--vb0IWG1a822B1Mu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYDYteAAKCRB8DEliiIei
geTDAQDQTcysUKOL+Ib+Ybx30/TcfbX84NNbHoabXlwT+jEnAgD/SjPteNeAMILM
T4tFVBxmmbS/Lbzuk+7Cf3HjDLrKDAY=
=UYNs
-----END PGP SIGNATURE-----

--vb0IWG1a822B1Mu6--
