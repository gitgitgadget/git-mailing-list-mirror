Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="HAxMikc0"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B4BF5
	for <git@vger.kernel.org>; Sun, 26 Nov 2023 03:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700999863; x=1701604663; i=l.s.r@web.de;
	bh=3WLRXjmGr2sZkzUHGGi6mmmZoAHZ2UACQnnE13vJ3Ns=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=HAxMikc0XBiNQPLSC4SIrIxzYCU2F+G5cqWGIOY2SVCNzL+I2W9oInPRuG5y9n/Y
	 QTaTHb7H8OYw2ldTAmhQyBoWJQ2B9OPXHD6LuaI7kV8g9mOOasXbmdzH4osEn9p4a
	 fSV3Xf0mHOoMwxcR8hDtpHfTi2XkrT4jV3rXlrMHu15vnvLDr0lCLP5mrHrTmxvyX
	 l0QadH1VrJvPZYsFFH6+4WNTWMQHJYD77fp/86DeskCQK4lmgCTMPCjDepjfkU9xQ
	 7qF10UWEMpWwUtYMxMLBwN5f2GcxdIcriD7nW3rKBy+MQxKo/BwR7zZzyQ6AtyP8y
	 oYWdgxjALDcl46/sTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.220]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0qv3-1rUErK1E6n-00wMdt; Sun, 26
 Nov 2023 12:57:43 +0100
Message-ID: <e6eb12e4-bb63-473c-9c2f-965a4d5981ad@web.de>
Date: Sun, 26 Nov 2023 12:57:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] i18n: factorize even more 'incompatible options' messages
Cc: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MMozrEwl0CgJPCGjdBWrKywEnBn2/1MulOvhIKQOIFY+p5nbxzF
 T1fH7H+wfIng7v3zgL1ujPA1W1WzEDSVpiXFZoNeEnwBgGinJ1bCEkXq7PHGNx9aOore/Vy
 Rx93QYTvG2YOhOq67p8FiOkjWEelo6KMrU1Rtfo/go4lSgA02J+o1v49MSlvbdaN76k89no
 lWodi5joWyYAlCU3FFmzg==
UI-OutboundReport: notjunk:1;M01:P0:gJdaj6NLxdc=;1JD2e7PeHgQi9IDoMApC/zX4QGz
 GmxWHGAe/zWH3wVIEPeb2xJl/C+1W5d+/NU3bDFZK+NLfX/1/MUALmxdVt30/71jdA7YUZICA
 EEL2toEzr7GxVpGDQ4Sg4vByHNDalFWDJioqoxA/vdGDe6rDjT88S2TCS4eNjHcmfZAy3cmpq
 yBh4AhmjkAGDtOfcFrGVfaRs8csKy5g4wJoDXBEmtF4FUUcxeXTxGA3XQ4jNobeov2pzebL5/
 S2AkUqx+xXHJ5hX+c4ebX8chgKPN7eBxVuDZMkFaItCUyuU+8I2y8tXKKuI2ufV5VS10rnHuF
 gHQD2HohdYCl1kWurgQLbVoOGzCZViefu2L89VjfJmaKXcSM1Cuh4BQkoRoxJooKoQLYcCUcZ
 4kz9pc30e7JLzSOj5sw3v5mKmoQPg9UU5NvGQnjd6Xr2OWAhuvWOc2W2Y0yzeVYhq/VXW6ivi
 92EnEgVeyNulnjlKycItHgGMv9J4c2pLxXeMT51TklGzia4RhHhyHJ5VmigwY3ywDrav4+fwA
 ydCIlTMUt7++idflIoqjbG9BGjJvY/PoULl27d5EYxJvV5EvfpQt0FRngUWBqqV8DxZMnMs8L
 TwZAnjSiO0M4bsUyZrXRJ6/xsA3QoGVdJfBGvZvTBO5cXqcBG8fbeZYq2l99XqFV6QXm9pjfK
 fsRwN0sCyElO6BTBQjxOJJfF0YrF0ZY8xYiXtcOeCbB7bY8Q892S9/tcaSlaCMshZAXSKAUjP
 siPY9gE1/gTgo8kvOw6VNPFQU9g+GtFtSvNZ0M5Wjc5/iNdKFOf6PQJfj4MYPTRbe/lE/zNb5
 rh3+wq8y0ei604SeB+5bopP9HfXA9gvmMBzp2c1jVYYUhvfY6vSjvlORxZ3qC7sGxWgOtB699
 X98LJChqMKnuDzEQ0zlVFCUptE1DosT2PBwvjlWD4/+ZVHG+cWya/aKRwB8BhCEpiInTf8OBz
 jBefJA==

Continue the work of 12909b6b8a (i18n: turn "options are incompatible"
into "cannot be used together", 2022-01-05) and a699367bb8 (i18n:
factorize more 'incompatible options' messages, 2022-01-31) to use the
same parameterized error message for reporting incompatible command line
options.  This reduces the number of strings to translate and makes the
UI slightly more consistent.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/clone.c                  | 4 +++-
 builtin/merge-tree.c             | 3 ++-
 parse-options.c                  | 3 ++-
 revision.c                       | 4 ++--
 t/t0040-parse-options.sh         | 8 ++++----
 t/t1006-cat-file.sh              | 2 +-
 t/t4301-merge-tree-write-tree.sh | 2 +-
 t/t5606-clone-options.sh         | 2 +-
 8 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index c6357af949..45a5070268 100644
