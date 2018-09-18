Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B29BB1F404
	for <e@80x24.org>; Tue, 18 Sep 2018 04:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeIRJj0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 05:39:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36683 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeIRJj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 05:39:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so338347pfo.3
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 21:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QcshJYbErKPtRZt/cFP+z4bKvfLxODsQO0mhl0dPlSA=;
        b=qXFEg5M3w5kS4hYWqvC6IjoVtAPIbVDT6Ii0KvBvTZgJcyZ8c06hjZeLLavR/kgELH
         TmJWJGpcbTkpV4fSCQewCiq5IOgzWEtPP6YBNg0Gcz8rGEfLktlJ5Ar/eynga9TWk38/
         0Jk9A6JUsNhgrudRA9pN7D1zwEkt89ntx7MIw8/zrEd053AHFVa4JMkLfHmlWKFV5dgl
         sWCA+rI0Ey15rANplinumAGl1FlIYfXMYdCv3n8kb0dVfb4PoR4dbT+AUZE29+kK5aNw
         /y8mON5Hd5WFernYR+xGXNDsSM6OhKWnFVel4z8WVa4ljFLOXtAhxxFUDs1XtZ3Ay8N/
         61Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QcshJYbErKPtRZt/cFP+z4bKvfLxODsQO0mhl0dPlSA=;
        b=AcBioB30YmV8+3fsisFhmz1tcxW0YrIlJygXZ7ZzsOo5CyV7ZNwqpTMrizvXUiN4PT
         kSAVGNMuUEY/CCrHYlLJd0f7gsa8HOLoPiZgOEi0afNcr9KyxdArKd5sLInuIiJgp5RQ
         r/L57nNIJx8IyH5iI9v+T9puUpJI2jOqKd72wnEla49gpC6T8J9z4hIeJ+25RvdSMj33
         6Z83KHKJs8AEZgDuU/2SIhyIG1+wTGNN7/DcnVMYpwNqoXe7HH/Fu+ZzPzZTByFw3zzp
         rYQyROv2sKtLWQERRraYHW8/y+IbN59ALBM5Ghkn910ReALJ8QnARyfcRYlyLj5NZT6I
         rdcA==
X-Gm-Message-State: APzg51CGIpZM8nH77lLhuhx7hgZjMR6isuOcOjDFVMDTrtYXtwqFYcXv
        Z1ZEz0NsaM453dWjMhI/sDTuDdc+
X-Google-Smtp-Source: ANB0VdZ53x+BbUb48BvakhjOPOYGABj2AK/cQTaDynFoJzPE+DHd10Xs5scFgsqaxmmIIS2TQKZX+Q==
X-Received: by 2002:a62:b0e:: with SMTP id t14-v6mr28382124pfi.36.1537243725574;
        Mon, 17 Sep 2018 21:08:45 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id k126-v6sm23460415pgk.26.2018.09.17.21.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 21:08:44 -0700 (PDT)
Date:   Mon, 17 Sep 2018 21:08:44 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Sep 2018 04:08:35 GMT
Message-Id: <404c9186080ecee6c1cc39a6dcd17deaaa7a620a.1537243720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v2.git.gitgitgadget@gmail.com>
References: <pull.25.git.gitgitgadget@gmail.com>
        <pull.25.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/6] test-reach: add run_three_modes method
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

The 'test_three_modes' method assumes we are using the 'test-tool
reach' command for our test. However, we may want to use the data
shape of our commit graph and the three modes (no commit-graph,
full commit-graph, partial commit-graph) for other git commands.

Split test_three_modes to be a simple translation on a more general
run_three_modes method that executes the given command and tests
the actual output to the expected output.

While inspecting this code, I realized that the final test for
'commit_contains --tag' is silently dropping the '--tag' argument.
It should be quoted to include both.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t6600-test-reach.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index d139a00d1d..1b18e12a4e 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -53,18 +53,22 @@ test_expect_success 'setup' '
 	git config core.commitGraph true
 '
 
-test_three_modes () {
+run_three_modes () {
 	test_when_finished rm -rf .git/objects/info/commit-graph &&
-	test-tool reach $1 <input >actual &&
+	$1 <input >actual &&
 	test_cmp expect actual &&
 	cp commit-graph-full .git/objects/info/commit-graph &&
-	test-tool reach $1 <input >actual &&
+	$1 <input >actual &&
 	test_cmp expect actual &&
 	cp commit-graph-half .git/objects/info/commit-graph &&
-	test-tool reach $1 <input >actual &&
+	$1 <input >actual &&
 	test_cmp expect actual
 }
 
+test_three_modes () {
+	run_three_modes "test-tool reach $1"
+}
+
 test_expect_success 'ref_newer:miss' '
 	cat >input <<-\EOF &&
 	A:commit-5-7
@@ -219,7 +223,7 @@ test_expect_success 'commit_contains:hit' '
 	EOF
 	echo "commit_contains(_,A,X,_):1" >expect &&
 	test_three_modes commit_contains &&
-	test_three_modes commit_contains --tag
+	test_three_modes "commit_contains --tag"
 '
 
 test_expect_success 'commit_contains:miss' '
-- 
gitgitgadget

