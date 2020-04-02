Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0951C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 00:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2B620721
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 00:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NMYQXyZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbgDBApj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 20:45:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51530 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732385AbgDBApj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Apr 2020 20:45:39 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D070760734;
        Thu,  2 Apr 2020 00:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1585788338;
        bh=B/EwXS70l0WPORrUiMOIpScioy6R9vTFDAWti1EBl5M=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NMYQXyZgUkhzCgNP+7Xnn1B6R2PG4CRN5R5CiJzP/A6qgpfAr7nHYZxupIAecDry6
         +v9hemJIqPDVOPU8AcZUJI5xcbEW2wl158Y+G3xV4GxTONbXOMrLEwSDDyI1w/1ThT
         cm3yIso5r3rlEnLxp9kk0r/Pxk471x5SmfmyNAZb3cmhJoj+5ehbNF1emSr+YcILaL
         EfR4+MkB1A+xyoCkBXN1L2gv+rqzYG06GPym+6P70Ep3GbYTwy7JYnFjsZxbGlxeld
         Ie5WWMqNHjaDXS+R9PKYI9vqxStVKgzMa0jrTCJ5aGKlzlm4qzfD8Diw218SzoaZZU
         +g3WctJ/Y8pIA0IKtVtAsTIMe34SesWW5hYFuXQzyWoaw/alAzELSAyfkIJzpiWP6T
         swDKZvwN4fIxpRLK/d+VaFLVuLYQGhQ1YLKuJrn8fpzJgnooMrQo4G6CkD0wOggj1I
         WosfuxuL6A6xVxi35pebWOwQD7mo9b1jeoOzRBdPJEmPVhAFMV9
Date:   Thu, 2 Apr 2020 00:45:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Doc: drop support for docbook-xsl before 1.74
Message-ID: <20200402004533.GA6369@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20200330094513.GB1735224@coredump.intra.peff.net>
 <20200331192600.588-1-martin.agren@gmail.com>
 <20200401101716.GC60227@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <20200401101716.GC60227@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-01 at 10:17:16, Jeff King wrote:
> On Tue, Mar 31, 2020 at 09:26:00PM +0200, Martin =C3=85gren wrote:
>=20
> > But most importantly: When I looked into the history, I came upon
> > c2a7f5d438 ("docs: monospace listings in docbook output", 2012-08-07),
> > which made me worry about breaking "make info". On second thought, I
> > might have broken it many times already over the past few years, since
> > I've never built the info. So maybe worrying about that all of a sudden
> > is a bit unfounded in a way. :-/
> >=20
> > (I tried to build "info" while working on this. It works in the sense
> > that it doesn't error out, but I don't get anything that looks remotely
> > useful. I've never used info at all though, to be honest, so could be
> > missing something fundamental.)
>=20
> I don't find "info" useful, either. The big thing it offers over "man"
> is actual hyperlinks, but linkgit attributes (the only thing we actually
> bother annotating) don't seem to actually become links! These days I'd
> expect most people interested in hyperlinking to just use HTML.  I
> wouldn't be surprised if there's some emacs integration with info,
> though, so maybe people use it there. I dunno. I'd be happy to see all
> of the info bits go away.

I believe Emacs does have good integration with the info format.  I
personally prefer documentation in almost any other format and would
also be happy to see it go away, but Emacs users may find it convenient.

Junio, I believe you use Emacs.  Do you have an opinion on whether, on
the whole, Emacs users are likely to make good use of the info
documentation?

> I've add brian to the cc, since he was the last person to touch texi
> stuff (though he may have just been doing it out of a sense of
> cleanup/duty).

I clearly see the commit in the history with my name on it and the
explanation seems like something I might have written, but I have no
recollection of touching that code or writing the patch at all.  I very
likely only touched it because I felt compelled not to introduce a
regression (although, as you mentioned, I failed).

> The .texi generated for the user-manual is the same before and after
> your patch, so I think it's OK to do.
>=20
> There _is_ an older regression in the user-manual, though. After commit
> 03920ac69b (asciidoctor: fix user-manual to be built by `asciidoctor`,
> 2017-01-02), the whole front-matter is missing from the generated
> "git.info" file, and there's a funky ": idm4" node. Nobody seems to have
> noticed or complained since then (though perhaps people are more likely
> to look at the manpages than the user manual).

If nobody seems to care very much for the info documentation, we could
drop it.  I've put a query out on Twitter to see if anyone I know is
using it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXoU1rAAKCRB8DEliiIei
gd/VAP9BUYq3Z9HKtO85Zt3ZKABcN4XG2dgXifXbhPMkXMAtJQEAqMkC8S29weAr
cBfEG+mtAQFbfiIfQy511lU0RGrWmwQ=
=BejN
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
