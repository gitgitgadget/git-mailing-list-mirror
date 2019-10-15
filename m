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
	by dcvr.yhbt.net (Postfix) with ESMTP id 561751F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 10:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfJOKZn (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 06:25:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32844 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbfJOKZk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 06:25:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id b9so23186968wrs.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 03:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fjrEpJ2fhUjux5ecC0FdGKxJc5Idjg81vPSBppBZbMQ=;
        b=Mrv5xL//e63Z4458YnJeo6e+tOPG6A3MWlOycWgCKpOkk7KFcb0z+HDhpqU7SNyvhB
         /I/2XkYQV8oGoXcSh/J/cLQfQwEFT/NwCD9YNXUIl0vMWE3N6Uyu4t6BXeyjtTqi+DTy
         7Xs1E9LMMTW1WmdTHPGu1UlgNutrMtPuDA7eCmop69KKQjasHLpG+RTBD18K0NAkt6RN
         /Qnxmv0uleqpBgsfheV1BxHz7tfwa3qxDQsMirj9cHpmKRp49eiEiGMLDRgPWhBKWat7
         0u+Rw2xjPtm1nYosF6CsIjh5WMA1QZoAyfCacwFoVylvvfZEExUUe+ZH0zUjNqBv/Xxk
         Hstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fjrEpJ2fhUjux5ecC0FdGKxJc5Idjg81vPSBppBZbMQ=;
        b=ZGrFeifAa9XrmefNAokov6ezM/j+VWQ5aP4U6OaY8Os0bnvAGplLxnk4RweBxn9wt1
         KL4viiUmH6peclKbkZ2fy0xgAWGiik07MBTXU4HIQKfjAjL3WkCEfZ1JsE27ob162yUp
         6L6Aou2c+C/dNfydFOs9u7DruMQpVRcMEypthNobYjzfucgWmXsMi1HUXs0jN3Kt5CWi
         4SBpKr/FyyiL7dlI8NHPj0pd/1JK3voLTIbo76/heHGZsEa61gnJVAyi2+i8oktz7qCb
         T0k5FuByNb/vtlqx0dptljIIJXzR+2tr7fokv6WtaQgKxX5vc0R7/c1RbcpxYhElPvzV
         T/pg==
X-Gm-Message-State: APjAAAWmlYZE/2jxEHS6cXCrsPOuENuKuGtY4NdfU15EEiqs2fY4JmQe
        dYupBJQsXENqCcUbt29reQSzrTGL
X-Google-Smtp-Source: APXvYqwaHHTC7ZJC+GyOIqWEl05tX/ep8u7p03EDz+LeITdjLdllbq6pORLpDaAGshUZR1pIQD8LFg==
X-Received: by 2002:adf:e38a:: with SMTP id e10mr19310771wrm.348.1571135137853;
        Tue, 15 Oct 2019 03:25:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q15sm42492176wrg.65.2019.10.15.03.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 03:25:36 -0700 (PDT)
Message-Id: <0eac3ede02c9518ce81ba113e0dc2f7d78f5a22c.1571135132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.388.v2.git.1571135132.gitgitgadget@gmail.com>
References: <pull.388.git.gitgitgadget@gmail.com>
        <pull.388.v2.git.1571135132.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 10:25:30 +0000
Subject: [PATCH v2 4/6] sequencer.h fix placement of #endif
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

