Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C07C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 17:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FCD20637
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 17:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XMS/yPHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgCORov (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 13:44:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54554 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728979AbgCORov (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Mar 2020 13:44:51 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8DC7A60478;
        Sun, 15 Mar 2020 17:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584294289;
        bh=RDLT/Yl0wisl0yIihK6ZmqEY+R5qjavfovO27ztZXtM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XMS/yPHXz+FjOd1nsB+WU6XdOlbUVC0BDMMdIr7ovSLmIVl2oA+AK+I8Bi+1IUeP9
         8JE7xfHy70RDrNRyws064jf/Ih7P2LzQOfFwUT43aQvEBkJkyDmAc8VYkQ9o9RNHeB
         pWNqXyqGzbf3w/fQ5K4xtFKLeVKz/o2KRDvSYmY/Y2J6r3EgkcCp0oOe7kcFuMjeKv
         SS2I5E1DiY5zo2JudBinJMRhngzlrR/EWrAE8bCgjvslbTSH2PMod4I+UK1i3LFeig
         t3KsP2faj+0FP8XhDVVogaLrRM4LeoHR9bzNfjvGJNigZ/fiz6B3X5X0Tua8LbThwu
         8qM8iFDMnnK6epMm6dleh1w/kvZkHw49n+76c2jNV4/DERiKCzjhnhuCqtF4PHi6U7
         O5Uf+xQY8vF1bW3gmHLPAeALHz/rGx2x01dXlKorGyMTT7kRJLs8Mm+ZT9CalSzVVd
         ggkEF8HnjvMTaTwDTQ7A/+j1IW910Sy4W4HfmeTruTwDKUTiFOV
Date:   Sun, 15 Mar 2020 17:44:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 5/8] builtin/clone: compute checkout metadata for clones
Message-ID: <20200315174445.GA6910@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <20200310182046.748959-1-sandals@crustytoothpaste.net>
 <20200310182046.748959-6-sandals@crustytoothpaste.net>
 <20200315103929.GH3122@szeder.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20200315103929.GH3122@szeder.dev>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-15 at 10:39:29, SZEDER G=C3=A1bor wrote:
> On Tue, Mar 10, 2020 at 06:20:43PM +0000, brian m. carlson wrote:
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 1ad26f4d8c..00e5427ef1 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -780,11 +780,12 @@ static int checkout(int submodule_progress)
> >  	if (!strcmp(head, "HEAD")) {
> >  		if (advice_detached_head)
> >  			detach_advice(oid_to_hex(&oid));
> > +		free(head);
> > +		head =3D NULL;
>=20
> Coccinelle suggests to use FREE_AND_NULL(head) instead.

I'll do that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXm5pjQAKCRB8DEliiIei
gVHxAPkBmIM5bEqevvcetgD943LiXrz+DtSyqqTZlD48MrgrFgD+Oc/iJDX5SYPU
KN8O05aEXG2H3YR5aE1VCJg3VQYwVAs=
=KG4o
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
