Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27D2D03B
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 09:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NLXZJUQg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TOzORDTR"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42701193
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 02:56:57 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 72A2532007CF;
	Thu, 26 Oct 2023 05:56:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 26 Oct 2023 05:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698314215; x=1698400615; bh=5l
	lSNq4xJ/qYO6+GDJxCg7b88d6n/9i2oxG35BMS8S8=; b=NLXZJUQgh8+QH0keI7
	OQ4pChWz4/7S5o0yDWREuilYLQJ5wMrYNwlGk6ghwtpy9JDllMz1Q30pvXjT21GU
	5HuMDGkQfBiyq0ZD+5WNDjnY+94dBFYpCOUQ8VkcR0a/fTWShJ/DGkKat4pe5CCF
	49z9KVciX699H8CbR9pVDvGW3fDb27jgSJ4Kub97xxm3hBSA0eg4dt1kbbb/0hsm
	H0QahliuYQr/ikFnf+8Qoom6a6e0wMEu3pR5QSAj0EszEa5Yqz9D7/sChqaFDq6i
	I6K9uHCS6gakxZHSJJg7JeDeMr5po713CaETEY7E10fBnH9iqCm+Q0Ois3S03WXM
	DNSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698314215; x=1698400615; bh=5llSNq4xJ/qYO
	6+GDJxCg7b88d6n/9i2oxG35BMS8S8=; b=TOzORDTRXdzi0VqA1aLswgfZzgSzz
	W3bS08PvxE3zN+AnjET01z5a8QMTCrbjnINb9VF8qStnNsKmyX4qp1Topduz2AAW
	wsA2nujTkGdqIyLiBbKQeUXizKDydGQZxb//kjZfbNzBHQwGuoi7vS3fJnQNONWe
	17MuBhu5LQbsBJpaibDC14yeffjwdWgqiPc0cnF5mzTr28ypjSxWsD9PGmw+Rv7w
	tmpUSWKG3NwEEbVAf8asjFV9Jp2kNd9UbAXglLxqQwrBFePRd9orLtyra3+QYSFT
	JGK1q6TB6bsqZYCNTKcZEtktVjZMjqLfgKJ/U3VNoIsLfZPeaCtsjIDXQ==
X-ME-Sender: <xms:5zc6ZYaD4-E8YFhZCw7k11AWYsNv1TJfgtF0D1T4SbaD7gGafcYZQA>
    <xme:5zc6ZTaAh1F-ZDBmhyhwtufBoriXEDVWKqRSLNVWzxpAHjZW7jppapNAsZw3Ld0jy
    WnXIY7-KzSfc0aqbQ>
X-ME-Received: <xmr:5zc6ZS9zCnFg6ubRbG_gsJyaHdyQwtC2PT_pmR3hdaozHXwVEgyisn5zc9C3x6e9nb2qlnI0JfW8PidHI1pzPbwHSMbHmwhS3IQLH1PdYYmDNX0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:5zc6ZSqxJrs66wcDXL6Y7Gj4LWl6x7l1KZ5Pu5nrkBQTGstZ-qaC0A>
    <xmx:5zc6ZTrvoG1657VkhvM2JReIe39XBlraQXad5LDuqIs9sAgZiTubWA>
    <xmx:5zc6ZQSU0pr5jR06xsjfQKOZLwBHMHxufqHJqJvS2Dgnd2YqNX7Isw>
    <xmx:5zc6Za3pgGx7a9mkfuMkqTqUKtDf7mlxQWIdu57TjnV01jhEfzNStg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 05:56:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6cfbab53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Oct 2023 09:56:45 +0000 (UTC)
Date: Thu, 26 Oct 2023 11:56:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v2 08/12] builtin/show-ref: refactor options for patterns
 subcommand
Message-ID: <88dfeaa4871be057eba2625ee562cdd079e540c8.1698314128.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KBCatX1q1cwBd6Lj"
Content-Disposition: inline
In-Reply-To: <cover.1698314128.git.ps@pks.im>


--KBCatX1q1cwBd6Lj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The patterns subcommand is the last command that still uses global
variables to track its options. Convert it to use a structure instead
with the same motivation as preceding commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 3e6ad6b6a84..87bc45d2d13 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -18,8 +18,6 @@ static const char * const show_ref_usage[] =3D {
 	NULL
 };
