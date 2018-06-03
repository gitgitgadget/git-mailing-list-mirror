Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B149B1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeFCQez (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:34:55 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34880 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbeFCQer (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 12:34:47 -0400
Received: by mail-lf0-f65.google.com with SMTP id y72-v6so21551188lfd.2
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hum09VQ3ktB2K3enD9CZZVRTtOT41uUJBMzhHZwscnE=;
        b=hntSAPvZ4EoJJsEFCbr75o6c3vdwUZ9aqBdK+gtKySJZZj3fjnAvlXYVMSbsKoxQFO
         RENbRMyG0kifvxGDqzRsbkckgdEpGve0srLEdrRC5Jx5QFqmV/t+bOnb2cW3dklZdj5k
         W2NBgJw9fFCLg0DF/trdnyYjBY2xepGs+LBFjrlPYaGNyqsk3eYjYK0kREM20eQmY8zy
         t2Tu8Mhr7N7m/w6dadTgraFhWtWJSlKghROZ9hQpQHu5ZArhqQ6dUe2+GdgIVBEuflA8
         VWKxl5PhuMWAQ8StXY4Pc2MFRjwQIG6TCuFlxxZMHq/yXdVXZxxnDuJbBCR4n3YBQ0NR
         ZggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hum09VQ3ktB2K3enD9CZZVRTtOT41uUJBMzhHZwscnE=;
        b=kz5Aib6uOCXb9DHjIlh/9ubsJnBcH9/aHUfsr65ys+SuA3KSBkizzj6OVCqN5JmzkJ
         QhDyao3Jbd4t4PKICKYqrcw4lK/APf4A8Yyfix/ci6CvDEs6lXoqmR3VuRQI4GEI75nL
         X9ClzVembVoLuO1iI2Dfjm2HVLSQMhXci9MXUS/MWbfsoBiDRzQwkXY/VmyDoCix2mdn
         z3bljx16h/7snoSRL3tu0KKtRpv60CBR0PEwp1JSOZ+RyLkWnkMLFBT3QSSzS5yoO9Uw
         AhahhWcgldY+CGD8eCuFFwhgGelHCu2S6es/AO4YbjGTePo2JHsKCbdL6BJktaF/nmUM
         rOXw==
X-Gm-Message-State: APt69E0W9LA8D9Vhfj77Ehy6OCHdIHhll4FFYpg8q4ZuTNRgv9sHd/DT
        paDcHFB8ut8N081eK9XMpbk=
X-Google-Smtp-Source: ADUXVKJclir3JQj/eCKeRGrSzVbUIVwrGgrZlVZm/aIDP4TNJvlD4VCb02N3Ns+OUQesfB7gIbOcjw==
X-Received: by 2002:a2e:2f07:: with SMTP id v7-v6mr1995090ljv.113.1528043686010;
        Sun, 03 Jun 2018 09:34:46 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v79-v6sm4726895lfd.32.2018.06.03.09.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 09:34:45 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 04/23] builtin/config.c: mark more strings for translation
Date:   Sun,  3 Jun 2018 18:34:01 +0200
Message-Id: <20180603163420.13702-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180603163420.13702-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
 <20180603163420.13702-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/config.c      | 48 +++++++++++++++++++++----------------------
 t/t1308-config-set.sh |  2 +-
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index ebeb4c5638..3c26df6c48 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -110,7 +110,7 @@ static int option_parse_type(const struct option *opt, const char *arg,
 		 * --int' and '--type=bool
 		 * --type=int'.
 		 */
-		error("only one type at a time");
+		error(_("only one type at a time"));
 		usage_with_options(builtin_config_usage,
 			builtin_config_options);
 	}
@@ -161,9 +161,9 @@ static void check_argc(int argc, int min, int max) {
 	if (argc >= min && argc <= max)
 		return;
 	if (min == max)
-		error("wrong number of arguments, should be %d", min);
+		error(_("wrong number of arguments, should be %d"), min);
 	else
-		error("wrong number of arguments, should be from %d to %d",
+		error(_("wrong number of arguments, should be from %d to %d"),
 		      min, max);
 	usage_with_options(builtin_config_usage, builtin_config_options);
 }
@@ -297,7 +297,7 @@ static int get_value(const char *key_, const char *regex_)
 
 		key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(key_regexp, key, REG_EXTENDED)) {
-			error("invalid key pattern: %s", key_);
+			error(_("invalid key pattern: %s"), key_);
 			FREE_AND_NULL(key_regexp);
 			ret = CONFIG_INVALID_PATTERN;
 			goto free_strings;
@@ -317,7 +317,7 @@ static int get_value(const char *key_, const char *regex_)
 
 		regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(regexp, regex_, REG_EXTENDED)) {
-			error("invalid pattern: %s", regex_);
+			error(_("invalid pattern: %s"), regex_);
 			FREE_AND_NULL(regexp);
 			ret = CONFIG_INVALID_PATTERN;
 			goto free_strings;
@@ -390,7 +390,7 @@ static char *normalize_value(const char *key, const char *value)
 	if (type == TYPE_COLOR) {
 		char v[COLOR_MAXLEN];
 		if (git_config_color(v, key, value))
-			die("cannot parse color '%s'", value);
+			die(_("cannot parse color '%s'"), value);
 
 		/*
 		 * The contents of `v` now contain an ANSI escape
@@ -485,13 +485,13 @@ static int get_colorbool(const char *var, int print)
 static void check_write(void)
 {
 	if (!given_config_source.file && !startup_info->have_repository)
-		die("not in a git directory");
+		die(_("not in a git directory"));
 
 	if (given_config_source.use_stdin)
-		die("writing to stdin is not supported");
+		die(_("writing to stdin is not supported"));
 
 	if (given_config_source.blob)
-		die("writing config blobs is not supported");
+		die(_("writing config blobs is not supported"));
 }
 
 struct urlmatch_current_candidate_value {
@@ -599,7 +599,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 	if (use_global_config + use_system_config + use_local_config +
 	    !!given_config_source.file + !!given_config_source.blob > 1) {
-		error("only one config file at a time");
+		error(_("only one config file at a time"));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
@@ -626,7 +626,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			 * location; error out even if XDG_CONFIG_HOME
 			 * is set and points at a sane location.
 			 */
-			die("$HOME is not set");
+			die(_("$HOME is not set"));
 
 		if (access_or_warn(user_config, R_OK, 0) &&
 		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
@@ -663,12 +663,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 
 	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && type) {
-		error("--get-color and variable type are incoherent");
+		error(_("--get-color and variable type are incoherent"));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
 	if (HAS_MULTI_BITS(actions)) {
-		error("only one action at a time");
+		error(_("only one action at a time"));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 	if (actions == 0)
@@ -681,19 +681,19 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		}
 	if (omit_values &&
 	    !(actions == ACTION_LIST || actions == ACTION_GET_REGEXP)) {
-		error("--name-only is only applicable to --list or --get-regexp");
+		error(_("--name-only is only applicable to --list or --get-regexp"));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
 	if (show_origin && !(actions &
 		(ACTION_GET|ACTION_GET_ALL|ACTION_GET_REGEXP|ACTION_LIST))) {
-		error("--show-origin is only applicable to --get, --get-all, "
-			  "--get-regexp, and --list.");
+		error(_("--show-origin is only applicable to --get, --get-all, "
+			"--get-regexp, and --list"));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
 	if (default_value && !(actions & ACTION_GET)) {
-		error("--default is only applicable to --get");
+		error(_("--default is only applicable to --get"));
 		usage_with_options(builtin_config_usage,
 			builtin_config_options);
 	}
@@ -707,10 +707,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 					&given_config_source,
 					&config_options) < 0) {
 			if (given_config_source.file)
-				die_errno("unable to read config file '%s'",
+				die_errno(_("unable to read config file '%s'"),
 					  given_config_source.file);
 			else
-				die("error processing config file(s)");
+				die(_("error processing config file(s)"));
 		}
 	}
 	else if (actions == ACTION_EDIT) {
@@ -718,11 +718,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 		check_argc(argc, 0, 0);
 		if (!given_config_source.file && nongit)
-			die("not in a git directory");
+			die(_("not in a git directory"));
 		if (given_config_source.use_stdin)
-			die("editing stdin is not supported");
+			die(_("editing stdin is not supported"));
 		if (given_config_source.blob)
-			die("editing blobs is not supported");
+			die(_("editing blobs is not supported"));
 		git_config(git_default_config, NULL);
 		config_file = given_config_source.file ?
 				xstrdup(given_config_source.file) :
@@ -823,7 +823,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
-			die("no such section: %s", argv[0]);
+			die(_("no such section: %s"), argv[0]);
 	}
 	else if (actions == ACTION_REMOVE_SECTION) {
 		int ret;
@@ -834,7 +834,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
-			die("no such section: %s", argv[0]);
+			die(_("no such section: %s"), argv[0]);
 	}
 	else if (actions == ACTION_GET_COLOR) {
 		check_argc(argc, 1, 2);
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 3e00d1af01..d0a2727b85 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -233,7 +233,7 @@ test_expect_success 'check line errors for malformed values' '
 
 test_expect_success 'error on modifying repo config without repo' '
 	nongit test_must_fail git config a.b c 2>err &&
-	grep "not in a git directory" err
+	test_i18ngrep "not in a git directory" err
 '
 
 cmdline_config="'foo.bar=from-cmdline'"
-- 
2.18.0.rc0.333.g22e6ee6cdf

