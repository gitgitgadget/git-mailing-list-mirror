Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40C9C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 02:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7147208DB
	for <git@archiver.kernel.org>; Thu, 28 May 2020 02:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="q8bZv5yl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgE1CSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 22:18:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38920 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725849AbgE1CSG (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 May 2020 22:18:06 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 040106045A;
        Thu, 28 May 2020 02:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590632255;
        bh=Yn3nIe6nrehXUJyCOzB9RO944GmexOoUslW0TRentcA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=q8bZv5ylsjKWfT4Vi37OmpKt4c7KkM+SwCQEUZ9NZDYqbAdJdxWukIgEVDsyklY4R
         730TKjRnVFGOxUlyDp9yhFlwNSDCwlgyo7u5E/gImPGel039MuKn85vgSkzR27/Lf8
         fbCi4ub3TqteNSAMILYpr4TPsQfg7jrADAJyZs5AlhSgzTPGof0jz36WtK9zm+tndA
         d7SgQ/rj19BXWvjc9t51BBV71I00HWl7FKmSI+6ozg9PRWasiOvajPd9VHArdsJ9j+
         /Qw80TbpNJOISJuY7Kl+qJ/XC/zKR6bDoXJObROfJmlPCLfyAEwtDfc89NagFCvCZA
         qje86lxUseLsQmXYl1UKR+VIFNCmNU4fwcUJgm1iu8TBy60jhve+ZUmPzYLktK7QhZ
         ssir1868aaRuTilGdthD66KiNa7CCLGJPBoRBy7EQpjZf2r/elkMr5Uisld9M5UboX
         tVeVEa7SHvntcuYCq+TEpulDWE+1EeZr7XjGubtBA/M403ZiSec
Date:   Thu, 28 May 2020 02:17:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     Marco Trevisan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Marco Trevisan <mail@3v1n0.net>
Subject: Re: [PATCH] completion: use native ZSH array pattern matching
Message-ID: <20200528021727.GH1915090@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Marco Trevisan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Marco Trevisan <mail@3v1n0.net>
References: <pull.645.git.1590520398132.gitgitgadget@gmail.com>
 <20200526235834.GG1915090@camp.crustytoothpaste.net>
 <20200527061359.GB40564@Carlos-MBP>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wjoFZxbW4tu+iR6v"
Content-Disposition: inline
In-Reply-To: <20200527061359.GB40564@Carlos-MBP>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wjoFZxbW4tu+iR6v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-27 at 06:13:59, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> On Tue, May 26, 2020 at 11:58:34PM +0000, brian m. carlson wrote:
> >=20
> > This file is necessarily used by both bash and zsh.  Does bash
> > (including the bash 3 used on macOS) happen to continue to work with
> > this syntax?
>=20
> if by that you meant t9902.[150-152] to succeed with macOS bash?:
>=20
> $ bash --version
> GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin17)
> Copyright (C) 2007 Free Software Foundation, Inc.
>=20
> then I think we can add (on top of master):
>=20
> Tested-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

Yes, that is what I meant.  I'm glad to know my question has been
answered and things work.  I'm okay with the patch as it is in that
case, although I'd give bonus points for mentioning that this syntax
doesn't regress bash.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--wjoFZxbW4tu+iR6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXs8fNwAKCRB8DEliiIei
gUn/AP42s9udMj06960GtzRES0ofrfOrglkbDJY0oWRYgsCbpAD9H9t2BOL6iLLp
f0EKJgqBEf1Id9mEWlqKRa2ZAnUzSQw=
=Ml2k
-----END PGP SIGNATURE-----

--wjoFZxbW4tu+iR6v--
