Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 965DA1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 20:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbfA3U5F (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 15:57:05 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:41871 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387936AbfA3U4c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:32 -0500
Received: by mail-ed1-f42.google.com with SMTP id a20so783493edc.8
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 12:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tvKTJiXAJRbFolLQ69BmhTNP+L5fZ0jkQWuYo1oYtd0=;
        b=RQZ3yumx+Y2aqrZabtJU1hWb5qPUNn1HbtdF3Zhdy/YD1jAqfTopngtLRAcOFaMBJT
         /wkT+sv0ocwdR3498OzWUQpVi8S/KQD7hn7ruwWM1uMc/d6N9M4SA6FL791gvX+0U/St
         KCV/FGdmDK/1V2e4YEzxfKnfwYd1WJP3oPS1BtvLd3v+14PW5BWG4QBCXInkzPVIIyub
         Cun4ximQoQrWyeocEEli3+FDF096RNSwOSd84RuHlgATGQUZBeb2SpuAMtRzYT7xnBUb
         WKsiZCeK/L6UsHC6WYuPFLafsF3Y/yBYVBMyadQ8bZT3dVzzjzd3yCzMVzIeb82YZrlF
         sgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tvKTJiXAJRbFolLQ69BmhTNP+L5fZ0jkQWuYo1oYtd0=;
        b=AsFAxmP0iFLtsfB4T4Sl3WJK1FbsWe1gNgmDlaZuRXj0kh6vlQ5V4+blDI5YiGtXV6
         8FtdcRp6mWACy71jlE1gVXZlCzedmFj3AOoS4MW06KlkSH0QM0EP6pSTPEKQaA1Dzqsf
         NKWAI2OSGXgLXvMb434B+xSZse4Vu1iyQxJyEnhCpuad2FSZqGQkG2CKp2BgOWV3jzHc
         9OY/UHOxTAgU9Hfb7rrJOx72s6CPFG9g1QscWIjv130CR332ykCkT3/AZeEQh6nvxm+s
         HhiytMyX0g0VsodD2Wf8WkfYsBeMc3Exunb9BxyHMRrT5/L5QG4SuPYZ1ajpUJixsbPJ
         CJ+w==
X-Gm-Message-State: AJcUukcKC60eHOdJsbKD9J4RTMeZWiUEPpZ7zZL+W8eQbWvCQ0BGfkrC
        4k1OsaFCcsV2kvod4VcQh8S7oVBl
X-Google-Smtp-Source: ALg8bN6o4zIqbWgu2R4rik407QbD7UvR/B3t0X1sU3dbi890SwMeWaGDQXpMsB3kvbGVvWH7jzLvnw==
X-Received: by 2002:a50:b881:: with SMTP id l1mr31106283ede.167.1548881789882;
        Wed, 30 Jan 2019 12:56:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a27sm765758eda.65.2019.01.30.12.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 12:56:29 -0800 (PST)
Date:   Wed, 30 Jan 2019 12:56:29 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 20:56:14 GMT
Message-Id: <87a73af3382c53a917026524d2308b0b8475ded0.1548881779.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v4.git.gitgitgadget@gmail.com>
References: <pull.108.v3.git.gitgitgadget@gmail.com>
        <pull.108.v4.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 09/14] trace2:data: add trace2 instrumentation to index
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

