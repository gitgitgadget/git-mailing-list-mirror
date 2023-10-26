Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472EE2D033
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CyBPzH5O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RSzC9eya"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADE118F
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 02:56:53 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 35F9F32009EE;
	Thu, 26 Oct 2023 05:56:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 26 Oct 2023 05:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698314211; x=1698400611; bh=fu
	2FvTtyzOtBibpJyiVHRxHo+Vd+9SBwQ5fZS+M22yw=; b=CyBPzH5OfpoLTelSFi
	fHNrlukMOLorIbkUKjyEWLnQiA01YefEPvEcRlpoEI7JCXcNoF6ss7AKkVujYvXz
	3C6wNEKyUeEchQFkuru/QPUPWEVB1xVDSiRdmAuvBTcpsImXIDmEVoYD5HsaKukb
	e8m9x+7CKL2N1I+/MQgupAoj88Ikz34SLJMDHZ5lwV50C8cC/VVNWDK4vDLdGQpw
	u1VLYCthDGhnUr1u+KwPcneAPgshsldDlHQbWccwRQ4O84gfXWU6aAc/NLr7mdur
	DhQAQlFnRjOZeQKKkotPWnH1lik6Rhy1snrCp/BnTO8rikhWyoTlKBdyUw3eNQ57
	1RGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698314211; x=1698400611; bh=fu2FvTtyzOtBi
	bpJyiVHRxHo+Vd+9SBwQ5fZS+M22yw=; b=RSzC9eya97WATvxe8Ou25jE83/3r7
	im3MwQOBnafehOcHvpNCETOSpEN1YOkKe7whtC9y99x0GSqZB0DijNMNToaNj2/T
	M25zc7RQ841YEAp4eWhEa6uM4AmJns0oYACMpLnvkT7iiLQ43r8chRpVnyQ0MKpr
	YlevkWTftRckOBTBhB0hOrXRALdVlBq96xiJQUcw66TCH5nOcq8YGTtwk8VbgMNm
	htwVH45hFZpCRou+WywopxgQ8dxnZMexSU/oYtJBInLi8Ufj8auV0bWD3Tgx2d7e
	9KG2VPOewC7H4FTDgHU58IhU5Hi1V2PM4z8sb7dLXywEPiqrHfXS6Mrhw==
X-ME-Sender: <xms:4zc6ZUJLm9lnhRqgxzvA9D0rh3mHq7tZtD9U2NKo707gWxh7klvhyQ>
    <xme:4zc6ZUJzihE6X4gmF8Xa8KEOD8oVmOpZewl2CZDaZQ-YQ_FZ5895r4W7BsKGngRA3
    7Q9gczp-Z7XdfFV-A>
X-ME-Received: <xmr:4zc6ZUu3uE9NLe3DXVRezTQLExaj-Ci12lB_z_MwFq7RU00Ua30VIE3InRVkk5_R2HCt2dOmD6sR_DwYpMC84DEX-vjIOoPMOcFKAgyz0tIR4NY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:4zc6ZRbZWi7TfFUgtOzNT3nQV2jLr10ZEunN4nWUXAfg2N9VnceRWw>
    <xmx:4zc6Zbb2Q8yisSwqppdQuqZZGKgYK81rNfPntmiTnFrRf7cq8ghuxg>
    <xmx:4zc6ZdArRs0Eucq8TJPWRp7F-1FwOCJVgIaQqdYHSdnObQ0VBvwJaQ>
    <xmx:4zc6ZankFvpQ8tVlupMwHp35CkyMTvVUOkgRK-29REs-S0HTsKIK_Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 05:56:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 38bf0267 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Oct 2023 09:56:41 +0000 (UTC)
Date: Thu, 26 Oct 2023 11:56:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v2 07/12] builtin/show-ref: stop using global vars for
 `show_one()`
Message-ID: <63f1dadf4c2e58439fde6489ee1ae33819f83462.1698314128.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/8KDWpPUYOdcKmDw"
Content-Disposition: inline
In-Reply-To: <cover.1698314128.git.ps@pks.im>


--/8KDWpPUYOdcKmDw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `show_one()` function implicitly receives a bunch of options which
are tracked via global variables. This makes it hard to see which
subcommands of git-show-ref(1) actually make use of these options.

