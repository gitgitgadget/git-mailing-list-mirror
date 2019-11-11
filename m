Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 893E11F454
	for <e@80x24.org>; Mon, 11 Nov 2019 21:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKKV2U (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 16:28:20 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:44679 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbfKKV2S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 16:28:18 -0500
Received: by mail-wr1-f42.google.com with SMTP id f2so16206731wrs.11
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 13:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QvlSZrg2iZwXCDbIoVz7SYXz/1QPUitavJOghXfdqbg=;
        b=b4URv8wHOxW2WVantC6+Vny2/PaPbViRX79UKMeE9xkiqcudovqxhUcugFWRmxKpD8
         4wvTYLngKp/u1TI6zdR3dpXsmT7uZgQjRwMLGOO8bS7xSowmAcHP+gyretNDPUDxYxtZ
         ZMaTdg3ksP57pygEoRsN/SSRJ8gLCnkmZP99gnaUWQiFuUjeD30rqy0UWKIFeR8s+eTI
         g4bl0zg3elnqJz5m1VOcktBsEZWUOJV1hEcTvKxfItgD6OCb5WVg0f0cH5oBIMa1eSa8
         o7Pz+tnewbpLxWD/bAHjfKK3+jfoSagvWzCt7W2QWWBn9mbCk2ZwTcK7YndhFhY96o7X
         vnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QvlSZrg2iZwXCDbIoVz7SYXz/1QPUitavJOghXfdqbg=;
        b=XVBQ8TPYHrDb3KsM9WT4kEIGbPeYBt030g3d8L+fvUTLkcUURKd1U6ze8S2cVCGluP
         DHJfI/JnA14RW2tm56lHHmguH/GlV3oxn/pSEhOkwT7DtjoGTnwa6xTFyemWeo6wjRB4
         RA5QiYDqG+wk+MvHZCEnvPPrM8K7j2I6m4ayGIZiPMh7UjQyRa3RzfXvKwNO99EzjP2u
         FSPZimNoMkbtDm11bkKU5kYA4+pDEP4GwlWp5D3jgCXWFUNCF/NiEOaDNHhpbzrngK/w
         2YSwO95hHIhfSfOHB2aqgSMcaR86cSfoAKJsPDANpgRA15R9U8dPLX0BksBNK4PPK0ND
         z2kA==
X-Gm-Message-State: APjAAAWmupEeK6eVcxIpKzLQk/wMP5Rhgqq2uETJ6rjpbIoADCHTruXG
        kdmqBqGBJyK3IT0en1nfbP23z5hj
X-Google-Smtp-Source: APXvYqxjkKSE1Kxx9ZT5EO2fMqFUVUxMrm7qTBqbHW3dYlN1SfChFo3+z4q+CKqG8pNICiO+twLh1A==
X-Received: by 2002:adf:c409:: with SMTP id v9mr22818169wrf.41.1573507695137;
        Mon, 11 Nov 2019 13:28:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w19sm763847wmk.36.2019.11.11.13.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 13:28:14 -0800 (PST)
Message-Id: <0e1663c039e5cd2c0c6ef2b727e855bea1bcf99f.1573507684.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
References: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
        <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Nov 2019 21:27:54 +0000
Subject: [PATCH v3 11/21] sigchain: move doc to sigchain.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Move the documentation from Documentation/technical/api-sigchain.txt
to sigchain.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Also documentation/technical/api-sigchain.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/technical/api-sigchain.txt | 41 ---------------------
 sigchain.h                               | 45 ++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/technical/api-sigchain.txt

diff --git a/Documentation/technical/api-sigchain.txt b/Documentation/technical/api-sigchain.txt
deleted file mode 100644
index 9e1189ef01..0000000000
--- a/Documentation/technical/api-sigchain.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-sigchain API
-============
-
-Code often wants to set a signal handler to clean up temporary files or
-other work-in-progress when we die unexpectedly. For multiple pieces of
-code to do this without conflicting, each piece of code must remember
-the old value of the handler and restore it either when:
-
-  1. The work-in-progress is finished, and the handler is no longer
-     necessary. The handler should revert to the original behavior
-     (either another handler, SIG_DFL, or SIG_IGN).
-
-  2. The signal is received. We should then do our cleanup, then chain
-     to the next handler (or die if it is SIG_DFL).
-
-Sigchain is a tiny library for keeping a stack of handlers. Your handler
-and installation code should look something like:
-
-------------------------------------------
-  void clean_foo_on_signal(int sig)
-  {
-	  clean_foo();
-	  sigchain_pop(sig);
-	  raise(sig);
-  }
-
-  void other_func()
-  {
-	  sigchain_push_common(clean_foo_on_signal);
-	  mess_up_foo();
-	  clean_foo();
-  }
-------------------------------------------
-
-Handlers are given the typedef of sigchain_fun. This is the same type
-that is given to signal() or sigaction(). It is perfectly reasonable to
-push SIG_DFL or SIG_IGN onto the stack.
-
-You can sigchain_push and sigchain_pop individual signals. For
-convenience, sigchain_push_common will push the handler onto the stack
-for many common signals.
diff --git a/sigchain.h b/sigchain.h
index 138b20f54b..8e6bada892 100644
--- a/sigchain.h
+++ b/sigchain.h
@@ -1,12 +1,57 @@
 #ifndef SIGCHAIN_H
 #define SIGCHAIN_H
 
+/**
+ * Code often wants to set a signal handler to clean up temporary files or
+ * other work-in-progress when we die unexpectedly. For multiple pieces of
+ * code to do this without conflicting, each piece of code must remember
+ * the old value of the handler and restore it either when:
+ *
+ *   1. The work-in-progress is finished, and the handler is no longer
+ *      necessary. The handler should revert to the original behavior
+ *      (either another handler, SIG_DFL, or SIG_IGN).
+ *
+ *   2. The signal is received. We should then do our cleanup, then chain
+ *      to the next handler (or die if it is SIG_DFL).
+ *
+ * Sigchain is a tiny library for keeping a stack of handlers. Your handler
+ * and installation code should look something like:
+ *
+ * ------------------------------------------
+ *   void clean_foo_on_signal(int sig)
+ *   {
+ * 	  clean_foo();
+ * 	  sigchain_pop(sig);
+ * 	  raise(sig);
+ *   }
+ *
+ *   void other_func()
+ *   {
+ * 	  sigchain_push_common(clean_foo_on_signal);
+ * 	  mess_up_foo();
+ * 	  clean_foo();
+ *   }
+ * ------------------------------------------
+ *
+ */
+
+/**
+ * Handlers are given the typedef of sigchain_fun. This is the same type
+ * that is given to signal() or sigaction(). It is perfectly reasonable to
+ * push SIG_DFL or SIG_IGN onto the stack.
+ */
 typedef void (*sigchain_fun)(int);
 
+/* You can sigchain_push and sigchain_pop individual signals. */
 int sigchain_push(int sig, sigchain_fun f);
 int sigchain_pop(int sig);
 
+/**
+ * push the handler onto the stack for the common signals:
+ * SIGINT, SIGHUP, SIGTERM, SIGQUIT and SIGPIPE.
+ */
 void sigchain_push_common(sigchain_fun f);
+
 void sigchain_pop_common(void);
 
 #endif /* SIGCHAIN_H */
-- 
gitgitgadget

