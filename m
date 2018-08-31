Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03F8D1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 16:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeHaU6Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 16:58:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43835 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbeHaU6X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 16:58:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id v66-v6so5687477pgb.10
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 09:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4/e5fBPhngzUCydE/NRf1DKVYBzF3WslCO+t+q/PEUQ=;
        b=e7W1+0ibQgk0qPYVpHXNo5MJ1WLzqhlDco4j3A2YMiyiNdrpQyb3KCjUOa35s3mO0e
         7ckNQQDq8lxcFulFEygaN4Fsh1T2ZsY2jMq3fNRvTB8MnKd4S9SSw4/2g7uV7uOZttJw
         2rTNLtB1MWDGh/QHzjPkfh3Jze6Oco3OFgHn0Qvn5ULOMzKar3ROTxBhiZSS2AGyJp8k
         PtNShiVm0cVqiHedJg3LPSI6C/Z+Q7jzQvfrP+ma6+j+hN/v4q1vpJSxxRObFAbnUnW7
         GBQB7gl4cG3Jx+hjnHGvxlMnf3MQmAVuLn1wKZUfzc/ASHEWpaasu5sbsh10cqYnrjip
         IyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4/e5fBPhngzUCydE/NRf1DKVYBzF3WslCO+t+q/PEUQ=;
        b=Vd17F16Q6XGAri9a3jNbLY6WepyvIAAl2gXdFUEJaasM0fgi5UKlR88jiBEHFBNOa5
         lXS1yttfshrejJ9hOaZuNYkWQ5VBgEoXZndULPBMFrR8Ryo+ufmNMnb0hDIzdiotVbdC
         KWm1fswfI9ri6GtWoaB7vsKZx2wU13sMzLg2twBWmU3nhpsbEgyXoFxCGe2WA4mj8bzL
         u/l8JDSwJUcxgtKaUMKbDSrXT1OHc2ZMLMhm/m5j5DR+HZ9GRJWMY3nfq52faoWi8GP/
         YxZ9NevrpCRHgcTh8J1RqoKPxguV+MEZuTzGyGQeiJnjQe8hcue6N0CZNTOIgnzw1cHY
         ZmXg==
X-Gm-Message-State: APzg51AFFq9qlSiYN8F0PZAyySFyy3KpVZtmtx0+BhD103hMuwSkpUK1
        M25ihT6Uygs6I5+rR6R5Y/9bLnI0
X-Google-Smtp-Source: ANB0VdY/n1OPALyyuIIrEjERLM6hAYZYhJ8SUB4eJPC1Md/9ScCpf484cQFt9nbC4Ws7+e0c+BUDeA==
X-Received: by 2002:a62:6547:: with SMTP id z68-v6mr16776770pfb.20.1535734201595;
        Fri, 31 Aug 2018 09:50:01 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id o62-v6sm13917527pfb.0.2018.08.31.09.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 09:50:00 -0700 (PDT)
Date:   Fri, 31 Aug 2018 09:50:00 -0700 (PDT)
X-Google-Original-Date: Fri, 31 Aug 2018 16:49:48 GMT
Message-Id: <45a88264dd20daddbe02af3cb6a785dbb49addfa.1535734192.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.29.git.gitgitgadget@gmail.com>
References: <pull.29.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 5/8] trace2: demonstrate instrumenting do_read_index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 read-cache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..7a31ac4da8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1867,6 +1867,8 @@ static void tweak_split_index(struct index_state *istate)
 
 static void post_read_index_from(struct index_state *istate)
 {
+	trace2_data_intmax("index", "cache_nr", istate->cache_nr);
+
 	check_ce_order(istate);
 	tweak_untracked_cache(istate);
 	tweak_split_index(istate);
@@ -2012,7 +2014,9 @@ int read_index_from(struct index_state *istate, const char *path,
 	if (istate->initialized)
 		return istate->cache_nr;
 
+	trace2_region_enter("do_read_index");
 	ret = do_read_index(istate, path, 0);
+	trace2_region_leave("do_read_index");
 	trace_performance_since(start, "read cache %s", path);
 
 	split_index = istate->split_index;
@@ -2028,7 +2032,9 @@ int read_index_from(struct index_state *istate, const char *path,
 
 	base_oid_hex = oid_to_hex(&split_index->base_oid);
 	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
+	trace2_region_enter("do_read_index");
 	ret = do_read_index(split_index->base, base_path, 1);
+	trace2_region_leave("do_read_index");
 	if (oidcmp(&split_index->base_oid, &split_index->base->oid))
 		die("broken index, expect %s in %s, got %s",
 		    base_oid_hex, base_path,
-- 
gitgitgadget

