Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AA4C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 00:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42999611AB
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 00:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhDQAgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 20:36:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34852 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231997AbhDQAgj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Apr 2021 20:36:39 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 892536078B;
        Sat, 17 Apr 2021 00:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618619743;
        bh=4upg77bf6aXVRrkwAkNb9DDuzAyDy/C0FTXkqqyh3E4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Qc0KTV1e/P4LY4ltabzp0Jm6DxHa+RYEBm23fP/WGRSIlkHSNrta3OtCdYSnRrYDp
         jY20ee6YEzxMUqCW7KYp8F73x8KNseaAOVfZpnyZZV+3SQ5D8CUr7ely+TomX3ptiT
         S4bmmxK1U3u/Uy74k7S0s4hSVKZrJw87FArSRl4rz3gY0rWl9j2Zennh75GF2q9ZsL
         P2tiN8cesDUL51kYNJhNIirwHlTR0c62piFCgOZ0A+KAarCavtvsHlL4tf3Q0Mqs6K
         iaGQKVcaaK8+NOSRiLLHipCpn/m0ekkEpszmkTF8kdGY3/uf/+o72mgHFeq7vUZrMR
         Nc++sLnY80uuBcOzDyE4vy5N1FzA1moBWQlcMojN0DdC2RtH7fRb7+gqYM0A94j8pn
         L4pDEwPu94HW1xvX+oddhAJzfJaeYF/9I+PtossLP8ppIg3c3uigqPlIeYnH13R+94
         2JqEIaq3ApfsXn15SWoySBG7mbSnBaerPLB67ltyFq8u9H6/VmD
Date:   Sat, 17 Apr 2021 00:35:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Lars Kiesow <lkiesow@uos.de>, Git List <git@vger.kernel.org>
Subject: Re: Bug report: gitk unable to handle Unicode properly
Message-ID: <YHotWPe8noZqd9zt@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Chris Torek <chris.torek@gmail.com>, Lars Kiesow <lkiesow@uos.de>,
        Git List <git@vger.kernel.org>
References: <20210416182121.3c824c87@pc.home.lkiesow.io>
 <YHobypuPjLTdjHIJ@camp.crustytoothpaste.net>
 <CAPx1GvetNRBovJMF8tkk9obuSHjC=w9JqryrSTeA0rVF35Q5+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e3vkQxURpg7PAhAg"
Content-Disposition: inline
In-Reply-To: <CAPx1GvetNRBovJMF8tkk9obuSHjC=w9JqryrSTeA0rVF35Q5+A@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--e3vkQxURpg7PAhAg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-17 at 00:01:45, Chris Torek wrote:
> On Fri, Apr 16, 2021 at 4:21 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On 2021-04-16 at 16:21:21, Lars Kiesow wrote:
> > > - Launch gitk
> > >     - Crash (see below)
>=20
> > I don't see a crash.
>=20
> I think this is a Tk/X11 interaction bug.
>=20
> See, e.g., https://bugs.python.org/issue42225 (which has the same symptom=
s).
>=20
> I'm no tcl/tk expert, but I vaguely remember other similar bug
> reports.  They all turned out to need a tk-side fix.

It seems from the linked bug report that this is fixed in Tk 8.6.11,
which I'm using, but not in Tk 8.6.10, which is available in Fedora 33.

So it sounds like this should probably be filed as a bug with Fedora.  I
don't know what their policy on backports is like, but they might be
willing to backport a fix to Fedora 33.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--e3vkQxURpg7PAhAg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHotWAAKCRB8DEliiIei
gdUlAQCB6jne6T/iymmz+W4ZoQbvA/Jj8oIVckpM28RQiCmUVgEAsv542KCJ9b9f
/CfBOcPdX3vVYNoZsb6N0EGCnLr09gk=
=Gfu2
-----END PGP SIGNATURE-----

--e3vkQxURpg7PAhAg--
