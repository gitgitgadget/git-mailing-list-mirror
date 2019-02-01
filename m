Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF0DD1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 17:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbfBAR7K (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 12:59:10 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:37581 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731511AbfBAR7J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 12:59:09 -0500
Received: by mail-ed1-f51.google.com with SMTP id h15so6153352edb.4
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 09:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tvKTJiXAJRbFolLQ69BmhTNP+L5fZ0jkQWuYo1oYtd0=;
        b=mMGvBllesAF3xPP2cchXCgk+ZJ3Xv+gb73PE4c0tCByjTakTK0RnPgM2HBgCHvQ6Ii
         RYtetckfpUQ/1Q88ybK6euoIn4qa1MhCEsWFLJ7N51Pq/Okd5pdN7cd9Aw2e3jLikVku
         WpIfSueCGeaBMQhwrvriq1ytBddN/EUN0Zd9nj6isklVqF/lMN1TCFgJqK2s8Jw8RRVu
         SqUslVJ77Hon2yVCSuWGUDR8/P1cuN9lX5gUQOvdHuFyJA+SytWUCpz46J125wpayHOo
         QnX5tpv4LPOW58z0GtWcTjRVVi6pedGwqtG6vt8K2a19t3r+SHWZ+kQnb8Usbl5XBrdv
         sLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tvKTJiXAJRbFolLQ69BmhTNP+L5fZ0jkQWuYo1oYtd0=;
        b=LggZCXRMWxfZenC+R4tVkxzeZYvVtCK5w8y4sXIEW8KAMVzLfiAcVGrkF2UIFbUIJD
         etPJQMlM590STQUpjOJWzBkoBULkEsli1jV/MyRLw3+Hpz27+Oy290vCANcpXDzNcXBJ
         Bv2X4/8F8WauVW5gwGm2Sai0iEAbuWLsqiEgXrOjzWeL1v8oOZ7T6thbL7r9DaEpVjmU
         inwMCuYuaJHu25fo+OI9DaW57WkveKEvit46nv1aP6jDgz3+t2feYA+P5HMB7hKmdvVs
         tn59RsJp7qUcelDOJlc2YKq+TjydQassEdqIkTYuEsLc2OaJSDMxC+O+vM+bZd4kTB0s
         mOWQ==
X-Gm-Message-State: AJcUukcNzaNre00etR/H+A+C/GkmlYGBgks04jPmfSKVJrvMrZGguSdL
        lWP6p65Un4F75BIpUxxB0fvUm5yV
X-Google-Smtp-Source: ALg8bN41Y+BHdK7osTEeJxN4N17T+bEbFYrM6apjDNDbA5IvTl8nNaASAWAlhQ1FHtVXrTRNq28FZQ==
X-Received: by 2002:a17:906:68c8:: with SMTP id y8mr29950614ejr.87.1549043946758;
        Fri, 01 Feb 2019 09:59:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13sm379133eju.30.2019.02.01.09.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:59:06 -0800 (PST)
Date:   Fri, 01 Feb 2019 09:59:06 -0800 (PST)
X-Google-Original-Date: Fri, 01 Feb 2019 17:58:50 GMT
Message-Id: <57b23542b3812222e7e36c63da8d85f257de5c6c.1549043936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v5.git.gitgitgadget@gmail.com>
References: <pull.108.v4.git.gitgitgadget@gmail.com>
        <pull.108.v5.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 09/15] trace2:data: add trace2 instrumentation to index
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

