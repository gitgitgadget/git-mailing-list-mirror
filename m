Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927B7C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 02:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E63611CB
	for <git@archiver.kernel.org>; Wed,  5 May 2021 02:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhEECOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 22:14:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:48008 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229799AbhEECO0 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 May 2021 22:14:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2527E6042C;
        Wed,  5 May 2021 02:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620180780;
        bh=6oCp+7y64ZuZ8PCiZxmPta29hcUc62MDD3BGS4NepLE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=byhqJt7oVk4/FJvddRdxqHV7Y8DZkQjQxFE+/IrfJFCvcYxHYX0eeMAufNWGbeb/S
         /1+qmRnWhr5kgYlT6q1Tj80W7LnUfhrAqcY7Pvc/35FUHYha9XNaewQBerHlq9uKyA
         oTCJk/g5PN4Kl/Cn/Ohq4IlWMxL9RhJIx63HKYiiUXBTMYGwZ5kikKr8mQwME3ghh8
         /3p4+HDsTGMhT4k/dIHvtCZ/YGB9sjR3Eu9dpNogabGNkp6NvDtmLGLz40PvrM6OuO
         ZZfXngR4M7T3IQZ7WkdjAt0JEIjeeGotSS4PBDA/6kHvqFLS1g1hvShh8LminahvA0
         Dz9MzuRxA3M1WLOh7AwWdNvaRU9v2Q2KMHjP4FroRqJJLOC9DuwJ/ZkBUnU58+hYj7
         vgnELJf6+Zj+TlupSEwiRSvl4fI2tRk12tWbQJC0I/b2OhlAVO0BVOAXxkHwLLi10Z
         Q/P76nV41/LPqRv+XeuJWL/kPnAqy9ZTLGaFGxr3QoRYTL8LdBQ
Date:   Wed, 5 May 2021 02:12:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Mark Amery <markrobertamery@gmail.com>, git@vger.kernel.org
Subject: Re: Bug: Changing folder case with `git mv` crashes on
 case-insensitive file system
Message-ID: <YJH/J+ungqbqT3Zb@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Mark Amery <markrobertamery@gmail.com>, git@vger.kernel.org
References: <CAD8jeghpOQoibk0xM0QgLsOwLNw9GdM=4rhYuzV-NSkw8LinMQ@mail.gmail.com>
 <20210504151954.aczbvml4rh7t2svc@tb-raspi4>
 <xmqqtuni58ra.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6tMKKms+CAl64Oll"
Content-Disposition: inline
In-Reply-To: <xmqqtuni58ra.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6tMKKms+CAl64Oll
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-05 at 00:23:05, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
> > To my undestanding we try to rename
> > foo/ into FOO/.
> > But because FOO/ already "exists" as directory,
> > Git tries to move foo/ into FOO/foo, which fails.
> >
> > And no, the problem is probably not restricted to MacOs,
> > Windows and all case-insenstive file systems should show
> > the same, but I haven't tested yet, so it's more a suspicion.
> >
> > The following diff allows to move foo/ into FOO/
> > If someone wants to make a patch out if, that would be good.
>=20
> Is strcasecmp() sufficient for macOS whose filesystem has not just
> case insensitivity but UTF-8 normalization issues?

strcasecmp is locale sensitive, so I would say it is not a good choice
here.  Notably, that means we have differing behavior with "i" and "I"
if the locale is Turkish versus English.  Only one of those behaviors
will be a correct match for what the kernel does, since it is not locale
sensitive.  Moreover, on Windows, the version of Unicode used for case
mapping is written into an NTFS file system when it's created, so a
fresh install may have different behavior from an upgrade, and
strcasecmp won't honor that.

And, as you pointed out, it doesn't handle Unicode normalization at all.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--6tMKKms+CAl64Oll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJH/JwAKCRB8DEliiIei
geAoAQDnar5aD4RGnc/K1JeAke+VJ4mFgt2plTFWxzgeaMeDHgEAm/fnToFJPULw
PR9Xvl4fGjPGi4KX7aQYZC9i4csEoAs=
=ib6F
-----END PGP SIGNATURE-----

--6tMKKms+CAl64Oll--
