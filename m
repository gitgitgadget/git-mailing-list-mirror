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
	by dcvr.yhbt.net (Postfix) with ESMTP id B83681F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 18:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfJJSgy (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 14:36:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39190 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfJJSgx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 14:36:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so9115673wrj.6
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 11:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fjrEpJ2fhUjux5ecC0FdGKxJc5Idjg81vPSBppBZbMQ=;
        b=Sq5W4lJjWOQC+whj7Sfef5G2UNOnkz0QOzHuMUZPgFa7xOYG/z7TRqrQCXga/jH0In
         8/bMBuCaKmFnB/3JfFzu3vUtyNPXH/ulPEceh1tFsEYBgnXLqMOiKLrgsKP1MUbvSeLi
         7UVdbrnnLtKzr+qwiSgdSlns+hR7Q3Hh35ARWpNIC2eh1U2tW7skYtwQh+CxXKFkBsOd
         D+RsAQBvRikaS9Q/zeCbfBudE7S7n7Pn2Da2tcA4oi7xODbUWGu8R1bDz4ecnZ/pJ1lp
         ZJPo5VFkJpm6OUUedOhdcMwYTXy46dPBlxpTbRzhGBGMLGyU0py9iluq7sbjGAbQ0Q28
         B42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fjrEpJ2fhUjux5ecC0FdGKxJc5Idjg81vPSBppBZbMQ=;
        b=AZLnfNhfrQFrTZq/ZLBvZAVtCBeIbYp4z6JmLzHhlI3mSSOs9Y3xpD1tya4Voej+Sa
         phNBeZP92sL0IVRnav3NFjbD1GBrOMJhmD3WFrEVT/8iN0fbU/GBaQaRedEjoPpEyLUR
         Qh//iuI2Rb7ND+3B29fuiHONmPJ8iLGE1iOEtOhBFhuz4u+i/BT3bs5l8fdpzlvhwPV+
         THzD2ucyqPL1s9gchoVxhKnN5fRYknPoqrvoVCIOKnFrZEncta9Kcj2ZlPItKV0kOvGZ
         EixJqz6eQJyBJrjOdS27N8YGOJEb83Ko06q7h7x3WktscJB957+RMQEMNdAdcLjYeWfb
         goFg==
X-Gm-Message-State: APjAAAUAqnPtVTYKw+/e8tLLjQytrKfNKeIvGxOM3J/B0mTK4BLjfwQa
        a2sCyhWziLue3hc1b5N8rH/77dyD
X-Google-Smtp-Source: APXvYqznZTtzz4YXIuovrZbcOfr0aVQA66egpRA9mhDcldwxGLQsxhlNOnzuL/8jeVhoXWWGzTh6Sg==
X-Received: by 2002:adf:814d:: with SMTP id 71mr10066841wrm.193.1570732610481;
        Thu, 10 Oct 2019 11:36:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5sm6809694wma.14.2019.10.10.11.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 11:36:50 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:36:50 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 18:36:46 GMT
Message-Id: <7305f8d8e81b856ba535aaafe97c708d80567566.1570732608.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.388.git.gitgitgadget@gmail.com>
References: <pull.388.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] sequencer.h fix placement of #endif
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Commit 65850686cf ("rebase -i: rewrite write_basic_state() in C",
2018-08-28) accidentially added new function declarations after
the #endif at the end of the include guard.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sequencer.h b/sequencer.h
index 0c494b83d4..ac66892d71 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -195,11 +195,10 @@ void print_commit_summary(struct repository *repo,
 
 int read_author_script(const char *path, char **name, char **email, char **date,
 		       int allow_missing);
-#endif
-
 void parse_strategy_opts(struct replay_opts *opts, char *raw_opts);
 int write_basic_state(struct replay_opts *opts, const char *head_name,
 		      struct commit *onto, const char *orig_head);
 void sequencer_post_commit_cleanup(struct repository *r);
 int sequencer_get_last_command(struct repository* r,
 			       enum replay_action *action);
+#endif /* SEQUENCER_H */
-- 
gitgitgadget

