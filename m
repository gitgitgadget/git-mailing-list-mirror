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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FB331F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 21:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfKQVFP (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 16:05:15 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:33428 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfKQVFM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 16:05:12 -0500
Received: by mail-wm1-f50.google.com with SMTP id a17so14468705wmb.0
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 13:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QvlSZrg2iZwXCDbIoVz7SYXz/1QPUitavJOghXfdqbg=;
        b=gmmjaEXb1jm12zWyCNZujRezWz3mAoWtRno+MSPC2Qffcf9ufzx7mJPbLL8UqQZDaN
         7OIH+hCTYVTNIIzj4rc0Eo7cKQ2TV9PvtInbFVh/JfteltbNZXu9rGf1JsGS2OY+Ud6A
         KYvqx37YR1RpL9AKwQWxHs335go7/mSbk1rVMY3LahKiKlRqMl4OD4IDKf1j+pTopYpu
         evb7S08HWPtjQp8ER/U+VNQa6ON2DTlnNIqLV4UBVMOfXyq5eeX65FlijVB/CV9mTihv
         rHfXJtkWWbHcW2PVb4l0SoCQT1PYD0QZU3eKGyTAcxBh5/hXymdnFV4TBeeKF47AJiZZ
         dy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QvlSZrg2iZwXCDbIoVz7SYXz/1QPUitavJOghXfdqbg=;
        b=ocuF9xY56y91D1NnXGSxcgEKrpDPMzkNhKl2bY4Mz9S0YF++w8bbonySfeZ90YeCu2
         36TDJtUAce9YMvcu4t6PqdzdtwW+KlHqeNqz9OtVEUBNjfG901Urjurgrmr/rsSTA2hb
         iDRnY8WrPVvWVFbJqM4a7KQvTy+DH0c/ZjGsl9vtDXxCVQ4h5PwSexidGIkIempNHEFW
         RYdBVd/CeuCpVLCYm22v8aQTkvYRq+RR9GvSWrbrqadOpDJwlm+DYDz79UoQelHQBT1+
         iyqybuVpeouiUgj8j5P/1HW5+llktQhamBVv+/dtiYdXmA8orQro3EZfNusHmy+excDx
         VSKQ==
X-Gm-Message-State: APjAAAVfLfWJFcQj0H3QxZS4QMtaycniGvWZyFLHRrhboW6N0B285gCm
        /YVcgwkA7zkR5F64NnccbHr2mRfn
X-Google-Smtp-Source: APXvYqyeJmjLFXdSDNjSIJKr3kN+6QBsd1/DLXKNytJxgKCGTcJbVAp0fu4mlXcppKt77Cmc1vUkVw==
X-Received: by 2002:a1c:9e10:: with SMTP id h16mr25219986wme.91.1574024710578;
        Sun, 17 Nov 2019 13:05:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm21379249wrt.45.2019.11.17.13.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 13:05:09 -0800 (PST)
Message-Id: <240a4bcb3227224529945c9576b6e49891545841.1574024701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
References: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
        <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 21:04:50 +0000
Subject: [PATCH v5 11/21] sigchain: move doc to sigchain.h
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

