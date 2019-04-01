Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E9C920248
	for <e@80x24.org>; Mon,  1 Apr 2019 10:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfDAKNB (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 06:13:01 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:40049 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDAKNB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 06:13:01 -0400
Received: by mail-wr1-f44.google.com with SMTP id h4so11187289wre.7
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 03:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZvePHlb9ihRsgYk6nlAeWv/d9CB5IN53bitShGnbjnI=;
        b=Ok+JmkgR0L03rmu+o2xZgEvKF1pjOQ6cUMyKcqskAlgAXtDfnziZD8uBfEioPrjtuP
         Wx8jJesoQmGqFyuQFUo4SemcYznIjKJTJBogAONpMkEev28lKX15Y58REDx/1wh/kcXf
         qjqnHLS49m8taVs4mhHVlY7bRYzcOGBE5/zxtn2NtYU7qNxGXG4RQvrVZ8kygoWmvRse
         mdPUQY5M+yTXZrWDyErwi5wcFDnwGqB9m9ytBuRI5IMSNPMSQSccbrIeuC6rjElPvrih
         jv7MrbVThMC38Y+HLIm4lpT6q95hmpdZrKRPTQ8TsG75yZvoYw0eDQsQ6O2Ib/lXOvuN
         PrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZvePHlb9ihRsgYk6nlAeWv/d9CB5IN53bitShGnbjnI=;
        b=AtUqS7FIYpABku6Wdn+c1PPzhvgWr8nVX/8o4z72if5L9H1gOxfEwqa7EZujGfzfyu
         4DGakZwbZ+LIIzN5nzzUQFJPpol0DGDBJuRFM1gtLwa4Q6/bjKQIdKaegoIdS1Tn0gbB
         eO2iRrNeBqtkBKT5RCbQVcHjwfghIvOXn1b1elkEe7HtjcSpJ5uWvY3UY/4KDFy0R9w8
         kpJ61xoXNTmwLkOOPN3tgEvcMJRkMK8rXK3zp/LQO/s/pUpQmLFmDwVOycYWyOuCkGnU
         6BOs7pP4fbHyiHEeNqkIvvG6uqb/83kcRL2Pu7zlx/8tvpyTJ9DqNOYFZxw4XIEQ0JdY
         v8MA==
X-Gm-Message-State: APjAAAUjw1ctil5sMarYW22/JKAd7RmRxvgvAq7/uf/p0o1NPO5QpxRa
        MEv25RyydA7guT8fb+vPdybz/7sjGn0=
X-Google-Smtp-Source: APXvYqxf0JknTCsOzAH2rcIYvpRSyr7deDE2coXJZnn0B7WnllZaEzAEJiL4VZ7oR2Zw/TPcDrhvVA==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr42033545wrq.218.1554113578737;
        Mon, 01 Apr 2019 03:12:58 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 204sm20466795wmc.1.2019.04.01.03.12.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Apr 2019 03:12:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] praise: a culturally sensitive wrapper for 'blame'
Date:   Mon,  1 Apr 2019 12:12:45 +0200
Message-Id: <20190401101246.21418-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a wrapper for "blame" for use in blameless cultural
settings. Users in such cultures have hitherto had to fall back on the
legacy "annotate" command and its inferior output if they wanted to
avoid culturally inappropriate behavior.

Now such users have the option of using this wrapper. Organizations
that wish to engage in cultural enforcement can set
"blame.culture=blameless" in their configuration to make any direct
use of the "blame" command an error. Those wishing to centrally report
such transgressions can do so with the trace2 logging facility[1].

1. See Documentation/technical/api-trace2.txt --
   https://github.com/git/git/blob/master/Documentation/technical/api-trace2.txt

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/blame.txt | 10 ++++++++++
 Documentation/git-blame.txt    |  3 ++-
 Documentation/git-praise.txt   | 20 ++++++++++++++++++++
 builtin/blame.c                |  9 +++++++++
 git.c                          |  1 +
 t/t8002-blame.sh               | 15 +++++++++++++++
 6 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/git-praise.txt

diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.txt
index 67b5c1d1e0..c85b35de17 100644
--- a/Documentation/config/blame.txt
+++ b/Documentation/config/blame.txt
@@ -1,3 +1,13 @@
+blame.culture::
+	Set to 'blameless' to enforce the use of the functionality of
+	linkgit:git-blame[1] in blameless cultural settings. This will
+	make invocations of linkgit:git-blame[1] an error, forcing the
+	use of linkgit:git-praise[1]. Defaults to 'blameful', which is
+	the default.
++
+Note that the `--porcelain` format for machine consumption is exempt
+from this enforcement to avoid breaking existing scripts.
+
 blame.blankBoundary::
 	Show blank commit object name for boundary commits in
 	linkgit:git-blame[1]. This option defaults to false.
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 16323eb80e..9c1bff7389 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -228,7 +228,8 @@ include::mailmap.txt[]
 
 SEE ALSO
 --------
-linkgit:git-annotate[1]
+linkgit:git-annotate[1],
+linkgit:git-praise[1]
 
 GIT
 ---
diff --git a/Documentation/git-praise.txt b/Documentation/git-praise.txt
new file mode 100644
index 0000000000..d34b9dbc61
--- /dev/null
+++ b/Documentation/git-praise.txt
@@ -0,0 +1,20 @@
+git-praise(1)
+============
+
+NAME
+----
+git-praise - A culturally sensitive alias for git-blame
+
+DESCRIPTION
+-----------
+
+Annotates each line in the given file without compromising the
+cultural integrity of blameless cultures.
+
+The functionality of this command is equivalent to
+linkgit:git-blame[1]. Its use can be enforced by setting
+`blame.culture=blameless` in the config. See linkgit:git-config[1].
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/builtin/blame.c b/builtin/blame.c
index 177c1022a0..238b19db48 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -37,6 +37,7 @@ static const char *blame_opt_usage[] = {
 	NULL
 };
 
+static int blameless_culture;
 static int longest_file;
 static int longest_author;
 static int max_orig_digits;
@@ -681,6 +682,10 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		blank_boundary = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "blame.culture")) {
+		blameless_culture = !strcmp(value, "blameless");
+		return 0;
+	}
 	if (!strcmp(var, "blame.showemail")) {
 		int *output_option = cb;
 		if (git_config_bool(var, value))
@@ -828,6 +833,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	struct parse_opt_ctx_t ctx;
 	int cmd_is_annotate = !strcmp(argv[0], "annotate");
+	int cmd_is_praise = !strcmp(argv[0], "praise");
 	struct range_set ranges;
 	unsigned int range_i;
 	long anchor;
@@ -889,6 +895,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	if (cmd_is_annotate) {
 		output_option |= OUTPUT_ANNOTATE_COMPAT;
 		blame_date_mode.type = DATE_ISO8601;
+	} else if (!cmd_is_praise && blameless_culture &&
+		   !(output_option & OUTPUT_PORCELAIN)) {
+		die(_("must be invoked as 'git praise' with 'blame.culture=blameless' set!"));
 	} else {
 		blame_date_mode = revs.date_mode;
 	}
diff --git a/git.c b/git.c
index 2014aab6b8..77640f8cd9 100644
--- a/git.c
+++ b/git.c
@@ -536,6 +536,7 @@ static struct cmd_struct commands[] = {
 	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
 	{ "patch-id", cmd_patch_id, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "pickaxe", cmd_blame, RUN_SETUP },
+	{ "praise", cmd_blame, RUN_SETUP },
 	{ "prune", cmd_prune, RUN_SETUP },
 	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index eea048e52c..2d59b856d1 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -48,6 +48,21 @@ test_expect_success 'blame with no options and no config' '
 	test_cmp expected_n result
 '
 
+test_expect_success 'praise' '
+	git praise --show-email one >praise1 &&
+	find_blame <praise1 >result &&
+	test_cmp expected_e result &&
+
+	git praise --no-show-email one >praise2 &&
+	find_blame <praise2 >result &&
+	test_cmp expected_n result
+'
+
+test_expect_success 'enforced praise' '
+	test_must_fail git -c blame.culture=blameless blame one 2>err &&
+	test_i18ngrep "must be.*git praise" err
+'
+
 test_expect_success 'blame with showemail options' '
 	git blame --show-email one >blame1 &&
 	find_blame <blame1 >result &&
-- 
2.21.0.392.gf8f6787159e