=20
-static int show_head, tags_only, heads_only, verify;
-
 struct show_one_options {
 	int quiet;
 	int hash_only;
@@ -59,6 +57,7 @@ struct show_ref_data {
 	const struct show_one_options *show_one_opts;
 	const char **patterns;
 	int found_match;
+	int show_head;
 };
=20
 static int show_ref(const char *refname, const struct object_id *oid,
@@ -66,7 +65,7 @@ static int show_ref(const char *refname, const struct obj=
ect_id *oid,
 {
 	struct show_ref_data *data =3D cbdata;
=20
-	if (show_head && !strcmp(refname, "HEAD"))
+	if (data->show_head && !strcmp(refname, "HEAD"))
 		goto match;
=20
 	if (data->patterns) {
@@ -180,22 +179,30 @@ static int cmd_show_ref__verify(const struct show_one=
_options *show_one_opts,
 	return 0;
 }
=20
-static int cmd_show_ref__patterns(const struct show_one_options *show_one_=
opts,
+struct patterns_options {
+	int show_head;
+	int heads_only;
+	int tags_only;
+};
+
+static int cmd_show_ref__patterns(const struct patterns_options *opts,
+				  const struct show_one_options *show_one_opts,
 				  const char **patterns)
 {
 	struct show_ref_data show_ref_data =3D {
 		.show_one_opts =3D show_one_opts,
+		.show_head =3D opts->show_head,
 	};
=20
 	if (patterns && *patterns)
 		show_ref_data.patterns =3D patterns;
=20
-	if (show_head)
+	if (opts->show_head)
 		head_ref(show_ref, &show_ref_data);
-	if (heads_only || tags_only) {
-		if (heads_only)
+	if (opts->heads_only || opts->tags_only) {
+		if (opts->heads_only)
 			for_each_fullref_in("refs/heads/", show_ref, &show_ref_data);
-		if (tags_only)
+		if (opts->tags_only)
 			for_each_fullref_in("refs/tags/", show_ref, &show_ref_data);
 	} else {
 		for_each_ref(show_ref, &show_ref_data);
@@ -233,15 +240,17 @@ static int exclude_existing_callback(const struct opt=
ion *opt, const char *arg,
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
 	struct exclude_existing_options exclude_existing_opts =3D {0};
+	struct patterns_options patterns_opts =3D {0};
 	struct show_one_options show_one_opts =3D {0};
+	int verify =3D 0;
 	const struct option show_ref_options[] =3D {
-		OPT_BOOL(0, "tags", &tags_only, N_("only show tags (can be combined with=
 heads)")),
-		OPT_BOOL(0, "heads", &heads_only, N_("only show heads (can be combined w=
ith tags)")),
+		OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only show tags (can be=
 combined with heads)")),
+		OPT_BOOL(0, "heads", &patterns_opts.heads_only, N_("only show heads (can=
 be combined with tags)")),
 		OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
 			    "requires exact ref path")),
-		OPT_HIDDEN_BOOL('h', NULL, &show_head,
+		OPT_HIDDEN_BOOL('h', NULL, &patterns_opts.show_head,
 				N_("show the HEAD reference, even if it would be filtered out")),
-		OPT_BOOL(0, "head", &show_head,
+		OPT_BOOL(0, "head", &patterns_opts.show_head,
 		  N_("show the HEAD reference, even if it would be filtered out")),
 		OPT_BOOL('d', "dereference", &show_one_opts.deref_tags,
 			    N_("dereference tags into object IDs")),
@@ -267,5 +276,5 @@ int cmd_show_ref(int argc, const char **argv, const cha=
r *prefix)
 	else if (verify)
 		return cmd_show_ref__verify(&show_one_opts, argv);
 	else
-		return cmd_show_ref__patterns(&show_one_opts, argv);
+		return cmd_show_ref__patterns(&patterns_opts, &show_one_opts, argv);
 }
--=20
2.42.0


--KBCatX1q1cwBd6Lj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6N+QACgkQVbJhu7ck
PpTQLg/+MgT+zVniYcd32pWCc/C9HkveWMNcpPiDYQaTnzq3grA1hC16daLxiHhc
2p+bPGY3ZM5SH5+hBsma8ZGX9zjTtrZHS8QknuAfnR9kmiGgGJ1Kd/Fq95lUXU/6
2G77JR3LLiNqokp0WPesvyARTZtE8fhi4+DsqE17i6nc/TgBDRl+e4rYSQKCRhSm
jrd3ppfBV9R9OzRIb0wiuOBem3iApL92F8JrdfvFjSll8wxy7ovr7kjhIkg0zYvO
JTXXP2rgD6yo/n5HdmF5i3c97rYWixrAywITbFZva2hGJhs+cLG8WuNpNQxjsZA9
FnA7IGDbGMmr4lzVCnnlv2NClvsE0hUQB0pDDTy1kEJT2Bg9N9L7lkDHevka/M4i
Trxt10F3v7GZ+IGWcB6eiWKp04IBrOnoqQsd9MW1lPXcCvhFmLT6H1g3S80zKtNM
dXwyv+oZL8kyeKgiEo9ksvbRWHlx85A8fLBxFTKFiEcp9/Ce/uslYTAGqhX+hojG
oEQA4p+qpnbZkEYMPBYLR74uxLuH3QAkqumAqhzMJ8eWarXpKprRXgRSVQl7HKDn
9NBCW1m11Piw1COV6ZJydZDU5tfSFTsRFd8XsjOOma4pUv0Eax+5qm/BzzX7p1ug
UNOFsqqfY8AkzgwqiutNY/EkgYRLKBkA5HxYAqUfOs179ADMSps=
=C7eI
-----END PGP SIGNATURE-----

--KBCatX1q1cwBd6Lj--
