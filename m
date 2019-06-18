Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FBFD1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 20:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfFRUZa (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 16:25:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46177 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730607AbfFRUZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 16:25:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so23550282edr.13
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 13:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UtMwdNJ9qk+40LxlT1yFJjlPipk+EuW7wYWAQAFkbmo=;
        b=jf1A6+nOzzxEmMAr7PnNet7rjXjm8Lu+Gtq86LOklXiUgoKX3Y+VazrFwU+4sStIzO
         mKcx5HEwSWQDD155H4PGqRLj0wJ1/TsbqAuMR6ezUQecjzpyjhSsEJJRLAeaf97PY2Tj
         HLpVWGjvF5perTJRap6bNXcHDRjY5hei5vPwkjOHPw6HqLpYSrAk8v2akRcVamv0G3f9
         1UN0clDIhkCQUHLVwvcZxDsn5LtRkavMW7jytLVZQW3FJl140uFiooXandWINpqjesmD
         KAzlRl+gvKu9kL+cE8oYSlQ1QAxXVhKstt6Dp55LpZiIWXQ8dBq10PbRDlWmXDWMvgBj
         AOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UtMwdNJ9qk+40LxlT1yFJjlPipk+EuW7wYWAQAFkbmo=;
        b=j4igGgP95mYXNxSw7L5SbjQuHhhwasX9ePEcOohYwTbdTNj0cXGrabGo3lgd2qtgbs
         u2pGw7IUvf3nqcUhNJ2x7JN/SL6W/Utr5HTE9+6NG5M4ssKCqVfLuVka9pPcKdehys+z
         5XCcXr3BG6jb7NvtTckaLEek8AUaI88BoK2s7fmY8nmcqFoSKNiv8i0ELtDs1Uwzk3Hs
         zkNtvWTAf4jH4WvmMU/BGaXp0wCUGJ5kz8tQr1ohw+ajtYGJX1kL/9gBbmSCrQw8fYmq
         zF9EzoUwTPg996k9Kbj8TkH4RadhQONxXZLPQ4iq5B9yQGMLnvFDFAJR8l+QeNMG9nwX
         JtCQ==
X-Gm-Message-State: APjAAAV2RIszIStf62WrBz+hvDoaG2AgSGlBX6QGUVNYSKbmss79/GHs
        6cYHLhRlPINUMQEXflm52JTdz2hW
X-Google-Smtp-Source: APXvYqx2ByT3uiHog/D8x0s/fpJ/WIMEbCkRXkXr/ZBOtH0QpPKnhgnzFaWURdS/dFQeW0U5q79EKg==
X-Received: by 2002:a17:906:2890:: with SMTP id o16mr77780046ejd.80.1560889527571;
        Tue, 18 Jun 2019 13:25:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm2947858ejr.61.2019.06.18.13.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 13:25:27 -0700 (PDT)
Date:   Tue, 18 Jun 2019 13:25:27 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 20:25:23 GMT
Message-Id: <25d467ea1db0db07ea976c7d1331f4223fa9ee9a.1560889525.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.273.git.gitgitgadget@gmail.com>
References: <pull.273.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] fetch: warn about forced updates in branch listing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     git@jeffhostetler, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The --[no-]show-forced-updates option in 'git fetch' can be confusing
for some users, especially if it is enabled via config setting and not
by argument. Add advice to warn the user that the (forced update)
messages were not listed.

Additionally, warn users when the forced update check takes longer
than ten seconds, and recommend that they disable the check. These
messages can be disabled by the advice.fetchShowForcedUpdates config
setting.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/advice.txt |  4 ++++
 advice.c                        |  2 ++
 advice.h                        |  1 +
 builtin/fetch.c                 | 25 ++++++++++++++++++++++++-
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index ec4f6ae658..1f1e847fb4 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -4,6 +4,10 @@ advice.*::
 	can tell Git that you do not need help by setting these to 'false':
 +
 --
