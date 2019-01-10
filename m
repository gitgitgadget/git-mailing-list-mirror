Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB398211B4
	for <e@80x24.org>; Thu, 10 Jan 2019 01:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfAJBCp (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 20:02:45 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58330 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726590AbfAJBCp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Jan 2019 20:02:45 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c537:b034:2963:7e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 57C7F60736;
        Thu, 10 Jan 2019 01:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1547082163;
        bh=X/HHikwprFLUOOEtTwaKqONbUYr5ZLttKTcojN9V6fU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YgzynfIERwNqZjXV+F3KIEXKDi+NCYbfzJAO/gBYU9Up2dXMWC4Zz5PDZY2yOn7zc
         USHaqbsK6mpLvd0XV1msx8lRjMIbRzJIUcI36FNiRXrjhdht+fd8fA/fm/Hcr52K1X
         4ObEUVhkhR2vHxqkGcyMN2P3FdfVqxZ+EF6XqBVTWqYblshP8vE98m5kjX0WZkoUre
         DseEMMqGWY2RXyNe7vOzD2l7vkZMKSpvEzrgZDu7Q+WEXbYMj4K+Ubwbc2MaZTiHqo
         J6ZvGiJxSgh981dIWqMic1PMWcdrMA3bf7D3bwWbBUjXGrIghI8v1Nl1ytuCsNnp2h
         NPWXpEyTcILA/PaCpzQIMohIKZs0MIxE3kv5XEaO7uGaCIFGHV/V+FU/JGnPw8OL8l
         78Rs4Galer/U0hi4x4IMP/nSUWhf8aoCvAYgcVunH3AOlZDpe8npbl13PG8qNnJ3Of
         ih5xdoYNWA9utxaopxyhb3AFQkgZji1ghkQNqJ5cgO6ozwyFx7d
Date:   Thu, 10 Jan 2019 01:02:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2019, #01; Mon, 7)
Message-ID: <20190110010238.GK423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com>
 <CAN0heSoRYYS3-UAamE9nibhORPoD+_TRHu5-ZTeYxYMS4BAnrA@mail.gmail.com>
 <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="64LDleNqNegJ4g97"
Content-Disposition: inline
In-Reply-To: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--64LDleNqNegJ4g97
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 10:06:08PM +0100, Martin =C3=85gren wrote:
> I found some more time to look into this.
>=20
> It seems we have a buffer with raw data and we set up a `struct
> object_id *` pointing into it, at a (supposed) OID value. Then
> `update_tree_entry_internal()` verifies that the buffer contains
> sufficiently many bytes, i.e., at least `the_hash_algo->rawsz` (=3D20).
> We immediately call `oidset_insert()` which copies an entire struct,
> i.e., we copy sizeof(struct object_id) (=3D32) bytes. Which is 12 more
> than what is known to be safe. For this particular input data, we read
> outside allocated memory.

Anything pointing to a struct object_id has to support at least
GIT_MAX_RAWSZ bytes, and that code doesn't, because it's a tree buffer.

I ran into this later on in my SHA-256 work and have a series that fixes
the tree-walk code, but it's a bit involved and requires copying the
struct object_id out of the buffer.

I thought we were going to be triggering this case only with some new
code I was introducing, but apparently somebody else got there first.

> I can think of three possible approaches:
>=20
> * Allocate with a margin (GIT_MAX_RAWSZ - the_hash_algo->rawsz) where
>   "necessary" (TM). Maybe not so maintainable.

I think there are actually several places where we allocate for these
buffers, so this is not likely to be a great solution. Even worse, in
some cases, we intentionally use a too-short buffer knowing that we'll
never dereference the data.

> * Teach `oidset_insert()` (i.e., khash) to only copy
>   `the_hash_algo->rawsz` bytes. Maybe not so good for performance.

This is probably the best fix for the moment if you want an immediate
fix.

As for my series, I'll need to run the testsuite on it, but I'll try to
get it out tonight or at the latest tomorrow if people want to use that
instead.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--64LDleNqNegJ4g97
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlw2ma0ACgkQv1NdgR9S
9osPow/+PztJWQUITWEWV2uGqUAsm0qujjnMd7xYpclRiLVKJMy6vX2/Gr2elD7Q
/i04j2VrWES0MNSwqX9lDYeLinNr/UsBe3dayDAcSTkZoc7Sggsp4/H3qtws3LpO
eN537lWGOBhC6Q9DWbChE+/wY9wrjQ4tQRovC1aCMjhKty5CxAdIkKBuiau7gyMH
jRhUklthJsKrDKKEG4bFZPecjEU0lFu46Ug3SsQQ76eg8TCwsq2iGAoaWx0Mgxsz
F+sZQjDc82QwbYw4hQsYsbgkZHwdIObz/CLWE3cFA7A9EwnSZDnNHvUaimqCZ08h
qjMiDKtiGDBmrJedKRnq9XRzagq9t/TTqpuJkAhNaUxHxpHyTzXqZs4QuuTgify3
v1/iZHT+ava1gDb6Z/ApP3n66ItYYhcHUvvGak4HNTGLEGIVT53sGaYBOb9L9VxG
7dr3mw3yPLasBFBq+MN0epTmfynrpfwjXnzDgjJGKABBabL1bCTCxUokAyAnnObm
oaJk+D1ULTSNuSWsXs0P0Ftk0kCXUw2l6t5KPcYsvIAygg0OWSMp8fm/aesCkber
8SLuogee4EIjO7o0CqC8hSYUC/W78jenEQF8zI3UeYu2mgHeVV5L9jDsjfJzDJH1
2hYKTSaiJFq8SCfboDQAWgdNjKCvfLxfz7IhQbrA5BqvkdgUKg0=
=GEN3
-----END PGP SIGNATURE-----

--64LDleNqNegJ4g97--
