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
	by dcvr.yhbt.net (Postfix) with ESMTP id 634351F462
	for <e@80x24.org>; Tue, 18 Jun 2019 18:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfFRSOl (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 14:14:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43229 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730340AbfFRSOi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 14:14:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id e3so22989181edr.10
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 11:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0VgUGqTcNhF6P1ymO8x14/dnJ8Ut7yWnbobrZLGu6u4=;
        b=kXcrQmKbZkKPZCvIcIRU2q/SUqJtssNkryHnjKOYG7LR83dVu/Nu5SdkLSrTt4RtGR
         sp1OhTsujq2q7OBU6cWH8XekclnUNoOjhXmN3ZEOmx77BnQgByES8qqlXtbX/HVnLQUK
         BLNjWdFQ4qEUWoWf01tChZHF3Jh2wX3uKuYMD3w6k9/iDbGCknjVJ7vSdW/ebV0zdxcv
         +v2FuoYG7MGve6d4fgabpVoi3qyvH25XLHEmL5E34OfrdF7liNlV4eox4QUwHrvEbZJi
         IMpPdoKyC7hO71+mz9RnARUjF4ZnscaEvCnuCkWgFPwOXuMv0w8bpQhnXRA2l+q19jSC
         lNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0VgUGqTcNhF6P1ymO8x14/dnJ8Ut7yWnbobrZLGu6u4=;
        b=RmSR94VEsm7J4Xy1opwfOBYMrYd71GY5/WxlL5B/8ui/3VJSciYzXczV9GH37GsTfl
         t9l27wZ8ORjqnGvwYWVmsYPImz1KI2nhzh8IyU6hz3YNvetIcMGIuTocDT2YKnd/59f5
         rLIDGCZzXoqTFdeDi0oD484k3yg1J5KZslCSW9zKxdF7AI+S7TZd64d720vX9CePKM+2
         ycgXOk2tFcdJN2/aXRZ67wJbCn4oOPm/7tVOddDZhMDWhSuutJwmK7ige8wQVh5bOSY4
         1i2uvqJtcYSMZ3RbgKFYxx4rJtG5GFEAUF3BJyzPNMd7W1f4texz0jowSxihIcri4rAw
         Fr2w==
X-Gm-Message-State: APjAAAXFdIyl0GrIlQ5ewyhwYntCggnQvjacAXUcmxgKYFZnvst5JkYO
        ygj7hixnqYXSOD+UHbYgKar9SXxk
X-Google-Smtp-Source: APXvYqysNj72DA/OaqwUx0NnW7kV0PWmJauFvRQjZDwROQqLkJCDyrIA4Cj+RUzjEJ8rk/m7LkSOwA==
X-Received: by 2002:a17:906:f0cd:: with SMTP id dk13mr54099492ejb.84.1560881677222;
        Tue, 18 Jun 2019 11:14:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12sm2219941edq.57.2019.06.18.11.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:14:36 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:14:36 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 18:14:20 GMT
Message-Id: <bad9f13cc27663051dd3d9eebdd61a6287129861.1560881661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v6.git.gitgitgadget@gmail.com>
References: <pull.184.v5.git.gitgitgadget@gmail.com>
        <pull.184.v6.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 18/18] commit-graph: test verify across alternates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git commit-graph verify' subcommand loads a commit-graph from
a given object directory instead of using the standard method
prepare_commit_graph(). During development of load_commit_graph_chain(),
a version did not include prepare_alt_odb() as it was previously
run by prepare_commit_graph() in most cases.

Add a test that prevents that mistake from happening again.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5324-split-commit-graph.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index fc0d00751c..03f45a1ed9 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -237,6 +237,7 @@ corrupt_file() {
 	file=$1
 	pos=$2
 	data="${3:-\0}"
+	chmod a+w "$file" &&
 	printf "$data" | dd of="$file" bs=1 seek="$pos" conv=notrunc
 }
 
@@ -295,6 +296,24 @@ test_expect_success 'verify after commit-graph-chain corruption' '
 	)
 '
 
+test_expect_success 'verify across alternates' '
+	git clone --no-hardlinks . verify-alt &&
+	(
+		cd verify-alt &&
+		rm -rf $graphdir &&
+		altdir="$(pwd)/../.git/objects" &&
+		echo "$altdir" >.git/objects/info/alternates &&
+		git commit-graph verify --object-dir="$altdir/" &&
+		test_commit extra &&
+		git commit-graph write --reachable --split &&
+		tip_file=$graphdir/graph-$(tail -n 1 $graphdir/commit-graph-chain).graph &&
+		corrupt_file "$tip_file" 100 "\01" &&
+		test_must_fail git commit-graph verify --shallow 2>test_err &&
+		grep -v "^+" test_err >err &&
+		test_i18ngrep "commit-graph has incorrect fanout value" err
+	)
+'
+
 test_expect_success 'add octopus merge' '
 	git reset --hard commits/10 &&
 	git merge commits/3 commits/4 &&
-- 
gitgitgadget
