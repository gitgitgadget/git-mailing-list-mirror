Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F03771F453
	for <e@80x24.org>; Wed, 17 Oct 2018 22:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeJRGgv (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 02:36:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51274 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727205AbeJRGgv (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Oct 2018 02:36:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AE83C61B72;
        Wed, 17 Oct 2018 22:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539815941;
        bh=9Ym/aUhqZT/tWAPj+Gm44CS1QRnl6IWqqslAs5a94cU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=H3NhH+oz3cKzsvO7xwBvdK4heNsKd6LYfHnERT2A5j3YMaZrfZ7XLYkPwEuVfmulg
         xw0zcB6XfzTaPe9kKP9/1sEeoiVnvKAIwFC+g36D/kztVBCzKf2apC2haF2VYzocd4
         ZoLNCl86koeH0UYORbc8ceY1MTu06/8M425ABJXd19rPNR3HMiJydu7oqnE85S6Kgt
         TqsUH8/xV0noKmZzkafxkOi4evLBfPb9281wp8Wwo4q3SehTjGpqJUB0bEsBrdG+Yi
         Yhg1dz3cCin3octPD7vgz/Xk5GuVzGk/tu4A3zIEZ0yd1OX+MMEkY/ATtsVE6FYHHj
         i/rAa9/AibH8gqf7MufCrPRx2/iI7rycg/xgOOI7cUCdsi88pQgkeTwmMd+6bFs0in
         3ZJN39hRW7XdTX1ggAIxEXKM8qzP6EM8LbOcuvccavrq2zM3aliOhXuUmWyyM8rRta
         zCUi50jU3Yq5n04Rhumi92GcAUyKa/YL9KRon50/V7qyNDj89gd
Date:   Wed, 17 Oct 2018 22:38:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 13/13] commit-graph: specify OID version for SHA-256
Message-ID: <20181017223855.GI432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-14-sandals@crustytoothpaste.net>
 <d7412414-61a0-2da5-257f-f3d9764e15dd@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LlyFhrrzptpgNMGs"
Content-Disposition: inline
In-Reply-To: <d7412414-61a0-2da5-257f-f3d9764e15dd@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LlyFhrrzptpgNMGs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2018 at 08:21:42AM -0400, Derrick Stolee wrote:
> On 10/14/2018 10:19 PM, brian m. carlson wrote:
> > Since the commit-graph code wants to serialize the hash algorithm into
> > the data store, specify a version number for each supported algorithm.
> > Note that we don't use the values of the constants themselves, as they
> > are internal and could change in the future.
> >=20
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >   commit-graph.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 7a28fbb03f..e587c21bb6 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -45,7 +45,14 @@ char *get_commit_graph_filename(const char *obj_dir)
> >   static uint8_t oid_version(void)
> >   {
> > -	return 1;
> > +	switch (hash_algo_by_ptr(the_hash_algo)) {
> hash_algo_by_ptr is specified as an inline function in hash.h, so this le=
ads
> to a linking error in jch and pu right now.
>=20
> I think the fix is simply to add '#include "hash.h"' to the list of
> includes.

hash.h is already included by cache.h, so it should be present.  We
probably need to make it static.  I'll make that change; can you see if
it fixes the problem for you?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--LlyFhrrzptpgNMGs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvHuf4ACgkQv1NdgR9S
9ov2Xg/+K7SVrF5VYXBqBG3yCZ5vsbM/HhXRLgMpu9dfywS2f00MKyacjDaRA25n
XMLnJnavdociaznhV0Evf7GfjM9PmX79DFzei9E81S0bFtPomQUfvJ+iqLwgo93s
Jwl6iSAP0pLvondoCjmEex48wFdUsmPI3IN9ngs3m6/P5bBUrBGszY0apLs8h+XQ
K9g5V613Phi2Kd97Y/OTVL9OPijZ/5hTR0GFuDm+qlgJX/JfeEt15X1MpFRqdBI/
hVHEZgWeh5pjMPnmokOp8PILnLeXsEHl/4VapgfrtOEJJi+DvkJx2jO1cbDYcD4N
FPHTjWvkOveq21N5AY8B85pI4v2yJqsiOt6hIySVNssKN4yZ7A8ppzeolY7cOP1S
kPGNhT7yQfh5pcxVsSbF3uv7WaBg5RrFxwnMaAcxNbDyd/KZVZavNb4jbndui6AG
fl+xMLg0xwfvDflOIqGBqlT/2NBYhHxhsl6pEIumAC5RH0MTlIAprdoWxmqnGMbC
94xgq7VJoSu3y+HctKFZTfDKXTAL7SLRvHzowF6ULFwKlUyMHjyjy3VakqLNEFwM
r6MY2VHyeXln6u1rhCKwr1SeM/WVNbsSZVHX8lPU+K7YtLADO3McrfWN1fDPIoPb
KDAte55GJ4PjSkWQqs8nwNqo3RF3DbklDve/36EKIld1hary0WI=
=zqAX
-----END PGP SIGNATURE-----

--LlyFhrrzptpgNMGs--