Introduce a `show_one_options` structure that gets passed down to this
function. This allows us to get rid of more global state and makes it
more explicit which subcommands use those options.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 62 ++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index c30c01785cc..3e6ad6b6a84 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -18,10 +18,17 @@ static const char * const show_ref_usage[] =3D {
 	NULL
 };
=20
-static int deref_tags, show_head, tags_only, heads_only, verify,
-	   quiet, hash_only, abbrev;
+static int show_head, tags_only, heads_only, verify;
=20
-static void show_one(const char *refname, const struct object_id *oid)
+struct show_one_options {
+	int quiet;
+	int hash_only;
+	int abbrev;
+	int deref_tags;
+};
+
+static void show_one(const struct show_one_options *opts,
+		     const char *refname, const struct object_id *oid)
 {
 	const char *hex;
 	struct object_id peeled;
@@ -30,25 +37,26 @@ static void show_one(const char *refname, const struct =
object_id *oid)
 		die("git show-ref: bad ref %s (%s)", refname,
 		    oid_to_hex(oid));
=20
-	if (quiet)
+	if (opts->quiet)
 		return;
=20
-	hex =3D repo_find_unique_abbrev(the_repository, oid, abbrev);
-	if (hash_only)
+	hex =3D repo_find_unique_abbrev(the_repository, oid, opts->abbrev);
+	if (opts->hash_only)
 		printf("%s\n", hex);
 	else
 		printf("%s %s\n", hex, refname);
=20
-	if (!deref_tags)
+	if (!opts->deref_tags)
 		return;
=20
 	if (!peel_iterated_oid(oid, &peeled)) {
-		hex =3D repo_find_unique_abbrev(the_repository, &peeled, abbrev);
+		hex =3D repo_find_unique_abbrev(the_repository, &peeled, opts->abbrev);
 		printf("%s %s^{}\n", hex, refname);
 	}
 }
=20
 struct show_ref_data {
+	const struct show_one_options *show_one_opts;
 	const char **patterns;
 	int found_match;
 };
@@ -81,7 +89,7 @@ static int show_ref(const char *refname, const struct obj=
ect_id *oid,
 match:
 	data->found_match++;
=20
-	show_one(refname, oid);
+	show_one(data->show_one_opts, refname, oid);
=20
 	return 0;
 }
@@ -149,7 +157,8 @@ static int cmd_show_ref__exclude_existing(const struct =
exclude_existing_options
 	return 0;
 }
=20
-static int cmd_show_ref__verify(const char **refs)
+static int cmd_show_ref__verify(const struct show_one_options *show_one_op=
ts,
+				const char **refs)
 {
 	if (!refs || !*refs)
 		die("--verify requires a reference");
@@ -159,9 +168,9 @@ static int cmd_show_ref__verify(const char **refs)
=20
 		if ((starts_with(*refs, "refs/") || !strcmp(*refs, "HEAD")) &&
 		    !read_ref(*refs, &oid)) {
-			show_one(*refs, &oid);
+			show_one(show_one_opts, *refs, &oid);
 		}
-		else if (!quiet)
+		else if (!show_one_opts->quiet)
 			die("'%s' - not a valid ref", *refs);
 		else
 			return 1;
@@ -171,9 +180,12 @@ static int cmd_show_ref__verify(const char **refs)
 	return 0;
 }
