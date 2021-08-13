Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D93C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 22:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5406610EA
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 22:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbhHMWag (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 18:30:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42162 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235029AbhHMWaf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Aug 2021 18:30:35 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E9C4E60448;
        Fri, 13 Aug 2021 22:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1628893808;
        bh=5PD/7poFBNLQVSk02RbGUn+5tixf0VgNB6/MC9Bu2Aw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QTXfxLV8ekxBTcIU4Y+0QTrfSFOchwNM5ZIOA+IDkLgaLlRsV5Krh+H44p8FNN6en
         9TyhJ0VuKAKGE3X3HhknwXFHbgMbooMFUyDhpa2eeS0x8Jx6DDgJ6DoMJwPLGWN3Se
         JNB/QOyQ61q0M+znNIWZSSyvvEd0dt14IAzt6RkoaP+S+q4hDBVrqHPPPVUrcPvjnx
         zoLSO5Hc6Hf7Z8OsQe2uQEBVXRmL4N0m7+SYanejITd39DrhIKtPWfKAYDat6yY/cm
         U1qAFbumGQOI03Ro49qZ3drwKLtbIIF9s9S2AgWij6hkQzsWcLM1v93Jee56WCttfT
         ai+2zxm4siZ/wNJgsGxRWu0KSI5VXBHWQmluJQPkjVLVKXxm4xrIk4QaFvIk2fhq0v
         guhyrPEUgA6oUo+VL0OpzNb9ARnHoa/oTBHRG9EpJXOphJ3R91PYwTmsPKcG6uTs2B
         jNoAcX7NZ4oi/Qbo5FSwbspgFyTMXGZtOv2I1vZgGbPvLhcn3BY
Date:   Fri, 13 Aug 2021 22:30:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Russell, Scott" <Scott.Russell2@ncr.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git clone corrupts file.
Message-ID: <YRbya0UO2+PvOjL5@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Russell, Scott" <Scott.Russell2@ncr.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <BN6PR15MB1426E50F03A0530CA9140F98CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14261C40E614CC11416388B4CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14264C9A96F4B5F6B01FA7FACBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YO7K/n3SYueP0bJT"
Content-Disposition: inline
In-Reply-To: <BN6PR15MB14264C9A96F4B5F6B01FA7FACBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YO7K/n3SYueP0bJT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-08-13 at 18:54:43, Russell, Scott wrote:
> File from git.
>=20
> =E0=A8=8D=E2=BC=80=E2=BC=80=E2=80=80=E4=B4=80=E6=A4=80=E6=8C=80=E7=88=80=
=E6=BC=80=E7=8C=80=E6=BC=80=E6=98=80=E7=90=80=E2=80=80=E5=98=80=E6=A4=80=E7=
=8C=80=E7=94=80=E6=84=80=E6=B0=80=E2=80=80=E4=8C=80=E2=AC=80=E2=AC=80=E2=80=
=80=E6=9C=80=E6=94=80=E6=B8=80=E6=94=80=E7=88=80=E6=84=80=E7=90=80=E6=94=80=
=E6=90=80=E2=80=80=E6=A4=80=E6=B8=80=E6=8C=80=E6=B0=80=E7=94=80=E6=90=80=E6=
=94=80=E2=80=80=E6=98=80=E6=A4=80=E6=B0=80=E6=94=80=E2=B8=80=E0=B4=80=E0=B4=
=80
> // Used by CamTest.rc
> =E0=A8=8D=E2=BC=80=E2=BC=80=E0=B4=80=E0=B4=80
> #define IDM_ABOUTBOX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0010
> =E0=A8=8D=E2=8C=80=E6=90=80=E6=94=80=E6=98=80=E6=A4=80=E6=B8=80=E6=94=80=
=E2=80=80=E4=A4=80=E4=90=80=E4=90=80=E5=BC=80=E4=84=80=E4=88=80=E4=BC=80=E5=
=94=80=E5=90=80=E4=88=80=E4=BC=80=E5=A0=80=E2=80=80=E2=80=80=E2=80=80=E2=80=
=80=E2=80=80=E2=80=80=E2=80=80=E2=80=80=E2=80=80=E2=80=80=E2=80=80=E2=80=80=
=E2=80=80=E2=80=80=E2=80=80=E2=80=80=E2=80=80=E2=80=80=E2=80=80=E2=80=80=E3=
=84=80=E3=80=80=E3=80=80=E0=B4=80=E0=B4=80
>=20
> File in github.=C2=A0
>=20
> //{{NO_DEPENDENCIES}}
> // Microsoft Visual C++ generated include file.
> // Used by CamTest.rc
> //

We're probably going to need a little more information about this.  My
guess as to what's happening here is that the editor you're using to
view the file is set to read files as UTF-16, but the repository has
them stored in UTF-8, or (less likely) vice versa.

Can you tell us what editor or other tool you're using to view the file
and what settings it's using for text encoding?  Can you tell us about
any working-tree-encoding declarations in your .gitattributes?  You can
use "git check-attr -a PATH" to see more information about that.

What code page are you using on your system?  Are you using PowerShell,
CMD, or Git Bash?  If you're using Git Bash, what are your locale
settings?
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--YO7K/n3SYueP0bJT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYRbyagAKCRB8DEliiIei
gbT8AQCujWIlYI+qzZrMwOq/VzacslEmBZtx74AojEBPb0g2+gEAyP8GmiYyozhG
da5YRGtxwsWDDpQdcee96eab1gHmKgE=
=kdyL
-----END PGP SIGNATURE-----

--YO7K/n3SYueP0bJT--
