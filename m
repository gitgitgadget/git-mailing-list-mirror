Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23FB11F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeIEByH (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 21:54:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46662 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeIEByH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 21:54:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id t19-v6so2204451ply.13
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EWoeoUuMpmqHnr7xTlZboGpqIQhImsVkBK7j9vlwtBg=;
        b=isXvgzAZ+LV6Uo/jgZrNj2w4d+S1F3sLAIo9zsCgw/Zt6F/X6351mz69JmGX1Yv8Fb
         vks5CM0OPy2uGDwHbuvAMXi3NBgQSqz7iv+gNHI9FTHxsdF3KlSPraYHjKrD2akw5Eoq
         JQH8bCRVSWYjUEqXfZA4ilaNPhTFM6hSqYHtplJ9l62Buw6QYqAX4yGgakfZVHV/g786
         SEPxuPZApZMe2gVDaZDmF+VzYpMsk5+qQJTatRmKuawQnY0LxKh+rx2sszhQcaTSKD2x
         l7xm067/Hy0AUpSEZzwVuH/qxkbm9kB9e4A1tlKf86naJZ91wu0P8gfW2BVYhmqJEGOI
         e7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EWoeoUuMpmqHnr7xTlZboGpqIQhImsVkBK7j9vlwtBg=;
        b=boi9YJaOy0MT97e6fuanwSLotdadI/kIGZKOLTDmGz9URT3DhZN2CpK5psKtCHPF0e
         HTovph7fRlL/3x6vrjOybzm6C1Dz0n+R/tQp3Ob9DOby0Fuk8ZeQRU/kWnP4oxrAWgVc
         7MSVbYLCI7i6L/9feSpc+5pb06eR7KYMFinKnzF/v4EFDXly1bs/L814Pk0e44Hg1PgO
         +d7wJekeRE1RNALRup+OdsIwZm6rIK8EibRmw9Gcjoygq6/HsyuzEfc9NRuvd/TY/Wnb
         Cjy9yE0H0M5hiwKGtJr4vnbZCz+IXah26we8uHXTCatackcLvKMrBQEjKiwYHk4/97cJ
         hBag==
X-Gm-Message-State: APzg51D6O35rTefMAtxifRzGSNETxI6nA/qs8M03MnB4jGDYWez5RhIT
        wbqkttPNPl5jSyVvwwpLcn+4xmHX
X-Google-Smtp-Source: ANB0VdYTgH6Db45vqEhgZTX9iBlDuYwQZmo5CqIbexIdqU1nQzdfgDKgAEatoho3qVj9QpnxGGDccA==
X-Received: by 2002:a17:902:49:: with SMTP id 67-v6mr36199610pla.206.1536096430025;
        Tue, 04 Sep 2018 14:27:10 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id s195-v6sm38038652pgs.76.2018.09.04.14.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:27:09 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:27:09 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:26:55 GMT
Message-Id: <f9826ab58f73d4ebca4d69134f4f75b5831bbd74.1536096424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.32.v2.git.gitgitgadget@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
        <pull.32.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 02/11] builtin rebase: support `git rebase --onto A...B`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pratik Karki <predatoramigo@gmail.com>

This commit implements support for an --onto argument that is actually a
"symmetric range" i.e. `<rev1>...<rev2>`.

The equivalent shell script version of the code offers two different
error messages for the cases where there is no merge base vs more than
one merge base.

Though it would be nice to retain this distinction, dropping it makes it
possible to simply use the `get_oid_mb()` function. Besides, it happens
rarely in real-world scenarios.

Therefore, in the interest of keeping the code less complex, let's just
use that function, and live with an error message that does not
distinguish between those two error conditions.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 742ed31498..38c496dd10 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -17,6 +17,7 @@
 #include "unpack-trees.h"
 #include "lockfile.h"
 #include "parse-options.h"
+#include "commit.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
@@ -311,6 +312,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	int ret, flags;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
+	struct object_id merge_base;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -387,7 +389,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (!options.onto_name)
 		options.onto_name = options.upstream_name;
 	if (strstr(options.onto_name, "...")) {
-		die("TODO");
+		if (get_oid_mb(options.onto_name, &merge_base) < 0)
+			die(_("'%s': need exactly one merge base"),
+			    options.onto_name);
+		options.onto = lookup_commit_or_die(&merge_base,
+						    options.onto_name);
 	} else {
 		options.onto = peel_committish(options.onto_name);
 		if (!options.onto)
-- 
gitgitgadget

