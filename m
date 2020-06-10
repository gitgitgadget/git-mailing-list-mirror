Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EBAC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 00:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3CD206F7
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 00:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ec2PGNdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgFJAEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 20:04:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39162 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbgFJAEe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Jun 2020 20:04:34 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1061260756;
        Wed, 10 Jun 2020 00:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591747443;
        bh=QY2JaSU+Tq/K92VGMipBxwWX6xF/HhgAUxMZ0LoDhNY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ec2PGNdiPZtx8tB/6u5/cUDSOaeoB+xj++NfJbkOlj2OMcs+w1+VCpHQJxNzXHcKR
         u6mJKvwgwmGCWxkDPfN4Dsvj7IpKRvKTWV/dnUACC8qGyfAyjq0RrPd9X2eKmq3r+l
         sfY9VRGIfFPuBMytvRCRhSNEnVMcOfEGKzPnsD6UwU7uf7mMn9axoFoKLLx4c6VW4Q
         jGxTH44dlZ1/iEtyfhcO9onw3JmUNQkUodG5l26cLLjb10/xOnG9qQNGf7QjiOX3D+
         9LR2jtmCyfcVakD9JQh7WsNyu+21GZp9Blbg86uvL44yNktZvOJ8Yzo0EtVaW3eiAp
         tssUxZ/4bkGEYjZZ7Jk+KttrUQ4fUU5obCd5TswtY201FwAid3TePgVjC1QaHQoAmL
         z6Tv0/UpCM9zkKQ2fW6BYKMbSO82pd4zuzQBpKaqnw1ZqmOC7hOMmLGnC7yq7I0Jl4
         6eIJ57PaGwhWERZWsGYOzfX3R51ThrL+r+ae5QKgy4I20b+ubA1
Date:   Wed, 10 Jun 2020 00:03:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: osx autocrlf sanity?
Message-ID: <20200610000358.GR6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CACPiFCJKvnDL9Xj1Xs0RCvuhymjDz4N0hT42dNtBQxp+TLiPaw@mail.gmail.com>
 <20200609231336.GQ6569@camp.crustytoothpaste.net>
 <CACPiFCK0h0LfdyE6Q=UJkuX+Qdb=rULcgDJwgxQ0w-1O0zpMew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dFvuq/4WPi1dbS7Q"
Content-Disposition: inline
In-Reply-To: <CACPiFCK0h0LfdyE6Q=UJkuX+Qdb=rULcgDJwgxQ0w-1O0zpMew@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dFvuq/4WPi1dbS7Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-09 at 23:31:23, Martin Langhoff wrote:
> Hi Brian,
>=20
> good question! There is a .gitattributes file, all the files affected
> have these attributes
>=20
> *.py     text diff=3Dpython

By default, Git will check out files with the text attribute with the
native line ending, and it will check them in with LF endings.  That can
be controlled by core.eol and core.autocrlf.

If the file in the repository (as shown by a "git show HEAD:filename")
has CRLF endings (usually less shows this as "^M"), then the user has
done something naughty by overriding the .gitattributes file with local
overrides and checking data in nevertheless.  If so, you'll have
problems on a Unix system pretty much regardless, unless you set
core.eol to "crlf", in which case you'll get all CRLF files.

It may be instructive to run "git diff --ws-error-highlight=3Dall" to see
what the changes are in the working tree compared to what's checked in.
I suspect it will probably be line endings only.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--dFvuq/4WPi1dbS7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXuAjbgAKCRB8DEliiIei
gSoyAQCKp+MDiU/Xy2F1rwB5LJaD8xtLi6MKmQDX2+XFpyJJZQD+KPtCcEYAAm+Y
thVMhE5Przw+dm1cG2uYaxo5o5qXnwI=
=b1QC
-----END PGP SIGNATURE-----

--dFvuq/4WPi1dbS7Q--