=2D-- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -965,7 +965,9 @@ int cmd_clone(int argc, const char **argv, const char =
*prefix)
 	}

 	if (bundle_uri && deepen)
-		die(_("--bundle-uri is incompatible with --depth, --shallow-since, and =
--shallow-exclude"));
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--bundle-uri",
+		    "--depth/--shallow-since/--shallow-exclude");

 	repo_name =3D argv[0];

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index a35e0452d6..a4aa6013c5 100644
=2D-- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -577,7 +577,8 @@ int cmd_merge_tree(int argc, const char **argv, const =
char *prefix)
 		if (o.mode =3D=3D MODE_TRIVIAL)
 			die(_("--trivial-merge is incompatible with all other options"));
 		if (merge_base)
-			die(_("--merge-base is incompatible with --stdin"));
+			die(_("options '%s' and '%s' cannot be used together"),
+			    "--merge-base", "--stdin");
 		line_termination =3D '\0';
 		while (strbuf_getline_lf(&buf, stdin) !=3D EOF) {
 			struct strbuf **split;
diff --git a/parse-options.c b/parse-options.c
index e0c94b0546..c3955847f4 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -279,7 +279,8 @@ static enum parse_opt_result get_value(struct parse_op=
t_ctx_t *p,

 	opt_name =3D optnamearg(opt, arg, flags);
 	other_opt_name =3D optnamearg(elem->opt, elem->arg, elem->flags);
-	error(_("%s is incompatible with %s"), opt_name, other_opt_name);
+	error(_("options '%s' and '%s' cannot be used together"),
+	      opt_name, other_opt_name);
 	free(opt_name);
 	free(other_opt_name);
 	return -1;
diff --git a/revision.c b/revision.c
index 00d5c29bfc..b2861474b1 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -2384,8 +2384,8 @@ static int handle_revision_opt(struct rev_info *revs=
, int argc, const char **arg
 		revs->left_right =3D 1;
 	} else if (!strcmp(arg, "--left-only")) {
 		if (revs->right_only)
-			die("--left-only is incompatible with --right-only"
-			    " or --cherry");
+			die(_("options '%s' and '%s' cannot be used together"),
+			    "--left-only", "--right-only/--cherry");
 		revs->left_only =3D 1;
 	} else if (!strcmp(arg, "--right-only")) {
 		if (revs->left_only)
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 8fdef88b65..ec974867e4 100755
=2D-- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -376,7 +376,7 @@ test_expect_success 'OPT_CMDMODE() detects incompatibi=
lity (1)' '
 	test_must_be_empty output &&
 	test_grep "mode1" output.err &&
 	test_grep "mode2" output.err &&
-	test_grep "is incompatible with" output.err
+	test_grep "cannot be used together" output.err
 '

 test_expect_success 'OPT_CMDMODE() detects incompatibility (2)' '
@@ -384,7 +384,7 @@ test_expect_success 'OPT_CMDMODE() detects incompatibi=
lity (2)' '
 	test_must_be_empty output &&
 	test_grep "mode2" output.err &&
 	test_grep "set23" output.err &&
-	test_grep "is incompatible with" output.err
+	test_grep "cannot be used together" output.err
 '

 test_expect_success 'OPT_CMDMODE() detects incompatibility (3)' '
@@ -392,7 +392,7 @@ test_expect_success 'OPT_CMDMODE() detects incompatibi=
lity (3)' '
 	test_must_be_empty output &&
 	test_grep "mode2" output.err &&
 	test_grep "set23" output.err &&
-	test_grep "is incompatible with" output.err
+	test_grep "cannot be used together" output.err
 '

 test_expect_success 'OPT_CMDMODE() detects incompatibility (4)' '
@@ -401,7 +401,7 @@ test_expect_success 'OPT_CMDMODE() detects incompatibi=
lity (4)' '
 	test_must_be_empty output &&
 	test_grep "mode2" output.err &&
 	test_grep "mode34.3" output.err &&
-	test_grep "is incompatible with" output.err
+	test_grep "cannot be used together" output.err
 '

 test_expect_success 'OPT_COUNTUP() with PARSE_OPT_NODASH works' '
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d73a0be1b9..271c5e4fd3 100755
=2D-- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -6,7 +6,7 @@ test_description=3D'git cat-file'

 test_cmdmode_usage () {
 	test_expect_code 129 "$@" 2>err &&
-	grep "^error:.*is incompatible with" err
+	grep "^error: .* cannot be used together" err
 }

 for switches in \
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-t=
ree.sh
index b2c8a43fce..12ac436873 100755
=2D-- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -887,7 +887,7 @@ test_expect_success '--stdin with both a successful an=
d a conflicted merge' '
 test_expect_success '--merge-base is incompatible with --stdin' '
 	test_must_fail git merge-tree --merge-base=3Dside1 --stdin 2>expect &&

-	grep "^fatal: --merge-base is incompatible with --stdin" expect
+	grep "^fatal: .*merge-base.*stdin.* cannot be used together" expect
 '

 # specify merge-base as parent of branch2
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index fc4bbd9daf..a400bcca62 100755
=2D-- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -64,7 +64,7 @@ test_expect_success 'disallows --bundle-uri with shallow=
 options' '
 	for option in --depth=3D1 --shallow-since=3D01-01-2000 --shallow-exclude=
=3DHEAD
 	do
 		test_must_fail git clone --bundle-uri=3Dbundle $option from to 2>err &&
-		grep "bundle-uri is incompatible" err || return 1
+		grep "bundle-uri.* cannot be used together" err || return 1
 	done
 '

=2D-
2.43.0
