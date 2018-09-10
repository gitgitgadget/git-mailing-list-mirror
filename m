Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DD3D1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 21:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeIKCyp (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 22:54:45 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:56075 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeIKCyp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 22:54:45 -0400
Received: by mail-io0-f201.google.com with SMTP id m15-v6so1931316ioj.22
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 14:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1AODeIPDv46vexyadb6PwWFiND/V1p15PPZuEpBrJ/8=;
        b=D5ovJphD8fkK77S7gDsS15p0jqj0GTq/E2ejaQcHAip1fjb4pIdxcfY5Ff4VjJhAIh
         sHbmSXEV3Hx2zZkiw93b/dl0ROYLf5FIxCAu3izPZ+IH5RTyT7G99ge42UFvuSkzr/2b
         coMgnKvGeaafHQDdzRPzQlnROcuh5FJ6tPTblqukDEMV88Xvy/nu7OVdNPmdhTMFITnA
         RuhpEB8GOxTk4Z/rlZV4e0JoUtq3F0szxZOJHw4fPj0VHwYWxSSJ3sQ7SLxLuT5JkgF5
         jHJ5P46GZcRJ5E+2awjNPwpTYN3qS0FpLDPVtcRiL1zWUKHHEl2lRbsAB4DNsquSiGBj
         d3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1AODeIPDv46vexyadb6PwWFiND/V1p15PPZuEpBrJ/8=;
        b=bS7yNQa4jJMPHWtJHYp3RGtlprr7CHRJE5yMEZIybZi6tnedEGPoFwZm97kmh7D4rB
         8Q3sJ1vc3sH8PJpMbSMRoe0wEFswEAylg5CtMz/W2KQ4a8mvo4pjxDsyHX3DeGNOHz1b
         lNNjIdI11bieRu6VS4iqFhlkCXRSWSHl+/Ae+Ky1lwpTLh2I/P/u9AwCsYDurlktbawb
         CV48yI66dyejA6K/oHVKqQDhtHwdLQsmsGBbCupIu4VxpLlVTt+FQ+Z5BYtsmPxsjkma
         pnP3jB9XR3YKqWCJ7HVfsgPPiK63a7KC7WaQEoMuhXAVto9G354qQDrdVbDTeIUU9y2b
         E4mg==
X-Gm-Message-State: APzg51A8VgQ1nuGNyRxReoEdn5BX3MLdXuo3ieXipwegpi/wO3IBXGQS
        A1CRNvqhHNODXcA14oEqCnm8L3YIS21O
X-Google-Smtp-Source: ANB0VdbJwB8zQHdP408T1tH85YXtr0PZbZb+EUUGAMuKD6MzHb1D1z1zAGzNP21oC7ni1IyKzqhBLMRphf/B
X-Received: by 2002:a24:294d:: with SMTP id p74-v6mr21009252itp.36.1536616719095;
 Mon, 10 Sep 2018 14:58:39 -0700 (PDT)
Date:   Mon, 10 Sep 2018 14:58:31 -0700
In-Reply-To: <20180910215831.17608-1-sbeller@google.com>
Message-Id: <20180910215831.17608-2-sbeller@google.com>
Mime-Version: 1.0
References: <CAGZ79kbObDXyaRLADQpvMMSitOLCDwb030Q6UBiX-7Y-XWnqog@mail.gmail.com>
 <20180910215831.17608-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: [PATCH 2/2] string-list: remove unused function print_string_list
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 string-list.c | 10 ----------
 string-list.h |  8 --------
 2 files changed, 18 deletions(-)

diff --git a/string-list.c b/string-list.c
index 771c4550980..1f6063f2a27 100644
--- a/string-list.c
+++ b/string-list.c
@@ -195,16 +195,6 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
 	list->nr = list->alloc = 0;
 }
 
-
-void print_string_list(const struct string_list *p, const char *text)
-{
-	int i;
-	if ( text )
-		printf("%s\n", text);
-	for (i = 0; i < p->nr; i++)
-		printf("%s:%p\n", p->items[i].string, p->items[i].util);
-}
-
 struct string_list_item *string_list_append_nodup(struct string_list *list,
 						  char *string)
 {
diff --git a/string-list.h b/string-list.h
index ff8f6094a33..18c718c12ce 100644
--- a/string-list.h
+++ b/string-list.h
@@ -113,14 +113,6 @@ typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
 void filter_string_list(struct string_list *list, int free_util,
 			string_list_each_func_t want, void *cb_data);
 
-/**
- * Dump a string_list to stdout, useful mainly for debugging
- * purposes. It can take an optional header argument and it writes out
- * the string-pointer pairs of the string_list, each one in its own
- * line.
- */
-void print_string_list(const struct string_list *p, const char *text);
-
 /**
  * Free a string_list. The `string` pointer of the items will be freed
  * in case the `strdup_strings` member of the string_list is set. The
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

