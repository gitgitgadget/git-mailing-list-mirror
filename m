Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FD382018F
	for <e@80x24.org>; Sun, 17 Jul 2016 15:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbcGQPmp (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 11:42:45 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59158 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750967AbcGQPmn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2016 11:42:43 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:395:747d:98e1:fc48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E627D282AF;
	Sun, 17 Jul 2016 15:42:39 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1468770159;
	bh=UzMP0TlVm9nNe1evtzK+psv3b4GhEltdO+BSC67ChiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozvvo3CNSQ6gfL16sXudYuJqa3/pyMYu7zL6+uf2q0iE4pPms5m9qVEK+jLEqpN5S
	 awxF2Ed6CnnKBs98XqBuSZ5QgHaiFeKtskMSZfhsr2itY3vFm1kKxvXiZLmP5NUXO/
	 E5gS1xHzDfx0ndvdSbVaDEI4G8o5AB61M8dUV6yRJ1Gwhs2DAO+6VNhUyGlsJkfIjz
	 heal7e0lnw2gsNQdbVlC+qseh2FqpMbTgB3jcoVjSjKNDoZL3GhNjF6Z0WzYHMCuam
	 1Sfk+/IpJg4d1p+0xgdvwbgRToELdLcJzp1dFSopVjYLgaRT39evePw9gaCDN4mjqY
	 TqtZvImCoL1PayErJf6niYCxed1xEjDqFQDLmFLAm/T0rEr9GqJXmOSLGEd2Fve1i8
	 Rd2OhrR2rZg5uQzSJqSr+SymClJowmm/9Whk+z8lXnGUMciltM+KOtqJpagd5rkgby
	 n225NDLPZT86Feb27m17zz+urKEP7tCrogGFzNGBVE9YRdDqIVI
Date:	Sun, 17 Jul 2016 15:42:34 +0000
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
Message-ID: <20160717154234.GC6644@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net>
 <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
 <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
In-Reply-To: <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-rc4-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 17, 2016 at 05:19:02PM +0200, Duy Nguyen wrote:
> On Sun, Jul 17, 2016 at 4:21 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On Sun, Jul 17, 2016 at 10:01:38AM +0200, Johannes Schindelin wrote:
> >> Out of curiosity: have you considered something like padding the SHA-1s
> >> with, say 0xa1, to the size of the new hash and using that padding to
> >> distinguish between old vs new hash?
> >
> > I'm going to end up having to do something similar because of the issue
> > of submodules.  Submodules may still be SHA-1, while the main repo may
> > be a newer hash.  I was going to zero-pad, however.  I was also, at
> > least at first, going to force a separate .git dir for those, to avoid
> > having to try to store two separate types of objects in the same repo.
>=20
> If it's just the external hash representation, can we go with a prefix
> <algo><colon> to identify the hash algorithm? For example
> sha256:1234... is SHA-256 while 1235... by default is SHA-1 (but we
> could switch the default to SHA-256 via config file later SHA-1 is
> dead and nobody wants to type sha256: every time). It catches
> incorrect hash algorithm references.

I'd make it such that the default is that of the repo.  If the current
repo is generating SHA-256, say, then 473a0f4 refers to the empty blob.
If you want to refer to an SHA-1 object, then you write sha-1:e69de29.

On disk, multihash[0] seems like the right way to go.  We'd serialize
references to the SHA-1 and SHA-256 empty blobs as
1114e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 and
1220473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813
respectively.  This makes parsing significantly easier.  On disk, we
could write them into the object database as 1114e6/9de2=E2=80=A6 and
122047/3a0f=E2=80=A6.

We could implement the default hash algorithm as extensions.hash and the
on-disk format (which would be a requirement for extensions.hash) as
extensions.explicitHash.

As I said, I'm not planning on multiple hash support at first, but it
doesn't appear impossible if we go this route.  We might still have to
rewrite objects, but we can verify signatures over the legacy SHA-1
objects by forcing them into the old-style object format.

[0] https://github.com/jbenet/multihash
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.13 (GNU/Linux)

iQIcBAEBCgAGBQJXi6dqAAoJEL9TXYEfUvaL69kP/A/TDWnnc2JmJFYV4pNpFtY8
CmqIP8Z47fvDYz9HA3XdgTLbPxk+RVnZ7QTf2Y868RpIfpC09Tdafkiq57kzC/RG
DWGKkl2jCl6QMezZkut1u8vBoIjk5Ds2/FfY7CIZlFbCtsOrRYh0WzUGn4MG90iB
Bbw0Y83IW0cKCv7EXdTjogKg7cFeOfINszczsGkY2cqdgcP/FO1hEdwdhoujmRbM
K2kp+NQzebxYZbaybhb3DRRoqK7yfNpGsnxeBvrCi3ocFfdziSmZ2ZhZS/tCADVH
ycpfe/6QRT21mI+23FzJW3M+6pnqomXwP4np1WDyZBem7dj896TRWPQbdVoEBfw4
5+wfzUlyUglE7RO4KveqfB7uA2ON/PWnZaJW7lOoYCZLrvoxzcIHdub+trXSX1qp
ZHRLLOEBZlbpUWFwfFBLwu3y0e5D7JcqPBJAkvKJlUgcIIy50jAN05TILPkOe62o
1sw3U8DkqiYxOyS+63ScWh2nrp/zYPdl5BMmEDb07aT+oRN5U4MJ47t4JlDs1aRt
YQrIjjdWADWMS89dO0qwyp1ax+B8Djtxa7CUg/yU2oPWGDHb88h5khZegH8ISOW9
av/Is05Q0GtZ5aW7n0hlf3DubJAtnmskN0zHQSWjTAzxr5JyZk3pXml/Ifhg0hXI
5oRjqKdgH7CRwHLdGn4D
=fgCJ
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
