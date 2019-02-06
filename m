Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2DD31F453
	for <e@80x24.org>; Wed,  6 Feb 2019 17:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbfBFRQE (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:16:04 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:43702 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbfBFRQD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:16:03 -0500
Received: by mail-ed1-f48.google.com with SMTP id f9so6513684eds.10
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 09:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tvKTJiXAJRbFolLQ69BmhTNP+L5fZ0jkQWuYo1oYtd0=;
        b=t2msDAZhPXjgNlau8s3EaKXK4wg38FFUiTMG2B+02DzvwznDaeRB1+zAUSuPqN3jTt
         tLSXlVoCGoQGiaohdWS+3hzsaB7B5HpO1cBpSk0UZkVJ3jqePXr+wKSGi7VZjXWynmPP
         ZaN7J4zaeyGAo82QzA3/p0usasvfxbSBoaL80pp0ZRuXRvggDIqesfhgNOkHQptmxtxG
         YYKwDti2Hzf2fbaRPlpJfHiBPZd7YlbrQ0KS7/bZcjGC1TPqqLcks1Jh+cd0lZztN1N2
         Oj01Ix3zAOp6C0geCnMPYkt1adSpR7IxsU25yjyKzc7TjhK9a3H1XmFHmYkWVRe4g39Z
         r9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tvKTJiXAJRbFolLQ69BmhTNP+L5fZ0jkQWuYo1oYtd0=;
        b=ffXbQ53h7358DsrQrCcT968f8y2UaSR4Oag3L/xJyXxiWvnPt5V/C5PIr37aJtbJ+g
         cK3ZeSBUq+sC9xytm7lvJmM1zM6oMgn5HO5cDR75NDe+qbUSIoI6UUvzuvHrGqMjBFBd
         vBZCyzQ5WDJcOanH500hzvachRtdBjVT/ygHnqjxy2XkK/o9Q6D5DfhYnzqnTzpSIJ+t
         6uf1zETlkTrwAl2ULp3nkNwM/BHnynymoqlFh5OhSxv/xYZ8HSKDbLpOVUChuTfg+5Ne
         iA4C5udj3QcALb3jhdNnKLhQ9gHnX1CZKTGnnTdJaVQ0zn6mwHSIZ4wMTd65HPCHPdq/
         YAiA==
X-Gm-Message-State: AHQUAuZVdpS36fiJBbtBVl7sm90L0xCKhu1UAcj9Yf6+RXVfLKhWHOnh
        e4du41yRl8XuPl4fGFXWDcVKAisf
X-Google-Smtp-Source: AHgI3IbvqhN/pRej+c5lNPeLxuCZDQMwFht/Ev2om2Lkz9hzEG0NsYz2B/sX6RlTwxv8s9S0ABP3bg==
X-Received: by 2002:a05:6402:1286:: with SMTP id w6mr9302435edv.53.1549473361159;
        Wed, 06 Feb 2019 09:16:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w56sm6135993edb.72.2019.02.06.09.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:16:00 -0800 (PST)
Date:   Wed, 06 Feb 2019 09:16:00 -0800 (PST)
X-Google-Original-Date: Wed, 06 Feb 2019 17:15:44 GMT
Message-Id: <bca6a7f0d6d58a1f0384933200c2e7f7fc4c7b42.1549473350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v6.git.gitgitgadget@gmail.com>
References: <pull.108.v5.git.gitgitgadget@gmail.com>
        <pull.108.v6.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 09/15] trace2:data: add trace2 instrumentation to index
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
 read-cache.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index bfff271a3d..240531d70d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2232,6 +2232,16 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		load_index_extensions(&p);
 	}
 	munmap((void *)mmap, mmap_size);
+
+	/*
+	 * TODO trace2: replace "the_repository" with the actual repo instance
+	 * that is associated with the given "istate".
+	 */
+	trace2_data_intmax("index", the_repository, "read/version",
+			   istate->version);
+	trace2_data_intmax("index", the_repository, "read/cache_nr",
+			   istate->cache_nr);
+
 	return istate->cache_nr;
 
 unmap:
@@ -2263,9 +2273,17 @@ int read_index_from(struct index_state *istate, const char *path,
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
@@ -2281,7 +2299,11 @@ int read_index_from(struct index_state *istate, const char *path,
 
 	base_oid_hex = oid_to_hex(&split_index->base_oid);
 	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
+	trace2_region_enter_printf("index", "shared/do_read_index",
+				   the_repository, "%s", base_path);
 	ret = do_read_index(split_index->base, base_path, 1);
+	trace2_region_leave_printf("index", "shared/do_read_index",
+				   the_repository, "%s", base_path);
 	if (!oideq(&split_index->base_oid, &split_index->base->oid))
 		die(_("broken index, expect %s in %s, got %s"),
 		    base_oid_hex, base_path,
@@ -2988,6 +3010,16 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	istate->timestamp.sec = (unsigned int)st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 	trace_performance_since(start, "write index, changed mask = %x", istate->cache_changed);
+
+	/*
+	 * TODO trace2: replace "the_repository" with the actual repo instance
+	 * that is associated with the given "istate".
+	 */
+	trace2_data_intmax("index", the_repository, "write/version",
+			   istate->version);
+	trace2_data_intmax("index", the_repository, "write/cache_nr",
+			   istate->cache_nr);
+
 	return 0;
 }
 
@@ -3007,7 +3039,18 @@ static int commit_locked_index(struct lock_file *lk)
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
@@ -3092,7 +3135,13 @@ static int write_shared_index(struct index_state *istate,
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

