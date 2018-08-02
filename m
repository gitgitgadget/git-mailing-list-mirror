Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75F0B1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 12:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbeHBOEL (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 10:04:11 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:38761 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732196AbeHBOEL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 10:04:11 -0400
Received: by mail-qk0-f201.google.com with SMTP id u68-v6so1835935qku.5
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 05:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B1VcKOxGsgaTJWCxB+ejEM0Z41/3wUWFgFVkfA/mWVY=;
        b=I0AOFAuPQhCxQ55cpVSJOcaQTGRWTck1IBlX9tXSNDykGIHPLy+TPm1ngyqwKQ6QKs
         rmCsr+X/OgAOY8OPMl0TV7BqCETW91hBivmh5ShbunbmecLMeAHNNJNkX5TK7l/sw9Ga
         +QZq2n3tL1iZpXvOrLlPZWUfBWtmnrqCKjuZEsdzYac+nFNeFQ53lI9rlHpWPLdmzFcm
         1AkmB9tTcEwx3d/5kNIeQG/9ZTt5x82r5qMnRhM8Pfz2ldabrceHVWKIBwvlYNKQFSQw
         eQv28qr6nNp6RKFVhKNGd/qwphVqcASkOQxLXMtNXH7XIGZRwCuEBHg9qLrfoXX/tepp
         OybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B1VcKOxGsgaTJWCxB+ejEM0Z41/3wUWFgFVkfA/mWVY=;
        b=uhEFcYpvhZmRN674SBQICY1rZsKOIoQPYXqUI4z0XUc8+436/erR/HjKfjFgMakaP+
         8n1Vj0rrec7Th5UNidx5F6NtOQ2YmQVCYMy+/V4ZOLYElA17h3R6zq3DppWU1BDYeBPI
         QCM2UUVAl9u/zpdr0UQ1cXH/OlpyxtvHauSwo5qY+JsQncN4a/itFZQxmfAe88p5Go3g
         YcnPkVHWEHaIPENn5tCdYaU7bDMMM1LXs2R3xF3mGEwhJBOzrf+dkYUIryd6KjVoSxMG
         Bcsii4FsMueVelvDcPWpeXR9mgOrDGf03lJcn0zbtDThUJQqtwhjAJum44Em+/WMtI4q
         izBQ==
X-Gm-Message-State: AOUpUlEin8lgxp5V6laEG39M4U90+HbVv0DwFrW1lnCrm4hhM19BKtcC
        BrEdXKEpVzGfQO9UmfRZulyOnnAhInY=
X-Google-Smtp-Source: AAOMgpdzJfSgydvK5gdlFNkzCJ+dz3qwhMW5breP01T9/tmjoU6HREUOVqqEcyLyq/QWgT9h9C4VpmEBHFw=
X-Received: by 2002:a37:3a04:: with SMTP id h4-v6mr1314108qka.43.1533211996205;
 Thu, 02 Aug 2018 05:13:16 -0700 (PDT)
Date:   Thu,  2 Aug 2018 14:13:07 +0200
In-Reply-To: <20180802121308.17371-1-hanwen@google.com>
Message-Id: <20180802121308.17371-2-hanwen@google.com>
Mime-Version: 1.0
References: <20180802121308.17371-1-hanwen@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 1/2] config: document git config getter return value.
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     gitster@pobox.com, sunshine@sunshineco.com
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 config.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/config.h b/config.h
index b95bb7649..41700f40b 100644
--- a/config.h
+++ b/config.h
@@ -178,10 +178,16 @@ struct config_set {
 };
 
 extern void git_configset_init(struct config_set *cs);
-extern int git_configset_add_file(struct config_set *cs, const char *filename);
-extern int git_configset_get_value(struct config_set *cs, const char *key, const char **value);
+
 extern const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
 extern void git_configset_clear(struct config_set *cs);
+
+/*
+ * These functions return 1 if not found, and 0 if found, leaving the found
+ * value in the 'dest' pointer.
+ */
+extern int git_configset_add_file(struct config_set *cs, const char *filename);
+extern int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
 extern int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
 extern int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
 extern int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
-- 
2.18.0.597.ga71716f1ad-goog

