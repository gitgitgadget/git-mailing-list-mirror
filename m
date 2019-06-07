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
	by dcvr.yhbt.net (Postfix) with ESMTP id BC1FF1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 18:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbfFGSil (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 14:38:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43491 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731901AbfFGSie (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 14:38:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id w33so4322335edb.10
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 11:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fw5Y2dHBDiFWW6OD8UhRfhbOL0mhunXuojtHWy7e9I8=;
        b=ZgRNnn4g+6EeEoVJwbeRCjsGq6zaFWFmQVPwyAlCEiX1FDguX0THHfqA0/Q509VJm8
         Rpw93JdMIxRvQXdGM+2qPrmSQ6d44qHRRdoI1YrDHW0zZ6TB2dWfmnnmsoYP0JzgmFaQ
         bbRv4URDpPDiZEtHvl5UGQFQw6NZB+5qmGOtFswvp+RX0AmGPFRqZWZJ8lpBzLx5e3je
         qYEAUJGKQit/u/HSsa1QdASCbf50hTSNzZxTQ2kILTw7hoRnhOCl7DcH2MIeMWIKamxP
         VSeMojLc6HTCV2fS5aVJ/UsBatvh2tflk8SMI5D2247hHbTgErErlDrP1TNRCB41RZSi
         CPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fw5Y2dHBDiFWW6OD8UhRfhbOL0mhunXuojtHWy7e9I8=;
        b=eoZS0u1Qji22cngKHgahvDObXWwyX9MnZUf4BhdoXxPUQnFepkdoGD7ozQxVPLcGsa
         qCl1xXqE1rgOBURH1UMjjG0YnH2GAn4g0/ww+7Y8ropFnTSQydS0uSlnu3n4aySLee8G
         GXzxh2gdoe443fFDw8C7Q8JV+RgIH3jKRQeiJekWhtmKUQSVm1DFpxSyntwFEZcTnLpv
         +yyl/wdYQI8RiKpzs9Vw3Lu6P6CkbuPrnpqZeABrRuwIvZBEx18UgwjFW//KQOEuwcrO
         RpxQp9HIQM3UaXT0CCro/xJty01GLMW1i48kXHBklOrU6fdCnSlVzpG56c/cRvVl8XzI
         yJyg==
X-Gm-Message-State: APjAAAXyFV7KxFzPu2cEq9/yogkyA1mg3rGvvSusYSzJoM9f4KQ9jJe+
        2+ySCyaaCzmPhcZEvI1l779yJWkP
X-Google-Smtp-Source: APXvYqws3Q4Tk9CLmiT2zyILEmuNhidfUaHHFzz1nXDVy511HVP/Gc3xIYQLcHht/BvTxm1DiB/ZLQ==
X-Received: by 2002:a17:906:41c5:: with SMTP id g5mr27931340ejl.114.1559932712753;
        Fri, 07 Jun 2019 11:38:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13sm708665edb.45.2019.06.07.11.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:38:32 -0700 (PDT)
Date:   Fri, 07 Jun 2019 11:38:32 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jun 2019 18:38:18 GMT
Message-Id: <101792b92db169a88d74d5f9292a7de30799e90c.1559932699.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v5.git.gitgitgadget@gmail.com>
References: <pull.184.v4.git.gitgitgadget@gmail.com>
        <pull.184.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 15/16] commit-graph: test octopus merges with --split
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

Octopus merges require an extra chunk of data in the commit-graph
file format. Create a test that ensures the new --split option
continues to work with an octopus merge. Specifically, ensure
that the octopus merge has parents across layers to truly check
that our graph position logic holds up correctly.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5324-split-commit-graph.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index e8df35c30b..704def70bb 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -290,4 +290,15 @@ test_expect_success 'verify after commit-graph-chain corruption' '
 	)
 '
 
+test_expect_success 'add octopus merge' '
+	git reset --hard commits/10 &&
+	git merge commits/3 commits/4 &&
+	git branch merge/octopus &&
+	git commit-graph write --reachable --split &&
+	git commit-graph verify &&
+	test_line_count = 3 $graphdir/commit-graph-chain
+'
+
+graph_git_behavior 'graph exists' merge/octopus commits/12
+
 test_done
-- 
gitgitgadget

