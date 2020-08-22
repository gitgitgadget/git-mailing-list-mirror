Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D32C433DF
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 01:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4546420735
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 01:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="PqzIhZIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgHVBym (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 21:54:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45064 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbgHVByl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Aug 2020 21:54:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3201A60457;
        Sat, 22 Aug 2020 01:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1598061248;
        bh=kHWSwMmnZ8ahWWV+ppGI8GEJfHgyrp2j31d9isMoTHA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=PqzIhZIZCdEXMhzvbGnyKYeeuh4age3d+dcToPPHGnVIh3alP0RRKSKthkOOlzs5K
         8kJ7ZV/Lm8mRMpN0BVm7i4zJMSp4TQ+ZFHbESLOkK1Sb5kGU7Zo5RUcNXYqoPtt42E
         mwu+tTOMFjxt/RhC6AuIC6rOxGFO2kZLa97oI3Tnqp9o2jX6UjnrSFnbq03b+iQ8WF
         XHevq9VQ4wZFyoLJoZb+VuijYwJpXWtPkVOJgOzEGr8oaRbJAP4lEC/P8a7v95rN6l
         ZKR/wgtAj34N4dUYoA8sg/WZDReLi8yUUjyX32Bz4cymxY3uC4YkoMifYAtv9m+qKU
         9zutdTI2NzfcWWST5Zc/z6x6PrJh6DeSQPkclXXD/J/ThyMJOn3z2H34CvTBG067e1
         RSdhvvN3F0dAF+INz5hcW4inXNRO/39vsYp9hkl1QrCoVpm7yee7WIkins7BpHSxlG
         i8ui0zQJK3AWkZhy/2YaJokj4HGmeNLfQllvI9oqsgLLyHh1Q1J
Date:   Sat, 22 Aug 2020 01:54:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ulrich HERRMANN <ulrich.herrmann@st.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git submodule status never =?utf-8?Q?s?=
 =?utf-8?B?YXlzIOKAnG9sZCBjb21taXRz4oCd?=
Message-ID: <20200822015402.GY8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ulrich HERRMANN <ulrich.herrmann@st.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <VE1PR10MB33746C60D550BB11162F5E24945B0@VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM>
 <VE1PR10MB3374796F04367FA5DE25F921945B0@VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oWEYV0WmY9Kcrzh0"
Content-Disposition: inline
In-Reply-To: <VE1PR10MB3374796F04367FA5DE25F921945B0@VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oWEYV0WmY9Kcrzh0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-21 at 12:14:58, Ulrich HERRMANN wrote:
> Hi all,
>=20
> I am now a user of git-submodules for quite some time. However I still
> haven=E2=80=99t figured out how to get better status/diff information. Wh=
en
> the submodule is at a different version it always gives me "new
> commits" but never "old commits" even though I have checked out an
> older version inside the submodule. git diff gives me two different
> hashes which also don't give any directly readable information. =C2=A0Git
> could check the ancestry graph to figure the relation of the two
> commits: child/parent, parent/child, common ancestor, etc.
> Or is there a feature / command line switch of git which I am missing?

You may be interested in the status.submoduleSummary option, which if
enabled will show a summary of what's changed in the submodule.  If you
don't want to set that setting, the command "git submodule summary" can
also be used.

For git diff, there's the --submodule option, which can be used to
control what information is shown in the diff, and the diff.submodule
option controls the default.

As for just knowing whether the revision checked out is ahead or behind
the committed revision, I don't think there's an option for that.  Most
notably, it need not be either: the two commits could be on two
different branches with some shared history or even on two commits that
don't share any history at all.  So there's not necessarily any answer
that's correct there at all.

You could script some of this with an alias or script by doing something
like this:

  #!/bin/sh -e

  # old value
  A=3D$(git rev-parse --verify $1)
  # new value
  B=3D$(git rev-parse --verify $2)
  MB=3D$(git merge-base $A $B || true)

  if [ -z "$MB" ]
  then
    echo "No common ancestors"
  elif [ "$A" =3D "$MB" ]
  then
    echo "New commits"
  elif [ "$B" =3D "$MB" ]
  then
    echo "Old commits"
  else
    echo "Common ancestor"
  fi
--=20
brian m. carlson: Houston, Texas, US

--oWEYV0WmY9Kcrzh0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX0B6uAAKCRB8DEliiIei
gQRqAP9AuN2qBf5+Sk+OJ+89GaspzpHLkegAxvzS+qVlloZnIgD8DC6kZS/86Ire
f70gf0S+m8P5jD1d1/87nxKXlfpx5AA=
=9KoE
-----END PGP SIGNATURE-----

--oWEYV0WmY9Kcrzh0--
