Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4881F453
	for <e@80x24.org>; Tue, 30 Oct 2018 18:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeJaDeq (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 23:34:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39000 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeJaDep (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 23:34:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id c25-v6so6287957pfe.6
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 11:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mm/rC6j88f54TRGCwwoMvP7x5ICF1CI+JKNsFJPW7iw=;
        b=Pa4jKJ2JmTXJ2c7roCL8r+My3QM/iC7dr3bJK7OzmLa3Ddc6JKWqLyRpESHLSHA/fp
         qckTLJe0Nv/19Lj98pzQxRqFWwc6sOCksqxloTvaq+MjNeSZgCdkB3sV7zUZ9wLJ91vq
         eecwQZBAR9ionTvJiIjsJXNVguYc0p0/let63TPxPyJTOGTkdX+ifWPKVUXCk4Tqtajy
         QA5cXbp7PGO4d3C2Pr5yDhfPd45/pV0Rpma3uPb+TnMwdcPiEDMcni/rs7n6/8l/SOs9
         5J7MLK/swhaO4H0AL065fN2Fk4Ho5BMg8aCS4UlVu5KSz/pgjyg7JMazGGACSf9gT6F0
         2QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mm/rC6j88f54TRGCwwoMvP7x5ICF1CI+JKNsFJPW7iw=;
        b=A3yxxNMfw5Eqfo9+izIVXFtIy6bbDXJUPHB33vb9m87A+nrW9v05O8eDUGUTSussTT
         b+YwD/7Ptq+oAFcHbTZ8RSaRACffRkLuvwqyf+PtDTBc4wWbqsBjz8k7LMI7b4YgGFH0
         JFlNn7HLnW1NLwZ3lB8RbAZJhh14WGeLRdm1nntX0fFyEjH+k5mq+mFM6AqkpCsdaSOg
         uAil34nNfsEmoVp8/onPxmIf0pcCG+yHMi5xO8gaZBsTykkWPfW9HkyeNhEQFHmc2DPn
         raJIhy8b5FF/Ypu4tyIFicHLlBsRnbmPpDe+7B9m7OFt2H9ZL89TwVStodwNOCwJSkg3
         gk1w==
X-Gm-Message-State: AGRZ1gLLQQxhP6d0Ytb/AKkK+W46onJ8c+5Q1Dp0ol4vv7PFyMi9luiN
        QbNfeNdY9HD+DKa/cm/QG2nmWDa7
X-Google-Smtp-Source: AJdET5ckJh79yJuA597e89d0ifambz7HKpwC/PIVydUA2EnNSHXqEcfEQ+N6XKxV+cGhCWwhxuYmuQ==
X-Received: by 2002:a62:ee03:: with SMTP id e3-v6mr3494553pfi.2.1540924807104;
        Tue, 30 Oct 2018 11:40:07 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id c17-v6sm4421319pgk.85.2018.10.30.11.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:40:06 -0700 (PDT)
Date:   Tue, 30 Oct 2018 11:40:06 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Oct 2018 18:39:58 GMT
Message-Id: <62813ef54647bb224a20208124d7d763bd9789d5.1540924800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.62.git.gitgitgadget@gmail.com>
References: <pull.62.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/4] Move Windows-specific config settings into compat/mingw.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h        |  8 --------
 compat/mingw.c | 18 ++++++++++++++++++
 config.c       |  8 --------
 environment.c  |  1 -
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/cache.h b/cache.h
index f7fabdde8..0ce95c5a8 100644
--- a/cache.h
+++ b/cache.h
@@ -906,14 +906,6 @@ int use_optional_locks(void);
 extern char comment_line_char;
 extern int auto_comment_line_char;
 
-/* Windows only */
-enum hide_dotfiles_type {
-	HIDE_DOTFILES_FALSE = 0,
-	HIDE_DOTFILES_TRUE,
-	HIDE_DOTFILES_DOTGITONLY
-};
-extern enum hide_dotfiles_type hide_dotfiles;
-
 enum log_refs_config {
 	LOG_REFS_UNSET = -1,
 	LOG_REFS_NONE = 0,
diff --git a/compat/mingw.c b/compat/mingw.c
index 293f286af..272d5e11e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -6,6 +6,7 @@
 #include "../run-command.h"
 #include "../cache.h"
 #include "win32/lazyload.h"
+#include "../config.h"
 
 #define HCAST(type, handle) ((type)(intptr_t)handle)
 
@@ -203,8 +204,25 @@ static int ask_yes_no_if_possible(const char *format, ...)
 	}
 }
 
+/* Windows only */
+enum hide_dotfiles_type {
+	HIDE_DOTFILES_FALSE = 0,
+	HIDE_DOTFILES_TRUE,
+	HIDE_DOTFILES_DOTGITONLY
+};
+
+static enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
+
 int mingw_core_config(const char *var, const char *value, void *cb)
 {
+	if (!strcmp(var, "core.hidedotfiles")) {
+		if (value && !strcasecmp(value, "dotgitonly"))
+			hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
+		else
+			hide_dotfiles = git_config_bool(var, value);
+		return 0;
+	}
+
 	return 0;
 }
 
diff --git a/config.c b/config.c
index 646b6cca9..5bf19a23c 100644
--- a/config.c
+++ b/config.c
@@ -1344,14 +1344,6 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (!strcmp(var, "core.hidedotfiles")) {
-		if (value && !strcasecmp(value, "dotgitonly"))
-			hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
-		else
-			hide_dotfiles = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.partialclonefilter")) {
 		return git_config_string(&core_partial_clone_filter_default,
 					 var, value);
diff --git a/environment.c b/environment.c
index 3f3c8746c..30ecd4e78 100644
--- a/environment.c
+++ b/environment.c
@@ -71,7 +71,6 @@ int core_apply_sparse_checkout;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
-enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
 enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
 
 #ifndef PROTECT_HFS_DEFAULT
-- 
gitgitgadget

