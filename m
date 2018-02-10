Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC0E71F404
	for <e@80x24.org>; Sat, 10 Feb 2018 16:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750880AbeBJQ51 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 11:57:27 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58798 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750832AbeBJQ50 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Feb 2018 11:57:26 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B679760402;
        Sat, 10 Feb 2018 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1518281845;
        bh=DCpnpzrP5Fnc8Chm3RsHeCdJQTbTwHVbifOfWkbMKfk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YXHeXszZkBQQlCYIl6YyykZaWBsIHcMRnDdDs0Nfis9BHbIotl2DjGZTttmJmSI0s
         ADEc/U5LWkZoW8PWW6SHxSNNcqQhda/v6NLtE4mdsFbE+sijW3YQel4Zl4oMqx7MCU
         9wDkFXd8OtLTGTiBW2YNZ4RiO3U3vr7yTLDCbDe29ca0TWC7IZxT6kuoudcxiALkBI
         P5GgucjU2l5e7i9ZOsSUyAMkWDqmpUe/bhrVIb53ylLtG5QZwOyIg0MHH/24i9UKCt
         F1ONNtMwnHMF+eci3xAE9hqvQza0gx5xWfXaYV5H2SfdxQl/z0v0Ba1wKSAAmKW2vx
         BkaJlUBSxV2AD+mh8SSvJUDNo7fXO8gmOlKTvlKdVdDNgxh8td8nvaRIudXM9L7YNJ
         zXxTuv6YjYrLQY9MoB4aNg58HLHBespAy1J1/nANWa/lEGwH20G53DTQN3OZX+sj1X
         HZMnsKFs9mfi+6XKbZj45JowiUERkjbFV7udtMQ0IgBtm/BTZ3I
Date:   Sat, 10 Feb 2018 16:57:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] docs/interpret-trailers: fix agreement error
Message-ID: <20180210165719.GE785098@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>
References: <20180208025614.872885-1-sandals@crustytoothpaste.net>
 <20180208101358.af4ecca9865dca4f04431bce@google.com>
 <xmqqeflvql6m.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
Content-Disposition: inline
In-Reply-To: <xmqqeflvql6m.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2018 at 12:29:53PM -0800, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>=20
> > On Thu,  8 Feb 2018 02:56:14 +0000
> > "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> >
> >>  Existing trailers are extracted from the input message by looking for
> >> -a group of one or more lines that (i) are all trailers, or (ii) conta=
ins at
> >> -least one Git-generated or user-configured trailer and consists of at
> >> +a group of one or more lines that (i) are all trailers, or (ii) conta=
in at
> >> +least one Git-generated or user-configured trailer and consist of at
> >>  least 25% trailers.
> >>  The group must be preceded by one or more empty (or whitespace-only) =
lines.
> >>  The group must either be at the end of the message or be the last
> >
> > Ah, good catch. Maybe "a group of one or more lines that (i) consists o=
f all
> > trailers, or (ii) contains ..."?
>=20
> Your version reads better perhaps because it talks about "a group"
> without placing undue stress on the fact that the member of the
> group are usually multiple---I guess it is better over Brian's?

I'm happy to make the change to be all singular instead.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlp/JG4ACgkQv1NdgR9S
9ouN/A/+Nh1qOguXiRiYd7WekX2XqTJp3hZPiGmBei53YjQ6CNebl519Dxo9P1gB
LaQVUi9CWDPhiwfWbHR3HenzSAneghnSicxnBcGpSL0FuK8wS4Vxj78CRrZgAfgK
j/bcNDW4IVb9z72fb4OggTvrSMgtESD4HjM2f5k2PwwTkxxmf2knlwcSqpRM3X+v
kC1pPnbDZ7wpk+7sQMX8j/lf8JAEDUoXMV3Mw5KftXDDOMaFntixliWtf3AWZir3
Rz5kRSxAsIR6ih1V+DrfBSbzLMGwXWf16kWTp3RDpQRp1fUc5hXEfFG+O2SHnJNw
gZUQY1vOGTkQsZaGkHFaOmaooQgefZQA3s6V9AdJlkf1/gxUYyUeJik92cqo9U/b
XYypz+gqmX5Bsu/vxbpISmv/tdb7nwycRMsmoK4kroo+C8BAkAfdSniEW0Bub37b
SjnIKX+/I2M1+6m/AfvASBwM6NaQu/abO56ZHUJYK8pJmU6dgldqmQd6q8J4FizI
dxan8uJQuRRRvDVdfgmmEpz5Vj5MgRFsz+/L6qG2miAB3o/SJ/9WXXaSbRHLasJM
BfR7kmf/t9phF11xjrOzUxMgOp4vZLqLDqA478+kkYOX/0kID16vpvHLvLFgX9pe
crMfYV2cJSutJHo5UoJF2QNar0yc5snTx4f9TfYvXO2xLw+dkJE=
=+IBM
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--
