Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1AD51F516
	for <e@80x24.org>; Sun,  1 Jul 2018 17:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965936AbeGAR5R (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 13:57:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49696 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964971AbeGAR5E (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Jul 2018 13:57:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7872:b1da:4747:5087])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0CC2960102;
        Sun,  1 Jul 2018 17:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1530467823;
        bh=kNTxYQD8mMGHha28xjNBgoAMXewGUILNCKIBX5y/KUc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XmHbga+lLOlyvEQyG/uft9sULATJ5wJ6huRDE0/xodNO3ON7tqIDHYdLptJFgjKZy
         oOeWOUp8aOUrjAdsmxBY4xwx9B8YQ27ksircX5gTzB0NPW5b5DUvJRvW9Th+cLOo5+
         a3Nm1ZkgJ2mzGsqj+yWw/w30eYjC/9mJMv4k1esVJFo1VGeD+3VrD7qyxDV3e7s1li
         Vo01cSL4QPwyx1rCmJz1d++pdWpEE5s13WfYhorsPLSZ34xT3LhJhciQjpzVqkRbzf
         sxkDIHxJPeC4fcQ/25rKFLuLOepuwvBzD3RlNDyjA2u0do68TrJGCro9D/bhKYhVRI
         M5hvtZfLX3xtwAlICDgtS87bBFH7Eu9ucJh+CS8YFhXtGjj6MP8kinNMe1qvYTI8YU
         Os58qunL+h6jioYaTmsD20jhJuYNrcwgG3F5dYFqMpoAmsaueg2YOO6LQFEzswMIeq
         uCq1/tvWkhIH1KOZTkgQ0H2/v9iPfutvmbvjnafetqg4CV0Iegz
Date:   Sun, 1 Jul 2018 17:56:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Steve Groeger <GROEGES@uk.ibm.com>, git@vger.kernel.org
Subject: Re: Use of new .gitattributes working-tree-encoding attribute across
 different platform types
Message-ID: <20180701175657.GC7965@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Steve Groeger <GROEGES@uk.ibm.com>, git@vger.kernel.org
References: <OF5D40FE06.C18CD7CD-ON002582B9.002B7A02-002582B9.002B7A07@notes.na.collabserv.com>
 <20180628024446.GD644867@genre.crustytoothpaste.net>
 <20180628143405.GA16657@sigill.intra.peff.net>
 <4E8CDDC9-2957-401F-9BBE-93276C026848@gmail.com>
 <20180628172707.GA31766@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline
In-Reply-To: <20180628172707.GA31766@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2018 at 01:27:07PM -0400, Jeff King wrote:
> Yeah, that was along the lines that I was thinking. I wonder if anybody
> would ever need two such auto-encodings, though. Probably not. But
> another way to think about it would be to allow something like:
>=20
>   working-tree-encoding=3Dfoo
>=20
> and then in your config "foo" to map to some encoding.
>=20
> But that may be over-engineering, I dunno. utf8 has always been enough
> for me. :)

I had a thought the other day about why this solution might be valuable.
Different platforms encode different values for iconv character sets.
So, for example, one may have platforms supporting some disjoint sets of
the following:

* LATIN-1
* LATIN1
* ISO8859-1
* ISO-8859-1
* ISO_8859-1
* ISO_8859-1:1987
* some lowercase variants of these

Therefore, specifying a working-tree-encoding value that works across a
wide variety of system may be non-trivial.  This is less of a problem
with UTF-8, but having the ability to pick an encoding and remap it to a
supported value may be useful nevertheless.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAls5FekACgkQv1NdgR9S
9ouqZRAAnovG3IN39TbH+o6l5omzpyIkQBpOEZoKZ2n/+NmxpG48TKxwMQaM+X9Q
WnlyCah/VyKbdFcUdyhOeM/FC97ntfsHCzcJ8/4kyLya1HHfml5ei/Za/RRZiI10
VXXO6KfqcmBRD0ALr/+xUaeCjaQFRgg2KaTBqHxSCaaEih7xyG7wiFiEnHX4xE9O
tS7vs5BiiPu1wuqHu9V22UnFbb9OgXlSixXtJhgu9qhBHW/NFgmtpGVNMogPjbmV
LGTwiW8yUZWE2CEk6MPgZ3cH5gxU/09GtMKVdI7ja7PCRJ/b0pRy0NH/AwOlhsJs
9aZrC8bfjAQCC664J0u6tLimyMxrFWoU1bwcsLo6/BijqTX1UB5KG66Fh9go5FA/
7xbq4yqOamNfKDzKkQW4AV2Y2LTJuU/OK2WByE8mEnvSPgvss5V087opqNeNSb3b
juooY/EvOzOsWzMbdK6eQAcqWnRXraYT9QZzv0doNApojuSfoebFXgBf+WJb/Ffa
iofWR+xVNKvfttLUJpL1EDV5ThvkDbA9+TvCYUoD4mM76Vts4LMlVRz1opBn3YE9
i1WHLilNX8VXIPCy0exgtK76chYv6cl0uiAK/lfpK8WqR0OsmLsnNxl+gcInu514
AEkPzsusftFm6TGZIhaevH3vQIB0b84bxzA/W99xsK6YhhFRJRQ=
=CqPo
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
