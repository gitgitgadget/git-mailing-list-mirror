Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 403071F462
	for <e@80x24.org>; Mon,  3 Jun 2019 20:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfFCUS2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 16:18:28 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:38612 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfFCUS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 16:18:27 -0400
Received: by mail-ed1-f49.google.com with SMTP id g13so28600424edu.5
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=46Q2deTrfQEmBNRbtlho/6RqM4sx9pnnvg1IennUr8Q=;
        b=oALegQnusiaZGwVftCJl/vOLB1jrHBwmbsA8unmayw/9SxLz1HIM04RQLkY+a8UaDc
         CfdHrXwdLx4/iufEbQH+HKRAMkYA/1RhJ2mHCnyT1qN9U59JgG3OMGns/P4YWRvJgQiE
         L/qm68j+PzeAT+4N3iMaGsGPc45sr1etsQu3Q5Gvq3et9bVtxuV7vk3BqRjjnnln0+QW
         O/jkWXDD7/KLsYoXDhQL/CuLv7YwKC8DirDsFLbWPS4g6Mz/j+FXmz7zwZVJODP/VMFO
         pxb9L5v1+JZcpyyQki1yXYuAcwajRy0xkWYGFUr3Fay08IWzkFo24HsGaVWAngAnldNZ
         Djmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=46Q2deTrfQEmBNRbtlho/6RqM4sx9pnnvg1IennUr8Q=;
        b=li3xtTGSSwIEgsQvb1asPbo8RNFJVT8bJkJAf4+owZgZFPcRtdLG4zHQk1/cIwpH/j
         0v6ea48MzLlqRICdEQNvIUKmHaLb9s0ldcfviG6N6JPDdu+J5LuYWmV6/a5M60sO4tGs
         blaJn1/BYIZL3Rqnbw/gCa+f4WhusMOsT+rjlpA8nIH0JIK9fjsRSVKspkl4v1xWkNS6
         DR7BLxHr7Oqc2M69dwE781CrlD+BJQpYRPWkI8B4eQ5EkcbdJipVjs6F86+YWeAg7zTv
         xIlQ5pDAj4KUxC4WUcrYuDbzPRSaAYRT4i+ZUtiJs3h5hemODCIAaG7uQ8JZLnxI6Js/
         XBcw==
X-Gm-Message-State: APjAAAWDUmqO4Ko566qRhWD9wlXemHWQvnUV1MDT7taa5lN8ESaSonOP
        EnF2Gc5lPNgJBLbnmGlVlM1o3tcv
X-Google-Smtp-Source: APXvYqxCpvq8+q39Hg5RNZtjjaCNeQE9vqYaayIYv5TJGm8B3mhSHU4SHx1P+/5HLGwovoelqsYQdQ==
X-Received: by 2002:a50:fa4a:: with SMTP id c10mr31252645edq.35.1559593105604;
        Mon, 03 Jun 2019 13:18:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6sm1434593edv.33.2019.06.03.13.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:18:25 -0700 (PDT)
Date:   Mon, 03 Jun 2019 13:18:25 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 20:18:15 GMT
Message-Id: <6a80cfa5a5604eb4560e8ad7254a982caa894678.1559593097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.git.gitgitgadget@gmail.com>
References: <pull.254.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 09/11] fetch: warn about forced updates after branch list
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/fetch.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 571c255218..f8ff98fdaf 100644
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
 
+	if (!fetch_show_forced_updates) {
+		warning(_("Fetch normally indicates which branches had a forced update, but that check has been disabled."));
+		warning(_("To re-enable, use '--show-forced-updates' flag or run 'git config fetch.showForcedUpdates true'."));
+	}
+	if (fetch_show_forced_updates &&
+	    forced_updates_ms > FORCED_UPDATES_DELAY_WARNING_IN_MS) {
+		warning(_("It took %.2f seconds to check forced updates. You can use '--no-show-forced-updates'\n"),
+			forced_updates_ms / 1000.0);
+		warning(_("or run 'git config fetch.showForcedUpdates false' to avoid this check.\n"));
+	}
+
  abort:
 	strbuf_release(&note);
 	free(url);
-- 
gitgitgadget

