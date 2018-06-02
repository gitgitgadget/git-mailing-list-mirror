Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB9561F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeFBEc7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:32:59 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34272 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbeFBEcx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:32:53 -0400
Received: by mail-lf0-f65.google.com with SMTP id o9-v6so17600198lfk.1
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8xwvTbl48c0IqH7RW3HdCqfAARK4D6gjoEh7tqGeO4=;
        b=ZadkV/sUmpmb+sLuyNWTB21XpPpmCeH2xzKa1IXlzl4qjj4BsYAmlh1AROIw6B3CFe
         nTPng2GWTti6IdLSetcQ5htTHMs/yDX1IDaYZGDork0854jc5jAQShdI68InTV683bQw
         U0dVe7Y6WaMzDCZSCxO4aqGPnNluNTAvqIxmyzofk4NEHdO9TaHJrqjTaNf5yfrKNZX0
         X+XLZ450NEU+c1Q85/ZWwfOKyo/mh7DqgTVOoGIpDTfzQDd9Vdz4xFMuOvumohLgS6/F
         7cEbkjqucwNK5Hnl1g7+HibvZ+TPTNHVbz1BQv2fwWD++p+vRaD4qvlaAD2kJPb3pqy1
         s/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8xwvTbl48c0IqH7RW3HdCqfAARK4D6gjoEh7tqGeO4=;
        b=gqi9NzqY1wsj/19BIPNDr+b36UOXo/RbL+ikofoktC6E3i4UcytdeV67v7n7x8lxmn
         fGkZlFeK3FIrEV4HXT9CD5P8KizlmcYiNMwsFBGq3D1OH8FD1WCfc5vtC3mg/U0ag7iZ
         ctA2UOtL7x1E5mq895h2rkOdZvwJ01EgrObh8iA6A5wDN+orAYlmmlY+prGNGLHUFLwL
         Kojv836YffI83dBqhzAsw7JgHpkxrff/xX80+r/CcFCICl03uqMUlOHYzl71rjbQjNBN
         OVuh4DGNcIzxC9lddxsIkvb6Gy4pJr3cY+ciMeT61ltSu3LHLZvKFapSnLCEtPlcgTYG
         nyxQ==
X-Gm-Message-State: ALKqPwdNGxE7620dnZOTHy9mLAEaCuoDrZ+EA3n4Bzb0vkOTAzBBPhGv
        WYDptMi6BcQObwlmc0Uzek5Lcg==
X-Google-Smtp-Source: ADUXVKKehIbapOCKcCSr8j2CfDtPj3bm5OoU6obdYl+/dN0D19KWpgJNWlic/vp27RsfayMGwoaHGQ==
X-Received: by 2002:a19:1329:: with SMTP id j41-v6mr7934526lfi.141.1527913971479;
        Fri, 01 Jun 2018 21:32:51 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:32:50 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/22] builtin/config.c: mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:22 +0200
Message-Id: <20180602043241.9941-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.309.g77c7720784
In-Reply-To: <20180602043241.9941-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are also some minor adjustments in the strings.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/config.c      | 48 +++++++++++++++++++++----------------------
 t/t1308-config-set.sh |  2 +-
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index b29d26dede..85f043a243 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -110,7 +110,7 @@ static int option_parse_type(const struct option *opt, const char *arg,
 		 * --int' and '--type=bool
 		 * --type=int'.
 		 */
-		error("only one type at a time.");
+		error(_("only one type at a time"));
 		usage_with_options(builtin_config_usage,
 			builtin_config_options);
 	}
@@ -160,7 +160,7 @@ static struct option builtin_config_options[] = {
 static void check_argc(int argc, int min, int max) {
 	if (argc >= min && argc <= max)
 		return;
-	error("wrong number of arguments");
+	error(_("wrong number of arguments"));
 	usage_with_options(builtin_config_usage, builtin_config_options);
 }
 
@@ -293,7 +293,7 @@ static int get_value(const char *key_, const char *regex_)
 
 		key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(key_regexp, key, REG_EXTENDED)) {
-			error("invalid key pattern: %s", key_);
+			error(_("invalid key pattern: %s"), key_);
 			FREE_AND_NULL(key_regexp);
 			ret = CONFIG_INVALID_PATTERN;
 			goto free_strings;
@@ -313,7 +313,7 @@ static int get_value(const char *key_, const char *regex_)
 
 		regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(regexp, regex_, REG_EXTENDED)) {
-			error("invalid pattern: %s", regex_);
+			error(_("invalid pattern: %s"), regex_);
 			FREE_AND_NULL(regexp);
 			ret = CONFIG_INVALID_PATTERN;
 			goto free_strings;
@@ -386,7 +386,7 @@ static char *normalize_value(const char *key, const char *value)
 	if (type == TYPE_COLOR) {
 		char v[COLOR_MAXLEN];
 		if (git_config_color(v, key, value))
-			die("cannot parse color '%s'", value);
+			die(_("cannot parse color '%s'"), value);
 
 		/*
 		 * The contents of `v` now contain an ANSI escape
@@ -481,13 +481,13 @@ static int get_colorbool(const char *var, int print)
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
@@ -595,7 +595,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 	if (use_global_config + use_system_config + use_local_config +
 	    !!given_config_source.file + !!given_config_source.blob > 1) {
-		error("only one config file at a time.");
+		error(_("only one config file at a time"));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
@@ -622,7 +622,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			 * location; error out even if XDG_CONFIG_HOME
 			 * is set and points at a sane location.
 			 */
-			die("$HOME not set");
+			die(_("$HOME is not set"));
 
 		if (access_or_warn(user_config, R_OK, 0) &&
 		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
@@ -659,12 +659,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 
 	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && type) {
-		error("--get-color and variable type are incoherent");
+		error(_("--get-color and variable type are incoherent"));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
 	if (HAS_MULTI_BITS(actions)) {
-		error("only one action at a time.");
+		error(_("only one action at a time"));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 	if (actions == 0)
@@ -677,19 +677,19 @@ int cmd_config(int argc, const char **argv, const char *prefix)
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
@@ -703,10 +703,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
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
@@ -714,11 +714,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
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
@@ -746,7 +746,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		ret = git_config_set_in_file_gently(given_config_source.file, argv[0], value);
 		if (ret == CONFIG_NOTHING_SET)
 			error(_("cannot overwrite multiple values with a single value\n"
-			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
+			"       Use a regexp, --add or --replace-all to change %s"), argv[0]);
 		return ret;
 	}
 	else if (actions == ACTION_SET_ALL) {
@@ -819,7 +819,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
-			die("No such section!");
+			die(_("no such section!"));
 	}
 	else if (actions == ACTION_REMOVE_SECTION) {
 		int ret;
@@ -830,7 +830,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
-			die("No such section!");
+			die(_("no such section!"));
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
2.18.0.rc0.309.g77c7720784

