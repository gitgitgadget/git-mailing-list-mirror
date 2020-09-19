Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E067C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 19:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3044321707
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 19:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgIST3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 15:29:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34544 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726511AbgIST3A (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 19 Sep 2020 15:29:00 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 868C760459;
        Sat, 19 Sep 2020 19:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600543738;
        bh=d8+7OfSW686jbNqntTrCiAYSvs2/K3eG9OKgoWfAnyA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ksj1JZNPnEdzwC2Ypy1oAOtI3Qm+8Uzvjr6mEuSzEycW8pAwATu/BnQJJVdeEtJu3
         4POp1d4d9mjcwxz4DjZBYM/CnzDydKmVR/zvmvSxlzatAHCu/3T/vSebJ6V1xJo9sa
         3sorgKsgsNx5IZ3QV60u8lJja2/8d6Su+cpQ4VI+zvjSspqrOUABj1BNSZRhWLq39z
         rvneVSpIiKW17NQC5sEC+XEdLWmZUfD03m3o6OEYexmXRM2N0aejSfo8d+rpsC4PsY
         ojc3DvNE9bKLqbBcriQ6OQJL1kT3O9xDrPmlokYFAa2oEDcIeDpmFsTzaFkMAXhL95
         +03m8jeG6beP93nqROm7VqVNNjOTTLsX+8frIW7TWoL7GYiPboZ/0o34VnpVK5MT5q
         P8f35PcNleWMq6JEsqig05C70EQZKPkTERO3ENnsIsCAo1NBlvP5V7pfeP3GXmoY9Z
         3pVAsJ7vhAMzyvz/8obj/wJGOuDYdcGGx8NhEh+myOFdZk9zPqG
Date:   Sat, 19 Sep 2020 19:28:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Apply git bundle to source tree?
Message-ID: <20200919192852.GG67496@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andreas =?utf-8?Q?Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Git Mailing List <git@vger.kernel.org>
References: <CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com>
 <CAMwyc-RCiEREpPsTb76LjhLc43Zr2qw-uxYVVPfuznexTTB+Tg@mail.gmail.com>
 <CAHpGcMJy=0deaByZ=jXHRiHgHH7utHc0JTG=BMq9Yf1DOKvuGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PpAOPzA3dXsRhoo+"
Content-Disposition: inline
In-Reply-To: <CAHpGcMJy=0deaByZ=jXHRiHgHH7utHc0JTG=BMq9Yf1DOKvuGw@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PpAOPzA3dXsRhoo+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-18 at 21:45:01, Andreas Gr=C3=BCnbacher wrote:
> What I had in mind were actually distro packages: most projects
> nowadays live somewhere in git repositories. When they're packaged,
> this usually results in a source package with a diff on top of a
> baseline release, so the commit history is lost. Friendly packagers
> include the commit hashes and point users to a suitable git
> repository, but that's not enforced or consistent. Including the
> actual git history in packages would be much nicer (i.e., a git
> bundle), but if that can't replace the patch as well, it's rather
> unlikely to happen.

Debian considered using Git as part of the 3.0 (git) format, but the
problem with that is that some upstreams include non-free or
undistributable material in their repositories, and obviously Debian
can't distribute such software in main.  Tarballs can be repacked, but
it's harder to rewrite Git history to exclude objects.

I do think the idea is cool and it would be a neat application, but
distributing the source history of an upstream project is tricky for
for packagers for practical reasons.
--=20
brian m. carlson: Houston, Texas, US

--PpAOPzA3dXsRhoo+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX2Zb9AAKCRB8DEliiIei
gTHmAP9DZDpz1GGLiNfQaWSpHf40o0E+DaXNVBslpLW1Ez5h7AD/WzDlAsnIhHt0
hLT9i7gEuWEN/Cx3G0uZKe2hki0i1QU=
=KAx7
-----END PGP SIGNATURE-----

--PpAOPzA3dXsRhoo+--
