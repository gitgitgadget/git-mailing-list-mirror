Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BF2A1F89C
	for <e@80x24.org>; Thu, 19 Jan 2017 03:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbdASDTF (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 22:19:05 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34900 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbdASDTD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 22:19:03 -0500
Received: by mail-pf0-f178.google.com with SMTP id f144so9412728pfa.2
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 19:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A1eRrBWwSNdLsFPIErhVWComuuvN1xphHfrKkdEzu6g=;
        b=tYccZ1DUejDa35QHEoDAhCcL7C+RjgSfryY+N5LPLgppaB/kx6WqMXq3d16cBWZcB2
         Mdk+28SmojAhjw3bKLFVjwhFht1V3k8eAOBvAfbUvuMMvFeFrF8eH9VKt9/a7fN9t/RG
         3bYfJXwOvuWjGHxyGSu0c+uG4b0q+X17LItn/6eexCuAUdbR0IbkRPCajrJPnPy1jHeH
         t6AdBS59v5GKRChDpqn15KW/E9z0Q+9lJUn/9MPuQJR20Vb2pQ9YxhqF/+nADy99vcqb
         3EEKmAE0qYAE1DVU4OJDOxKPtzR+XXCGdfEZO99jw0gIiy/uzY1ZJRPA4v1Jq+w5yfAz
         N1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A1eRrBWwSNdLsFPIErhVWComuuvN1xphHfrKkdEzu6g=;
        b=g4fXwMtxdc2qtk0LqOpxPQaV3meaocydgSFcyMhc6esNjmdNPYSladoIX/C5f/1Hpm
         h4YL8mGkgT5cr52lCQqGd8YR8FoXXE4GG+6T8JY5pdGWUXNpvU8XuIj4mTEYdFxRpHV5
         hRG/yTPP4utNfVUoDRIlOjRmsu2KJ2v5AF8toqS3v90sHC9YVwwOxSh7jmP994zr8JaU
         HisGN88YEY6z1qVXTinMmb9Ho6NbewP9ArKWb5FumjaoP2DrN2AioR+ItgKqIUUUv0aN
         tAcNHRNdv9hUbBE6aHZYXLQz1WIBvHRUWpg4/y0nF3+bYCCKyskHt0bcl1M2f0iZRUHR
         e7Wg==
X-Gm-Message-State: AIkVDXLeP4AMHpqSS+gJPjGOz/6Z5odQpGaYC7zJphVdSX/kdEfFGl0ZbJgwq0QtHd5H2Cpn
X-Received: by 10.84.231.205 with SMTP id g13mr10022740pln.118.1484795942142;
        Wed, 18 Jan 2017 19:19:02 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:40e0:b9ca:546a:a0ec])
        by smtp.gmail.com with ESMTPSA id r1sm3787456pgn.48.2017.01.18.19.19.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Jan 2017 19:19:01 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 2/4] cache.h: document remove_index_entry_at
Date:   Wed, 18 Jan 2017 19:18:52 -0800
Message-Id: <20170119031854.4570-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.299.g762782ba8a
In-Reply-To: <20170119031854.4570-1-sbeller@google.com>
References: <20170118232145.31606-2-sbeller@google.com>
 <20170119031854.4570-1-sbeller@google.com>
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
index 1469ddeafe..929474d7a9 100644
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