=20
-static int cmd_show_ref__patterns(const char **patterns)
+static int cmd_show_ref__patterns(const struct show_one_options *show_one_=
opts,
+				  const char **patterns)
 {
-	struct show_ref_data show_ref_data =3D {0};
+	struct show_ref_data show_ref_data =3D {
+		.show_one_opts =3D show_one_opts,
+	};
=20
 	if (patterns && *patterns)
 		show_ref_data.patterns =3D patterns;
@@ -196,11 +208,16 @@ static int cmd_show_ref__patterns(const char **patter=
ns)
=20
 static int hash_callback(const struct option *opt, const char *arg, int un=
set)
 {
-	hash_only =3D 1;
+	struct show_one_options *opts =3D opt->value;
+	struct option abbrev_opt =3D *opt;
+
+	opts->hash_only =3D 1;
 	/* Use full length SHA1 if no argument */
 	if (!arg)
 		return 0;
-	return parse_opt_abbrev_cb(opt, arg, unset);
+
+	abbrev_opt.value =3D &opts->abbrev;
+	return parse_opt_abbrev_cb(&abbrev_opt, arg, unset);
 }
=20
 static int exclude_existing_callback(const struct option *opt, const char =
*arg,
@@ -216,6 +233,7 @@ static int exclude_existing_callback(const struct optio=
n *opt, const char *arg,
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
 	struct exclude_existing_options exclude_existing_opts =3D {0};
+	struct show_one_options show_one_opts =3D {0};
 	const struct option show_ref_options[] =3D {
 		OPT_BOOL(0, "tags", &tags_only, N_("only show tags (can be combined with=
 heads)")),
 		OPT_BOOL(0, "heads", &heads_only, N_("only show heads (can be combined w=
ith tags)")),
@@ -225,13 +243,13 @@ int cmd_show_ref(int argc, const char **argv, const c=
har *prefix)
 				N_("show the HEAD reference, even if it would be filtered out")),
 		OPT_BOOL(0, "head", &show_head,
 		  N_("show the HEAD reference, even if it would be filtered out")),
-		OPT_BOOL('d', "dereference", &deref_tags,
+		OPT_BOOL('d', "dereference", &show_one_opts.deref_tags,
 			    N_("dereference tags into object IDs")),
-		OPT_CALLBACK_F('s', "hash", &abbrev, N_("n"),
+		OPT_CALLBACK_F('s', "hash", &show_one_opts, N_("n"),
 			       N_("only show SHA1 hash using <n> digits"),
 			       PARSE_OPT_OPTARG, &hash_callback),
-		OPT__ABBREV(&abbrev),
-		OPT__QUIET(&quiet,
+		OPT__ABBREV(&show_one_opts.abbrev),
+		OPT__QUIET(&show_one_opts.quiet,
 			   N_("do not print results to stdout (useful with --verify)")),
 		OPT_CALLBACK_F(0, "exclude-existing", &exclude_existing_opts,
 			       N_("pattern"), N_("show refs from stdin that aren't in local rep=
ository"),
@@ -247,7 +265,7 @@ int cmd_show_ref(int argc, const char **argv, const cha=
r *prefix)
 	if (exclude_existing_opts.enabled)
 		return cmd_show_ref__exclude_existing(&exclude_existing_opts);
 	else if (verify)
-		return cmd_show_ref__verify(argv);
+		return cmd_show_ref__verify(&show_one_opts, argv);
 	else
-		return cmd_show_ref__patterns(argv);
+		return cmd_show_ref__patterns(&show_one_opts, argv);
 }
--=20
2.42.0


--/8KDWpPUYOdcKmDw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6N98ACgkQVbJhu7ck
PpQD1RAAj7d/XeRu7kcaaUSafOS4sbFdvOapgaKmssGvAHlDsJ6xslGca5n5VUNC
sfsn6jYpRR40eFdGhLC7E2koNCsEuJuHX3VPOeuggyFasO9bvVGUzvNx7vuvat0k
G5RFL9OnwCdGukw1ZRkQ4U0uPAufkP9CaXgO0jcynZoR3lvcuwKGqJf2l1lv7vWD
0FtKvXCiGT50c0cR7+SL9QNIbnwBvlwn9fbMqPmtpk3vvJh2R9qZFeka+mSHdb/a
E5JGWbLWtqJmd9Mov3mH8mzHZW+K1nH+Po8hvn2uHQweExCTb10k0GGUlT/WJKLQ
brol7nzWkPY3LhlSBhft4v8EH3AFUuufdezf6HldtA0Da2XAyhKH7qCM6ecxlz5C
tRrll+sznEVHbhNRKsNeO+vpiIQ3VCJp5vmK1qrwa9c2JX35QHfEhFQUAV7+RZ52
IOdUA/3dLV13XS0chnSUjNvCO7Z5693OBW/YU1/nkx5fgrL1hQb1DmLRFGHfhQjQ
gY3K0pOLdDThmOET1rFnfQUfdydw5rDUUvq4Z9L05S3rlgvvy/eqH9eJ2TfjT5bo
8XIR+9nzCCHNM7g5t3w3xzFWQwidEhrO3ApHnnVIsv1/PMQfojkEtUIZG7hrskvw
Dg1DjEtZ2lgqp8XMK0jhKUGmHlAPrxdQltkkPQYiDpNiz/v6o+w=
=m9b6
-----END PGP SIGNATURE-----

--/8KDWpPUYOdcKmDw--
