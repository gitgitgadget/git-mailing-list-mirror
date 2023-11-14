Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D71156C8
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WfpZgftf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h68cEoE0"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DADAA4
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 00:58:54 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 189055C02CD;
	Tue, 14 Nov 2023 03:58:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 14 Nov 2023 03:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1699952334; x=1700038734; bh=XS
	5T7Q19tnCREkTM3xevNpdFo16EPMp+TJZHqxDkdk8=; b=WfpZgftfqIlLW9sCtR
	qSaktpAbzZdYs1anDJgyEykOvUB52D7yevXx+lg5RBIRFANDziZu0kJR0Pb9Ucr0
	2EBYdZF/4r/557UMHQlnNkhUNQ9vyzv3Gv7nwnmbFUfm3t7r6yDosOIesof/jmfD
	G7sJhdiZKRkxd5q8ZdXfcacJ6Y8ixszrRc1xBP2K72hdREfmn9NwN7kWaXoljn2V
	13oLlcJF63qQg+MD0DZxyM57fMYDdXMgdx3FWdrKariIS39kO16C9W99+dpGl9Bk
	7V+8Lxp0xgf3WXHrf6xKKrqEPJb7Voqe3DPPfcfwBEZ/Zwv8lLggWi20KKo2WbTi
	3giQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1699952334; x=1700038734; bh=XS5T7Q19tnCRE
	kTM3xevNpdFo16EPMp+TJZHqxDkdk8=; b=h68cEoE0VgeHqZXzCJVa5/dfdcqsk
	jiB8/mzB/DtlU+E0pUTjvh2SfKajK+Ka25I2QPjUkFml22oi7KI5UmLAizxBlUP+
	pkqFo3l2SUanagUaLBkDZtxCM/LcDF+dPn6ReQhggObsqgJ4qNt8Tf/tnYYeFiaq
	XLLyV1mMdwUbXxpZrjVEIgNuIFU2fhJu73Qj1yEAL99gOgynXaWlyHUmvvCI9ZDC
	llD3Q9R2CCcoqnbyeysYjGGkRW0gomUFaQYE5u+ixZuxqemAMXcxgfjGWoVFbwqA
	ZRe7VnJw8bPqYdjfN691br9AUxjMirlrs5tcvRAqPeI4szrOQt3Rp1qnQ==
X-ME-Sender: <xms:zTZTZQz96g5QGWA5vmc2_185J_-WupJj3TZ0HQEwqP4xf-osmbYqUA>
    <xme:zTZTZUSibHDCgPtRo-14nPlJ1pbk31-N_Mbvrd32fJkJo_1VeLFarQE84R0e5qtSS
    ynlEi5IE7bYTpRoDA>
X-ME-Received: <xmr:zTZTZSWHGv53B-PutMIotIVZlRTuUJ6u93bx_dwJKZo8COGpjuUTUT_AFUyZG6Wyp868TJrmDgO3sZFn5Oi4HGWcCDMF0SHsWe8-r7G8aQceNQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefuddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:zTZTZeg0tvczWDxTLoeVk_NmCpy1fLqMEsqX-SomDuCYrj6-lyb1BA>
    <xmx:zTZTZSC7QF68Hm3F5J3QTTzx2-IJyqlIZGyZAuTtdnsswjXXHC7g0g>
    <xmx:zTZTZfIIFQxwPJqBIjWSVp4a3Zd-3dmGSNQ3WBd8qJcMLgQ9bUjcyg>
    <xmx:zjZTZT71N_IsKEtMkd3xSErkDhh3iKjZFSAmaXJmmGGW0obOK3Earw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Nov 2023 03:58:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aa269565 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Nov 2023 08:58:15 +0000 (UTC)
Date: Tue, 14 Nov 2023 09:58:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: David Turner <novalis@novalis.org>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 4/4] refs: remove `delete_refs` callback from backends
Message-ID: <0e61c42a92f5fbaba28d7326645a6f1903a5ae66.1699951815.git.ps@pks.im>
References: <cover.1699951815.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7vg8UA/cfb9pzz+2"
Content-Disposition: inline
In-Reply-To: <cover.1699951815.git.ps@pks.im>


--7vg8UA/cfb9pzz+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Now that `refs_delete_refs` is implemented in a generic way via the ref
transaction interfaces there are no callers left that invoke the
`delete_refs` callback anymore. Remove it from all of our backends.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/debug.c          | 15 ---------------
 refs/files-backend.c  |  7 -------
 refs/packed-backend.c |  7 -------
 refs/refs-internal.h  |  3 ---
 4 files changed, 32 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index b7ffc4ce67..83b7a0ba65 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -143,20 +143,6 @@ static int debug_create_symref(struct ref_store *ref_s=
tore,
 	return res;
 }