+	fetchShowForcedUpdates::
+		Advice shown when linkgit:git-fetch[1] takes a long time
+		to calculate forced updates after ref updates, or to warn
+		that the check is disabled.
 	pushUpdateRejected::
 		Set this variable to 'false' if you want to disable
 		'pushNonFFCurrent',
diff --git a/advice.c b/advice.c
index ce5f374ecd..4b283be51a 100644
--- a/advice.c
+++ b/advice.c
@@ -3,6 +3,7 @@
 #include "color.h"
 #include "help.h"
 
+int advice_fetch_show_forced_updates = 1;
 int advice_push_update_rejected = 1;
 int advice_push_non_ff_current = 1;
 int advice_push_non_ff_matching = 1;
@@ -59,6 +60,7 @@ static struct {
 	const char *name;
 	int *preference;
 } advice_config[] = {
+	{ "fetchShowForcedUpdates", &advice_fetch_show_forced_updates },
 	{ "pushUpdateRejected", &advice_push_update_rejected },
 	{ "pushNonFFCurrent", &advice_push_non_ff_current },
 	{ "pushNonFFMatching", &advice_push_non_ff_matching },
diff --git a/advice.h b/advice.h
index e50f02cdfe..495e53255c 100644
--- a/advice.h
+++ b/advice.h
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 
+extern int advice_fetch_show_forced_updates;
 extern int advice_push_update_rejected;
 extern int advice_push_non_ff_current;
 extern int advice_push_non_ff_matching;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 571c255218..cf7eb0dd8d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -24,6 +24,8 @@
 #include "list-objects-filter-options.h"
 #include "commit-reach.h"
 
+#define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
+
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
 	N_("git fetch [<options>] <group>"),
@@ -40,6 +42,7 @@ enum {
 
 static int fetch_prune_config = -1; /* unspecified */
 static int fetch_show_forced_updates = 1;
+static uint64_t forced_updates_ms = 0;
 static int prune = -1; /* unspecified */
 #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
 
@@ -707,6 +710,7 @@ static int update_local_ref(struct ref *ref,
 	enum object_type type;
 	struct branch *current_branch = branch_get(NULL);
 	const char *pretty_ref = prettify_refname(ref->name);
+	int fast_forward = 0;
 
 	type = oid_object_info(the_repository, &ref->new_oid, NULL);
 	if (type < 0)
@@ -781,7 +785,15 @@ static int update_local_ref(struct ref *ref,
 		return r;
 	}
 
-	if (!fetch_show_forced_updates || in_merge_bases(current, updated)) {
+	if (fetch_show_forced_updates) {
+		uint64_t t_before = getnanotime();
+		fast_forward = in_merge_bases(current, updated);
+		forced_updates_ms += (getnanotime() - t_before) / 1000000;
+	} else {
+		fast_forward = 1;
+	}
+
+	if (fast_forward) {
 		struct strbuf quickref = STRBUF_INIT;
 		int r;
 
@@ -980,6 +992,17 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		      " 'git remote prune %s' to remove any old, conflicting "
 		      "branches"), remote_name);
 
+	if (advice_fetch_show_forced_updates) {
+		if (!fetch_show_forced_updates) {
+			warning(_("Fetch normally indicates which branches had a forced update, but that check has been disabled."));
+			warning(_("To re-enable, use '--show-forced-updates' flag or run 'git config fetch.showForcedUpdates true'."));
+		} else if (forced_updates_ms > FORCED_UPDATES_DELAY_WARNING_IN_MS) {
+			warning(_("It took %.2f seconds to check forced updates. You can use '--no-show-forced-updates'\n"),
+				forced_updates_ms / 1000.0);
+			warning(_("or run 'git config fetch.showForcedUpdates false' to avoid this check.\n"));
+		}
+	}
+
  abort:
 	strbuf_release(&note);
 	free(url);
-- 
gitgitgadget

