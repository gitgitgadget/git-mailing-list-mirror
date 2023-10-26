Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881BD2D02E
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hR5/B0dc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bmpXolXJ"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF64319D
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 02:57:09 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 23FE032009E0;
	Thu, 26 Oct 2023 05:57:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 26 Oct 2023 05:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698314228; x=1698400628; bh=9K
	K9a7oRQWFccu2SHYcosZ2fI/Cx+XYJDPRyBPhiPdQ=; b=hR5/B0dcxZIET9yzR4
	9o6BttpCtgo/IBzewq8m49OsO5KW+mH43OLVWkeUXT6Ks8KgZ1nd2a5lxt3s6ucO
	Gu/KHNP4ODwGsUa73Y5FSmDtZzblyp6+rq8jpx10Xa7xqKSTpJuO+OeP5JikdM/C
	wXVZE2klvmiaDwARnk8HEPjxA8J8kd6JPBudoBPRHKWimBpshd+3QnyaPbUA8/5K
	6kiWcnHr2RH0Rrj2Coez8fChTrUT+pLoeQy801UfppoVIKax+Am3AqG3wT9VUNmP
	Gw/lWfT+D/dQcgBhnmZVKNVI/zAcMAHYvroN2nbZtp2hZBzYO27912iLWkE13ALx
	uZhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698314228; x=1698400628; bh=9KK9a7oRQWFcc
	u2SHYcosZ2fI/Cx+XYJDPRyBPhiPdQ=; b=bmpXolXJz1MGW2KMggdiQQfqXOpLG
	LZQI+p1ZbKcwg3hBWiDeXFw+prcs4n4qMJDGzzaRiGfPJWPCQ5pV08QOKYvxeOdh
	8LIgUpZ1dl4gTU2nL7EgD3nO4k6zUDwIcZekWKlwaB7maRRdWVj9ha8hmAInpaV7
	xDtzDbT0s+EJARvbMXP2SBiqmb0Xys3O07hgiqqhNY5LY4+SqDE5cPxnE1xNHL2v
	ls0w4NVxA5mExgWx59H80jdd0ghDkrp1UzIBqaoUA3F1mJ0CfQEzp3F1L/vv2u53
	+3xdXuhIssybJyrScDyz8IwCOg6t5sKVxRLIfE/zKIpaO+jRyygD3lMog==
X-ME-Sender: <xms:9Dc6Zc3Iquv6FRkgg8qyc4sN6uHigEMgj4_Z97bbuXdE35uqBSJmyQ>
    <xme:9Dc6ZXHJEfOaoTKoUNOyU8h2marOaF1YAeYiskEs4Q8rguVUEq_YO3Q0Xn8e0NKVt
    JJAiruEK0rxyXTf_Q>
X-ME-Received: <xmr:9Dc6ZU6jGiNBr96f5RbUFAIl9OSp9J8cWAbHK-kb1o6x06NSBBL_mmk1HzRMwMt6tOGOhtllFzUpJFVZmWCZLa33R9tne38PkRht99FQQyECfwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:9Dc6ZV0I21V3EUDufnHGj6Z-eC-e_nDxECUXL6UVKpbXXrYowGpeIg>
    <xmx:9Dc6ZfHhxe9du08yT6pUPdtSvbojbW-GacgJv7ncjCL4dAypFBQeTQ>
    <xmx:9Dc6Ze9VUqmAE6BRmW-fvZMXKTs8PUrel2JQVul_EJ_AqsNfXiOBQQ>
    <xmx:9Dc6ZUTcduMx0Y72nDknUQtvOL-WJND0NjEPZxI99L6mORH8YzIUmQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 05:57:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aef9cf63 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Oct 2023 09:56:59 +0000 (UTC)
Date: Thu, 26 Oct 2023 11:57:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v2 11/12] builtin/show-ref: add new mode to check for
 reference existence
