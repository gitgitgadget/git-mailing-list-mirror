Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72D0A2055E
	for <e@80x24.org>; Sat, 28 Oct 2017 16:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751310AbdJ1QnA (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 12:43:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55528 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751273AbdJ1Qm6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 12:42:58 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 173416044A;
        Sat, 28 Oct 2017 16:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509208977;
        bh=RD9ErY7lJFuDNr99T40kFSTWWetBRb+SbME64pEfuvc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HcB9LcETJzsM2/RsdxnubDsKn51+RisOZhBFR/7o0giDyK8GhC+W6MwKvIBlI4cry
         nq2yntU7ls85CCL3mmUY2kQAMDvmRMu1FrkXeG2pOBdOBGQazJvv1K+8ZlRSUaYPO2
         dku+gm2DV69A72iSh6KOHnvXkHLf5vPujlB1IpSF1sAmhzRvvF1d3AMjkZfRPoqc1Z
         gIwQKPpAH6+DXGhBbsMbWYk/TUHcrYhnPnsKXiSrI22ud3yhCkoQtVbA3vUNZvHKpf
         /i8znDqS50WIgOQ4Xdo6FRXIPEZjUELlYVPgTgVOI+N0RI2oCLUJanxRnJYUAdZO3T
         2Cg19DLwk67oFrGRZO8fjLn6W/xxZw87nG79hQ6fSZR69H23vJCr2mw/uVnzyniNNQ
         I5/+0xyRbAHEKGOKWfq1QK2E0GNUmfhoR6kkqxg9EmulR6L1J8pA0ptOC5n/zAWYDn
         EKjGOse/Coz2G6ZH/VnK3AgYmgmy87YZz9PYo6HuiV+3Rwt4zd0
Date:   Sat, 28 Oct 2017 16:42:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] t1404: add a bunch of tests of D/F conflicts
Message-ID: <20171028164249.ufro5weobwadfonv@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <cover.1508856679.git.mhagger@alum.mit.edu>
 <be088bd57e61f4ea0dc974a65829a928ecd30534.1508856679.git.mhagger@alum.mit.edu>
 <CAPig+cRLB=dGD=+Af=yYL3M709LRpeUrtvcDLo9iBKYy2HAW-w@mail.gmail.com>
 <20171024194634.pigmvgoqtdexvjhc@sigill.intra.peff.net>
 <e66694a3-98e2-33aa-4cdd-dac41d2a89d5@alum.mit.edu>
 <20171026063250.dckc22ocr3zjmsxv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6jghv4vcronzk53"
Content-Disposition: inline
In-Reply-To: <20171026063250.dckc22ocr3zjmsxv@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.13.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--d6jghv4vcronzk53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2017 at 11:32:51PM -0700, Jeff King wrote:
> On Wed, Oct 25, 2017 at 10:03:09AM +0200, Michael Haggerty wrote:
>=20
> > > Yeah. It's supported by dash and many other shells, but we do try to
> > > avoid it[1]. I think in this case we could just drop it (but keep
> > > setting the "local foo" ones to empty with "foo=3D".
> >=20
> > I do wish that we could allow "local", as it avoids a lot of headaches
> > and potential breakage. According to [1],
>=20
> Agreed.

This would be useful.  Debian requires that all implementations that
implement /bin/sh support local and a small number of other features.

There is discussion in the Austin Group issue tracker about adding this
feature to POSIX, but it's gotten bogged down over lexical versus
dynamic scoping.  Everyone agrees that it's a desirable feature, though.

> > He mentions that ksh93 doesn't support "local", but that it differs from
> > POSIX in many other ways, too.
>=20
> Yes, the conclusion we came to in the thread I linked earlier is the
> same: ksh is affected, but that shell is a problem for other reasons. I
> don't know if anybody tested with "modern" ksh like mksh, though. Should
> be easy enough:

As far as I can tell, bash, dash, posh, mksh, pdksh, zsh, and busybox sh
all support local.  From my reading of the documentation, so does sh on
FreeBSD, NetBSD, and OpenBSD.  Not all of these are good choices for a
POSIXy sh, though.

ksh93 will support local if you alias it to typeset, but only when
called from functions defined with "function", not normal shell-style
functions.  I have a gist[0] that does absurd things to work around
that, but I wouldn't recommend that for production use.

Solaris 11.1's man page doesn't document local in sh (which is a ksh88
variant) and ksh is ksh93, so it doesn't appear to support it.  Solaris
11.3 documents bash, so it's a non-issue there.

It's my understanding that using ksh as a POSIXy sh variant is very
common on proprietary Unices, so its lack of compatibility may be a
dealbreaker.  Then again, many of those systems may have bash installed.

> > Perhaps we could slip in a couple of "local" as a compatibility test to
> > see if anybody complains, like we did with a couple of C features recen=
tly.
>=20
> That sounds reasonable to me. But from the earlier conversation, beware
> that:
>=20
>   local x
>   ...
>   x=3D5
>=20
> is not necessarily enough to notice the problem on broken shells (they
> may complain that "local" is not a command, and quietly stomp on the
> global). I think:
>=20
>   local x=3D5
>=20
> would be enough (though depend on how you use $x, the failure mode might
> be pretty subtle). Or we could even add an explicit test in t0000 like
> the example above.

I'd recommend an explicit test for this.  It's much easier to track down
that way than seeing other failure scenarios.  People will also usually
complain about failing tests.

[0] https://gist.github.com/bk2204/9dd24df0e4499a02a300578ebdca4728
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--d6jghv4vcronzk53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAln0s4kACgkQv1NdgR9S
9ossfxAAov0BXplysAPxFGnGKuevokxlORrjPfqbZmPPoPilHCJlX6YnxnryBX7N
j22iDD0p1odnqifkrdSvcGcRxjQYuhK8B1xXoXzmsBIUdk2t8ON/iwNM9epmGUve
FjYMRNu+NkKzQIohUgbGlbPbENcp4WDiEP5VyRbTxLzNwlrpLnrIVP3UNcTIl7kb
bVPOuvDTERY+Zu7zlmteuCTWVnun51P7OGW3Bx3uXMEwLL7FKt/tDShcJ6mO1c+I
cRayH99mxpeh+jfuc3Klxbd7v9t6/WNphr61lnhb/i3NFFPSDzfe9GkyTerv8ciL
I08al9DY2UdMAY70+mb3Ne/xJCF1oCvvhWQfRzAAnoGh8Drp4JJeu8+1AXECPwLI
QXocScHcnR9nBE57QA0Z1iKkuzO0/7ewxwbVteJ3DCRWrf21ZDgDRLBqNGeRyTX5
kxZZQlm9vmT37AyJDxtgIrD33cMrGlyJyQ7qJlH0Y8lpwueEcDIEqpk5CXwZKnOI
Fb7aJGSLXrUW2+UMAufB7dQaT10lCv6xe/us1YgOOLxL9zeqXTXOdYW2UGUrsG0u
seqKl1foOiODNPj+yePSf9Vb0HGvz1z3YD7Ci9Jcm5pwZgFDtTZRBvAo57YQ8QTc
n6Yk5NSRUR9qiCbuGObMAbyTg57ISp/fTdOcR/T2sX6kNTz4tKg=
=GnUt
-----END PGP SIGNATURE-----

--d6jghv4vcronzk53--
