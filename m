Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03F351F597
	for <e@80x24.org>; Thu,  2 Aug 2018 11:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbeHBNiu (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 09:38:50 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:34540 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbeHBNit (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 09:38:49 -0400
Received: by mail-qt0-f201.google.com with SMTP id l23-v6so1436493qtp.1
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 04:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B1VcKOxGsgaTJWCxB+ejEM0Z41/3wUWFgFVkfA/mWVY=;
        b=cfyvG627vnc8b5iaPuN7ullygcZH+Yi9neLF9qIqNjfqcw5NB/Vqa36FVrc7BLU9UB
         HRGu3OhsnkeYvP1YcdfL9V8MtYpMvZaLUzIOibWCFDBQxhioZ/5W6DowAUmojXp7wSzt
         8h8itJHa7LYy5R4BBpRWVl2cWNNRZUm4Bv9G+nZLxK6OgdwIXx/LYd9Dmx0kMC7Wdu3+
         QfDGKcODzN+AmmfElkioEthzTyl3DTYF8Ci5pysQc77/vxf5pGhPgTu7pzGXkeQ1umu5
         Vd9nG6n5jWH1EwLwnCeOV5dk5uMK7mkyNeYM8ul20EfzMs9OHvvb4SnVzzU7RgkpMBA4
         8QLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B1VcKOxGsgaTJWCxB+ejEM0Z41/3wUWFgFVkfA/mWVY=;
        b=b5DN6O/SQCj2G7RpHQW8/cPu36Epl6SdnBu5il19nkP04Bqh8DtoXuT6iPDR09/9nq
         PypDBy7t9r8o3mMKY5Hc7y3AoMyECOOuqeqzo2t+Z1gPTNbF6DwItpN4ezHrDWWA+Sfk
         nrBvzAEQXPaKRGdsWTB2xQQdEl73Q17uUOpMfUD+SWx30IvJdtPqWYA0Eu+el/cTGUMC
         /KeK+VSJaQMndo02iw5yh+R5m2d/0kyg9ZkBOZoKwieSl9YbFvu9VsoHJm3wP9kIt1nq
         XrbALVjdki+A58bIb8s49sNmPT5+kjDc9LxeePu5q8PnDlDI27DZek753R+e9h2aMJ0j
         BW/g==
X-Gm-Message-State: AOUpUlE26PctlNEi2tRAaGCsIuRW5dU1744lizFfgLNbW4ER0YlJdHZm
        R1t2cRKMMHR50PGiWYIdLg0d0CveXVs=
X-Google-Smtp-Source: AAOMgpeQZrF1iYtCj8usRjUkrj7G9HupmV2Aq2nR05ZCQL/N3KICQtTgd+yFtoYjUpt8E422mkq6+ndXLok=
X-Received: by 2002:a0c:9532:: with SMTP id l47-v6mr1348504qvl.30.1533210481101;
 Thu, 02 Aug 2018 04:48:01 -0700 (PDT)
Date:   Thu,  2 Aug 2018 13:47:52 +0200
In-Reply-To: <20180802114753.9715-1-hanwen@google.com>
Message-Id: <20180802114753.9715-2-hanwen@google.com>
Mime-Version: 1.0
References: <20180802114753.9715-1-hanwen@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 1/2] config: document git config getter return value.
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     gitster@pobox.com
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

