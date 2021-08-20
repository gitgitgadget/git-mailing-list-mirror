Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDC4C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 19:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18AE461102
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 19:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbhHTTPY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 15:15:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47118 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhHTTPX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Aug 2021 15:15:23 -0400
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E37B46076A;
        Fri, 20 Aug 2021 19:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1629486885;
        bh=xe4Qu9aHnEYTc7O5/7cLCItN9f4LuBto7LI1hjk56kY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NQ3CXym8HbcYBRKllPiwAxkuNEqKG38XaGKOYNv5kkbP/hzirMYktROSXz3+AhMJU
         JRKvGNuK4U73DOieCHWM6b6AuSpAWw+jOsaKPCfQnwyE8XAz84MoObHVWNAcg0Ok8w
         rUdaaAeEUz+6RBthMmb0lfRU6uj0AL5X5IHxasvB44dDaMlYIZn3/5gfQv7UhSpBAf
         iVKD0DTMBODwQEbTiyXQYfc9iwdfIH329yMg25x/uPJT8OQ8OYh3U2L82dMWemBc+j
         aXJik0NicM6Ii0OcdpI4lVTI8EDXSvM+EBFq0vJIbbg0AjYR8ePjvaACoFoSVNvqyE
         VLEATPvKeVA5dt7JQIbxUROE1CV+BDxqxtoIQ2rXc2xtmHSFI7+QOyMkuB6gNEoo3J
         1tkidPYvSYJrn8ODezv1c0NyYfoIErYR+u4PbhthRAQ3DbxLuUDOW48kvLX8LSdgJV
         2llca3mRnG3JielOPoyqlt43jzNXDqNAOdHq5OGBsOrgmJM11+G
Date:   Fri, 20 Aug 2021 19:14:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathon Anderson <janderson@acesquality.com>
Cc:     Jeff King <peff@peff.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: Git Modifying DLL
Message-ID: <YR//IDB9ml5RO2H6@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathon Anderson <janderson@acesquality.com>,
        Jeff King <peff@peff.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
References: <CAG83euoGmVUUBh00wAEX1muZogNPOQUV6+ppL8x8qCaDnzTbDw@mail.gmail.com>
 <010f01d79525$f10a1f60$d31e5e20$@nexbridge.com>
 <CAG83euo2B4QFU_S6Yqd3UACWq63p=L+T30CwzT52D8H=S5pRVg@mail.gmail.com>
 <YR/tyHWQ6+2sP2iA@coredump.intra.peff.net>
 <CAG83euofNXHx8-=7Obj-Ju5U_fjwNBuLVJjmccVhe9bqRFyBiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EhA+EZh23EjLip+f"
Content-Disposition: inline
In-Reply-To: <CAG83euofNXHx8-=7Obj-Ju5U_fjwNBuLVJjmccVhe9bqRFyBiw@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EhA+EZh23EjLip+f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-08-20 at 18:47:02, Jonathon Anderson wrote:
> On Fri, Aug 20, 2021 at 1:00 PM Jeff King <peff@peff.net> wrote:
> >
> > On Thu, Aug 19, 2021 at 01:21:03PM -0500, Jonathon Anderson wrote:
> >
> > > I had not. I tested that and it worked. I assumed that git would
> > > automatically treat dll files as binary. Thanks for the help!
> >
> > Git doesn't know about any file extensions by default. Its default "is
> > it binary" test looks for NUL bytes in the first 8k or so of the file.
> > I'd expect your DLL would probably have such a NUL byte.
> >
> > Is it possible you have other .gitattributes set which are confusing
> > things?
> >
> > You might try:
> >
> >   git check-attr --all <path>
> >
> > or:
> >
> >   git ls-files --stdin | git check-attr --stdin --all
> >
> > -Peff
>=20
> When I remove '*.dll binary" from .gitattributes, I get this:
>=20
> $ git check-attr --all ./PSWindowsUpdate.dll
> ./PSWindowsUpdate.dll: text: set
> ./PSWindowsUpdate.dll: eol: lf

Yes, this is definitely not correct.  The flag "text" being set tells
Git to do line-ending conversion and "eol=3Dlf" says to convert line
endings into LF.

You should look for things in your .gitattributes file that say
something like "* text", which you probably don't want.  You could use
"* text=3Dauto", which should be fine for most cases, though.  It's also
possible those aren't in a .gitattributes file in your repository but
one elsewhere on your system.  You can check gitattributes(5) for the
locations of other files that can affect it.

As a note, it is best practice not to check binary dependencies or build
artifacts into the repo.  Those are best stored elsewhere, such as an
artifact server.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--EhA+EZh23EjLip+f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYR//HwAKCRB8DEliiIei
gc10AQCwitNxMD4CHzqFwfVT37g9FFJwmaXdx0loheM1cD0xGAEA/pvnLQspPsAh
DI9fvC9CRRIl8qL5Hm2OqmRqliia5g8=
=6cb6
-----END PGP SIGNATURE-----

--EhA+EZh23EjLip+f--
