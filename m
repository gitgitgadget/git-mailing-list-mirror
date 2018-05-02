Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64CFE1F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeGCL1B (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:27:01 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41924 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbeGCL0U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:20 -0400
Received: by mail-pf0-f193.google.com with SMTP id a11-v6so873207pff.8
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=I4q1x+t3/CrRv1fpI+/EjKCJP8rFlSYYu5tSM6QV52E=;
        b=SYvKXqOb0PdGEetMRpch+2LSbiTNvYHp+Gyf47B+ifGmgXAmrOb5iB6l0hTW2u9UAv
         FCDgSIHBKeJ+WuXm6xS7qOJJ+FzWh1y/2BNNxKi7XvZXkSdjGlEBZuAiP6H6y7aOhX0T
         A6rNA/molThJQmR4BjNzKyiNd0O6ha40BLFvzP2eVZESTwV4dOiWpijpJ7mh/gkGELyJ
         +w9dt8+u00EDdUgyUNWZzpNGie5oQwPKoZ0hRxwVIp0n+RFqeUKwVtJ4CF0spPOZgGdc
         mig+h7HapjKH5UcyCDAO1fE0qVLdV96vMZaCC2qFfH33DV7zKwfm40VflZHkI3ETqlIH
         fnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=I4q1x+t3/CrRv1fpI+/EjKCJP8rFlSYYu5tSM6QV52E=;
        b=T13wvuROzPmhhgJ+ToHh3GvU7KmpKt1SndNCLnK3GKzxnJQY9OJqZ40iHBFVA6U9fg
         DLTvIHSnaZfXqMvHui52gQ1HxyBJYKBNoFSyJuZOvlL4NXDeG/6spgpyCrqPt9WviDFQ
         Cvc6yY+SgpASrx6PXjy5ZcFloS4BDZuEkBc9UhtuVDV2DHw6TJLxFWGvIeHrsvrC0UmC
         xVr2396hiYsBf6HjrmCtAN+md9cHr3n8U9ee/eQqnIJiAAZCjZRbBWgvxsylcrt7Xa0U
         gYTT6rsXt+LkvwvUzs5tV8/SIQWbZm0ViJUT7Hm6HiAteBDFGX56va8JDzOhJBbfdnLM
         14Cg==
X-Gm-Message-State: APt69E3M9vZrOQY8ZY7ycaEjYrT4Z9JsodGvmqeaz93i3JJzpH5LgZkO
        E4KmYmVf7Yi4oS1zuK/QvqraVA==
X-Google-Smtp-Source: AAOMgpfkcjitaT3QqBEF9SibS4m4QgrMfjcswZ9xXxT327nMw+dwckjC33Y1L8WnJqFMQBAoo6Fb3Q==
X-Received: by 2002:a62:ff0e:: with SMTP id b14-v6mr5727978pfn.135.1530617179582;
        Tue, 03 Jul 2018 04:26:19 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id c67-v6sm3442203pfj.173.2018.07.03.04.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:18 -0700 (PDT)
Message-Id: <ca5282815fa3f733c298dd412a61a585e441f278.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 2 May 2018 16:52:21 +0200
Subject: [PATCH v3 07/20] range-diff: indent the diffs just like tbdiff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The main information in the `range-diff` view comes from the list of
matching and non-matching commits, the diffs are additional information.
Indenting them helps with the reading flow.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/range-diff.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 5f12bbfa9..660e1f961 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -11,6 +11,11 @@ N_("git range-diff [<options>] <base> <old-tip> <new-tip>"),
 NULL
 };
 
+static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
+{
+	return data;
+}
+
 int cmd_range_diff(int argc, const char **argv, const char *prefix)
 {
 	int creation_factor = 60;
@@ -21,12 +26,16 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	int i, j, res = 0;
+	struct strbuf four_spaces = STRBUF_INIT;
 	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
 
 	git_config(git_diff_ui_config, NULL);
 
 	diff_setup(&diffopt);
 	diffopt.output_format = DIFF_FORMAT_PATCH;
+	diffopt.output_prefix = output_prefix_cb;
+	strbuf_addstr(&four_spaces, "    ");
+	diffopt.output_prefix_data = &four_spaces;
 
 	argc = parse_options(argc, argv, NULL, options,
 			builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN);
@@ -78,6 +87,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 
 	strbuf_release(&range1);
 	strbuf_release(&range2);
+	strbuf_release(&four_spaces);
 
 	return res;
 }
-- 
gitgitgadget

