Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57C681F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 18:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfHMShy (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 14:37:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50271 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbfHMShv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 14:37:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so2420638wml.0
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d9x/xVtvOysV+dqHJo69MkERwL8LNtYRrDpHOmZPe2s=;
        b=gKxRiysTqQ136QGKi87swvK4wB30hfdxg8Yk0bX9sOHUKDiDwbOQkAahLoU6KJYBy/
         ByljLAorFnOmbHpWX4YQ4Ge9tXnp1XnoVpa2Jr2U9p8H9jMLMfKzdt7VDfcrXqCF7SKm
         QIj8t5ptOt/1jCbQIFTMjeTb2q15gM7q2N4sfH7VgwD9rbKb7EAJPTVe3zaSMFAYWVsS
         nc7OVbbbG3HCGryL3lUtgGz+12aSJ001Yu0PK9xJh0KXLV4a86Ni+EYKtmuIpJyLzMIL
         0pzOSkhkJVSxUOptWGhi1gtSQliepsiCr/rSxxjYpH/6gDoAXRz1jmXVxyDl/JVDs6y1
         3JHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d9x/xVtvOysV+dqHJo69MkERwL8LNtYRrDpHOmZPe2s=;
        b=KQhVjiLejPH1ppRgtYc6cFnQTp0eeOeT4Y+d5KY4AwhaiaFWZykstotbg2/GICfgLk
         7+qh62oRXyLERdZuCCgV3QE/9zgsD+FW3h4cRGS7uZH5apL3rvNkvwD5bp6kH9eoVmv8
         RNX76mt4h/+ak+2WsgKR2CmHpmUXWAAg44JFN1EoxqAmnPD6xHNJJnmKcJj5xCnjkuYD
         Kwf6GNdt0LciVyVhzJDugXuKKe8HFIQCvTgw41OYR0k2dgqo3bVuwc+aVq2zc80A0MXV
         A04TxgiyQDdPdR7oHwVD+Aj8WGifH69xWz+QcXz8xZ3tRka6wHxogDhjcDyw3waiDMFa
         D60A==
X-Gm-Message-State: APjAAAXtXCNEQKLKwKP6oKnKmZO59ZEe2NywlRiqOU7LpNznZ4Xz7DRU
        0LcjdU8ZbDGT7g8BLLzUqW/VBGRp
X-Google-Smtp-Source: APXvYqxhHKWhmeN0CG3II7H8FvJEO5mHMwECHyerZ/6FlP/g4kW7CEFCM0poxBcDRtYWAY4AAf/E2A==
X-Received: by 2002:a1c:9855:: with SMTP id a82mr4243453wme.134.1565721468573;
        Tue, 13 Aug 2019 11:37:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j2sm1826861wmh.43.2019.08.13.11.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 11:37:48 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:37:48 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Aug 2019 18:37:41 GMT
Message-Id: <f30e25fcd67a4d1c36b3a43f9e953655eb73f964.1565721461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.v4.git.gitgitgadget@gmail.com>
References: <pull.292.v3.git.gitgitgadget@gmail.com>
        <pull.292.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 6/6] repo-settings: create feature.experimental setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'feature.experimental' setting includes config options that are
not committed to become defaults, but could use additional testing.

Update the following config settings to take new defaults, and to
use the repo_settings struct if not already using them:

* 'pack.useSparse=true'

* 'fetch.negotiationAlgorithm=skipping'

In the case of fetch.negotiationAlgorithm, the existing logic
would load the config option only when about to use the setting,
so had a die() statement on an unknown string value. This is
removed as now the config is parsed under prepare_repo_settings().
In general, this die() is probably misplaced and not valuable.
A test was removed that checked this die() statement executed.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/feature.txt     | 14 ++++++++++++++
 Documentation/config/fetch.txt       |  3 ++-
 Documentation/config/pack.txt        |  3 ++-
 fetch-negotiator.c                   | 25 +++++++++++++------------
 fetch-negotiator.h                   |  5 +++--
 fetch-pack.c                         | 11 +++++------
 repo-settings.c                      | 13 +++++++++++++
 repository.h                         |  8 ++++++++
 t/t5552-skipping-fetch-negotiator.sh | 23 -----------------------
 9 files changed, 60 insertions(+), 45 deletions(-)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index 8ea198a642..545522f306 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -4,6 +4,20 @@ feature.*::
 	developer community as recommended defaults and are subject to change.
 	In particular, new config options may be added with different defaults.
 
