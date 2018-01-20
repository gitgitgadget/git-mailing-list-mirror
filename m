Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AEF01F424
	for <e@80x24.org>; Sat, 20 Jan 2018 20:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932289AbeATU6j (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 15:58:39 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58184 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932198AbeATU6h (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 20 Jan 2018 15:58:37 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EDFBD60402;
        Sat, 20 Jan 2018 20:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1516481915;
        bh=lHxHj9RoBdZzFIar3P2a3U+9SXidQQv2YYYGtZ9kKyU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ic7AqpQxSnn/5wQWWpLOv8EMpDENoiWcOczQoX27bvRiLWDcN1fyqkRe0Eu4GbX7q
         /DdsrY+h4lUCqnALuhGWiR6h9P1SGnI+1athgzWUpdmgxf/qLwct+TKD0lASOhjtXe
         vrBxFqb97t+rvcoIrKPn2FY+n/AqdY28J0GSi9xmWshivingyHsCFR+rSrzcIISwo+
         eH3BEnGtXtfJIsnmUq2+7a52pf5llIvgqtOsh4jcuegiQlDheRxjEgL9otRsN1cIfa
         RnPnvLTJb8bVD6y7P0H8qbVbiRVc8E+0HoO32d7jc9CMs5etgfDWOQsaadbEhIS6pq
         3cDXftxd4pGy58g/Qw61/irw56xWIxWRdab6j/3DwR2I/vgYOc0uY1Sg69mo4sqZFa
         hRvOl18nbny+Uz7UBwG4WiSpcCZUmWojEtiYNCObxSwy1nQFv4GT8GjFd1wn9ogOo0
         xyGdCJwZzT4gW+W8We2i4nqC5f1oNO32TL5qnfjAUvrpFFXosqX
Date:   Sat, 20 Jan 2018 20:58:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/11] Some fixes and bunch of object_id conversions
Message-ID: <20180120205830.GC8965@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patryk Obara <patryk.obara@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 03:50:52PM +0100, Patryk Obara wrote:
> * brian m. carlson implemented vtable for hash algorithm selection and pu=
shed
> the repository format front - thanks to him it's now quite easy to
> experimentally replace hashing functions and, e.g. do some performance te=
sting.

Good, I'm glad this has been helpful.

> Patch 1 is not directly related to object_id conversions but helped with
> debugging t5540, which kept failing on master for me (spoiler: it was Fed=
ora
> fault).  It helps with debugging of failing git-push over HTTP in case of
> internal server error, so I think it might be worthwhile.
>=20
> Patch 2 is a small adjustment to .clang-format, which prevents unnecessary
> line breaks after function return type.

I have no strong opinions about these two patches, but didn't see
anything that looked problematic.  Better debugging is always nice.

> Patch 6 is a tiny fix in oidclr function.

I think this is a good direction to go in.

> All other patches are progressive conversions to struct object_id with so=
me
> formatting fixes sprinkled in. These should be somewhat uncontroversial, =
I hope.

Overall, I like the direction this series is going.

When I've made changes to the sha1_file functions, I've traditionally
moved them away from using "sha1_file" to "object_file" to ensure that
we make it a bit more obvious that they handle object_id structs and
aren't limited to SHA-1.  For consistency, it might be nice to make that
change.

Other than that and the question I had about the formatting, I think the
series looks good.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpjrXYACgkQv1NdgR9S
9osMFhAAgLH51UkHBmBFqlvFqb5rHeqae4OJGUBNO2EgC/44jOwakOairFBU5ZWk
Sh4yfR9f0CTyZ1wbuwX+ldkDdjxNUQ77I3nTxn7PvZVG0FRxd+dcFqmVI9WB1u3F
UhPZE86nHjiYZYyNCv9dVscwb5Jw6sV1yTbzKpDAOXlBkSabfudTTngBe71UEPtP
OZUNJhPcH79bCm4kGnvgmcZmal6+sZCG/Bn8f/5crFBLmwDH8c1lTy6mjbcdDJOY
qgcKRYIngCBUwHjNUMO55/ArtRxsj+pscD6SczQ7EL4n29dE5gw5g3ISn2JZZO7N
IIazOX1hz2dFpXyz08hqDQsVQTH7KXY1Gec1W+fbkrOZ/7PLuIuyPQiHI6oVH3rh
AOZIgrxOEY2Gyy3/94pkZ6A1R97Yt0xnbhJP6hZvaW1BnbztcMEYIhjFTVhBVmAj
iXHjzqEQiHBxaIQEBgvL1JJJZW7fRA8OC4OMF8aeUIunEW8OHqJpWmigRPmaOlcD
4RkpzV5nPWZB+IU+N+0i57envfoFEsA0vDnmqAqjNNnYk4RyJlooZuuPJoJGnWtc
F7vk2YGyIM7ZIfC5PMaqu7owcWjuWQFpFZGx6RKikMqJ/mb3tq6O6x8ZUTf53Qn5
9mrHyq+0a92uO+dAdmfPH6AB5U5g+NOymwujZlzsEA+kbJtQPIs=
=5wT6
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
