Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B185C35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2402021473
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="RWjV/yGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgEGXZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 19:25:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37974 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726445AbgEGXZY (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 19:25:24 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3041A6044D;
        Thu,  7 May 2020 23:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1588893893;
        bh=d1Wgy5cEUE/KjNWahpl/CTWCNI5/D5nZzKIFmYB+CxY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=RWjV/yGIJWPm4hqRH5kiEV/6ga8Infmkl/eFLKz6J65RHXDXhqJyepFvT84iv4Zzi
         GdYUrN/p+ykrgL4v2b0hDfZ6vCddb7+dpaIldiLPSxtT6wF283ACeb0ieW5OccTjQV
         okZIiZqMS5RYjmntEKTI/P1AGQBk2qBqfHInSLn5E9roM2VbhTfBwR3uSYnOoNm2md
         q8kthSM9Gde9h6DTUpqwrbUalOyLnrL+H9XRhzhJCgol6ry0Lz3ZSuDWh2c6KjukZr
         /rGR+CoiexNp0ThF7eqaft0C8xLsQunf5nKit/3itY8F2hw2nLURqSPt7mYHNqVecY
         UWGZEc2eOjIbLfhu3vfCr7/87tExDTyFsOmwebwXTKWUp/8zruPQhFaa6VkIL2r+d1
         BMuybDLw7tK/wDAj2iWAzE1e/QgnEdjiV3fOvmPCIseLQKjfnA4335dTLFLw2feWL8
         y4/nsaU351qPL/Hqq+se2nbgO8J+MzHWQ9KzmdG1dzVPJ6fWrCk
Date:   Thu, 7 May 2020 23:24:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Alexander Mills <alexander.d.mills@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: check if one branch contains another branch
Message-ID: <20200507232448.GB7234@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alexander Mills <alexander.d.mills@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <CA+KyZp7TELrswPjNgB99BXXHEXi5pRr5bO3g_wy7zBvv1R4Kww@mail.gmail.com>
 <xmqq1rnv2vi2.fsf@gitster.c.googlers.com>
 <CA+KyZp6pvqqNnOOj0ap9ekPdv9mZg2u_NQuwFgMXfwfV17SrYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <CA+KyZp6pvqqNnOOj0ap9ekPdv9mZg2u_NQuwFgMXfwfV17SrYQ@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-07 at 23:12:09, Alexander Mills wrote:
> so it would be:
>=20
> feature_branch=3D'my_branch'  # the branch that I want to ensure is
> completely merged into origin/dev
> git merge-base  origin/dev --is-ancestor "$feature_branch"
>=20
> that won't work?  since git merge-base only works with current branch?

No, that's not the case.  You can write this:

  git merge-base --is-ancestor $feature_branch origin/dev

This works from any branch and exits 0 if the branch is in origin/dev
and 1 if it is not.  In neither case does it print anything.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXrSYwAAKCRB8DEliiIei
gWpzAPwNrHs4Fl0z/HeSE59rirE8by004Ed2jfrdsESI/AL19AEA4/QVqOS4Kqeb
H/HGmkTpLwj9L5xLTEZMnVc1hKkdyQg=
=xWUb
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
