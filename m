Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 528451F454
	for <e@80x24.org>; Wed,  6 Nov 2019 02:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbfKFCTm (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 21:19:42 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33514 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730426AbfKFCTm (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 Nov 2019 21:19:42 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8ED3B6046C;
        Wed,  6 Nov 2019 02:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1573006780;
        bh=pKnZ3mHtcWaaSLML2VPu9C4uD1kC2XU7xlcSZcSwT8o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=DPvygv+sPQ5q5+SwBTBk88wp12JtLmpKkq1bYwYix22sI3ED7+8DEsoOoJZyRTZqZ
         VISomnyUmSuHOe4udI+czKQq37TqBbc7EgCnacg0oSq5YVxgv7wvkEu1ptaWOzCd9V
         4yHayAPxMytInt5tMQXGTKX+HT/YfUK5WnOjwLv0709Kms+9m+nrJnvJGGxMPsA5we
         rmx4laT6dzxVF3uxeXcnLGw6E3M0aY2RGkVHkRGvsVCtsNAtaNBZ8hetifUmBz4Dq5
         ReE0C49sgzFkV5WtmRl9ClYYu3D7zotxDfHW1CjKvkeMAZMQ/kW6aXG6e9fKUb7OFu
         b/H8OwPxxF80p63hIziDncOhurc5M3zu8HJlnBE1S4C1d+LBepkax7F3FwYi0CX0wF
         4qPcPL1EPtvBb+jTsIVSxLk38IXBLxNOeq1g0pfsLBN8g6wGjwyu0rZKDYV8zNFfhu
         8koqkxSzzBm/Vhc3F/EyFMlgIleyfEt/nxbVRNZw8GvhvII3zvs
Date:   Wed, 6 Nov 2019 02:19:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Documentation for common user misconceptions
Message-ID: <20191106021935.GF32531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
 <20191104222634.GC22367@sigill.intra.peff.net>
 <xmqqsgn1wyt2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
Content-Disposition: inline
In-Reply-To: <xmqqsgn1wyt2.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-1-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-06 at 01:58:33, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > Thanks. I think this is an improvement over v1, but I'm still a little
> > iffy on some of the other movement in the first patch.
> >
> > TBH, I don't think it's making anything _worse_, but I think it
> > highlights how some of our documentation is a mish-mash of low-level and
> > high-level details. ;) So it might be a good opportunity to at least
> > clean up the documentation around ident environment variables.
>=20
> Yeah, I hate to suggest another round, but agree with your comments
> on 1/4 wrt the way how and the place where the environment variables
> are explained, which invalidates the changes in 2/4.  Fortunately
> 3/4 and 4/4 are unaffected ;-)

Yeah, I agree another round is warranted, and it's not the end of the
world: it'll get into 2.25 either way.  I'll try to get a reroll out in
the next few days.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl3CLbcACgkQv1NdgR9S
9ouxuw//dSe/N3NOpZiDntXzA8yP+JcO1V43DM9eBtImUYE2jsB2gTmfqkOeaPcc
9+B5cYsB5nxJuVhurH8AQiCP0M03ZdDJxT/5b/LJ1OFnGE19bRKHBAFxtj5GMlNd
R6GLrs9tLg4+k46CkTaeMVEKj4+7Txo/GG2WXUNBnMx2kfswMKh8+Kpbc9wajkI9
wJsyIuSTLDa05OZ4V04UYRsT6AkVtVi6FrWwlT1RF5++j9iqYvDe6cvTgYSbsWaE
ZmDrbnIDlQU23cZMfUdVLXnDhgkF4KNb8xayEzxmv5avGHOQdS7uNDk2a4p1045i
cDzEXXhuISRRmRAAZdFDsijrfW/HUEyS5GaJvOB/DFufXyyDBqekp3zBZfkSRBRy
Z9UOxKp2qpPKOBjsxIDgUUwBCAjdsNoQ5aD8rpK8fGyqRB6j1aU6MOagEp7oqj8U
9naOs8XiA8LzGIhcTNEaFN5mfraAI7rj6iWf/bzLiR+N/JX2ZojH/xzlLkvQu1/i
tfgemndbd42CkfDovkHk2U6djibAFMNIQvPGb8Rp3herpPCEApdaUXvBNTG3mjCn
8oKLRxlVqD/78AGuYHQgTPcbh+gSnumGR+Xtg5DoEIOmCCCWPwtx3ajZabXhfCwQ
K5MocSlQ9SGobVogmVFvAuROiknxEcVxWjIc725gaqgjS6ficJE=
=JPpY
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--
