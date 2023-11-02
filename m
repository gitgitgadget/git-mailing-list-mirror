Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E461FDF
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lUnrPkR2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oloj8KBz"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9901E12C
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 01:46:46 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 9BC733200925;
	Thu,  2 Nov 2023 04:46:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 02 Nov 2023 04:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698914805; x=1699001205; bh=mC
	5f7yW+sMhQR+N7FZ7yZSSGO1YBs/TTYn/7WTaGHvY=; b=lUnrPkR21wWZsn1xK8
	0pM87ru1mS9Yi++bgZHrqBYLkvNuCPHJaKMiA5VAyxKsdul16ToLLD2tYNZ3UHjS
	Y2AXxLi30RuKvgSPuPKW7w7Un0NYbhJJXE2owLOIDXnkyAPLV5F36+MorFN90v3y
	O2NgwkQPJAbK4Y9a1Q1Nj81xdE6umFPWKIih+JwkfNB+eY000gE/Izje8hVv9+8m
	sQYbhkae5qsbBqKRL8ERRGilNv5c1l8GStGrjQPL85GXO/+mwm9A6rb96PtOx64Y
	rJZLyffFX7/Cwelq9J9xGgBN+sD/stKY8AEARZXXRI8NpUaTklYGgGJ1IrHY3BT9
	4zOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698914805; x=1699001205; bh=mC5f7yW+sMhQR
	+N7FZ7yZSSGO1YBs/TTYn/7WTaGHvY=; b=Oloj8KBz5I0UiGWjbMtaUsE9VI5D+
	AqPd2GeBd/uxTljQ7MuAqymqA0LkZWB7TZYozpvrGg28Ap4MXz6gD0LrKBUPg2bz
	Pgi3KGbUwnmrMvZlcRgOU140yf/LiKC+mZ0+4WwE+pqtk10lUp7yEkCOTBN1PKg/
	N5OYh487kW4cRNtH8hPijqjl43Yi2vNwwAL4uVa15azJ2XsCzhMrDrgDZ2JcZNRf
	8DeFPXvuKWVu0hJFF0Rk7hPyqB12zk7kdFppvnizNaO3zwgxrF5GPbXqNXkk3Fq9
	ziV7/FBj9jmbp3HI+VrJWtv2TnMysR+X9qo/DBC3tbaSDfgazpMPFLmGg==
X-ME-Sender: <xms:9GFDZZUZVO2iFK6EerVlBEs8tYnT7JNgNWncNNS03lQ4WOUWWHKG3w>
    <xme:9GFDZZneHK_kBnK8OZuU8D7206vkLkYxG6pZx4R5VqTJEleYj4-1w94qUVK6R3Aiv
    OMn0LsnKpva9LKxSA>
X-ME-Received: <xmr:9GFDZVaVtFm93UYJr2ZrZO-vZ_ucUXwl7dhVi0XJYnMgxzadzOpIf2D-pxCxcTARHIk_lLtfgtDA8-mj_3Cas0MiC-geIbfdrQev61UjVoFIBmo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:9GFDZcVFOvQRQUqd2aosrPc18ofwCQ9-KhdvQVTA88w5-LAbskQv_w>
    <xmx:9GFDZTl3XruWg3XHAzxPewuTgL8ybPAnE0f_1RfvJwfYlG0n9fahQA>
    <xmx:9GFDZZeVyH1JuDVhK4hj2uUejZ8hv57X9mJB3OJmSO56WZ6GasI66A>
    <xmx:9WFDZRh3PxlVsbJU22-MnG5U6hgPYQylih5HlbCGd_SdhKXXFxxHxQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 04:46:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9281ca90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Nov 2023 08:46:31 +0000 (UTC)
Date: Thu, 2 Nov 2023 09:46:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/9] t: allow skipping expected object ID in `ref-store
 update-ref`