Message-ID: <327942b116293593deca668842a4f32db7acb0e5.1698314128.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wm2I2jNPFoHBYfpP"
Content-Disposition: inline
In-Reply-To: <cover.1698314128.git.ps@pks.im>


--wm2I2jNPFoHBYfpP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While we have multiple ways to show the value of a given reference, we
do not have any way to check whether a reference exists at all. While
commands like git-rev-parse(1) or git-show-ref(1) can be used to check
for reference existence in case the reference resolves to something
sane, neither of them can be used to check for existence in some other
scenarios where the reference does not resolve cleanly:

    - References which have an invalid name cannot be resolved.

    - References to nonexistent objects cannot be resolved.

    - Dangling symrefs can be resolved via git-symbolic-ref(1), but this
      requires the caller to special case existence checks depending on
      whether or not a reference is symbolic or direct.

Furthermore, git-rev-list(1) and other commands do not let the caller
distinguish easily between an actually missing reference and a generic
error.

Taken together, this seems like sufficient motivation to introduce a
separate plumbing command to explicitly check for the existence of a
reference without trying to resolve its contents.

This new command comes in the form of `git show-ref --exists`. This
new mode will exit successfully when the reference exists, with a
specific exit code of 2 when it does not exist, or with 1 when there
has been a generic error.

Note that the only way to properly implement this command is by using
the internal `refs_read_raw_ref()` function. While the public function
`refs_resolve_ref_unsafe()` can be made to behave in the same way by
passing various flags, it does not provide any way to obtain the errno
with which the reference backend failed when reading the reference. As
such, it becomes impossible for us to distinguish generic errors from
the explicit case where the reference wasn't found.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-show-ref.txt | 11 ++++++
 builtin/show-ref.c             | 49 ++++++++++++++++++++++---
 t/t1403-show-ref.sh            | 67 +++++++++++++++++++++++++++++++++-
 3 files changed, 121 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 22f5ebc6a92..8fecc9e80f6 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	     [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]
 	     [--] [<ref>...]
 'git show-ref' --exclude-existing[=3D<pattern>]
+'git show-ref' --exists <ref>
=20
 DESCRIPTION
 -----------
@@ -30,6 +31,10 @@ The `--exclude-existing` form is a filter that does the =
inverse. It reads
 refs from stdin, one ref per line, and shows those that don't exist in
 the local repository.
=20
+The `--exists` form can be used to check for the existence of a single
+references. This form does not verify whether the reference resolves to an
+actual object.
+
 Use of this utility is encouraged in favor of directly accessing files und=
er
 the `.git` directory.
=20
@@ -65,6 +70,12 @@ OPTIONS
 	Aside from returning an error code of 1, it will also print an error
 	message if `--quiet` was not specified.
=20
+--exists::
+
+	Check whether the given reference exists. Returns an exit code of 0 if
+	it does, 2 if it is missing, and 1 in case looking up the reference
+	failed with an error other than the reference being missing.
+
 --abbrev[=3D<n>]::
=20
 	Abbreviate the object name.  When using `--hash`, you do
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index d4561d7ce1f..2cbe4e3f721 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -2,7 +2,7 @@
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
-#include "refs.h"
+#include "refs/refs-internal.h"
 #include "object-name.h"
 #include "object-store-ll.h"
 #include "object.h"
@@ -18,6 +18,7 @@ static const char * const show_ref_usage[] =3D {
 	   "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]\n"
 	   "             [--] [<ref>...]"),
 	N_("git show-ref --exclude-existing[=3D<pattern>]"),
+	N_("git show-ref --exists <ref>"),
 	NULL
 };
=20
@@ -216,6 +217,41 @@ static int cmd_show_ref__patterns(const struct pattern=
s_options *opts,
 	return 0;
 }