+feature.experimental::
+	Enable config options that are new to Git, and are being considered for
+	future defaults. Config settings included here may be added or removed
+	with each release, including minor version updates. These settings may
+	have unintended interactions since they are so new. Please enable this
+	setting if you are interested in providing feedback on experimental
+	features. The new default values are:
++
+* `pack.useSparse=true` uses a new algorithm when constructing a pack-file
+which can improve `git push` performance in repos with many files.
++
+* `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
+skipping more commits at a time, reducing the number of round trips.
+
 feature.manyFiles::
 	Enable config options that optimize for repos with many files in the
 	working directory. With many files, commands such as `git status` and
diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index ba890b5884..d402110638 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -59,7 +59,8 @@ fetch.negotiationAlgorithm::
 	effort to converge faster, but may result in a larger-than-necessary
 	packfile; The default is "default" which instructs Git to use the default algorithm
 	that never skips commits (unless the server has acknowledged it or one
-	of its descendants).
+	of its descendants). If `feature.experimental` is enabled, then this
+	setting defaults to "skipping".
 	Unknown values will cause 'git fetch' to error out.
 +
 See also the `--negotiation-tip` option for linkgit:git-fetch[1].
diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 9cdcfa7324..1d66f0c992 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -112,7 +112,8 @@ pack.useSparse::
 	objects. This can have significant performance benefits when
 	computing a pack to send a small change. However, it is possible
 	that extra objects are added to the pack-file if the included
-	commits contain certain types of direct renames.
+	commits contain certain types of direct renames. Default is `false`
+	unless `feature.experimental` is enabled.
 
 pack.writeBitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index d6d685cba0..0a1357dc9d 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -2,19 +2,20 @@
 #include "fetch-negotiator.h"
 #include "negotiator/default.h"
 #include "negotiator/skipping.h"
+#include "repository.h"
 
-void fetch_negotiator_init(struct fetch_negotiator *negotiator,
-			   const char *algorithm)
+void fetch_negotiator_init(struct repository *r,
+			   struct fetch_negotiator *negotiator)
 {
-	if (algorithm) {
-		if (!strcmp(algorithm, "skipping")) {
-			skipping_negotiator_init(negotiator);
-			return;
-		} else if (!strcmp(algorithm, "default")) {
-			/* Fall through to default initialization */
-		} else {
-			die("unknown fetch negotiation algorithm '%s'", algorithm);
-		}
+	prepare_repo_settings(r);
+	switch(r->settings.fetch_negotiation_algorithm) {
+	case FETCH_NEGOTIATION_SKIPPING:
+		skipping_negotiator_init(negotiator);
+		return;
+
+	case FETCH_NEGOTIATION_DEFAULT:
+	default:
+		default_negotiator_init(negotiator);
+		return;
 	}
-	default_negotiator_init(negotiator);
 }
diff --git a/fetch-negotiator.h b/fetch-negotiator.h
index 9e3967ce66..ea78868504 100644
--- a/fetch-negotiator.h
+++ b/fetch-negotiator.h
@@ -2,6 +2,7 @@
 #define FETCH_NEGOTIATOR_H
 
 struct commit;
+struct repository;
 
 /*
  * An object that supplies the information needed to negotiate the contents of
@@ -52,7 +53,7 @@ struct fetch_negotiator {
 	void *data;
 };
 
-void fetch_negotiator_init(struct fetch_negotiator *negotiator,
-			   const char *algorithm);
+void fetch_negotiator_init(struct repository *r,
+			   struct fetch_negotiator *negotiator);
 
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index 65be043f2a..d81f47c07b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -36,7 +36,6 @@ static int agent_supported;
 static int server_supports_filtering;
 static struct lock_file shallow_lock;
 static const char *alternate_shallow_file;
-static char *negotiation_algorithm;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
 
 /* Remember to update object flag allocation in object.h */
@@ -892,12 +891,13 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 struct shallow_info *si,
 				 char **pack_lockfile)
 {
+	struct repository *r = the_repository;
 	struct ref *ref = copy_ref_list(orig_ref);
 	struct object_id oid;
 	const char *agent_feature;
 	int agent_len;
 	struct fetch_negotiator negotiator;
-	fetch_negotiator_init(&negotiator, negotiation_algorithm);
+	fetch_negotiator_init(r, &negotiator);
 
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
@@ -911,7 +911,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 
 	if (server_supports("shallow"))
 		print_verbose(args, _("Server supports %s"), "shallow");
-	else if (args->depth > 0 || is_repository_shallow(the_repository))
+	else if (args->depth > 0 || is_repository_shallow(r))
 		die(_("Server does not support shallow clients"));
 	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen = 1;
@@ -1379,6 +1379,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				    struct shallow_info *si,
 				    char **pack_lockfile)
 {
+	struct repository *r = the_repository;
 	struct ref *ref = copy_ref_list(orig_ref);
 	enum fetch_state state = FETCH_CHECK_LOCAL;
 	struct oidset common = OIDSET_INIT;
@@ -1386,7 +1387,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	int in_vain = 0;
 	int haves_to_send = INITIAL_FLUSH;
 	struct fetch_negotiator negotiator;
-	fetch_negotiator_init(&negotiator, negotiation_algorithm);
+	fetch_negotiator_init(r, &negotiator);
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
@@ -1505,8 +1506,6 @@ static void fetch_pack_config(void)
 	git_config_get_bool("repack.usedeltabaseoffset", &prefer_ofs_delta);
 	git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
 	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
-	git_config_get_string("fetch.negotiationalgorithm",
-			      &negotiation_algorithm);
 
 	git_config(fetch_pack_config_cb, NULL);
 }
diff --git a/repo-settings.c b/repo-settings.c
index d5bf9069f4..3779b85c17 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -36,16 +36,29 @@ void prepare_repo_settings(struct repository *r)
 		free(strval);
 	}
 
+	if (!repo_config_get_string(r, "fetch.negotiationalgorithm", &strval)) {
+		if (!strcasecmp(strval, "skipping"))
+			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
+		else
+			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
+	}
+
 	if (!repo_config_get_bool(r, "pack.usesparse", &value))
 		r->settings.pack_use_sparse = value;
 	if (!repo_config_get_bool(r, "feature.manyfiles", &value) && value) {
 		UPDATE_DEFAULT_BOOL(r->settings.index_version, 4);
 		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
 	}
+	if (!repo_config_get_bool(r, "feature.experimental", &value) && value) {
+		UPDATE_DEFAULT_BOOL(r->settings.pack_use_sparse, 1);
+		UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
+	}
 
 	/* Hack for test programs like test-dump-untracked-cache */
 	if (ignore_untracked_cache_config)
 		r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
 	else
 		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
+
+	UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_DEFAULT);
 }
diff --git a/repository.h b/repository.h
index cf7ff0778c..4da275e73f 100644
--- a/repository.h
+++ b/repository.h
@@ -18,6 +18,13 @@ enum untracked_cache_setting {
 	UNTRACKED_CACHE_WRITE = 2
 };
 
+enum fetch_negotiation_setting {
+	FETCH_NEGOTIATION_UNSET = -1,
+	FETCH_NEGOTIATION_NONE = 0,
+	FETCH_NEGOTIATION_DEFAULT = 1,
+	FETCH_NEGOTIATION_SKIPPING = 2,
+};
+
 struct repo_settings {
 	int initialized;
 
@@ -28,6 +35,7 @@ struct repo_settings {
 	enum untracked_cache_setting core_untracked_cache;
 
 	int pack_use_sparse;
+	enum fetch_negotiation_setting fetch_negotiation_algorithm;
 };
 
 struct repository {
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 8a14be51a1..f70cbcc9ca 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -60,29 +60,6 @@ test_expect_success 'commits with no parents are sent regardless of skip distanc
 	have_not_sent c6 c4 c3
 '
 
-test_expect_success 'unknown fetch.negotiationAlgorithm values error out' '
-	rm -rf server client trace &&
-	git init server &&
-	test_commit -C server to_fetch &&
-
-	git init client &&
-	test_commit -C client on_client &&
-	git -C client checkout on_client &&
-
-	test_config -C client fetch.negotiationAlgorithm invalid &&
-	test_must_fail git -C client fetch "$(pwd)/server" 2>err &&
-	test_i18ngrep "unknown fetch negotiation algorithm" err &&
-
-	# Explicit "default" value
-	test_config -C client fetch.negotiationAlgorithm default &&
-	git -C client -c fetch.negotiationAlgorithm=default fetch "$(pwd)/server" &&
-
-	# Implementation detail: If there is nothing to fetch, we will not error out
-	test_config -C client fetch.negotiationAlgorithm invalid &&
-	git -C client fetch "$(pwd)/server" 2>err &&
-	test_i18ngrep ! "unknown fetch negotiation algorithm" err
-'
-
 test_expect_success 'when two skips collide, favor the larger one' '
 	rm -rf server client trace &&
 	git init server &&
-- 
gitgitgadget
