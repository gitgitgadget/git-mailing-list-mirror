Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E2ED1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 17:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390996AbeIUX31 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 19:29:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33854 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389545AbeIUX31 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 19:29:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so6296125pfi.1
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 10:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y1zQlUARm7GbYNl3NtJpUgMhk/cSFyvMqeULyUEQfWc=;
        b=QS/a03rovOdifrL/63HAdJlWFIHn50te8ZSNWBDKkc8DY09nB38NRcjo4NRQC//STG
         x+f4Y6yQVn3KkwxSAXXRp5/Nb78ws/QSZkwEcyImSQ4HVrlL/TUk8z96sNf+GKrgVcu9
         itOk5h/+QuL9uw0ZmTrE2OBRitEImRZrV/+H0yELpoMs9ItC+R0NC4blK2IaZ5DM5aND
         W0LuclJ+Q5kykgnYlzXRNcA45cnNGfqt58E0HXRF+9hoWI97vFsxC89e27USGLTkRFPx
         5c1ORDIbwt0MQCp4bAiJGQGfXInPxYyu2qWkLDi7EJY8DarQYt54ADiOxyIFMlblsFyn
         2XqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y1zQlUARm7GbYNl3NtJpUgMhk/cSFyvMqeULyUEQfWc=;
        b=WFAwQD8ch1OhBLAk0JABzx8ubEQ9ZHHvuypU8WcZ2t3yTlb3H0jYR8rrnRs+esonf8
         yDm5fXOIRtILTtO5AKQ7vAgcGbi3c6bflgHcG2LnG6MhNX4R/8s/WP0rF/9f+5k6q/ZK
         0fAEjsQgOdzSdDKnpl1Guf/3koe6zXv2bJIgr7/xONOD/pseLnW7M4yhSVKPuQmirCGJ
         h87Tv4lgPzyr3E9stR5BJRJn5KAS52WSGtM6VqOWe11LnTYetwGnsg8DByB70usGj0Nz
         QXT56sJq6BBlajhvfG5TQjNUjuYe+hLv1Mwyp2iVHSpgp1yXOJEvBeqKzZDbdqSVBMP/
         DXgw==
X-Gm-Message-State: APzg51CKwazS7urTrzMvgQdI6qAH2KAH+0dMenvJUNPGSKQ8WhcD/U2m
        p3HbvA+94jF0icmO8n6wtdoOqSeH
X-Google-Smtp-Source: ANB0VdYMott/62hhsee27mcSJ2Ja9r0gLRLdrCYCb6sYxsvSUnWGX4eIga30MOZlFEp808scLzo1XA==
X-Received: by 2002:a63:4f64:: with SMTP id p36-v6mr41222686pgl.210.1537551571490;
        Fri, 21 Sep 2018 10:39:31 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id e73-v6sm54878514pfb.153.2018.09.21.10.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 10:39:30 -0700 (PDT)
Date:   Fri, 21 Sep 2018 10:39:30 -0700 (PDT)
X-Google-Original-Date: Fri, 21 Sep 2018 17:39:19 GMT
Message-Id: <b0ceb960761329179d14e613343019e7ac207e4d.1537551564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v3.git.gitgitgadget@gmail.com>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
        <pull.25.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 3/7] test-reach: add rev-list tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The rev-list command is critical to Git's functionality. Ensure it
works in the three commit-graph environments constructed in
t6600-test-reach.sh. Here are a few important types of rev-list
operations:

* Basic: git rev-list --topo-order HEAD
* Range: git rev-list --topo-order compare..HEAD
* Ancestry: git rev-list --topo-order --ancestry-path compare..HEAD
* Symmetric Difference: git rev-list --topo-order compare...HEAD

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t6600-test-reach.sh | 84 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 9d65b8b946..288f703b7b 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -243,4 +243,88 @@ test_expect_success 'commit_contains:miss' '
 	test_three_modes commit_contains --tag
 '
 
