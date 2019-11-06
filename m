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
	by dcvr.yhbt.net (Postfix) with ESMTP id BFB181F454
	for <e@80x24.org>; Wed,  6 Nov 2019 10:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbfKFKA1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 05:00:27 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:54244 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731713AbfKFKAA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 05:00:00 -0500
Received: by mail-wm1-f46.google.com with SMTP id x4so2606818wmi.3
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 01:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C8GBxdLoF5Xz2AERpIWZpzuVBkkny6L685nRw2Wwj+0=;
        b=J9d4XuGXmPsD/JGAJar3oY56JH+cArspO/7mAtbJm8KKoL+yGrRwJhvcZLSV/pg3OD
         AMUu+Rf/jiZRo+dbXiSnGZ6TFT69L+vy8d0qAcUqleistEUkWJrfIV2EYDYom+M8PVc5
         /nY3MudLr3meTlcmcLNl1snZoXqa7KFNLt1e7la6euJGHVmg6xF5uK1029ncjf8jLrl/
         cz6tbyEQlIAoofGB7Vh/feu6HjxJOmBl70bk+HR2t4QsmO29aljoXxBabdbdOSYjLWtr
         yC+l3D7RJ0uod1pCP/TGUhcqq5izBptvwAC8cV2zhjl9fqij/l/17Twb1FRD85umkXea
         my2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C8GBxdLoF5Xz2AERpIWZpzuVBkkny6L685nRw2Wwj+0=;
        b=YHhMsufyVLMOx/rNNXOaKyqxNkZ7m42MF73c3iKjcGM7GKg+5Frp8XyIrM8Llmin2j
         zOm9OHpXA8cXM2cYZf8nVp+pszkpGGdWpIG014bznaLoHIPGHnUnT2Q1V+RZn/MBOb6D
         YHcRnuEvJi25XxY1EjS1MjeuLdyiTAv8O28rzxi6z4SmUjyhmmE28bkUShC3Y5/Pni0G
         F3kqDD2cIdPB2Ia84twTLPmzW3yiR8UiWGHrLYZWXqrTjqRCmjx/7kdeK+jkPjq2D/iI
         ksZm9F3IK0wxIqdvNCZk6LkivC1j+9rvvq/TtHaigjeEeoU/MjTJm7iiglmE2Cm5Etvz
         qZJA==
X-Gm-Message-State: APjAAAW3UGjn2E4+HvGYcAamMkgvHicFSX2E6BfhRYLSJC8oF+KahZEO
        yXLlpnKuS6XavoVI8bSkaQxrCRPH
X-Google-Smtp-Source: APXvYqw0Pvoas7BXZqXjDcr1wM7EVy++72pg27Qarm67DNOTufzSNlgroebbYbC+Z1sNFHwgg4se0g==
X-Received: by 2002:a7b:cd0b:: with SMTP id f11mr1734128wmj.26.1573034396716;
        Wed, 06 Nov 2019 01:59:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b3sm2558093wmh.17.2019.11.06.01.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:59:56 -0800 (PST)
Message-Id: <3499b99538425f9605fead842c10bc63238f94b9.1573034387.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
        <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 09:59:38 +0000
Subject: [PATCH v2 11/20] sigchain: move doc to sigchain.h
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
 Documentation/technical/api-sigchain.txt | 41 -----------------------
 sigchain.h                               | 42 ++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 41 deletions(-)
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
index 138b20f54b..a990f18cf6 100644
--- a/sigchain.h
+++ b/sigchain.h
@@ -1,12 +1,54 @@
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
 
+/* push the handler onto the stack for many common signals. */
 void sigchain_push_common(sigchain_fun f);
+
 void sigchain_pop_common(void);
 
 #endif /* SIGCHAIN_H */
-- 
gitgitgadget