=20
+static int cmd_show_ref__exists(const char **refs)
+{
+	struct strbuf unused_referent =3D STRBUF_INIT;
+	struct object_id unused_oid;
+	unsigned int unused_type;
+	int failure_errno =3D 0;
+	const char *ref;
+	int ret =3D 0;
+
+	if (!refs || !*refs)
+		die("--exists requires a reference");
+	ref =3D *refs++;
+	if (*refs)
+		die("--exists requires exactly one reference");
+
+	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
+			      &unused_oid, &unused_referent, &unused_type,
+			      &failure_errno)) {
+		if (failure_errno =3D=3D ENOENT) {
+			error(_("reference does not exist"));
+			ret =3D 2;
+		} else {
+			errno =3D failure_errno;
+			error_errno(_("failed to look up reference"));
+			ret =3D 1;
+		}
+
+		goto out;
+	}
+
+out:
+	strbuf_release(&unused_referent);
+	return ret;
+}
+
 static int hash_callback(const struct option *opt, const char *arg, int un=
set)
 {
 	struct show_one_options *opts =3D opt->value;
@@ -245,10 +281,11 @@ int cmd_show_ref(int argc, const char **argv, const c=
har *prefix)
 	struct exclude_existing_options exclude_existing_opts =3D {0};
 	struct patterns_options patterns_opts =3D {0};
 	struct show_one_options show_one_opts =3D {0};
-	int verify =3D 0;
+	int verify =3D 0, exists =3D 0;
 	const struct option show_ref_options[] =3D {
 		OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only show tags (can be=
 combined with heads)")),
 		OPT_BOOL(0, "heads", &patterns_opts.heads_only, N_("only show heads (can=
 be combined with tags)")),
+		OPT_BOOL(0, "exists", &exists, N_("check for reference existence without=
 resolving")),
 		OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
 			    "requires exact ref path")),
 		OPT_HIDDEN_BOOL('h', NULL, &patterns_opts.show_head,
@@ -274,14 +311,16 @@ int cmd_show_ref(int argc, const char **argv, const c=
har *prefix)
 	argc =3D parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, 0);
=20
-	if ((!!exclude_existing_opts.enabled + !!verify) > 1)
-		die(_("only one of '%s' or '%s' can be given"),
-		    "--exclude-existing", "--verify");
+	if ((!!exclude_existing_opts.enabled + !!verify + !!exists) > 1)
+		die(_("only one of '%s', '%s' or '%s' can be given"),
+		    "--exclude-existing", "--verify", "--exists");
=20
 	if (exclude_existing_opts.enabled)
 		return cmd_show_ref__exclude_existing(&exclude_existing_opts);
 	else if (verify)
 		return cmd_show_ref__verify(&show_one_opts, argv);
+	else if (exists)
+		return cmd_show_ref__exists(argv);
 	else
 		return cmd_show_ref__patterns(&patterns_opts, &show_one_opts, argv);
 }
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 4a90a88e05d..b50ae6fcf11 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -197,8 +197,73 @@ test_expect_success 'show-ref --verify with dangling r=
ef' '
 '
=20
 test_expect_success 'show-ref sub-modes are mutually exclusive' '
+	cat >expect <<-EOF &&
+	fatal: only one of ${SQ}--exclude-existing${SQ}, ${SQ}--verify${SQ} or ${=
SQ}--exists${SQ} can be given
+	EOF
+
 	test_must_fail git show-ref --verify --exclude-existing 2>err &&
-	grep "only one of ${SQ}--exclude-existing${SQ} or ${SQ}--verify${SQ} can =
be given" err
+	test_cmp expect err &&
+
+	test_must_fail git show-ref --verify --exists 2>err &&
+	test_cmp expect err &&
+
+	test_must_fail git show-ref --exclude-existing --exists 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success '--exists with existing reference' '
+	git show-ref --exists refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+'
+
+test_expect_success '--exists with missing reference' '
+	test_expect_code 2 git show-ref --exists refs/heads/does-not-exist
+'
+
+test_expect_success '--exists does not use DWIM' '
+	test_expect_code 2 git show-ref --exists $GIT_TEST_DEFAULT_INITIAL_BRANCH=
_NAME 2>err &&
+	grep "reference does not exist" err
+'
+
+test_expect_success '--exists with HEAD' '
+	git show-ref --exists HEAD
+'
+
+test_expect_success '--exists with bad reference name' '
+	test_when_finished "git update-ref -d refs/heads/bad...name" &&
+	new_oid=3D$(git rev-parse HEAD) &&
+	test-tool ref-store main update-ref msg refs/heads/bad...name $new_oid $Z=
ERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+	git show-ref --exists refs/heads/bad...name
+'
+
+test_expect_success '--exists with arbitrary symref' '
+	test_when_finished "git symbolic-ref -d refs/symref" &&
+	git symbolic-ref refs/symref refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_=
NAME &&
+	git show-ref --exists refs/symref
+'
+
+test_expect_success '--exists with dangling symref' '
+	test_when_finished "git symbolic-ref -d refs/heads/dangling" &&
+	git symbolic-ref refs/heads/dangling refs/heads/does-not-exist &&
+	git show-ref --exists refs/heads/dangling
+'
+
+test_expect_success '--exists with nonexistent object ID' '
+	test-tool ref-store main update-ref msg refs/heads/missing-oid $(test_oid=
 001) $ZERO_OID REF_SKIP_OID_VERIFICATION &&
+	git show-ref --exists refs/heads/missing-oid
+'
+
+test_expect_success '--exists with non-commit object' '
+	tree_oid=3D$(git rev-parse HEAD^{tree}) &&
+	test-tool ref-store main update-ref msg refs/heads/tree ${tree_oid} $ZERO=
_OID REF_SKIP_OID_VERIFICATION &&
+	git show-ref --exists refs/heads/tree
+'
+
+test_expect_success '--exists with directory fails with generic error' '
+	cat >expect <<-EOF &&
+	error: failed to look up reference: Is a directory
+	EOF
+	test_expect_code 1 git show-ref --exists refs/heads 2>err &&
+	test_cmp expect err
 '
=20
 test_done
--=20
2.42.0


--wm2I2jNPFoHBYfpP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6N/EACgkQVbJhu7ck
PpSzBQ/9FdPPyQ1P5qP4zOpPdWDzY3vhEqt5GJLVvY+6A2Mhi7L8VLSxc63Tl5G4
d++wggqf0OHYtVuZhl6yScM3ziKxhKJYEKTHy187wc87rqfMH7X88m4RUPRQgrFM
ZIEUii4w7+oxcpCD9IHMg8WhZa5b4K8VhZLlMESrQUa50WLCD7gPnbJAyz2+ueSP
pty+SeJPHumZjLJoVQHFGUfBjVfjuTOI+j6mLzjhYy4WVLGNPqKPBuQKT3Iary5H
o5MQHqK/D0V9CWVSV15EZQbvjsShp8L6q4Cx+67ZL9PUPg5OAnYtRMJXMATrC+W4
8zXPv8fFWwKLr0fhUrJb1vo0tYeePwvoE/KXkrETsGgf++hy0WYefyHyRhCNdrzT
wDf8rb2o0I/APwoQBUdHIk/lEkthhCJYmfFliX0anMSUmJo+pgvQP+w0HdhClicw
Zxr3Usx3w8H7h+XUIp1sOt6xsFLpGBmL1YRdKf2V8ZXRQWXXIykATiX2UV9xAay0
DPMafXNUyHcmMaIoXWL/tcXhG7IDEhRn4SkV8O4s1SNQb5hiNWEjqxpQg6DE+Xcx
lWR63fe+XxU3xkgApvHokTyBYsvG/AcHU0YOzzqqpDmNXThTOvK143IpWlsNLa39
gqBfH3/JVnwzbBBZdzicgXMw9XEysPxVZVxCcFH5QiDikgiI96Y=
=W04S
-----END PGP SIGNATURE-----

--wm2I2jNPFoHBYfpP--
