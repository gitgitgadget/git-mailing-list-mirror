Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0D8A1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 23:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbdARXaN (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 18:30:13 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33147 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbdARXaM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 18:30:12 -0500
Received: by mail-pg0-f44.google.com with SMTP id 204so8304975pge.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 15:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6+ohBgzxOm9qNbik01L2M7Lc9smdrXE9kAuXCyn/Jn4=;
        b=M/qei+Y0L+YKfC4x20i9g5zqFpvUmml37D6MDl9sstdgV/I95i6mKW6PZk4a9GciBe
         MSlm3AO5Rq154cTr2pkIiYd6cMKQHAUcfTVmNoHENkLH0ryk4JU3LSqcKJWrFoue7fPG
         xzC3iKsBYmGaEp1yYTQ8GXlmrcSqxDL1UUz6zLl8u3+PFyI6wdM1cxYi+J/q0AzmJfwQ
         JmJXHN37PCYzP2gPwp5dO/Qu+Zrn/hhZOxCLXelul5FP6VMdSnfLylD11auRvyaU/oq3
         qVAvKf9UjkxrseV0/rtA6sPnoj4xIR/Srl6wEEWVed3nJD7Lt28VOP5dQXR0h9c2szXF
         5A9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6+ohBgzxOm9qNbik01L2M7Lc9smdrXE9kAuXCyn/Jn4=;
        b=JlOJ/7+B9+kpZVh1NjDN3vRHHUAmsuPQ3uluqOqibVjlgTRiiP7dIRNe2fUf1rMLPM
         GzH5aQ2OAAr+nteFwW5WJNrOKUavp9jsptJW8HLSua8yZ4QB8FRPMaSPuQMCbx4od7dF
         pa7i7luTUUs9Y/LeIOfiqeSKW4yIw9Itd4YyR2mhePECQrCa0GFYd89kvwV7ZyvQeXUW
         2IQgWNouAXsGJQxJpC5Ih2KaSUip+ClaTLImylBVIyZ54r5quMz8ds3pDJPzx/puZkqH
         P5c/bf5KsLx4M955GtDBAUA/vzx0hCEp8YruHhtLsDFwrSMglXXXXRKHriyPix1jPyPg
         kv+A==
X-Gm-Message-State: AIkVDXITtkQq/GJEqNKhuolcNDgj0CK+/poVtVlgfiYhtcW7cWb2YmUh280qUX2f36c8Zp5U
X-Received: by 10.99.153.26 with SMTP id d26mr6920649pge.44.1484781723055;
        Wed, 18 Jan 2017 15:22:03 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:40e0:b9ca:546a:a0ec])
        by smtp.gmail.com with ESMTPSA id u64sm3151507pgc.39.2017.01.18.15.22.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Jan 2017 15:22:02 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 2/4] cache.h: document remove_index_entry_at
Date:   Wed, 18 Jan 2017 15:21:43 -0800
Message-Id: <20170118232145.31606-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.299.g762782ba8a
In-Reply-To: <20170118232145.31606-1-sbeller@google.com>
References: <20170117233503.27137-1-sbeller@google.com>
 <20170118232145.31606-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do this by moving the existing documentation from
read-cache.c to cache.h.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h      | 3 +++
 read-cache.c | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 3dbba69aec..87eccdb211 100644
--- a/cache.h
+++ b/cache.h
@@ -603,7 +603,10 @@ extern int index_name_pos(const struct index_state *, const char *name, int name
 #define ADD_CACHE_KEEP_CACHE_TREE 32	/* Do not invalidate cache-tree */
 extern int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
 extern void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
+
+/* Remove entry, return true if there are more entries to go. */
 extern int remove_index_entry_at(struct index_state *, int pos);
+
 extern void remove_marked_cache_entries(struct index_state *istate);
 extern int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_VERBOSE 1
diff --git a/read-cache.c b/read-cache.c
index 2eca639cce..63a414cdb5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -503,7 +503,6 @@ int index_name_pos(const struct index_state *istate, const char *name, int namel
 	return index_name_stage_pos(istate, name, namelen, 0);
 }
 
-/* Remove entry, return true if there are more entries to go.. */
 int remove_index_entry_at(struct index_state *istate, int pos)
 {
 	struct cache_entry *ce = istate->cache[pos];
-- 
2.11.0.299.g762782ba8a