Message-ID: <3caf9e3f28f2c2b8c87d95307852299b66d0fe12.1698914571.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
 <cover.1698914571.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rHd5gqMj3w+4jnBP"
Content-Disposition: inline
In-Reply-To: <cover.1698914571.git.ps@pks.im>


--rHd5gqMj3w+4jnBP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We require the caller to pass both the old and new expected object ID to
our `test-tool ref-store update-ref` helper. When trying to update a
symbolic reference though it's impossible to specify the expected object
ID, which means that the test would instead have to force-update the
reference. This is currently impossible though.

Update the helper to optionally skip verification of the old object ID
in case the test passes in an empty old object ID as input.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-ref-store.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 48552e6a9e0..702ec1f128a 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -298,16 +298,19 @@ static int cmd_update_ref(struct ref_store *refs, con=
st char **argv)
 	const char *new_sha1_buf =3D notnull(*argv++, "new-sha1");
 	const char *old_sha1_buf =3D notnull(*argv++, "old-sha1");
 	unsigned int flags =3D arg_flags(*argv++, "flags", transaction_flags);
-	struct object_id old_oid;
+	struct object_id old_oid, *old_oid_ptr =3D NULL;
 	struct object_id new_oid;
=20
-	if (get_oid_hex(old_sha1_buf, &old_oid))
-		die("cannot parse %s as %s", old_sha1_buf, the_hash_algo->name);
+	if (*old_sha1_buf) {
+		if (get_oid_hex(old_sha1_buf, &old_oid))
+			die("cannot parse %s as %s", old_sha1_buf, the_hash_algo->name);
+		old_oid_ptr =3D &old_oid;
+	}
 	if (get_oid_hex(new_sha1_buf, &new_oid))
 		die("cannot parse %s as %s", new_sha1_buf, the_hash_algo->name);
=20
 	return refs_update_ref(refs, msg, refname,
-			       &new_oid, &old_oid,
+			       &new_oid, old_oid_ptr,
 			       flags, UPDATE_REFS_DIE_ON_ERR);
 }
=20
--=20
2.42.0


--rHd5gqMj3w+4jnBP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVDYfAACgkQVbJhu7ck
PpQoSRAAlW5AqcBZ6yuX4s8UTT4/WpVMzcuYyQw839IVQ93d8+XE7R2Pt6v2A7Tp
CiFpSUQHotRoNq1WIVshvENF9TMX2VAwl3S+1QtS6dZbP2NJJubhqviqg6reMIq4
jW6LZa/dmTeLLaDnWpth6rSf77D1jUV3ZxEM8ODEaDeTqpXYUFM/JXaXNp7LonlJ
E42F9ZxoY6e2lgkId3xdvRuXMfOOLOateCIVTDwq6cLBmJK+2XVo9l+1G1pn6+MR
myYzeigRHSSkQx8mhCpCTglh+7NmmBO4frRu9PhjUiPdxICMp/ZBswK1n133ttmf
RO4psvKXP5fUfLMG8Ng5hGnt6dBXKRDewDBFYeIIcgJsFB+yDEKYSBroM8dXACdq
HYiYgA+YlndSchFI+52Yu5rNP3Trg9x1D7EVNMfYpIIOYLzQZQQ1xyhXExYUjMrw
ITWXC4hAhGp04wM9MlWhOEFZ7+3AEa9iGD9CDQE5b1TGq1x4yx3Wg6fjVb5qPsxQ
q+lDZK9rUpRHGiD+r8qW1rZOpw1/aqAO7wcO42Oxs4JKTK+Q0zTixJOSosc8ZIPT
09qFTonwz2hJ4+BT5aR+iSZNRdTue3LdzRJY1snIXi64W9nXtq59CQFu80zCZinG
18Slabnq6YKGdiMCNIQt34d0g4ummC+1x4GMCFbqf5VMqVBZU/c=
=k4Rw
-----END PGP SIGNATURE-----

--rHd5gqMj3w+4jnBP--
