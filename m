Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599EFC2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 14:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E18A61C76
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 14:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhF1OKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 10:10:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58798 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230033AbhF1OKu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jun 2021 10:10:50 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 197BB6073C;
        Mon, 28 Jun 2021 14:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1624889274;
        bh=RIo4sPYej2FTt7rW9kPddCjw1s2psWLPcM9mv5s6Ix0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=z3l/c5g5F5uuKDeg4dUWMeyalYmG6E/j3WwaKY1EWJtTMub8l4j05p6tbf4WEEC0L
         +xmH1/4AZ4pL0bj5HjlApNDzAjHonZ3M5EAj6ESpSopqBeY1atXg4zmqyxjrd8mJgk
         ot6Tap8Q0+DZ9JHs/s02qVKEPT8X06pDRq5mv8b/DC9lxrLUQnOcr9xHpbJ5PE/ErJ
         XNUC7im8HMAzZvxOhn7Z+fqmtdLtDTl8JrInC3DYOBcoR+WR0oxLP1paI4n40wj+C5
         aHO+iZ6QY43bqVym0Y8oAfAsSmQLbu03/sbeycoT3JW/UjNuuq/N0sB5cXCEgG2OFY
         WB1Adv5FE6EiDjb0NH+xEmUs+UFsy9Fa26BmSmpqZwjr0ZHyvFS4GeXY8Gl2DIER+o
         Uuf3AgqIFWX8zI+BXttk0n92zluKsUl3lm1KgrjRUBX3IAiy5yP+ZBm1oc+L+MHFgv
         mZLMEHoCZ0c9mOAXlxyyYd9SJZMjHVd9tjBr15RtbclqfW5aMv1
Date:   Mon, 28 Jun 2021 14:07:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?S8O2cHBlbiw=?= Thomas <thomas.koeppen@nordlb.de>
Cc:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: Release notes: mIssing version information for git-LFS
Message-ID: <YNnXti6Bf0SP7OIO@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?S8O2cHBlbiw=?= Thomas <thomas.koeppen@nordlb.de>,
        "'git@vger.kernel.org'" <git@vger.kernel.org>
References: <21210b30b6c44361aef0c99ca5983f52@nordlb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Smd5DmYCO2y3xHor"
Content-Disposition: inline
In-Reply-To: <21210b30b6c44361aef0c99ca5983f52@nordlb.de>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Smd5DmYCO2y3xHor
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-28 at 13:46:02, K=C3=B6ppen, Thomas wrote:
> Hello all,
>=20
> in the release notes for git i miss the information which version of git-=
LFS was implemented.
> Am I just reading over it or is this information really missing?

Git LFS is a separate open source project that's developed
independently.  Git for Windows includes the Git LFS binary, but it is a
separate project from Git itself and as such it isn't mentioned in the
Git release notes.

If you're interested in the release notes or other information about Git
LFS, you can find it at https://github.com/git-lfs/git-lfs.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Smd5DmYCO2y3xHor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYNnXtQAKCRB8DEliiIei
gUESAQDIBlBprROyfsEiEWli2Q3b9T7A4qrIw6oOODSjAxXcXwD/Rk2EBaz8onwB
GUtz2ygZAM9RBEeX4Q0R3xRdCQom5Qo=
=HEWB
-----END PGP SIGNATURE-----

--Smd5DmYCO2y3xHor--
