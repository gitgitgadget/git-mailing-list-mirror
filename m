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
	by dcvr.yhbt.net (Postfix) with ESMTP id 04DF31F462
	for <e@80x24.org>; Tue, 21 May 2019 19:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfEUTeB (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 15:34:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36491 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfEUTeB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 15:34:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so51456edx.3
        for <git@vger.kernel.org>; Tue, 21 May 2019 12:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nsW/yM28biho6UCZ1sKpNYnIkqqbT2SiXrzNEgpbnMg=;
        b=fOMVmMYyn9m8ypiLg6jNMzkYah3Wlx1IQitd4BAh7CT8kWSQF33KFzVJa/oQ1Vf3Mf
         lr6Y11rdmYRFl8uOYkG2m1GRy9bVWebyIlIGw9UuJpne3x6bmuoRKyrcL7R+/cVfCd+3
         6wRyxMuKrOxa58AWCT3S9trl/tq459Ihf/n9yQP9iDnAvjtjNjqQuXSChwYNnznM1Hos
         iJKLbFSkOuGBrjtv9qL901/ymxGMHqfY+y4WpcEwSD2PMfgNbokQBCrHq4s5XmPjQ+Ro
         Ync+WkAM9mOC2UnoQZ0LcPSV335WADaI1sAxouGjFz7aq5oQOK5/rrUppqBDQHyuAIn9
         tp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nsW/yM28biho6UCZ1sKpNYnIkqqbT2SiXrzNEgpbnMg=;
        b=GWizLUiTNp/xktgvroPGzdujnOZp4+KBgQcVxXT0uL/6Jk5IoMm8N9I6E36v2rGT3O
         IhJDAoCzoGqjr6qZPau2N5poRnkfGL89oxpR26TZXeq/kUeGR5XRCbrQg8lG2NwoxESl
         fpbRKr1b7Vh5y7jCppwN313g7dSfuluqZTWgYpbokJc4JkIFr25zqRg6EOr++Y3NEyy/
         /mkTeogpQZas3xznvIDefh83uakRnlOPO+CWfymKnrMlyfeDV9jxzuzkN+ajHHGfq5zH
         qFuTWT2Tw+ZzoF5U6jyqQL5TRpBrKNaY2YzpUHHiCD0LEEm0t6ECVY8zh4oy/ukTWaH+
         cWFw==
X-Gm-Message-State: APjAAAVfTGLryDm5mQo9wL5/MZGnDWm3CvX4nfTzuj5zNb2LYHSlYdpJ
        D5Nn6rCTodQm89aKRy+Rz5pc+sDs
X-Google-Smtp-Source: APXvYqzwCY2QErq2CkuPZGRra1AxZQgXOraczzVX/qz8g9TTl7QLqhnhSD5CJJY2EdBCkctkdNo3+w==
X-Received: by 2002:a17:906:6c94:: with SMTP id s20mr55499956ejr.294.1558467239490;
        Tue, 21 May 2019 12:33:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8sm3640758ejs.87.2019.05.21.12.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 12:33:59 -0700 (PDT)
Date:   Tue, 21 May 2019 12:33:59 -0700 (PDT)
X-Google-Original-Date: Tue, 21 May 2019 19:33:57 GMT
Message-Id: <c195394c86c1ee599945cd4ea65633a72a3fd30e.1558467237.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.222.git.gitgitgadget@gmail.com>
References: <pull.222.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] trace2: fix tracing when NO_PTHREADS is defined
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach trace2 TLS code to not rely on pthread_getspecific() when NO_PTHREADS
is defined.  Instead, always assume the context data of the main thread.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tls.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index e76d8c5d92..067c23755f 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -61,7 +61,12 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
 
 struct tr2tls_thread_ctx *tr2tls_get_self(void)
 {
-	struct tr2tls_thread_ctx *ctx = pthread_getspecific(tr2tls_key);
+	struct tr2tls_thread_ctx *ctx;
+
+	if (!HAVE_THREADS)
+		return tr2tls_thread_main;
+
+	ctx = pthread_getspecific(tr2tls_key);
 
 	/*
 	 * If the thread-proc did not call trace2_thread_start(), we won't
@@ -76,9 +81,10 @@ struct tr2tls_thread_ctx *tr2tls_get_self(void)
 
 int tr2tls_is_main_thread(void)
 {
-	struct tr2tls_thread_ctx *ctx = pthread_getspecific(tr2tls_key);
+	if (!HAVE_THREADS)
+		return 1;
 
-	return ctx == tr2tls_thread_main;
+	return pthread_getspecific(tr2tls_key) == tr2tls_thread_main;
 }
 
 void tr2tls_unset_self(void)
-- 
gitgitgadget
