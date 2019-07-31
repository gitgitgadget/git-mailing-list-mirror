Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C9C1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfGaPSn (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:18:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40488 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfGaPSn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:18:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so60217600wmj.5
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cNyaNgBOebgF4ObFz+d5QNzmjWb1Wn62d3g6L1wBL6I=;
        b=YB3ZVVSn3LG/wlFv8KhS90xWLZ4RhW16avD5nzD+8dRNi83P/Y/Wz92VBThmgnIb89
         R39C/LEakPF2Vm7Mj3jN0iD/VfoFieGayIumU0npHSqOWRj5kzDVtDXfXHcyFAWrpOSw
         rvlB+WcHX3jPNSLr2Ul2EX3J0UTEztQVCHUMm7HDEdN7oQTsgLo6PEXP1xhnyCnekxnj
         kiAsLHjRGRYIYKv9FQI5lkkj78/q9E+rii7+uyYGQGgpeeGupzgEaF5400MuN11WRWw3
         etbvlWmsuvFvhKjKJ6I3/5FZ7NN1nBgVwhwQBCPOUpJEEe56Z5q6ARf6QG1v/mKQ0tI6
         rzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cNyaNgBOebgF4ObFz+d5QNzmjWb1Wn62d3g6L1wBL6I=;
        b=t4rQW4p32riU3c6LYWkDriWoA7BUjWqrck1QVY12SQfjOSRlYjFrOY8PPvVVIbZzoV
         Jyu/GNdEmI7LvfuasmRXDriix0L0z9N7ZF8cuu8/PCwU1TRmsKKalm1ztPOAAVYhslfY
         t24WtWE+DVmtuPbrynmXre49Tv8eVBcqdmhgxKmSOQ6aTLQ3iCg8w5vDprACJgPfsXEi
         9jbR61QKqNsvBXXbcpbPIb0HTQS5e+sU2JTrXacsWrVpAyMElmT5QhpTfO/TmmFIbcaS
         V0hcjRYspNmoeSu5B+TrdSF+m3nBEYdkHiUjSB8XGxAZog0RguQAhUSqPak9phyl5EPw
         +F1w==
X-Gm-Message-State: APjAAAVSB9N3GIl5k3ai5EaajNeNKvdvALXSgYT6kNOAfP61htGf1XbF
        wxlYzvKhEfgtrXGsJSEfzGrEbm2J
X-Google-Smtp-Source: APXvYqw23T3cNnMNnFvSjCiBb1w0PZ3hOQrvrBwdrNuhTHI0zLjjp9gtiA/Ys42lQ/Z5sbGpVt5ICg==
X-Received: by 2002:a1c:6c14:: with SMTP id h20mr7548421wmc.168.1564586321059;
        Wed, 31 Jul 2019 08:18:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c1sm156066843wrh.1.2019.07.31.08.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:18:40 -0700 (PDT)
Date:   Wed, 31 Jul 2019 08:18:40 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 15:18:24 GMT
Message-Id: <db9ec248e1be7144602b7dfff7972249851d30e1.1564586316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.v2.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
        <pull.294.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 04/16] sequencer: the `am` and `rebase--interactive`
 scripts are gone
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Update a code comment that referred to those files as if they were still
there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index f88a97fb10..334de14542 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -767,7 +767,7 @@ static int parse_key_value_squoted(char *buf, struct string_list *list)
  *	GIT_AUTHOR_DATE='$author_date'
  *
  * where $author_name, $author_email and $author_date are quoted. We are strict
- * with our parsing, as the file was meant to be eval'd in the old
+ * with our parsing, as the file was meant to be eval'd in the now-removed
  * git-am.sh/git-rebase--interactive.sh scripts, and thus if the file differs
  * from what this function expects, it is better to bail out than to do
  * something that the user does not expect.
-- 
gitgitgadget

