Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hKQVhEQl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P/P7SSAX"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CC92695
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 06:53:36 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 7BC363200A33;
	Fri,  8 Dec 2023 09:53:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 08 Dec 2023 09:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702047215; x=1702133615; bh=8F
	0/oFQqHSzKyZi5t1vp1b2t9e42ME5tkwAbvPgw+vw=; b=hKQVhEQl8wv1+rfMeJ
	+YJimozOw8sWPBgclqB26Ad/VEoAnOVCNGgSCqzvM4JNelOu/MAZs4IPFO+xghFq
	fNnXne8xuVLVo0c8+lPQ91GDZCMtunehDlhp3IKt/yLkhQK8EYWfei7SoQqbJjqN
	T5kx9QOWcNx/8rsICqp/kV4GH004MoGUkvdRv7L6GhQBWG6hcNzYwhomU+vvHJhS
	zMrupGzeIddXBghw78N9fjN/lg5EMBWr1qhC8EaG0pWw3OoflnWAq0SZeWD0+Rqj
	xVR+rEwGTd5jPyB0TWwlJ2V/EgH4KzjSC6wCWlZ/RIEnlhSdL2p1Cj1GW2zSde8S
	cCpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702047215; x=1702133615; bh=8F0/oFQqHSzKy
	Zi5t1vp1b2t9e42ME5tkwAbvPgw+vw=; b=P/P7SSAXgoeaADKZbEgWrqAQMpCJe
	puHK+sAIaaXiERLDw6xY94ZKxrLJweboKevuil80qcH1ExANup4uIWjDmiZISK0U
	SzgvlPC5Zo0mDqBbrIr1OdzQQEmqrnQGRUNLSoTnmfQfjm3vaufftqyxqXrRmNLB
	tvBMAB8Dp/jBe9YOKYAfIsl9a2Ee3BIhBwtkC6uQ8vJG4Vg6eCi/HymO9zXVkYTK
	P8TswUEY7lFPEehdXDBXYGFfXFNSt3BKKb3X0Sa5W2MSFxcFAQ/f/PT66yZnv2co
	ZYKEkSwOOa2mWxGF8hsIr4ijeZg/UQxlxnfLvcDg/akB7ub9Sm7ZrhmCA==
X-ME-Sender: <xms:7i1zZXsSRFVH24Xnggrk7joEyf4He-1k5djzM8gRRZZRIKD2qonDNA>
    <xme:7i1zZYd88HEaUSDXbBPMovIOQF8E4dTI4zoa2xGYsAjdFbKguH9-_x3tUcvK2EB_u
    szVVy1uEv2eS6qpAQ>
X-ME-Received: <xmr:7i1zZaynGmnGmykHGsvXeT5tWTFXHYeWtgOp8aKtJHZFb1TZ0vqH7kMcY8YxnlFZyQJ-i8PfS4X0UQxEHwletMKiIZTDf9mAfglPK32yKZv7Qjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:7i1zZWNYcbJpE16h4aDZad6jdgw-UPLL8OXoOk5oWFiEeUMMqGo7AQ>
    <xmx:7i1zZX9YM2GW46hw6Ig7ZjUN0xHKa3WT_ZjIwgEn6ktf94KUKBCqmA>
    <xmx:7i1zZWVkWbz7hU1FNFREBBte-ShC5o9m6unh81VuiPkrAWduQKBmhQ>
    <xmx:7y1zZRntJ8WQ6LnRL8xJ6oW8MtuDI7BKuH6bkeu0rqIfU0ip-_vvow>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 09:53:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6dcaad72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Dec 2023 14:52:02 +0000 (UTC)
Date: Fri, 8 Dec 2023 15:53:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 09/11] reftable/merged: reuse buffer to compute record keys
Message-ID: <cbf77ec45a26c215884d26a4e249adeeaf634f3d.1702047081.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1sRCvMxxUhYeIgyG"
Content-Disposition: inline
In-Reply-To: <cover.1702047081.git.ps@pks.im>


--1sRCvMxxUhYeIgyG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When iterating over entries in the merged iterator's queue, we compute
the key of each of the entries and write it into a buffer. We do not
reuse the buffer though and thus re-allocate it on every iteration,
which is wasteful given that we never transfer ownership of the
allocated bytes outside of the loop.

Refactor the code to reuse the buffer. This also fixes a potential
memory leak when `merged_iter_advance_subiter()` returns an error.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 31 ++++++++++++++++---------------
 reftable/merged.h |  2 ++
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 5ded470c08..556bb5c556 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -52,6 +52,8 @@ static void merged_iter_close(void *p)
 		reftable_iterator_destroy(&mi->stack[i]);
 	}
 	reftable_free(mi->stack);
+	strbuf_release(&mi->key);
+	strbuf_release(&mi->entry_key);
 }
