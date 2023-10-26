Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2348AD29
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zST6exJK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OKc63zdm"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF3B1A5
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 02:56:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 284B43200928;
	Thu, 26 Oct 2023 05:56:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 26 Oct 2023 05:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698314187; x=1698400587; bh=w8
	bmCXcQ6tCeqrFz8/9w8fksdWwooBhWSZLNWX3QQcY=; b=zST6exJKglJ1Mlf9vC
	p7qdA5sLXa0me10vdR5Ziglv/Wd7ICpa2lqhlebbDdyGjIUCLLhRR4p5Nwoq1DQP
	70f2drd5XXIms3ghnP66Dfv6qqZXRGT+g+1XO4o+k6qnRRcvnpEPUm9jVmaWuw1D
	HGL6Gtt237yp4DCubEzhAdzGIrQ2O3WtNYuoEOpB4eVYUZw5QVYZ9tT0y9qLAvvF
	rgyirOq2ni2zg8kpOuuzxbGcTR/HP4eb7Y1dkxwntp4+hceucUIjVA6c7KgJw7tU
	VOr54cb/veJ72YVmJ/lVrfHpe1UPwW6EmYVQQqoMZc/gnuLTxTbJBAYr2urshZlx
	qciw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698314187; x=1698400587; bh=w8bmCXcQ6tCeq
	rFz8/9w8fksdWwooBhWSZLNWX3QQcY=; b=OKc63zdmy0Ww0S4n12lQOkFoSQ6XP
	giAwoj29DN0P2hoaT5QRdVKymD6G3ZV8Dmri1UlkshiRhJY4w5yumTe6SuGLz0To
	d1vZodUjRUGEGWLwS0cZ5YuDfzwBc3XQLrtHGwll3FVIYNW9DR8UIpRncfxwns4Q
	JqJd2MloIZKVVvD41laAqrI6CygiVnJUOas8sJMrsYA3llhqHJMtFOhILRLN/xb4
	Bhpp/0eQJgPm4W5WbyK7f86nwRt9oE0aQwzFvJ8J3OJYEuK/H3yNT1GaXR8ed7Pf
	9lLnvKXvDhgUu73FO+DKsbFNlPR2vWSXjWwL9DpLwmlN1bdl0Ydb/3b1A==
X-ME-Sender: <xms:yzc6ZaxEhAMoUwQsubLqxEwN0-6UfPkYWDlJDTGkjIjm5GVHwoh-zQ>
    <xme:yzc6ZWThiRMTHk1c7hxnXD77ZjDziUbs62kVb7lneENX9R9FXmKv1Hs02l1BX3a07
    zfIdEO4sCWMKEtcSg>
X-ME-Received: <xmr:yzc6ZcUnxakYjKDk8u0977SeL4epThZODMWJeHkaEaF8MBeN304ikT8Hv0kQ1cCBYQe9Uy1JJxDNlds1NOil1QMqfd-1ZPnQZzS0BmiNoye_T_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:yzc6ZQhZLC8QnuYztvzp3ONO1nlkNRTX1K17EZ_0N0Wfh_IxjuDMdA>
    <xmx:yzc6ZcDcgi0pOrK62QSDFCGCIo_WNJQmiZeG64SUj6UQQhZmRDtsnQ>
    <xmx:yzc6ZRIa83QdsWjVr5pjf-LCfJBdwzi8C6V3uDls7i3GUNONMzGBOA>
    <xmx:yzc6ZfPBhAm4UmQGSgHIIVnzCgiUQL3yd1Yo6d5kzWgDyu-HywHzkA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 05:56:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 33aea980 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Oct 2023 09:56:18 +0000 (UTC)
Date: Thu, 26 Oct 2023 11:56:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v2 02/12] builtin/show-ref: split up different subcommands
Message-ID: <9a234622d991186bf7a618bffbf15a936aba34c4.1698314128.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FN7q7rVphx3Ailwc"
Content-Disposition: inline
In-Reply-To: <cover.1698314128.git.ps@pks.im>


--FN7q7rVphx3Ailwc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While not immediately obvious, git-show-ref(1) actually implements three
different subcommands:

    - `git show-ref <patterns>` can be used to list references that
      match a specific pattern.

    - `git show-ref --verify <refs>` can be used to list references.
      These are _not_ patterns.

    - `git show-ref --exclude-existing` can be used as a filter that
      reads references from standard input, performing some conversions
      on each of them.

