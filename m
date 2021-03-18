Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A965C43381
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 17:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6B864F24
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 17:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhCRRZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 13:25:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43802 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232350AbhCRRZC (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Mar 2021 13:25:02 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CBD7F6048E;
        Thu, 18 Mar 2021 17:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1616088271;
        bh=reWylKvSpFfTX/g7RMEJPecpQvULeJ3GCCSpPluQ8y8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tFnMxS6n1JBD3pn6CTOKQ3WJnhCtBTAABB1yZXkap+toOmb+hDGwkR2ZGMchhFUbx
         qFYZJhsyUySnhIuNggcW2ed/ZhI2GBOiw1kk5wa4LJnwwJ3Vkcxy0w+e3qzviClAd5
         f8RvGbqF4eOM6QLh2UfyxsRFiMsBSXPHgKSWW5WTRfi95U3QYLZ7XSthrPRX58Ry42
         w0bKj6Pq6VZGe38fhQBXUzo7UGmoBZnsVC7Mcf6Vwu2VTCCAnyO40I7Q6iB6hPhnax
         ppgr0LRqKj/l2VzjHEIV7KlhXor5tK6qkAVEtp9GibusnnWCjc7/oThXd4ePTk/lKl
         MuthYRldT8aUXamHDipllEEY+u43h6pXgoQLGN7YWTy/mI2gHorGXDE0Jbdzod2lNG
         xiNCwjY/jeinP1vRvb1LDFuGFKRGoZPHejJfNKxxDRb9dWUNRNiJ/L4eG871p5hOzK
         f1Yik/cztaUK5ZHWg8CMo6fqkZ4IiSJth+4p2RRnvEqJ9tj5QXM
Date:   Thu, 18 Mar 2021 17:24:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Christian Strasser <christian@avr-fun.de>, git@vger.kernel.org
Subject: Re: Git install crashed nearly whole System
Message-ID: <YFOMylgx9paP5anv@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Christian Strasser <christian@avr-fun.de>, git@vger.kernel.org
References: <8aa7be071abc23371397f72b725babc4e4e90190.camel@avr-fun.de>
 <YE5wFxE5RPew5zrJ@camp.crustytoothpaste.net>
 <b805d53740429a26413cdd4e756db29f95c98052.camel@avr-fun.de>
 <YFOA8ARUwa34tiTl@camp.crustytoothpaste.net>
 <YFOHFABji5/sDZod@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/otedxb8y/3mY6Su"
Content-Disposition: inline
In-Reply-To: <YFOHFABji5/sDZod@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/otedxb8y/3mY6Su
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-18 at 17:00:04, Jeff King wrote:
> On Thu, Mar 18, 2021 at 04:33:52PM +0000, brian m. carlson wrote:
> > If everything's working for you, there's no need to change it.  It's
> > _possible_ to install git-all and not have this problem, but because of
> > the way modern versions of Debian and the packages in question are
> > configured it ends up tending to have this problem by default.
> >=20
> > In this case, it may be that git-daemon is installed but not configured
> > to start, or it may have been removed when you reinstalled GNOME since
> > it's not a hard dependency.
>=20
> Yeah. I think fundamentally this is a packaging issue. It looks like
> "git-daemon-*" has been downgraded to "Suggests" in Debian unstable. It
> looks like this was done in 1:2.26.0-2 last April. From the changelog:
>=20
>     * debian/control: downgrade Recommends by git-all on git-daemon-run
>     to Suggests. The git-all package is a "batteries included" full
>     installation of Git. Automatically running a daemon is not useful
>     to most of its users.
>=20
> So they are already aware of and addressed the problem, but older
> releases will still show it.

Yeah, and I think that https://bugs.debian.org/953875 has fixed the
problem where installing runit (by using git-daemon-run) would switch
the default init system.  So in bullseye, this will probably be
fixed even if the daemon does get installed.

I think the person who previously maintained both Git and runit in
Debian was busy with other things for a while, which prevented this
issue from being fixed.  Now Jonathan is maintaining Git (and is doing a
great job, especially with the next builds in experimental) and someone
else has taken over runit and fixed the problem mentioned above, which
occasionally caused this same problem with other packages as well.

So I think this will sort itself out in the next release, and in the
meantime, just be careful with git-all in buster and older.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--/otedxb8y/3mY6Su
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYFOMyAAKCRB8DEliiIei
gSwUAP9oE0nXgksi6cu97VoGDAHwhm4Hur2ogxTCLC+bTUqXEAD/UriCVor3dU6Z
F8pBZEoUzIMv6TkYogJ7fuc7mgX8XA0=
=6GsA
-----END PGP SIGNATURE-----

--/otedxb8y/3mY6Su--
