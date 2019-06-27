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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E7BD1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 08:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfF0IMw (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 04:12:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41031 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfF0IMv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 04:12:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id p15so6186883eds.8
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ca68ei1q60tytXFcQmZTqIQJPAjmqQhCODIBcOwvGEY=;
        b=I6YD/9eYZCa0oqArYZzXxTAEzA9Jn3KlbTDyIVIGCcz3Osut2JjrWMxrNKGR/hSarR
         NR5fi49UEUJ2egyeJ/5asdE3+LLXnsxP3ij/rG5luhi3gEKE9lWVUXk99ZaTCEVH2dsH
         Npoh9FV1LYPzSxlBzJdVcP7uw5Ov4jrRWbhoRkPeijZQ25JO6WqWP7Dmnq2nVilfYj0R
         oUmW5D4VcYgj1/39SJzfMGvqXVSND4XCaKk0dI/qHx9LkSg+3cckX5kqsMtEMJGN9f9g
         eIpkZNsCFTy13yIz+jwu5bbUQ1HPy5g3PGJrOiuBS4LuBPNVHZK61SIORwB6fGm2amL0
         OEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ca68ei1q60tytXFcQmZTqIQJPAjmqQhCODIBcOwvGEY=;
        b=ir/avfzZjBX/7XSOWWDZ9fIYO3zD+yoGVAntq8u7dSchSI+Lmji1DvdoYkuIl7BmYm
         sLAR+lk91iXQSA0KR5wkgJU6FhQB+4ufS8x3CPrCAa6sbj7LddI/RurNLOmh+gFZOB/G
         xglqn1VC8luKYtd6onQMS6SIIeUbmSSe3uX28YBUbwqFvAVOCWWeovAVWfsRSLHsSQ9i
         xaINjOjcXyKi86TcXORPt7ccr8Y1M2btnzqGjLjoh6m5XnWprRZdneTqtYbWfeLu15QH
         Bl3CDkwNIkN9iL+hgk3MI8FvwyeMPrOyCFmB1ZRuEsellHV4iYqYEbiLY0HFZo/giaPB
         yRQw==
X-Gm-Message-State: APjAAAWdyKskpXYTziVH0YAavBOd9xiChSt9L+A1aPyfTQc6gZxjLJJZ
        SkQlDn1OHvPCmeUz1GqGcOLPGL1f
X-Google-Smtp-Source: APXvYqxz1tzaLuYsTv1nXRE0GcUwwbDWEhkMF3oo6XZ8gGmkaY0X9uSGRqh3NccwIsrvbDY1NHvazA==
X-Received: by 2002:a50:9167:: with SMTP id f36mr2491019eda.297.1561623170158;
        Thu, 27 Jun 2019 01:12:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 17sm500817edu.21.2019.06.27.01.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 01:12:49 -0700 (PDT)
Date:   Thu, 27 Jun 2019 01:12:49 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 08:12:47 GMT
Message-Id: <fab124da41858b849ae74dfb1fe403bb834870f1.1561623167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.253.git.gitgitgadget@gmail.com>
References: <pull.253.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] Let rebase.reschedulefailedexec only affect interactive
 rebases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Vas Sudanagunta <vas@commonkarma.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It does not make sense to stop non-interactive rebases when that config
setting is set to `true`.

Reported by Vas Sudanagunta via:
https://github.com/git/git/commit/969de3ff0e0#commitcomment-33257187

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c           | 7 +++++--
 t/t3418-rebase-continue.sh | 8 ++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4839e52555..78c3bd0634 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -834,6 +834,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
+	int reschedule_failed_exec = -1;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -929,7 +930,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "root", &options.root,
 			 N_("rebase all reachable commits up to the root(s)")),
 		OPT_BOOL(0, "reschedule-failed-exec",
-			 &options.reschedule_failed_exec,
+			 &reschedule_failed_exec,
 			 N_("automatically re-schedule any `exec` that fails")),
 		OPT_END(),
 	};
@@ -1227,8 +1228,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
-	if (options.reschedule_failed_exec && !is_interactive(&options))
+	if (reschedule_failed_exec > 0 && !is_interactive(&options))
 		die(_("--reschedule-failed-exec requires an interactive rebase"));
+	if (reschedule_failed_exec >= 0)
+		options.reschedule_failed_exec = reschedule_failed_exec;
 
 	if (options.git_am_opts.argc) {
 		/* all am options except -q are compatible only with --am */
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index bdaa511bb0..4eff14dae5 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -265,4 +265,12 @@ test_expect_success '--reschedule-failed-exec' '
 	test_i18ngrep "has been rescheduled" err
 '
 
+test_expect_success 'rebase.reschedulefailedexec only affects `rebase -i`' '
+	test_config rebase.reschedulefailedexec true &&
+	test_must_fail git rebase -x false HEAD^ &&
+	grep "^exec false" .git/rebase-merge/git-rebase-todo &&
+	git rebase --abort &&
+	git rebase HEAD^
+'
+
 test_done
-- 
gitgitgadget
