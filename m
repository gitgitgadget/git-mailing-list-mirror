Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BA471F453
	for <e@80x24.org>; Mon, 28 Jan 2019 21:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfA1Vrw (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 16:47:52 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:42308 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfA1Vrv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 16:47:51 -0500
Received: by mail-ed1-f51.google.com with SMTP id y20so14329821edw.9
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 13:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QAe7g9GDoGCmHOhFbW4EJTd2P3CEqzRzbu7s7h2M8UU=;
        b=WVp5D1l7ho+3ypKbzHmDHUMQPEZZMUR49wI3CnkMzQHmU/HTdAyLBus7m/cocHX7c6
         eUVjWPBc4bKEm/4PfyYDsf9jh2Zgq7oV/j+HjyONd6o1d7aW5T4ZIkrtS8bDLemaOb1t
         eiGo6JPT9G7MTILi3wlDbvmeKoInnAPUbntosIftzFzIg1rmaKhzt2pbeY8XmOFiMVDw
         fnkraj54qsUy2Ql4CaOSrHhxScF02tt3vlHCML3yEXn1MQ5ATmgWCoSi5X+87F+DfcoC
         TCXF72x8m3S+wd3oYdwG9eH/JDDP+BaCNa9AI99pd2Af+PPepImkTaYxhsTgv6bQKeRj
         vAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QAe7g9GDoGCmHOhFbW4EJTd2P3CEqzRzbu7s7h2M8UU=;
        b=lzTkEoXtLvMYPtjUyeO0JEv71N6hZmThhk4NcY1g7EYzjXUo/NpiRo06j5viGszIXQ
         En8uoKnFzQszRvYz0rr8hK4oFCVVmBhOALn7m9pR7BNK6jQevRNMQrDuljqkdtAgaNop
         26y9CQCPHmXmC5y7mvYAjVkuzeAj2a+qY9mjrdlvaGgMV1dIbO0afqAzGtOwQcV2qZhM
         CpWNPvpb/AYNjMK3m9oCN5FCtC1mnSAZda66tK4xknnSdI26ugy5KdAE3OvAlY8hjoeU
         21F8n8ZGzcKacNg7doGGOKG5esT+LSmt2occ7fKpmf59RkksaeeNCNOGvoxuGOD1QFVs
         Fg8w==
X-Gm-Message-State: AJcUukeHFjl/Rvv+xT5PKhe5L8xacBMq2ENfY+uMGbSK8x/jeLx3GT9z
        I46RwRWSaj/t1BQVIOJ7fjTBg7oy
X-Google-Smtp-Source: ALg8bN6d5zvlwPzGwgeb4vjyK12TuYUCFFXAFwbzWGjx/ENE/MehNJcTVzSWV80J36uxZCF29SUe/A==
X-Received: by 2002:a50:a622:: with SMTP id d31mr24254435edc.228.1548712068728;
        Mon, 28 Jan 2019 13:47:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10sm14067434eda.77.2019.01.28.13.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:47:48 -0800 (PST)
Date:   Mon, 28 Jan 2019 13:47:48 -0800 (PST)
X-Google-Original-Date: Mon, 28 Jan 2019 21:47:34 GMT
Message-Id: <548ea5274217e67b2bb9ba59b185a521b9e36160.1548712060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v2.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
        <pull.108.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 09/14] trace2:data: add trace2 instrumentation to index
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

