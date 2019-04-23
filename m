Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 829A91F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 00:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfDWAAe (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 20:00:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35566 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729094AbfDWAAe (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Apr 2019 20:00:34 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D702460458;
        Tue, 23 Apr 2019 00:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1555977632;
        bh=EJw+yrCZo3wBRn9mRhjxh+fSQtKsIb0o0YvRhdEjNJ0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=DUvNWvHIBrWRP2HL7iDYLz0N6boS3hb3CSn8bIX+lgtC1TcjBF7gNFDoYZ/nuY4LC
         3lcvtmj4C1r8E4kHx03mgGi3UHWoqsDIhSl0XAPvLUlftWnBlL45bhlyPUxyl21rkE
         l+bWZQCeuKft0NrPTmrVYFoQiaiIoLyChqVNuIYyx1duSR92FjRYHFA6kZcUqugPD6
         AosyTo91O+6nB7wkjSDs1UpMII3VJV9vph4wVPHrNWZlVDO0FmNUE1EzVYkB5L0ty+
         F6GfFkMk7zj0GTFyN6BnlY23y592uhl871+D/iqK+dzW7qWLqVo/bPd4yrhRYLHpq7
         1iw2k+uZEZ15Aie3GMPpdacLWSfCQLIYe0a29uK1T4T4ohN+vVWnyQv4Lb9aVicjK9
         aP/kiR+MKc4fDuv/QH2WHr/kuttOO7rYXdtvtp4H+ptYlwi7uEQZshVxNpg9OOYNTZ
         3BFXF8PxaiYdh3QNrF+to8Z15AMTXJFyvwIC+ilT9WgoJMQfMEL
Date:   Tue, 23 Apr 2019 00:00:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Santiago Torres Arias <santiago@nyu.edu>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.us
Subject: Re: [RFC PATCH] builtin:tag:verify_tag: allow gpg output + pretty
Message-ID: <20190423000026.GE6316@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Santiago Torres Arias <santiago@nyu.edu>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.us
References: <20190412201432.11328-1-santiago@nyu.edu>
 <20190422152726.GB1633@sigill.intra.peff.net>
 <20190422154655.sxyrkee7rnywoh2w@LykOS.localdomain>
 <20190422160211.GB9680@sigill.intra.peff.net>
 <20190422230701.GD6316@genre.crustytoothpaste.net>
 <20190422232627.3mw3rejbjp5tb7zy@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OzxllxdKGCiKxUZM"
Content-Disposition: inline
In-Reply-To: <20190422232627.3mw3rejbjp5tb7zy@LykOS.localdomain>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OzxllxdKGCiKxUZM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 07:26:29PM -0400, Santiago Torres Arias wrote:
> On Mon, Apr 22, 2019 at 11:07:01PM +0000, brian m. carlson wrote:
> > On Mon, Apr 22, 2019 at 12:02:11PM -0400, Jeff King wrote:
> > > On Mon, Apr 22, 2019 at 11:46:56AM -0400, Santiago Torres Arias wrote:
> > >=20
> > > > I think that would be great, as we could make it simpler for verifi=
ers
> > > > to parse gpg output.
> > >=20
> > > Alternatively, we could make it an option to dump the --status-fd out=
put
> > > to stderr (or to a custom fd). That still leaves the caller with the
> > > responsibility to parse gpg's output, but at least they're parsing the
> > > machine-readable bits and not the regular human-readable stderr.
> >=20
> > Don't we already have that for verify-tag and verify-commit? I recall
> > adding "--raw" for that very reason:
>=20
> I think this interface only shows you raw gpg output, but not any
> --format=3D specifiers that you may want. The idea would be to support
> both. Or am I missing something?

My response was mostly in reply to Peff's suggestion that we have an
option to dump the --status-fd output, which we have. I think that
behavior properly belongs to verify-tag and verify-commit, which are
plumbing.

I'm not so sure that it's necessary to have the --status-fd output in git
tag -v, which is more for interactive use, although I don't feel
strongly about it. I think of --format as a tool I typically want to use
on multiple of something, and while it's theoretically possible to
distinguish multiple signatures by GnuPG's "NEWSIG", parsing multiple
tags' worth of output between standard output and standard error is
going to be pretty unpleasant.

As I said, I don't feel strongly about it, so if you want to implement
it, feel free.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--OzxllxdKGCiKxUZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAly+VZoACgkQv1NdgR9S
9ovkog//Z3zOpX5Ar66fggdK7+uFg1EdCRd+colWbi72qvT5LzBDYHC1KG7QTgCA
GyWXjDIT/Cby31iFohquGf4Fezw39JxViQEaTC+ftICtARe+ooGPcSibV0tnXwvg
jV22MEYIQkgl/AUU2unROXOTaKqDiDiRI9HJpFT0LY11DVyUH2apBfOUOvemRdG1
L2Ol8qOrCGyx3TjcPYUoTHa2u3LVkGAC8sY/mFKU1+ZLkBeSk9eHdAS8q7ga8y3w
+R+QzHL8RAHeNJdXEpaZypvqdwqYBktqZIyjOW88HFJzzWzYP4l07Iki72RavQWY
gyVJIreOBRPe4hLUyuwRkNQiC2I273DwwmbHL+c8CkV8vDysKwd2VeYgpZ3I7iZB
m+ytyLFKmalvC8rGp5s5iqsQvzPSNPpAgRzy2ovfntWi1eENDte5PEX8ZtKwoF15
h6kWG9dIJbV7Bt9G34fr8oIfIjh1LwFdbhzpxx/MfR+kH4ksgrfJgNqVtg0sVKPr
THmUCZYt6mwz0YEv1JBDpR3E3j2Sn10ZmR0i6bwCcdZix7PHP8FAImPvOIKVjjl7
ma9pIB3vfw+hnoVy0go4D10qflGkmLER7sbU2rQAVALepe42J+mu/2YBsXZuqmVo
U/jPyULvrZo6XerPzj+BpoDWbTqRqMB+ScPhKvxGZ8P2jjiM5yY=
=CQYa
-----END PGP SIGNATURE-----

--OzxllxdKGCiKxUZM--
