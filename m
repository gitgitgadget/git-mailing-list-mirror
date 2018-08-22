Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 711A51F97E
	for <e@80x24.org>; Wed, 22 Aug 2018 05:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeHVI7w (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 04:59:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57904 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726696AbeHVI7w (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Aug 2018 04:59:52 -0400
Received: from genre.crustytoothpaste.net (108-60-118-130.static.wiline.com [108.60.118.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8052A6047A;
        Wed, 22 Aug 2018 05:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1534916191;
        bh=ipJXwXbaz17qG4l7RPKXPVBze9GAamWwyZ9EDWLxvfY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Iv3htzz6CdqPnVaQWLguM+4WlZDE9Ucl8buNIMP3bKWkXmzdQMK3K4No+hKCsSNM1
         oGadHOqcxz+zZEdHlKkd0e5AEz3Ojk3Ow6wQWj8a4zA80rWk0XjJP6aVjfnDm9I11i
         P92UPE6Zg/FiFpm+pmoA10H7PRCJE490GoNO5lCIcZhhtLwMn9hqUlpSJlIz4gDUcn
         SB+Ox7k5GMQ3Z3Oo3r7HKQovtmm6WBc8UScvxrqzvNryIsPz4gWwXKsM2XOAaCRLDi
         Ut1auzLL92lCumg2wj1NYElDKs27zDtasehY1tJP5Kk9Z2C1JK+gCoa4VP0l5MxZDx
         qGOJmqFuwpn4T08Pd5WO3FaTvMT/uRD4wuJ9dVA9y1748cQ/DAtB6cFcnywVNPaNwN
         ebNbSClMztGMx2bdbjSRuP1CygEvukpCalkuVRSByu0+WNu0CQ9B9YN7Uf2Oznx+Kt
         dlTl2SmizDWUvZdjrc1tBivZUP6ESPp1XdOll07OK+R9NZSylJq
Date:   Wed, 22 Aug 2018 05:36:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180822053626.GB535143@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <20180822030344.GA14684@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 11:03:44PM -0400, Jeff King wrote:
> So I wonder if there's some other way to tell the compiler that we'll
> only have a few values. An enum comes to mind, though I don't think the
> enum rules are strict enough to make this guarantee (after all, it's OK
> to bitwise-OR enums, so they clearly don't specify all possible values).

I was thinking about this:

diff --git a/cache.h b/cache.h
index 1398b2a4e4..1f5c6e9319 100644
--- a/cache.h
+++ b/cache.h
@@ -1033,7 +1033,14 @@ extern const struct object_id null_oid;
=20
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *=
sha2)
 {
-	return memcmp(sha1, sha2, the_hash_algo->rawsz);
+	switch (the_hash_algo->rawsz) {
+		case 20:
+			return memcmp(sha1, sha2, 20);
+		case 32:
+			return memcmp(sha1, sha2, 32);
+		default:
+			assert(0);
+	}
 }
=20
 static inline int oidcmp(const struct object_id *oid1, const struct object=
_id *oid2)

That would make it obvious that there are at most two options.
Unfortunately, gcc for me determines that the buffer in walker.c is 20
bytes in size and steadfastly refuses to compile because it doesn't know
that the value will never be 32 in our codebase currently.  I'd need to
send in more patches before it would compile.

I don't know if something like this is an improvement or now, but this
seems to at least compile:

diff --git a/cache.h b/cache.h
index 1398b2a4e4..3207f74771 100644
--- a/cache.h
+++ b/cache.h
@@ -1033,7 +1033,13 @@ extern const struct object_id null_oid;
=20
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *=
sha2)
 {
-	return memcmp(sha1, sha2, the_hash_algo->rawsz);
+	switch (the_hash_algo->rawsz) {
+		case 20:
+		case 32:
+			return memcmp(sha1, sha2, the_hash_algo->rawsz);
+		default:
+			assert(0);
+	}
 }
=20
 static inline int oidcmp(const struct object_id *oid1, const struct object=
_id *oid2)

I won't have time to sit down and test this out until tomorrow afternoon
at the earliest.  If you want to send in something in the mean time,
even if that limits things to just 20 for now, that's fine.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlt89loACgkQv1NdgR9S
9osM6BAAn//WFPBiszbjsP1kii2aBxb5cbHbT6pAFn9xR0n+ulfa8p//kve90KIt
kGBRLNZsa7zNa6M189n1u6Y1DAexxhYqUoIYYCP7RoMzPPADreq3Wfx8xVmtqp/O
+j5zfJiMnMvppgqY7MIP+5QyTgXx0bGuiEDn1RfciytrFJIKnn1BjeDnLVVM2fQW
l2JwnvRVtIA5kUoWM387sUsMSUpSXfEUC7rbvIVxlhGjxeN97wcBumoyx31+DWG3
wZV9Y+WbGQytrGAFK0C6D4jFSRssx5otwqXzL3da7jwWO7r5CKkbq8yKa7Jzdtz2
W2vJY5lf3Mg5BFKsK7p9AFL4JijrhlG4utfHItV1tnb4bWZSWoZmkVVCHZW2RTuq
+3rHHCjJcLzuuMNElAsYjj17FBzK/DU0o6B6xBvUyeqrnCg0aPl/ddHYPjI/qP41
gIDmc4R2lPVln8BGQC04KdBQrB9Lpe9pE+dtMDVOmBkK3brwDTDOPB+FLQItZcsG
PpPrzJSoBB2Lxk9uEHCVEkpK6V/h6M8CRxpOeNhOS5Q4BLV3A4B8KAJJQs5gJsb7
d8XgBTWoxJ6r9UILkGkTaG2UouijWghueiO7fUntI7vJ/1NVl2ShR4sH0PU1HOwk
VAuDglx3BO3sz+4r7uAS0nWKlKNVoq0h7x8kxaQebzNimv7Kqn8=
=EaOJ
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
