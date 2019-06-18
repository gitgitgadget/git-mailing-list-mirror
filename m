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
	by dcvr.yhbt.net (Postfix) with ESMTP id 50F631F462
	for <e@80x24.org>; Tue, 18 Jun 2019 18:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfFRSOm (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 14:14:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38868 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbfFRSOg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 14:14:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so20851295edo.5
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 11:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fw5Y2dHBDiFWW6OD8UhRfhbOL0mhunXuojtHWy7e9I8=;
        b=eUOQGH0lSH8pJpFrRlaAA+p5ddouZf4PrwHzB1uY1q+7gL2qMvaLJVaYGnDDj2nXXT
         gg2xdMNjR5t2gOw7jmMY7Z0Zms20rpmo+XUbllMqNitEQE6g2ialfJaZMqMDU4VcVXBY
         jvyw7uh7o0dZi0/axDV+/LW9fK2XAEwIc+JVM84i2ApLrMDA2zK4/i13azoCUJ8ZxBlQ
         yHB3lqv32Xm/N+HX4R6jcAhla6dp0jOpwqjZKw0peHZLu7v7BpGeoJg5Jexm5ZNGOOT/
         m6vY9dS8OivrPnKWuXErNu7eQzB9+eJiekk+jSlonmQpOBCLPzSvYp7NGOr6iM6noPni
         BvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fw5Y2dHBDiFWW6OD8UhRfhbOL0mhunXuojtHWy7e9I8=;
        b=AA5sOWs1QKVKOR/uOLvJokgaNSrTCft7HhlbCl0mFVnyr/dwZIWq3Hab6OohOhrP+4
         pQlEtsfvnWaZXYvtZ1nXqF/Uo1lrY3n7t4S8QmNcTCP9PuU5X6DqtUDR+gmYmCR+eid3
         PtcXcznuYPZl4D3JRqBS/DoSzVr3olqNhx/HNSKiKFgb56Re1i7BgAALpxEtdgo20uWv
         kO8f0H55UX5IlIMC4wStd3BIBHn0d8K+yJOS84cU9ysP5JPc5rG0KVhyqy6srsjKWe5s
         oZD3z9oLF5B30/QRmbrQY6i+JMJ/OAvtdFROAjGgt3kOIlc8gSfFlMvY8CSR1NlN25Eq
         S7eQ==
X-Gm-Message-State: APjAAAUu9J7N9tqR6+RhvQFPbmXOZRMhuKHJqMq5EAC3VRhABKPBWimi
        /SUuJneehpX1pOjpiCkNUUUSvOnL
X-Google-Smtp-Source: APXvYqxum5JkJU2RmqzqHNCu+qBMlY/CYb0EPEVYEtezZv+teOzujDL+8PdP3UwWR2aeucAv8PlFLw==
X-Received: by 2002:a50:a7a5:: with SMTP id i34mr126881044edc.294.1560881675047;
        Tue, 18 Jun 2019 11:14:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k62sm4898718edc.70.2019.06.18.11.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:14:34 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:14:34 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 18:14:17 GMT
Message-Id: <4877166d2ff74ff75f72a2c4d92b25bd3a6b343d.1560881661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v6.git.gitgitgadget@gmail.com>
References: <pull.184.v5.git.gitgitgadget@gmail.com>
        <pull.184.v6.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 15/18] commit-graph: test octopus merges with --split
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

