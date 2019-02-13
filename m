Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A09781F453
	for <e@80x24.org>; Wed, 13 Feb 2019 00:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbfBMAav (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 19:30:51 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34494 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728438AbfBMAau (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Feb 2019 19:30:50 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8D30660443;
        Wed, 13 Feb 2019 00:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550017847;
        bh=QrBV2a8cG8PgrnHVRvRaXvAkfuORNg2ipCg8nAElm+U=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XqIid/kSqFPQkppSE9oIKv5kYIpOk9WTMeKLaVjEmbfxiy6V7BtTjUh3An7GmwP+Z
         LurUcyb7xyRluWUg+zyimGwvnAoef1jCWUjHAHxK5q09TxgmG+eUVEOiL3gsHOPF1l
         PG2O30gMeFG1trj/nhTUvlb7F+38x9ZFdhMQAFBcEIK4WDJOW/uTyaz1I5BXcqZun2
         pkV0WDDQJ/MQW8Zra2nMaH0sQpmiN8IvBN1uLJtCoMTJfNDYEUowVDsrYkc3dLAJIE
         dbT2uxJ7nHZX1BYYz1LdQTCSJh5ZreRkQA96Z+O9uH9cOU493o5Akt+6UWnVh/HkGI
         lAbkSk592KHiiOLXwNUe7Nr8NKNrd1ZtZjUbIcdiyvqQaZ0nCgHvT+jFBZpnxZZrna
         eXl8ENfGCyIjYrXOWTNvzZYH8jpjO3Hj4x4qOp5WYSeYSUS/8HsntMeKr7Ozccvaj1
         3zEWfBeYKor5VnbJ/pi4p0yfYwc6k5T1FBMxwmKvnQlZnyzoTUZ
Date:   Wed, 13 Feb 2019 00:30:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 28/31] dir: make untracked cache extension hash size
 independent
Message-ID: <20190213003041.GI684736@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
 <20190212012256.1005924-29-sandals@crustytoothpaste.net>
 <87y36ljmcu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3U8TY7m7wOx7RL1F"
Content-Disposition: inline
In-Reply-To: <87y36ljmcu.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 12:08:01PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> Both this & the follow-up 29/31 look scary since this is an on-disk
> structure and this patch & the next one rather than implementing some
> transition, just changes the structs & code we use to read & write to
> use the current hash size.
>=20
> So what are we going to do when the "current" size is SHA-256 and our
> on-disk cache is SHA-1? It seems like with this we'd at best (I haven't
> tested) throw away the SHA-1 UC data, and at worst introduce some silent
> persistent read failure.

That's a good question. The current design has everything in the .git
directory other than the loose object table and the pack indices in one
algorithm. That is, the untracked cache extension, like the rest of the
index, will always be SHA-256 when the objects are stored in SHA-256.

Having mixed algorithms in the .git directory would add a lot of
complexity.

> In any case that seems like something we should have tests for with an
> on-disk format, i.e. write in one hash, see what happens when we read in
> another, and perhaps instead of not understanding SHA-1 hashes in
> SHA-256 mode we'd read the SHA-1 and consult the SHA-1<->SHA-256 lookup
> table we're going to be eventually maintaining on the side?

Correct. The current plan is that when the transition code is fully
implemented, we'll read object IDs from the user in whatever algorithms
we support, translate them into the default algorithm, and then use
them.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--3U8TY7m7wOx7RL1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxjZTEACgkQv1NdgR9S
9osTUhAAy/V/Sdvz/s3VGzTEHMlaRd/2cPOxf6X1+0oVB8j7lV3uupNTw7BhAdfJ
YKF100dK52iYZgxN2su+fXZ4iE60WjjjBkrTiFAMr8wrAKJnRLyvqqMn01U35q41
v8QylriURCOWF+dRF929WRD2t7haScUvVvEdNV2tPZx77v6O81TY/Yq3pxNcrhiv
qeVvsviFK3/c72iq+nsUz2Z9JXtcsL7FGAxV4jg5CWWlPpUeIOjWPI020sdSMZHz
dX3tV1M4L6vObSSl+qfjUsZENI+ku6Hr4YG33fvTKxKwThBCinWvICrue/jNE0wl
/psoSV9ADHEpDT/N4qkTm2d487FwrR6A2YmEEsOuVcKx+GgX0upt7bkiwCydipFC
NE5iM5C9RkPfzuqWSMTZlVyeq1s6O6ovnZ8VgS9S8WX77GSXTqlHccVarJyH2CVH
IUnql3fr6OCoCqfj96m7sVTytaLSMnXfpZge8tWkbXb6URbYGxR9L2CzYzaqAhB2
VW5Df+/Um+dPdzCvwTeU6A/XGD1gtB89cAb9vrTdl5X9jeV7lRzNi2pUzwsq9dIH
cLmvei1Zn6ppg8vNlM0hthHb2FtVK+Jz62nlrZZc9eHn7+w2r5FefoOD/ol92UZZ
WpKnXakqBhf2tNRgS9Few8KcjNSVKvGewRYCZkuSH4AdyGkixYM=
=cfUb
-----END PGP SIGNATURE-----

--3U8TY7m7wOx7RL1F--