+test_expect_success 'rev-list: basic topo-order' '
+	git rev-parse \
+		commit-6-6 commit-5-6 commit-4-6 commit-3-6 commit-2-6 commit-1-6 \
+		commit-6-5 commit-5-5 commit-4-5 commit-3-5 commit-2-5 commit-1-5 \
+		commit-6-4 commit-5-4 commit-4-4 commit-3-4 commit-2-4 commit-1-4 \
+		commit-6-3 commit-5-3 commit-4-3 commit-3-3 commit-2-3 commit-1-3 \
+		commit-6-2 commit-5-2 commit-4-2 commit-3-2 commit-2-2 commit-1-2 \
+		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
+	>expect &&
+	run_three_modes git rev-list --topo-order commit-6-6
+'
+
+test_expect_success 'rev-list: first-parent topo-order' '
+	git rev-parse \
+		commit-6-6 \
+		commit-6-5 \
+		commit-6-4 \
+		commit-6-3 \
+		commit-6-2 \
+		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
+	>expect &&
+	run_three_modes git rev-list --first-parent --topo-order commit-6-6
+'
+
+test_expect_success 'rev-list: range topo-order' '
+	git rev-parse \
+		commit-6-6 commit-5-6 commit-4-6 commit-3-6 commit-2-6 commit-1-6 \
+		commit-6-5 commit-5-5 commit-4-5 commit-3-5 commit-2-5 commit-1-5 \
+		commit-6-4 commit-5-4 commit-4-4 commit-3-4 commit-2-4 commit-1-4 \
+		commit-6-3 commit-5-3 commit-4-3 \
+		commit-6-2 commit-5-2 commit-4-2 \
+		commit-6-1 commit-5-1 commit-4-1 \
+	>expect &&
+	run_three_modes git rev-list --topo-order commit-3-3..commit-6-6
+'
+
+test_expect_success 'rev-list: range topo-order' '
+	git rev-parse \
+		commit-6-6 commit-5-6 commit-4-6 \
+		commit-6-5 commit-5-5 commit-4-5 \
+		commit-6-4 commit-5-4 commit-4-4 \
+		commit-6-3 commit-5-3 commit-4-3 \
+		commit-6-2 commit-5-2 commit-4-2 \
+		commit-6-1 commit-5-1 commit-4-1 \
+	>expect &&
+	run_three_modes git rev-list --topo-order commit-3-8..commit-6-6
+'
+
+test_expect_success 'rev-list: first-parent range topo-order' '
+	git rev-parse \
+		commit-6-6 \
+		commit-6-5 \
+		commit-6-4 \
+		commit-6-3 \
+		commit-6-2 \
+		commit-6-1 commit-5-1 commit-4-1 \
+	>expect &&
+	run_three_modes git rev-list --first-parent --topo-order commit-3-8..commit-6-6
+'
+
+test_expect_success 'rev-list: ancestry-path topo-order' '
+	git rev-parse \
+		commit-6-6 commit-5-6 commit-4-6 commit-3-6 \
+		commit-6-5 commit-5-5 commit-4-5 commit-3-5 \
+		commit-6-4 commit-5-4 commit-4-4 commit-3-4 \
+		commit-6-3 commit-5-3 commit-4-3 \
+	>expect &&
+	run_three_modes git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6
+'
+
+test_expect_success 'rev-list: symmetric difference topo-order' '
+	git rev-parse \
+		commit-6-6 commit-5-6 commit-4-6 \
+		commit-6-5 commit-5-5 commit-4-5 \
+		commit-6-4 commit-5-4 commit-4-4 \
+		commit-6-3 commit-5-3 commit-4-3 \
+		commit-6-2 commit-5-2 commit-4-2 \
+		commit-6-1 commit-5-1 commit-4-1 \
+		commit-3-8 commit-2-8 commit-1-8 \
+		commit-3-7 commit-2-7 commit-1-7 \
+	>expect &&
+	run_three_modes git rev-list --topo-order commit-3-8...commit-6-6
+'
+
 test_done
-- 
gitgitgadget