=20
 static int merged_iter_advance_nonnull_subiter(struct merged_iter *mi,
@@ -85,7 +87,6 @@ static int merged_iter_advance_subiter(struct merged_iter=
 *mi, size_t idx)
 static int merged_iter_next_entry(struct merged_iter *mi,
 				  struct reftable_record *rec)
 {
-	struct strbuf entry_key =3D STRBUF_INIT;
 	struct pq_entry entry =3D { 0 };
 	int err =3D 0;
=20
@@ -105,33 +106,31 @@ static int merged_iter_next_entry(struct merged_iter =
*mi,
 	  such a deployment, the loop below must be changed to collect all
 	  entries for the same key, and return new the newest one.
 	*/
-	reftable_record_key(&entry.rec, &entry_key);
+	reftable_record_key(&entry.rec, &mi->entry_key);
 	while (!merged_iter_pqueue_is_empty(mi->pq)) {
 		struct pq_entry top =3D merged_iter_pqueue_top(mi->pq);
-		struct strbuf k =3D STRBUF_INIT;
-		int err =3D 0, cmp =3D 0;
+		int cmp =3D 0;
=20
-		reftable_record_key(&top.rec, &k);
+		reftable_record_key(&top.rec, &mi->key);
=20
-		cmp =3D strbuf_cmp(&k, &entry_key);
-		strbuf_release(&k);
-
-		if (cmp > 0) {
+		cmp =3D strbuf_cmp(&mi->key, &mi->entry_key);
+		if (cmp > 0)
 			break;
-		}
=20
 		merged_iter_pqueue_remove(&mi->pq);
 		err =3D merged_iter_advance_subiter(mi, top.index);
-		if (err < 0) {
-			return err;
-		}
+		if (err < 0)
+			goto done;
 		reftable_record_release(&top.rec);
 	}
=20
 	reftable_record_copy_from(rec, &entry.rec, hash_size(mi->hash_id));
+
+done:
 	reftable_record_release(&entry.rec);
-	strbuf_release(&entry_key);
-	return 0;
+	strbuf_release(&mi->entry_key);
+	strbuf_release(&mi->key);
+	return err;
 }
=20
 static int merged_iter_next(struct merged_iter *mi, struct reftable_record=
 *rec)
@@ -248,6 +247,8 @@ static int merged_table_seek_record(struct reftable_mer=
ged_table *mt,
 		.typ =3D reftable_record_type(rec),
 		.hash_id =3D mt->hash_id,
 		.suppress_deletions =3D mt->suppress_deletions,
+		.key =3D STRBUF_INIT,
+		.entry_key =3D STRBUF_INIT,
 	};
 	int n =3D 0;
 	int err =3D 0;
diff --git a/reftable/merged.h b/reftable/merged.h
index 7d9f95d27e..d5b39dfe7f 100644
--- a/reftable/merged.h
+++ b/reftable/merged.h
@@ -31,6 +31,8 @@ struct merged_iter {
 	uint8_t typ;
 	int suppress_deletions;
 	struct merged_iter_pqueue pq;
+	struct strbuf key;
+	struct strbuf entry_key;
 };
=20
 void merged_table_release(struct reftable_merged_table *mt);
--=20
2.43.0


--1sRCvMxxUhYeIgyG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVzLeoACgkQVbJhu7ck
PpTFFQ/+L4h849xH+GrwDrH2Z0L25SlEjUot3CBUrQ3/Y66j4/wrkE7tQvMlSlOb
iDBvWDFMBQ44BvLy/Zk+cpP4ymSJtkaPUFiccJfA/P68Wh+mxS1yb1Q71L7C9ZE8
Dtzg2F0jT/ls/2O6AqfESW80BKGUsjOfc0aVNuRrG0GtVNp1UBpg3Cq9qrJjXTR8
D+f/HqclQFFLBZpaU3MZy4MbDsAfEqt393zz2HO6TDm71bOcoXUINgBaGIsl58Cg
rTbuC/1AT3kcbk1m4awOG2tiACpCPUd7mkzmMOT+x2xrjwmXIX/qqT7lQqlggdbk
tbyBJG7Vbi6IP2zeU6g8evMzs/juMnZX1C394QP7aAEA1dK9R4x90yN6jwTX4mJH
JbvY7VsnwbZwk2knFmWsWE27qnlV6CsUWr5H+l6YIi1zasQKWtc7f59KH/6HEqVG
6cqR1tQq2CLfnvIO4ey/cipQuXFMT0tIWYJjmJwOB8Dh/gzGh9STRsRoyGHm4gvb
fwsw0KcO2wuuNMrd92/6UIf8zg/qoThJUElzHgOWmHnAp1CFMDZTdtnqqQWUEHxy
YgzBCL8HsFb/XJrEYBu1x2EqfjbvWp/IKLG/9gOFgpNOr0N3Io3tBtqVQ97HF2ew
fD8dOs9URuKeN50aTkqjsJbn26F+lPpFJy6g+tcol//vByyi/TE=
=RNdT
-----END PGP SIGNATURE-----

--1sRCvMxxUhYeIgyG--