Let's make this more explicit in the code by splitting up the three
subcommands into separate functions. This also allows us to address the
confusingly named `patterns` variable, which may hold either patterns or
reference names.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 101 ++++++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 47 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 7efab14b96c..cad5b8b5066 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -104,7 +104,7 @@ static int add_existing(const char *refname,
  * (4) ignore if refname is a ref that exists in the local repository;
  * (5) otherwise output the line.
  */
-static int exclude_existing(const char *match)
+static int cmd_show_ref__exclude_existing(const char *match)
 {
 	static struct string_list existing_refs =3D STRING_LIST_INIT_DUP;
 	char buf[1024];
@@ -142,6 +142,54 @@ static int exclude_existing(const char *match)
 	return 0;
 }
=20
+static int cmd_show_ref__verify(const char **refs)
+{
+	if (!refs || !*refs)
+		die("--verify requires a reference");
+
+	while (*refs) {
+		struct object_id oid;
+
+		if ((starts_with(*refs, "refs/") || !strcmp(*refs, "HEAD")) &&
+		    !read_ref(*refs, &oid)) {
+			show_one(*refs, &oid);
+		}
+		else if (!quiet)
+			die("'%s' - not a valid ref", *refs);
+		else
+			return 1;
+		refs++;
+	}
+
+	return 0;
+}
+
+static int cmd_show_ref__patterns(const char **patterns)
+{
+	struct show_ref_data show_ref_data =3D {0};
+
+	if (patterns && *patterns)
+		show_ref_data.patterns =3D patterns;
+
+	if (show_head)
+		head_ref(show_ref, &show_ref_data);
+	if (heads_only || tags_only) {
+		if (heads_only)
+			for_each_fullref_in("refs/heads/", show_ref, &show_ref_data);
+		if (tags_only)
+			for_each_fullref_in("refs/tags/", show_ref, &show_ref_data);
+	} else {
+		for_each_ref(show_ref, &show_ref_data);
+	}
+	if (!found_match) {
+		if (verify && !quiet)
+			die("No match");
+		return 1;
+	}
+
+	return 0;
+}
+
 static int hash_callback(const struct option *opt, const char *arg, int un=
set)
 {
 	hash_only =3D 1;
@@ -185,56 +233,15 @@ static const struct option show_ref_options[] =3D {
=20
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
-	struct show_ref_data show_ref_data =3D {0};
-	const char **patterns;
-
 	git_config(git_default_config, NULL);
=20
 	argc =3D parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, 0);
=20
 	if (exclude_arg)
-		return exclude_existing(exclude_existing_arg);
-
-	patterns =3D argv;
-	if (!*patterns)
-		patterns =3D NULL;
-
-	if (verify) {
-		if (!patterns)
-			die("--verify requires a reference");
-		while (*patterns) {
-			struct object_id oid;
-
-			if ((starts_with(*patterns, "refs/") || !strcmp(*patterns, "HEAD")) &&
-			    !read_ref(*patterns, &oid)) {
-				show_one(*patterns, &oid);
-			}
-			else if (!quiet)
-				die("'%s' - not a valid ref", *patterns);
-			else
-				return 1;
-			patterns++;
-		}
-		return 0;
-	}
-
-	show_ref_data.patterns =3D patterns;
-
-	if (show_head)
-		head_ref(show_ref, &show_ref_data);
-	if (heads_only || tags_only) {
-		if (heads_only)
-			for_each_fullref_in("refs/heads/", show_ref, &show_ref_data);
-		if (tags_only)
-			for_each_fullref_in("refs/tags/", show_ref, &show_ref_data);
-	} else {
-		for_each_ref(show_ref, &show_ref_data);
-	}
-	if (!found_match) {
-		if (verify && !quiet)
-			die("No match");
-		return 1;
-	}
-	return 0;
+		return cmd_show_ref__exclude_existing(exclude_existing_arg);
+	else if (verify)
+		return cmd_show_ref__verify(argv);
+	else
+		return cmd_show_ref__patterns(argv);
 }
--=20
2.42.0


--FN7q7rVphx3Ailwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6N8gACgkQVbJhu7ck
PpRLERAAnVQn9J/SZw7ZzQtDHVyFEwOeC1UoepbMC9syHFQfhH+2DGsNxrWOeiEd
uj9JoiywGrFvzkIYhB8aFBI5iQdG/PBAtRy09iWh0MH2BAEAMtU1ZqqPjs1/kM7D
2iKXBmDtuZA6la0mqnHXEemrl032aBcjPSxZW8rLpOd4tsCd5JKDt0jRFx1WJNej
0V0V7n/yG+HYtqhlKneeSSmZTexqp7LmOrtTGUOGJz4tkNnkevVwAyEkMH1rUh7S
5ZP8VnXDEqagGVJhZAvwhIMxfKxXfIcC65lGMl+xkok9F1KeuG6CBdOf6HSSAzz1
Zoo7GtlChwAViySWWfS+EYeb8yhYkedyyidpRbHzY7zxXCFmXaj3ZfKljRhAB36V
OoQZSujcxCCA01Pancuh1fXn8Ey9Un2o27SE2dafkG0KzRzwhXdLNxwxqQ+ug4nH
UjjpMZCpey9anH2m088ohn0NvYyQP0wOLsK1MnEA9WSbmEN1Py+WEG3JkzxGDD47
ucU4/t51jrutUm2Y+F7bLJrUBt95jhwMk749Nu+Rk7nPFhIIE9VvLk0vJNGJO9tj
/ADOPQ0DTikbHMI5Zj4tFyc78+k19EPs9yFyL4NRnAPA5NsoCRLlFAVuq3aR/z7f
vtoFxRCWY1kN3EzLXvOKhvA8UWVw2JUOeWZzJn3aOZSHHkDTvRQ=
=xhSg
-----END PGP SIGNATURE-----

--FN7q7rVphx3Ailwc--
