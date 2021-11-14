Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AE3C433F5
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 21:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B641161077
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 21:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhKNVqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 16:46:21 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:42792 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhKNVqN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 16:46:13 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B290D5B482
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 21:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1636926197;
        bh=kfUZRQsKcURRrQxT1my+IBn5LfC0AejAudafVtMg+cc=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YE+z3XWWCp9LxC2jgqAPSJnD5QW9q7n1s5Q1uoxhW/ZInj0Ye5IwnMhVi97Ntu2km
         KJ7V6vgxo6n3331EawZOm8OE72zC7KUpyjtR17fwzLlFzLnTF+2VB/XwjdnLSdJ459
         GP98ZUicWkkYyUPzZdK7ThtpNGOjqegxVDLPGZjNYjyfTQQ8/F21blfldlUUmiclev
         hTsqTVS3uUV+PjuEq0TGssyl/pQ2HeML7q3gBPbMy2i1b6p7U0vGArm34x8HT5mHfi
         VvaK7M5mW5D1HFyCmKKH3bjPyL2Hko++Zgp28zilKAJgcr/dC3OfjB6ibI/KMyJ+JJ
         Gj2yOwsTGA6GTfjoIIXno7hkzHJf0WoKWYCmoco9w0WZFjen5uN8M59dAKMNLWb3eI
         Tmp1e6ASzXBr/08j9qMPIGyIwM9I+C4cB6HvoSURsimJXNk3OXtH7z4tJP2Q+pwRNz
         3+RNbdcS98HQnLPoXVQjQtnOermI11Hp8CnYyvpee3b2Bu3vZu+
Date:   Sun, 14 Nov 2021 21:43:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Add a test balloon for C99
Message-ID: <YZGC868o77qo8j8/@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y7i2PacDdn2TULMp"
Content-Disposition: inline
In-Reply-To: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--y7i2PacDdn2TULMp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-14 at 21:24:36, brian m. carlson wrote:
> brian m. carlson (1):
>   git-compat-util: add a test balloon for C99 support
>=20
>  Makefile                            |  4 ++--
>  contrib/buildsystems/CMakeLists.txt |  3 +--
>  git-compat-util.h                   | 12 ++++++++++++
>  3 files changed, 15 insertions(+), 4 deletions(-)

Note that vger has decided to firewall my old MX, so I've resent this
through a new one.  If you received a CC on this, it's a different
email.

This should be fixed for the future.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--y7i2PacDdn2TULMp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZGC8gAKCRB8DEliiIei
gQ7qAP9vSDGBoF15Yu+aBNydYiegRNCKT6cDjoC5VRraDOqjowD9HTjrzxEYDkl2
vCzWwKbXhoOYJE6uf95t3EiEJW6VCgE=
=lRB4
-----END PGP SIGNATURE-----

--y7i2PacDdn2TULMp--
