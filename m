Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 698EA207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbdEBWYT (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:24:19 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34677 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbdEBWX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:59 -0400
Received: by mail-pg0-f44.google.com with SMTP id v1so68095131pgv.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4LAyNLoPQyUPINkcuKGry2Bfuc3l6rAj/763dwzCn1k=;
        b=ue/iK8GFc+lTMWjyrXFPfB27CzwTe78OuvwxRGLn63zt/iS4n8vmHQRe2iVG6ubqN+
         hM2c2RKPdA70taVwGs8AHFqVJPjflUdngrjjwfnIPGcmfV8c41cvK2+zi9yms7cHleC/
         QvVzekWhP7g28LmZBt0Y4muwsKsKI7fd6Y+aZtF0YMoYeN/bpT5DKBxmLRA2MZD6bfQN
         m8Yymwtm3DqVEyWQ1St80RpXKTqi33QSjTWjqBe7gh99D8088KCA710Wtgw5RlfSP3r0
         uCcHrPoSRCKatlV0XO+/4lYPTHC4HilP34nqMIK1B1jp6QHbd1MvIf6thuVNQt5TpuJy
         V4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4LAyNLoPQyUPINkcuKGry2Bfuc3l6rAj/763dwzCn1k=;
        b=HOB7kuwwZRfejFbESNpXhtx2OOj/hwEqfE2/9DVPHJX03Q39QKfiiiK4DXMBupg1jg
         +ILy97sFS2CXyWRGqFVwSq50RfOEHJ120HgMklBW8ar1I5EUckRs4m9F1l6/Zwiqh7DR
         NlmzuAKCVT/35cQ0+RPiPNQNJwCLkhT/7gBWQg1Gf7dCw1xNEXZnWMaK3PWEfzy9KnPL
         iBsfQEvFqXYcA3ChbsTwbvI/PE3h1dfEJbLaj4pw7j/4nc479wOW5dauZcLbYJtLwRTF
         AYdR1hQyBasfK9P3ecG8+djlOTqTGkgSHpIcrD6NKTn9JFikhKzQHe4CsrjHhr0j+p3e
         gOwA==
X-Gm-Message-State: AN3rC/6D/DYWmDgQvMG8S1rKkdS5TGFvUM8PqrEFEPVW00klxEJ7xg3a
        U6kk+ZZqYyImAoDf
X-Received: by 10.98.134.194 with SMTP id x185mr1396945pfd.106.1493763833494;
        Tue, 02 May 2017 15:23:53 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id 83sm671618pfu.106.2017.05.02.15.23.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:52 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 20/24] cache.h: drop chmod_cache_entry
Date:   Tue,  2 May 2017 15:23:18 -0700
Message-Id: <20170502222322.21055-21-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/add.c          | 2 +-
 builtin/update-index.c | 2 +-
 cache.h                | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f6d71b10d0..288b1f5bb3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -40,7 +40,7 @@ static void chmod_pathspec(struct pathspec *pathspec, int force_mode)
 		if (pathspec && !ce_path_match(ce, pathspec, NULL))
 			continue;
 
-		if (chmod_cache_entry(ce, force_mode) < 0)
+		if (chmod_index_entry(&the_index, ce, force_mode) < 0)
 			fprintf(stderr, "cannot chmod '%s'", ce->name);
 	}
 }
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 8c4911e920..f1c52a5531 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -432,7 +432,7 @@ static void chmod_path(char flip, const char *path)
 	if (pos < 0)
 		goto fail;
 	ce = the_index.cache[pos];
-	if (chmod_cache_entry(ce, flip) < 0)
+	if (chmod_index_entry(&the_index, ce, flip) < 0)
 		goto fail;
 
 	report("chmod %cx '%s'", flip, path);
diff --git a/cache.h b/cache.h
index a9b059913e..07ad23d912 100644
--- a/cache.h
+++ b/cache.h
@@ -354,7 +354,6 @@ extern void free_name_hash(struct index_state *istate);
 
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
-#define chmod_cache_entry(ce, flip) chmod_index_entry(&the_index, (ce), (flip))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
-- 
2.13.0.rc1.39.ga6db8bfa24

