Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010A7C433ED
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 18:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECE4613D8
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 18:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhDXSZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 14:25:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40958 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232339AbhDXSZW (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Apr 2021 14:25:22 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0140F6042C;
        Sat, 24 Apr 2021 18:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619288653;
        bh=5qJ5ovtrTz8kCgC4HhXem0Jd/GQyjqZ7/hesp1e86XM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Br9OwnOw3Dnx4+0aHTa3unPDWqANfq1QcMeEi8CFHGV1Yem89tAtt4F7R5GeNNMSC
         I/+xuUOoG3rORChY/O1Lai0PK5xSLl0xCSmg+dS8iRz66z5b1lZGroMiI3ygM5G1iK
         X1+W9r7XkaxoMHEehoCTZnfrBIM9xc6hEdAvLdNiHXzi7dXebfS8E68FKEbj/r5UPl
         6k1S69aUm8wnR9k9HUGXYPDjqA7o6cQQYx/bryajhw3BFSXEuPGTTNMdNUe4JWx9+P
         xgJaZdeLoVvHAmumQWPcyk3mkxRjFR6o506R8DZ3YW4yXxBQPMg+sx8AGaRAUpciMX
         JixFLz2h5VCj4GHQQTTlIDlvIli9Der4fEk2Nh9dWIv/JRzy80us2G7zv6k8eEjRWt
         01AA+tbEow9L+z7cfnOBtnYqkbcptL3ztTF8bQNns8A9KXplFxbIGXsUWCIq6Bvndw
         w8MPw+lIewW6/FFklPDaXqxOHyXqbQFTcd0I1TLR6Jr0bjM9hN2
Date:   Sat, 24 Apr 2021 18:24:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        git@vger.kernel.org
Subject: Re: how to rename remote branches, the long way
Message-ID: <YIRiSJDem/JaBHuN@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        git@vger.kernel.org
References: <87mttofs5t.fsf@angela.anarc.at>
 <60836fa129078_ff602089c@natae.notmuch>
 <87k0osfpt8.fsf@angela.anarc.at>
 <60839422353fc_10cb9208c7@natae.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ndiC/Nj9J6ddTH75"
Content-Disposition: inline
In-Reply-To: <60839422353fc_10cb9208c7@natae.notmuch>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ndiC/Nj9J6ddTH75
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-24 at 03:44:34, Felipe Contreras wrote:
> I see.
>=20
> That makes me think we might want a converter that translates
> (local)main -> (remote)master, and (remote)master -> (local)mail
> everywhere, so if your eyes have trouble seeing one, you can configure
> git to simply see the other... Without bothering the rest of the word.
>=20
> I'll give that idea a try.

I don't believe this is a helpful response, and judging from the
follow-up, neither did the OP.  They're not trying to do anything
dangerous, improvident, or harmful to others and they are trying to
solve a problem that many people have and that is due to an inherent
limitation in Git (its inability to rename remote branches easily[0]), so
there's no reason to respond in this way.

There is a difference between being firm and steadfast, such as when
responding to someone who repeatedly advocates an inadvisable technical
approach, and being rude and sarcastic, especially to someone who is
genuinely trying to improve things, and I think this crosses the line.
I'd appreciate it if we could aim to avoid the latter type of response
and not scare off new participants to the community right away.

I realize I also sometimes fall short of where I should be in terms of
kindness on the list and elsewhere, but I hope we'll all endeavor to do
better here.

[0] Regardless of how you feel about this _particular_ rename, one would
want the ability to do this to preserve reflogs for _all_ remote
renames, and so this would be a valuable and desirable feature to have
in Git anyway.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--ndiC/Nj9J6ddTH75
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYIRiSAAKCRB8DEliiIei
gZRCAP9zxJjt+MAkeppfuJAN9bDKR2vvNyar0mdkr7KfhQjivQEA9s6wsM/0xGlX
9G4INrK4cxtCRHRy/JHWgcvPdvn8Lwo=
=xWWT
-----END PGP SIGNATURE-----

--ndiC/Nj9J6ddTH75--
