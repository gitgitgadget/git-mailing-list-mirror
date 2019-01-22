Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 517D91F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfAVVW2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:22:28 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:43504 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfAVVWX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:22:23 -0500
Received: by mail-ed1-f47.google.com with SMTP id f9so20516439eds.10
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QAe7g9GDoGCmHOhFbW4EJTd2P3CEqzRzbu7s7h2M8UU=;
        b=aDbwxVe/xLCRK70RL8XW2lPCG4FmeUQKkSCEnXKAc7htZ1+m7WEYvZ+aOcPpVVkXfn
         I9zsSmDQPXq3exBLvRVmqdbT77QjvstQ386PD2dSreVXhlhh4CULTaoYj9mGW6+kx6lT
         aU84TgFpgZAEHcNmu9aj9w3WIQeTNYRSHGo0pzPjYnGaV/m4bIra1bh7y2ArpUWgCEkI
         ofXmuYGH9hp9PDh2Ih8OEpUK11OiAgT6lKP8H6MyhM7JL6cVR5Zzg4fIGm4oqzVWDKK+
         uEKzP8+JsuREgvX59+KcyQUL1bocwiOKtrQXJPL5lAznzDW9YxbKAF/r8jAs5PlNsNUF
         AB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QAe7g9GDoGCmHOhFbW4EJTd2P3CEqzRzbu7s7h2M8UU=;
        b=qM5/LWs428fb6rouue8YHDFgt+RHCSQaqp+mCnzpQeuP6SeL3RTrRJlJW+1OYee019
         2eQKi+iwqrTSdZYR9aQcB1QyrSDKXVdUHFP4ZMHlgrwsxsdpkVQyS3NTZqSnkGiX/lUN
         ofxjGOTOnCCpFne6tPNPCHjOdNt4K+8fy8jqeWtbqm2xKUPxXHSknxahB0k9Wly+cUid
         N9WpmVa/EaRr0/cj1NRzvVkxahJYzkMMg6SNWHldqF9oLFikkfLJVr7gzzURfp7E7jc7
         7INH1xZEOcVfEp7tNhNaI8/elghlBKn0TFiT9QxKKlxnm7QhXTayOhPtKzU2Gv3bKY2d
         00fA==
X-Gm-Message-State: AJcUukcNINvSdLpVgCwOg0vbm6+xfWpfSmJ4h+uLgtKIIhiXYYdLy4OT
        /tltgx6GZkbFfGXqARUEch0iVZa+
X-Google-Smtp-Source: ALg8bN5EfnPgXZdSARi5VMyDLfY6nWSj1jd4N+ptwvHsjmy/QYF9J5lBESQaLJ6aleXG6Tn8qceWwg==
X-Received: by 2002:a17:906:288d:: with SMTP id o13-v6mr103689ejd.53.1548192140551;
        Tue, 22 Jan 2019 13:22:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c29sm9915348eda.75.2019.01.22.13.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:22:19 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:22:19 -0800 (PST)
X-Google-Original-Date: Tue, 22 Jan 2019 21:22:06 GMT
Message-Id: <705c2ece6db6e054a6436f8d6549a2eff97a7155.1548192131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 09/14] trace2:data: add trace2 instrumentation to index
 read/write
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add trace2 events to measure reading and writing the index.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 read-cache.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index bfff271a3d..f6d84bd7ae 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2232,6 +2232,14 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		load_index_extensions(&p);
 	}
 	munmap((void *)mmap, mmap_size);
+
+	/*
+	 * TODO trace2: replace "the_repository" with the actual repo instance
+	 * that is associated with the given "istate".
+	 */
+	trace2_data_intmax("index", the_repository, "read/version", istate->version);
+	trace2_data_intmax("index", the_repository, "read/cache_nr", istate->cache_nr);
+
 	return istate->cache_nr;
 
 unmap:
@@ -2263,9 +2271,17 @@ int read_index_from(struct index_state *istate, const char *path,
 	if (istate->initialized)
 		return istate->cache_nr;
 
+	/*
+	 * TODO trace2: replace "the_repository" with the actual repo instance
+	 * that is associated with the given "istate".
+	 */
+	trace2_region_enter_printf("index", "do_read_index", the_repository,
+				   "%s", path);
 	trace_performance_enter();
 	ret = do_read_index(istate, path, 0);
 	trace_performance_leave("read cache %s", path);
+	trace2_region_leave_printf("index", "do_read_index", the_repository,
+				   "%s", path);
 
 	split_index = istate->split_index;
 	if (!split_index || is_null_oid(&split_index->base_oid)) {
@@ -2281,7 +2297,11 @@ int read_index_from(struct index_state *istate, const char *path,
 
 	base_oid_hex = oid_to_hex(&split_index->base_oid);
 	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
+	trace2_region_enter_printf("index", "shared/do_read_index", the_repository,
+				   "%s", base_path);
 	ret = do_read_index(split_index->base, base_path, 1);
+	trace2_region_leave_printf("index", "shared/do_read_index", the_repository,
+				   "%s", base_path);
 	if (!oideq(&split_index->base_oid, &split_index->base->oid))
 		die(_("broken index, expect %s in %s, got %s"),
 		    base_oid_hex, base_path,
@@ -2988,6 +3008,14 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	istate->timestamp.sec = (unsigned int)st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 	trace_performance_since(start, "write index, changed mask = %x", istate->cache_changed);
+
+	/*
+	 * TODO trace2: replace "the_repository" with the actual repo instance
+	 * that is associated with the given "istate".
+	 */
+	trace2_data_intmax("index", the_repository, "write/version", istate->version);
+	trace2_data_intmax("index", the_repository, "write/cache_nr", istate->cache_nr);
+
 	return 0;
 }
 
@@ -3007,7 +3035,18 @@ static int commit_locked_index(struct lock_file *lk)
 static int do_write_locked_index(struct index_state *istate, struct lock_file *lock,
 				 unsigned flags)
 {
-	int ret = do_write_index(istate, lock->tempfile, 0);
+	int ret;
+
+	/*
+	 * TODO trace2: replace "the_repository" with the actual repo instance
+	 * that is associated with the given "istate".
+	 */
+	trace2_region_enter_printf("index", "do_write_index", the_repository,
+				   "%s", lock->tempfile->filename.buf);
+	ret = do_write_index(istate, lock->tempfile, 0);
+	trace2_region_leave_printf("index", "do_write_index", the_repository,
+				   "%s", lock->tempfile->filename.buf);
+
 	if (ret)
 		return ret;
 	if (flags & COMMIT_LOCK)
@@ -3092,7 +3131,13 @@ static int write_shared_index(struct index_state *istate,
 	int ret;
 
 	move_cache_to_base_index(istate);
+
+	trace2_region_enter_printf("index", "shared/do_write_index",
+				   the_repository, "%s", (*temp)->filename.buf);
 	ret = do_write_index(si->base, *temp, 1);
+	trace2_region_enter_printf("index", "shared/do_write_index",
+				   the_repository, "%s", (*temp)->filename.buf);
+
 	if (ret)
 		return ret;
 	ret = adjust_shared_perm(get_tempfile_path(*temp));
-- 
gitgitgadget

