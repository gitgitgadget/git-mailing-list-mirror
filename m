Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75697C433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 22:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B7F2074B
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 22:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KImSDnOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgFEWnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:43:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39038 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728256AbgFEWns (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Jun 2020 18:43:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6FB776077B;
        Fri,  5 Jun 2020 22:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591397027;
        bh=Q+zYNgBunA8xLDZgKoLpmte/QdbkzwVU502igci6EH0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KImSDnOH7YWKmA2b39HpYgt8cUv4XTcwkmcVhMRgdpvXw9g2VCI+rByj6Sq76y0+5
         YWYNFl8Sr91qErwdzotJW6hQWHqcZTNouDHVlHoOraT3EfLGdl7SW7RJcYRSB63ORJ
         lcIha9IMRh2dTa13SxchR3orgGS5E22UTPrMcqgkUOYGmp1//vpp7PL6xcfVNICt7I
         MoSPqMmWyvv2m2w46APCYWDcyfUalFKFe+mdVYZLZ6bR33ADAm4iUvO+1ubthy7bNO
         yd9PGKTgU5JQrZOiontfXLIhUbIpYHu3jxjFeNSAbeTPgXpsscP29JBXnHk14d/F1e
         vK5++coyBGGzNX11LzwuctHP5coq7PREqHVQULbrm/hxc5TyDw7+Arh20gmXrBz2C6
         Cxh+3tu7I3E6xKKMiEK8uGBHuFNJEpyz+S6d7e5Aui2ATL5YOp92S0ZzuKaUPAXMrS
         BMAtM1YpjHFTWynG+BKt/3ebI+cZGTrDpGqrvLG4OJr9aolNlyt
Date:   Fri, 5 Jun 2020 22:43:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Billes Tibor <tbilles@gmx.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: git-fast-import out of memory
Message-ID: <20200605224342.GF6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Billes Tibor <tbilles@gmx.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <c53bb69b-682d-3b47-4ed0-5f4559e69e37@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TU+u6i6jrDPzmlWF"
Content-Disposition: inline
In-Reply-To: <c53bb69b-682d-3b47-4ed0-5f4559e69e37@gmx.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-05 at 05:15:04, Billes Tibor wrote:
> Can you help me fix this issue? I hope the information I gathered is
> enough to
> help you find the cause of this behavior. I'd be happy to provide more
> information if needed or test patches.=C2=A0 Unfortunately the source cod=
e I was
> fetching is proprietary, I cannot post it.

Hey, thanks for this report.  I can confirm this with git.git and the
following commands:

  git fast-export --all --reencode=3Dyes --signed-tags=3Dverbatim --tag-of-=
filtered-object=3Ddrop >$TMP/git.fe
  cd $TMP && rm -fr test-repo && git init test-repo &&
    (cd test-repo && /usr/bin/time git fast-import --export-marks=3D$TMP/gi=
t.marks < $TMP/git.fe &&
    /usr/bin/time git fast-import --import-marks=3D$TMP/git.marks < $TMP/gi=
t.fe)

The latter fast-import command gets killed with SIGKILL due to using 16
GiB of memory, which I would agree is unreasonable.

It looks like with Junio's patch at
<xmqqeeqto4x1.fsf@gitster.c.googlers.com>, the memory usage is down to
1.4 GiB, which considering that a pack must be written, is much more
reasonable.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--TU+u6i6jrDPzmlWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXtrKngAKCRB8DEliiIei
gfPkAQCXrM3m82hHMq8omaw1sR0HmcYZJP9cImxNXEqgAWRBpwEA2pL2K7v0DPQk
fXB5bEXnBdJ9Rvm/3xAmXgmqYwQnZwY=
=/eSg
-----END PGP SIGNATURE-----

--TU+u6i6jrDPzmlWF--
