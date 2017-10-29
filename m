Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20858202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 16:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbdJ2QMP (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 12:12:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55628 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750929AbdJ2QMO (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2017 12:12:14 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CE78A6044A;
        Sun, 29 Oct 2017 16:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509293533;
        bh=oAI2xiSIoPhOg0PbrCP5gDiM1Wx9ggAgntjE6ZTvk+E=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uloKeEOR+MHzjcVyUdTZKtDXAIA6073ndUzA+cKAa71IkpPCpzt+O66K1Sg+cf85M
         gFegkKPd5f3/m4062bUin1AmhB4FeZnfKNwmpgwwEowl0uzMTQOf+riP+d+eb0Ss98
         W12eRWQTKg4WNBS9cSE9Fz9z/1t2MtomndlA/jWthYVZDvjBLL2A4DPrF7fWzbxB9P
         juvcXeIqngAj0SRq+xpVivbmy0PdHI4bnNR4jtyxS8CbxprhzI2ogw1W7HabO5TAUz
         Z+Wzm2twqDI9j5Zq5rJxUrtRc6i5YO92RcLgpPfSr2qcTD5LjuQ9D3iXMkWEFk50wo
         lAf/+M94XYfAjCyF4rBbRK/XJL0BMjOzgZui2K3uPPN9vfL5ENgh7zGTIIQ2vfQ/lf
         xKBlj/al98LQquBPk8mEwre42Xdt+GMdu8SgQWipM6ZcZ9BnivC+PVq24DqSxKgoeG
         znMSVzmMWNzBbtxqPtGpoWvahbZLQQCNl3/B4ue70WPq3hQML2G
Date:   Sun, 29 Oct 2017 16:12:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] t1404: add a bunch of tests of D/F conflicts
Message-ID: <20171029161206.soieyxfiru2fvi7j@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
References: <cover.1508856679.git.mhagger@alum.mit.edu>
 <be088bd57e61f4ea0dc974a65829a928ecd30534.1508856679.git.mhagger@alum.mit.edu>
 <CAPig+cRLB=dGD=+Af=yYL3M709LRpeUrtvcDLo9iBKYy2HAW-w@mail.gmail.com>
 <20171024194634.pigmvgoqtdexvjhc@sigill.intra.peff.net>
 <e66694a3-98e2-33aa-4cdd-dac41d2a89d5@alum.mit.edu>
 <20171026063250.dckc22ocr3zjmsxv@sigill.intra.peff.net>
 <20171028164249.ufro5weobwadfonv@genre.crustytoothpaste.net>
 <xmqqk1zebyxz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yg4x726z2f4mcla4"
Content-Disposition: inline
In-Reply-To: <xmqqk1zebyxz.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.13.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yg4x726z2f4mcla4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2017 at 09:05:44AM +0900, Junio C Hamano wrote:
> In short, unless you are a binary packager on a platform whose
> native shell is ksh and who refuses to depend on tools that are not
> default/native on the platform, you'd be OK?

Yes.

> > I'd recommend an explicit test for this.  It's much easier to track down
> > that way than seeing other failure scenarios.  People will also usually
> > complain about failing tests.
>=20
> Hopefully.
>=20
> Starting from an explicit test, gradually using more "local" in
> tests that cover more important parts of the system, and then start
> using "local" as appropriate in the main tools would be a good way
> forward.

I completely agree.  I just wanted to ensure that if we failed, it was
at least obvious to packagers who ran the tests.  I'm not sure there's
anything we can do if people don't run them.

I do think people may run the tests more frequently than you think,
though.  I always do in my packaging at $DAYJOB, but any failures
(usually missing SANITY) tend to already be patched by the time I get
off work and write a patch.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--yg4x726z2f4mcla4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAln1/dYACgkQv1NdgR9S
9ovVgxAAgLHok/LmCGbnCFa4tGtaCwVRnoIWUFMNsEDasZ+lpRW6YGzZrvpe9haa
UbQgpypo14m+QIHxvFeh/MtglSCGQOJEun7w7YvfqUPwiwTJBfmMrwbRqGiwO/Ab
aYzrN3zkDK9ZlEOTRmRfwKSxxvoHC335e/euHDwqw8f5GQybW9CE7hmNrilUGpOE
Z2rJCrRBLaOTBnVOvoz8ThilSK7uDJboKSCkj+3nf3nupaJwObQfYDe3IweKQ/Ac
RLkG+iqnAFNTI7tmcfT4h7GsgQ2iqpHORp7rnEsHLs/rGyUZ4Lj3sBP+nrym79y2
gKciHLYRGyNaLqXM+GWXSfSptDCWjY2L6AZeFuahNqEcjYzz6dUfu5H/LnIAbPIX
bdGWaUsOwQ+9Anr/jZj6UIvcVmrcqyDNpcumLrCu+1uQw6MttWz43SsFfsSmfwNQ
PyfjV8RkM4hi0ckXJgoaz+NWrxLqVU8ND3W8beMnzQF+8tILp+E8OQ0ly4G7gjrT
OMvg8r+rcn47TWH47N5Tf+fIxzjsxmdQSgGJGl4P1zNEzgIF6pm/202/wdFD9rDQ
dftAxD5vqpkwFsCRdPLEYyE6C5vXRyCqDEUz6Gm9Q1/DeDpXqyPnP4vfxjtUi91S
A5qhFQrHHjPLlse8VfdyLfNiTLJJQv5ZHFlwXRoju+W7S4ykd10=
=aebz
-----END PGP SIGNATURE-----

--yg4x726z2f4mcla4--
