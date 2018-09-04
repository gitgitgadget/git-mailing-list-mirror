Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8DB51F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeIEByR (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 21:54:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39774 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeIEByR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 21:54:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id i190-v6so2287126pgc.6
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/zwQGrWC0f3gpyveYnsjDUZRSqmvgIV/CvwaXSpwfxQ=;
        b=X1Sw10zehVqBC0ozTnrBMP2l/OO4vnabgAL5kjcd8MXNDaZ0Cf7Eb5VFibmRnjndq9
         NZwc+VwXKTpieJty3ivw8d2vAcB0gGU4iEjhJMjr1fhjthhigxmodXCC9KrtoihNjGuR
         6b8lbfa3g6/w/ZXDJtMHmM3LfxlHV3+Vp1gCL89HppnZbHEMaI0SRFaYhSz4Vf0lUv7p
         OoAs8ZtRm20gmoeWqTU8ndzWpsoEy6Mo6M+uIEYYI376GaP9hByEiEWJnEBhG52nWB1M
         17QGrtzDsySDenq67aI4iO4RBCh+yjRNn3rOHmelejAjPdh15XUOOqeLLD6R1COlPUyB
         Ghag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/zwQGrWC0f3gpyveYnsjDUZRSqmvgIV/CvwaXSpwfxQ=;
        b=HD2xOBwTCA/c8h7fVCd1/8TfqKBCJblpbhkyBpqWcPEvbBvXj35L+1J/cXEDeIcaC2
         xdAfe2UX/64EgFeFAVhBhJ00HQe4t4oC6llMgBaYQlSE394vmXvshfJDvXbqmH2rLprJ
         6wO3dTqFadv5wNv+AxGsKf89N30bZMCuT3f8LNZXU77tDbVYA6g6D4m3Itp0rMF64zZg
         bO7BLrsn9M3xNkIMx5z+EbW5HVlDLHTx0P4yrhlQW3zYE2u59RK2IhBDRg8FxL5HI7jc
         1rZmEU9IHlgsktXFeVRnnK3DGdw8hf+xWvp5NiFebBjnqhcHdDdrZYDpWJn0Dllgf8Yb
         T2ag==
X-Gm-Message-State: APzg51B8Jpy3+v38pBdpaT859tZmsJQMRtCu/Pxu7QWVR/p/7A8gd8il
        dcAxnQi3cJhCyXTvVqmLwHqumzCX
X-Google-Smtp-Source: ANB0VdaEQ0wuuvk9AIL5se3qG2yWH9GbIVVfJa82+gX2gKlHt8MZFNBjiBUIDkPkG0/RkJfOgJVyMw==
X-Received: by 2002:a63:5660:: with SMTP id g32-v6mr32244824pgm.227.1536096439694;
        Tue, 04 Sep 2018 14:27:19 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id x24-v6sm29033181pfh.67.2018.09.04.14.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:27:18 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:27:18 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:27:02 GMT
Message-Id: <b639bfa5a828ed15fc960450dd813136408b5c70.1536096424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.32.v2.git.gitgitgadget@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
        <pull.32.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 09/11] builtin rebase: start a new rebase only if none is
 in progress
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

To run a new rebase, there needs to be a check to assure that no other
rebase is in progress. New rebase operation cannot start until an
ongoing rebase operation completes or is terminated.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 8a7bf3d468..d45f8f9008 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -87,6 +87,7 @@ struct rebase_options {
 		REBASE_VERBOSE = 1<<1,
 		REBASE_DIFFSTAT = 1<<2,
 		REBASE_FORCE = 1<<3,
+		REBASE_INTERACTIVE_EXPLICIT = 1<<4,
 	} flags;
 	struct strbuf git_am_opt;
 };
@@ -392,10 +393,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		.git_am_opt = STRBUF_INIT,
 	};
 	const char *branch_name;
-	int ret, flags;
+	int ret, flags, in_progress = 0;
 	int ok_to_skip_pre_rebase = 0;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
 	struct object_id merge_base;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
@@ -447,6 +449,30 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	git_config(rebase_config, &options);
 
+	if (is_directory(apply_dir())) {
+		options.type = REBASE_AM;
+		options.state_dir = apply_dir();
+	} else if (is_directory(merge_dir())) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "%s/rewritten", merge_dir());
+		if (is_directory(buf.buf)) {
+			options.type = REBASE_PRESERVE_MERGES;
+			options.flags |= REBASE_INTERACTIVE_EXPLICIT;
+		} else {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s/interactive", merge_dir());
+			if(file_exists(buf.buf)) {
+				options.type = REBASE_INTERACTIVE;
+				options.flags |= REBASE_INTERACTIVE_EXPLICIT;
+			} else
+				options.type = REBASE_MERGE;
+		}
+		options.state_dir = merge_dir();
+	}
+
+	if (options.type != REBASE_UNSPECIFIED)
+		in_progress = 1;
+
 	argc = parse_options(argc, argv, prefix,
 			     builtin_rebase_options,
 			     builtin_rebase_usage, 0);
@@ -455,6 +481,26 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
+	/* Make sure no rebase is in progress */
+	if (in_progress) {
+		const char *last_slash = strrchr(options.state_dir, '/');
+		const char *state_dir_base =
+			last_slash ? last_slash + 1 : options.state_dir;
+		const char *cmd_live_rebase =
+			"git rebase (--continue | --abort | --skip)";
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "rm -fr \"%s\"", options.state_dir);
+		die(_("It seems that there is already a %s directory, and\n"
+		      "I wonder if you are in the middle of another rebase.  "
+		      "If that is the\n"
+		      "case, please try\n\t%s\n"
+		      "If that is not the case, please\n\t%s\n"
+		      "and run me again.  I am stopping in case you still "
+		      "have something\n"
+		      "valuable there.\n"),
+		    state_dir_base, cmd_live_rebase, buf.buf);
+	}
+
 	if (!(options.flags & REBASE_NO_QUIET))
 		strbuf_addstr(&options.git_am_opt, " -q");
 
-- 
gitgitgadget