=20
-static int debug_delete_refs(struct ref_store *ref_store, const char *msg,
-			     struct string_list *refnames, unsigned int flags)
-{
-	struct debug_ref_store *drefs =3D (struct debug_ref_store *)ref_store;
-	int res =3D
-		drefs->refs->be->delete_refs(drefs->refs, msg, refnames, flags);
-	int i;
-	trace_printf_key(&trace_refs, "delete_refs {\n");
-	for (i =3D 0; i < refnames->nr; i++)
-		trace_printf_key(&trace_refs, "%s\n", refnames->items[i].string);
-	trace_printf_key(&trace_refs, "}: %d\n", res);
-	return res;
-}
-
 static int debug_rename_ref(struct ref_store *ref_store, const char *oldre=
f,
 			    const char *newref, const char *logmsg)
 {
@@ -458,7 +444,6 @@ struct ref_storage_be refs_be_debug =3D {
=20
 	.pack_refs =3D debug_pack_refs,
 	.create_symref =3D debug_create_symref,
-	.delete_refs =3D debug_delete_refs,
 	.rename_ref =3D debug_rename_ref,
 	.copy_ref =3D debug_copy_ref,
=20
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8d28810e67..ad8b1d143f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1265,12 +1265,6 @@ static int files_pack_refs(struct ref_store *ref_sto=
re,
 	return 0;
 }
=20
-static int files_delete_refs(struct ref_store *ref_store, const char *msg,
-			     struct string_list *refnames, unsigned int flags)
-{
-	return refs_delete_refs(ref_store, msg, refnames, flags);
-}
-
 /*
  * People using contrib's git-new-workdir have .git/logs/refs ->
  * /some/other/path/.git/logs/refs, and that may live on another device.
@@ -3258,7 +3252,6 @@ struct ref_storage_be refs_be_files =3D {
=20
 	.pack_refs =3D files_pack_refs,
 	.create_symref =3D files_create_symref,
-	.delete_refs =3D files_delete_refs,
 	.rename_ref =3D files_rename_ref,
 	.copy_ref =3D files_copy_ref,
=20
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 1589577005..b9fa097a29 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1688,12 +1688,6 @@ static int packed_initial_transaction_commit(struct =
ref_store *ref_store UNUSED,
 	return ref_transaction_commit(transaction, err);
 }
=20
-static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
-			     struct string_list *refnames, unsigned int flags)
-{
-	return refs_delete_refs(ref_store, msg, refnames, flags);
-}
-
 static int packed_pack_refs(struct ref_store *ref_store UNUSED,
 			    struct pack_refs_opts *pack_opts UNUSED)
 {
@@ -1722,7 +1716,6 @@ struct ref_storage_be refs_be_packed =3D {
=20
 	.pack_refs =3D packed_pack_refs,
 	.create_symref =3D NULL,
-	.delete_refs =3D packed_delete_refs,
 	.rename_ref =3D NULL,
 	.copy_ref =3D NULL,
=20
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 9db8aec4da..4af83bf9a5 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -553,8 +553,6 @@ typedef int create_symref_fn(struct ref_store *ref_stor=
e,
 			     const char *ref_target,
 			     const char *refs_heads_master,
 			     const char *logmsg);
-typedef int delete_refs_fn(struct ref_store *ref_store, const char *msg,
-			   struct string_list *refnames, unsigned int flags);
 typedef int rename_ref_fn(struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
 			  const char *logmsg);
@@ -677,7 +675,6 @@ struct ref_storage_be {
=20
 	pack_refs_fn *pack_refs;
 	create_symref_fn *create_symref;
-	delete_refs_fn *delete_refs;
 	rename_ref_fn *rename_ref;
 	copy_ref_fn *copy_ref;
=20
--=20
2.42.0


--7vg8UA/cfb9pzz+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVTNsoACgkQVbJhu7ck
PpT6jxAAgWLs8zmdpIV1a7PQ6HmJ7SajkeamtA/beXAsUik1nlwo70YLP49DPOK4
Y8z88BVFqjyM9r6WQ6ePR1mnmBkF1iD6OaAL2RG+eenevqShfp+I10CaRNc/g0OH
bnDF3QmYoIsbAaRQeP3NS39mLb+oawxI3MKI0/RCmG2zmJ7CZ3ExxtC1YiwcFCeR
MxWgEwNtACgVD2ICHzhM6TYOO3EF1YyrytHkNF1oMIkPR4i3Vr4uWAWJNQftQT7m
Nwo/bNlVt0MAQ1nTgdQce5DHlYegnMPoLxo62Es5Yq3fW4vhxHynV8x9/tQsCEhX
bXNsYRLCUxvFGbvfaKAObdcNXglfqdL7f/BFx/PDjNY7qzBZySuuzljhWultydMp
aivoDHHIA98dHarq5jDl5oOSSbOXqfvh351HDA9PYnYc4QUyv5SulE0z9QeuBrQl
VzBIqxLtiKTyhLElx83e/0Tg98KEfBuVBCLlfVuK+StHIA1hnB6+ZB85dENNpdOw
br8Ui+5C5loRQGpcmsGhGXu6wq2gFhCDinjbjqNsUoT3OWjYs4UX/+sQ/NEWClSd
FQEUamW7fMB9N2RZEwF1gEbuH+iGhFmSPh/Wm0fV+j1D+g6bT0OdgjvwIX5l5R3N
doCGt5tUCC7cUEGbG11sgRQFVJGBR2gu2BsuBAzJ7xoom8ixUrk=
=5dKV
-----END PGP SIGNATURE-----

--7vg8UA/cfb9pzz+2--
