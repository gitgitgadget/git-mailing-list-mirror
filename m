Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74B3C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 22:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A04520656
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 22:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uzmSjLQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgFKWxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:53:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39254 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbgFKWxI (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Jun 2020 18:53:08 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5B8D260436;
        Thu, 11 Jun 2020 22:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591915956;
        bh=dMF7xL3gT1oNEtR4NGh3S/GjgVnWeRx1XejO98Q8RNk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uzmSjLQmO1LeLXw2lVYZ0KFldqOfyJ+i+7aM6VrHplOxE+J/ZIvnGFUZDOZIsPaff
         L240P4PKkJAK1Ty/OD7DPMSWH7z3Hu76lp0hftESdwKDIsuM+yDQ+6VvqktLHzH3Im
         LP5eJQ/UgyOWAyNd4WEStcqXuzgHdxPnz6sY17bQDzFX/rKtHC+gp61A8Ikc9J3ipt
         QRjyXRVRsQkjyo/SfyEnHTS1kLmT1uucaPkpDVhLO80euHSbwtQT+ScgEeGTbGkUrl
         8+Ax5IOyeAjkKPzNcDUgAJohaPAHyLYcNiEUZBkh+wFtlf1z20aNcmeSFctAFDtzkG
         VjhvI7VeIrGrAthhhzmkNiSovhmLpCahHGoJBIV/z6Dl8dwSNu6S2k7s8hXNf3mG3Q
         Ioi18YrIfLTyir/7WwuxI+Q/l4QoPD/ZhNl2lFOAUY00cA64C5kUojmfwthIwG2B83
         JaTjrfB+mnrtZd6IAEQfnmoERsEbWgMWyMWqBLyPwSqlmkXYLgU
Date:   Thu, 11 Jun 2020 22:52:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Shreya Malviya <shreya.malviya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Question: Setting the Email Address in ~/.gitconfig
Message-ID: <20200611225216.GZ6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Shreya Malviya <shreya.malviya@gmail.com>, git@vger.kernel.org
References: <CAEqpqjGNANrCX0wMDUP+dZ+_PdMveSJf6XFyiCpJdUH5t6jXvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TuBLotoxjxNtqonL"
Content-Disposition: inline
In-Reply-To: <CAEqpqjGNANrCX0wMDUP+dZ+_PdMveSJf6XFyiCpJdUH5t6jXvw@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TuBLotoxjxNtqonL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-11 at 21:25:45, Shreya Malviya wrote:
> Hi!
>=20
>=20
> I was playing around with git when I realized that it's possible for
> me to commit something to a repository as another user (explained a
> scenario below for a better understanding of what I mean) and it is
> not considered a security vulnerability, understandably so
> (https://bounty.github.com/ineligible.html#impersonating_a_user_through_g=
it_email_address).

This is GitHub's bug bounty policy, not Git's, but it is definitely an
intended feature in Git and not a bug.  I should point out that they are
separate and independent.

> For example, let's assume I have push access to some repository called
> AAA, and my email address is abc@xyz.com. I can simply edit
> ~/.gitconfig on my system and set the email address as some other
> person's email address: def@pqr.com. Then, I make some changes in my
> local repository and commit them (reminder: it's with the email
> address def@pqr.com since git tracks commits by email address). Now,
> if I try to push to the remote repository, it asks for the username
> and password. I put mine and since I have push access to AAA, it goes
> through. I've successfully pushed commits on behalf of the owner of
> the email address: def@pqr.com.
>=20
> So basically, in this way, I can impersonate people and add commits on
> their behalf. BUT AGAIN, this is not considered a vulnerability (link
> for reason attached before).

In the Git project, users send patches to a mailing list and those
patches are applied by a maintainer.  When the maintainer applies them,
they contain the user's identification and therefore are attributed to
that user as the author.  This is a common workflow in patch-based
projects.

Disallowing people from pushing commits that contain another email
address would prevent the maintainer from pushing commits authored by
others, so Git doesn't do that, although it can be configured with push
certificates and a hook if you like.

If you are asking why GitHub attributes commits based on email, you'd
have to ask them.  However, be aware that there are projects that are
concerned about commit spoofing, especially corporate projects in
regulated industries, and the way to handle that is to use and require
commit signing.

> My question:
> It would be much easier if git didn't allow changing the email address
> so easily. Why hasn't git implemented OAuth, or something of that
> sort, for every time that the email address is changed in
> ~/.gitconfig, yet?

This is a local configuration file, so asking someone to implement OAuth
to change a local configuration file wouldn't be helpful.  Many Git
servers are, for example, SSH only, and so OAuth isn't even a
possibility.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--TuBLotoxjxNtqonL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXuK1rwAKCRB8DEliiIei
gVCTAQCCfRl8uH1aZvcw+6SLybyGG4T/OjPxXs7E2HAUQwaY8gD/XCL5JBASgKeZ
OafMVUBRO6mJBgc4AspJdHyiM4BubQk=
=BDRw
-----END PGP SIGNATURE-----

--TuBLotoxjxNtqonL--
