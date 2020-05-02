Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67270C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 19:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B04206CD
	for <git@archiver.kernel.org>; Sat,  2 May 2020 19:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgEBTbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 15:31:06 -0400
Received: from sauhun.de ([88.99.104.3]:50560 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbgEBTbF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 15:31:05 -0400
Received: from localhost (p5486C608.dip0.t-ipconnect.de [84.134.198.8])
        by pokefinder.org (Postfix) with ESMTPSA id 846FA2C052E;
        Sat,  2 May 2020 21:31:02 +0200 (CEST)
Date:   Sat, 2 May 2020 21:31:02 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Kevin Daudt <me@ikke.info>, Wolfram Sang <wsa@kernel.org>,
        git@vger.kernel.org, Thomas Koutcher <thomas.koutcher@online.fr>,
        Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: tig: bug when binding to 'generic'?
Message-ID: <20200502193102.GA1160@kunai>
References: <20200502190433.GB25220@ninjato>
 <20200502190729.GC1838755@alpha>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20200502190729.GC1838755@alpha>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kevin,

> Tig is a third-party interface, not maintained by git. You can report
> issues for tig on [github][0]

I know it is third-party. Seems the README in tig needs fixing, too:

===
Bugs and feature requests can be reported using the issue tracker or by
mail to either the Git mailing list or directly to the maintainer.
==

I prefer the mail option, so I wrote here and CCed the maintainers.

Kind regards,

   Wolfram


--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6tynIACgkQFA3kzBSg
KbZTHQ/8Dc93SZhtRwuu4QC7bH+oCvotpZrK1iN+kBGbYCBxPEuUffTD9oouKKZ1
nL2P8YFqp7TbLDm3V/4n+e3owU1hXKDpphav8FidW7TMZ+vVxYjXHfMLvU2OjECb
s02sevbvo7fnl4mKxNP8X6D0YjO/XbuwjJARqN7S5jPH4w8kAEnb+pasegyx4hDA
cTFgrVxgywgPTXpzttdqHGVmAohaQEaF0yt4yqrAom/yAXfqBWBnkB9gBpstpLpP
gJh/JboKkzFR7fI3L6IMZjMs8uGJlOosohsak5AjDC7iCkbJtGr34in8NYfjZ3Cb
cyq5EExzLh0nsEuugy4HSHS7aVr+AywZglEIMMW68lHr7DBXyxlttHWjNwuW8fca
sihvxtL3UHMiW3Ow1yDcBa/vsNkN20v6KN6fQSC/06ghLgItmPpOSGMSW6dkf5E8
1wQ/wNyajS8tM2iuTlgMPOK3vNgP1GCxA9lEZeJx8zjxPs701W2WA2HvZBH1RbYL
CK+L0SuirW0so+UnF+d3+JMTXr0KEUTjLCmxmR+JFQUJAUcel417KUNYXBu0jGfx
nGXlijHCpIB0f96GI6ijdeBofzbPIGX0qHrCKRN+Pq/RFE6v+8OZao49WBS4Herr
0y32GL1EbWUzhKoGbs/4utoRnimrWgJ+/v8DSfZktWu3tTowhpw=
=LN6Q
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
