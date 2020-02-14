Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C186BC352A3
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 00:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCA5217F4
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 00:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="o5fvFYkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgBNA1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:27:19 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60512 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727594AbgBNA1T (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Feb 2020 19:27:19 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AB52D6048E;
        Fri, 14 Feb 2020 00:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581640038;
        bh=6Y2Bnpz0qk9WDLaUz/zVC42h93GSXd+LxVxX/iHjKW0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=o5fvFYkNHuq340aBsSpFEB1yj6apJ6leb1xw2EmHjLAV8CD/q6AriMLt8SwOxmYuW
         s01AdC1+ApbCFuxTQK1ioZm4bqVG8x4lasBLgpZ5F3ZvuLGssT5bn6t4omNekqX5FM
         xlW4CsFypBrt4GeGqvzPnUe9Qn8FfWPZTNyMHNjpfBZ+WGvyHSvzn12PWRsj0ro6FF
         TgKD23fiF8n5KFcysAPU66tyHP0WvGpnoUDo7nZdrW6JKeQhcGUSzaHzbKTSoXX2V8
         qg//9MgtG9k0ao0E8FrKmb4iMs0Yu7glHX2gCPWYZJSFTtOY7OIFuFftM7nuXQGuFH
         WggncMlEgXkQziobOGQQ7g9RxDJpeWqrwbFIC9ttKDZOcpljNe1qxxOegUSiOkgtbe
         XUrbnyxsn8OQdfw/0Mcfjpg1tmu4HAUqGuNTYac/tydno3Wmeb1Q4D+6Q2X7G0xrw+
         wN31xsfS2JcwriMhdUC0zUZzaltyY2EEXFc67rd/lXpJi1kT/dg
Date:   Fri, 14 Feb 2020 00:27:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?Q?Vejn=C3=A1r?= <vejnar.martin@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: Calculating major.minor.patch from commit hash
Message-ID: <20200214002713.GA6806@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?Q?Vejn=C3=A1r?= <vejnar.martin@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
References: <CAJFfRmt65DV5bZa5yTvg9sDb8SS8dFFyX7Zm23T7mAHL58v1Lw@mail.gmail.com>
 <014f01d5e27c$5f5166d0$1df43470$@nexbridge.com>
 <CAJFfRmt3w60Yq+HS9oVmGtfPMzLeKzFSnkwS7v4_xe+eEWSxzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <CAJFfRmt3w60Yq+HS9oVmGtfPMzLeKzFSnkwS7v4_xe+eEWSxzw@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-rc5-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-13 at 14:54:48, Martin Vejn=C3=A1r wrote:
> On Thu, Feb 13, 2020 at 3:46 PM Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
> > You should consider using annotated tags and the git describe command t=
o derive your release number. [...]
>=20
> I'd like to avoid tags in this case, because a new tag/deletion of a
> tag could change the hash->version mapping and I'd like that to be
> stable.

Tags, usually signed tags, are the traditional way to indicate versions,
and with them, git describe is usually used to describe commits.  While
it is possible to rewrite tags, people usually rely on convention and
social sanction to not do that without good cause.

If that isn't enough for you, then you'll probably have to build things
yourself.  I'm not sure Git provides functionality that finds the
longest path between two commits, but you can probably find the commit
depth like the following:

git log --format=3D"%H" -- VERSION | head -n1 | xargs -I{} git rev-list {}.=
=2EHEAD | wc -l
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5F6WEACgkQv1NdgR9S
9osixxAAwkNt0uH18v+UGy8qSHd+gh/b8KWTRn7wdlsinUD67JcnDwMqzGjN7zE1
hw0rylLqTk92L+WfkyjIj/o6uCZ/swepGkgFJ6sBGvuO4/sr3UtQUNRyY4Hrvqo+
OiEEl1N2mezu1ETGoNEJlnKglZuejsIbXHDKtS9HlzGzgaNfbxerdzmwozEsWZHW
PBLPimSILrBJFhUaxp6QBRpz++/Idp/qHNSv2GHbFECOVCi4LExYeuxiP1cS5/8E
7kkzcU02mtQ/MhVZm4NHpWId5MJpTZUWhgNqmrCAeK8CC5zOHL/ZBEAv5Z2/RHvD
BthmvyLstAt6i9006VwOPitn52QRyj4ODxYOHdG/uhPClB+42QZgydNnw4iRGxNq
xuHiAaZOSgNascWYF6B0ZhhfDu0/gZfqxb3YEL/FhFbT2zlUId1jk3dUpOD5PTPi
qc+056g6iI1y2Rmx2HzA1nefhLWEHNKyC9cNpaY/WOGFsor/GENrvXVuVVk59cLx
KMy42VQyioxHC74S9anblc0B4mC+cOopmeNMNrEy67XOAXqrQcElNfZqdFD55vlE
gyrMeLQugHOcu5zL+hcx9K8unpJH8sx0qOST2HgVD688gVXiq+q1TwfwAgOvtH4v
wjUFbLT48R0uFhcnQCNqOarYfh1Ep3dJS+JhLWkn4Cf/PuauTkk=
=Wx3a
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
