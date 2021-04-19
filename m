Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DACC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 02:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9D4610CB
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 02:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhDSCL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 22:11:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36574 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232097AbhDSCL1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Apr 2021 22:11:27 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D98876044F;
        Mon, 19 Apr 2021 02:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618798228;
        bh=+xzW90HgXpVUykXKrHfgKZXoH0f0gxFbOfDQZZVYIuA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uCfQKuIACcAEwIoljQzI4Q22jXbBlIV/FdYbvJwMb2JHbms5QdL2MDahQHYzA/EjD
         qjyZ2glpoUiWDPteTniXM745jEQmVinwC+P1hR0dr3HQMqSJOmg1a/6BkpDUdmebn/
         FAf1ZD7phTVFofuq+zWMJTP1JLJXzk1ErXjZOTp+l+Guan2KMtQdOCLQ+hP67Lwl9d
         pioAp/MgBTcYz1d+S+fBActAKaXgFBE6iQos/aRYOFA9PlYWPHeWkebF33Nd+Ugw4v
         qlQuGvdB0G7x28DFUz+esvyvMa/5hQhjvrlcsIE3HyEhlUlfYpijtv6qKr7oG+1ZW6
         8Mq06GFM0rJ33ZdluGCPV8TJNLNM7P2/gMdG0XTLJEL66piBaoTjZunGNIa6447Nq+
         kfiL+F0Jm+amZ/XjEO8AAo9umDOeweDwgxNjDV9/DOHfLVx0Af4rQZrAMaYhGo6Y/Q
         pbz9BmHtTekdnPDVHozEW6mxV+6mnGCxfRFeA+q3DkdOxiKuo62
Date:   Mon, 19 Apr 2021 02:10:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: What's cooking (draft for #4's issue this month)
Message-ID: <YHzmjhLy2QjDefXy@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
References: <xmqqmtu1zn3o.fsf@gitster.g>
 <xmqqim4owixg.fsf@gitster.g>
 <YHeKFILFySGRo2Dc@camp.crustytoothpaste.net>
 <xmqqr1jcrr3c.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5S4s0wVL04/OVzDr"
Content-Disposition: inline
In-Reply-To: <xmqqr1jcrr3c.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5S4s0wVL04/OVzDr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-15 at 06:37:11, Junio C Hamano wrote:
> I actually do appreciate the topic to be in 'seen', as these
> integration exercises tend to serve as an early warning for
> impending messy conflicts I'll need to be worried about.
>=20
> I do worry about the memory requirement bloat of the object_id
> structure, as we do need to keep one instance per object in-core,
> but the squashable fix for the reftable topic given by Patrick
> to replace use of hashcpy() with oidread() is still a good idea even
> if we are going to use a different mechanism to keep track of which
> object_id instance uses what hash algorithm, so again I am happy to
> have seen your bc/hash-transition-interop-part-1 topic and had an
> early chance to make it collide with others ;-)

I'm still working on a full reroll for the series including performance
measurements (since this took me much longer than I expected it would),
but I wanted to include a patch for the segfault below to keep things
tidy in the mean time.  I should point out that this doesn't appear to
crash when running the testsuite in SHA-256 mode for reasons I'm not
sure about, which explains why I didn't see it originally.

---- %< ----
=46rom 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
=46rom: "brian m. carlson" <sandals@crustytoothpaste.net>
Date: Sun, 18 Apr 2021 22:56:04 +0000
Subject: [PATCH] http-push: set algorithm when reading object ID

In most places in the codebase, we use oidread to properly read an
object ID into a struct object_id.  However, in the HTTP code, we end up
needing to parse a loose object path with a slash in it, so we can't do
that.  Let's instead explicitly set the algorithm in this function so we
can rely on it in the future.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-push.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http-push.c b/http-push.c
index b60d5fcc85..5675cd7708 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1022,6 +1022,8 @@ static void remote_ls(const char *path, int flags,
 /* extract hex from sharded "xx/x{38}" filename */
 static int get_oid_hex_from_objpath(const char *path, struct object_id *oi=
d)
 {
+	oid->algo =3D hash_algo_by_ptr(the_hash_algo);
+
 	if (strlen(path) !=3D the_hash_algo->hexsz + 1)
 		return -1;
=20
---- %< ----
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--5S4s0wVL04/OVzDr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHzmjgAKCRB8DEliiIei
gROpAP9q97f9+7lDEl2BaEdhMPJrAKiCYeyz7Y7Sp6hq0aH2FAEA3NsHN2R5Jzvo
0Fhhid4GzvFUJROJAXK4ln2Ny7V2Owk=
=/31B
-----END PGP SIGNATURE-----

--5S4s0wVL04/OVzDr--
