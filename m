Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 170491F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbfA3TvR (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:51:17 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:46662 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733195AbfA3TvP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 14:51:15 -0500
Received: by mail-ed1-f50.google.com with SMTP id o10so593320edt.13
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 11:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tvKTJiXAJRbFolLQ69BmhTNP+L5fZ0jkQWuYo1oYtd0=;
        b=HsPLtlasWT0NaNB0taliahvbbmPQDDMY3D4LL5Krpez8+/h7+fq5wyLDHVDSaHGxXf
         kkySAPDIEoJshwgLLkAIMt+EL1OEAC1+UKZ0xxlqjFOwME6QUeBWCpFrymjAe0nCX9Yd
         5gy7ZWUxhLlB/txE00M1qO1dXJJ69zLANd7XunMeBf4zs0/aYRttXZzxoz61Me3wF78U
         Ywv94D0a1+blg2fBTZyWkgzVUvseKm1VKsHsTPLauQAa2Y2cG0l8h74auIZe2epACDar
         GE9EP2gNPrTU5FaKnRHGO2o4X8Nss/U4kbWL+RCzgcNo9oKuKaDMDRdMuvV8OkspEiiN
         EIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tvKTJiXAJRbFolLQ69BmhTNP+L5fZ0jkQWuYo1oYtd0=;
        b=orpxUNxpN3aY2XvyCvap9n5qcRoVVg7fkZDXUObAEFjCGoZFyu3MRCgvZCtXv52R1c
         bd5x1+TGPMq+TdSbIDq0mJqp2hhUIrjY2QC/qryR9znpasTiwbUS71lHoVjGcKAF2WwM
         iHNEyDY6C8PGn3569dutFLjMEbP1GwRagbQeU1ydMku9Cj7wQ7hiUjl91/xzjHd50Khn
         oNflt3NItI5pYc0mf3mfLDTr4/4/RmqlYB4PJS6uxvk83wpYMdpTrWaUqRdl0YZujn6t
         AMz47/BaaHRsHjSaz3b99/8yQG/jqE0zHE3EdN/+4SaMIN0BxKseq2fBQHorzy52YQAD
         8ZTg==
X-Gm-Message-State: AJcUukfiemwIShZP2qgew7d3X5FDhV3v6bZa1nKmIXV31nzMqClx7FGi
        umVS0QBa8aCB8L/irgBeawmwmuF8
X-Google-Smtp-Source: ALg8bN5CvbN+hXztuZb2XVvbg4N9zflmlhKqAVYML/Xs9gjg6IXXC/2Gb1fsmKZMAE6PT6gbRPOUiw==
X-Received: by 2002:a17:906:b318:: with SMTP id n24mr28036951ejz.21.1548877872837;
        Wed, 30 Jan 2019 11:51:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4-v6sm454113ejf.9.2019.01.30.11.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:51:12 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:51:12 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 19:50:58 GMT
Message-Id: <a2bcc6fd2804377a5599acf9bc6b99a017e83575.1548877863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v3.git.gitgitgadget@gmail.com>
References: <pull.108.v2.git.gitgitgadget@gmail.com>
        <pull.108.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 09/14] trace2:data: add trace2 instrumentation to index
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

