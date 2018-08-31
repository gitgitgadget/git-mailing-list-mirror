Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3D111F404
	for <e@80x24.org>; Fri, 31 Aug 2018 16:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeHaU60 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 16:58:26 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:36032 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbeHaU6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 16:58:24 -0400
Received: by mail-pf1-f170.google.com with SMTP id b11-v6so5791750pfo.3
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U1Kwou+0/8dzrIjE3bxYzJr1T8DLrbclhhDnsf6eZzA=;
        b=btzA3hguzyJjwFwYj5VFyjUgAbNIv4deNjdNeMqsdUa9cf7s4qZEZaZqSkAPf6gwqr
         /tywfIjTzl1bnv5eSvzwgPboZIFzqbQGBHMU312fOfhATyqHvMIAtxR3qGwp+NDdz0z1
         WQe+9dlrUqLWq7rd7iUO0i1BIg1B0DSdeR0pWbP5aks5t7xWc2mNGYIHnDAJ0cviLMMc
         3uQQAIoVZk3Olt2qTIdvB+TeurpVj9xtdNYr6spC1TPXiilFncGVAgYDgRyZjuCNX9EZ
         hLaDcHo5tEfgNVT7zx6T86uyVFufwgv+oF1Y9dg46kd2dIk8/X3NhaCFTMIIwWIEgao/
         /Udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U1Kwou+0/8dzrIjE3bxYzJr1T8DLrbclhhDnsf6eZzA=;
        b=bXEjmwkcqTz3CJGtFo72L+W4XOLM+G9Xv6ZGtjjdjFchy4WQmA7OUDKOuAYgiyVvoS
         riK4S7vTrSWBtIEgZl+hcFLIo2HuHaYw1X6YWBtv6chubcpQxG5KpyoDTuVKiSCNFUB6
         ioqzcnpInm8E7bTnmh6sF/7E8KRy1rwZRaY2kbrPVVpd0FckNTuIZtM4qwHG5PFIIQjq
         Vqwgj5e478kkT+dR0QPKyM0zXc5sYPfTyNRrA70xfzjvve0gvCRAMscbhp89ut4tDBZ5
         joMrM//SyL+SRaa+jta/ep833m4e4ggyfzDRgmfc6zPZPXxWnYLDLqSWoiIXFEQoNto/
         9tRQ==
X-Gm-Message-State: APzg51Bzq5BDCqK88j00ZlimO3ExLBwA7ZDEj9GPyuHaDNAjryJaZON7
        1XldNHDuaxwwVAgVoDFqYy6USjsR
X-Google-Smtp-Source: ANB0VdZLwJrSCGMEBstyOEN29k495aqgT686wKZj7SuUc0OKVBOtBuvBzbmfnWD5CSX/3r5bhOi5bQ==
X-Received: by 2002:a62:68c3:: with SMTP id d186-v6mr16670125pfc.70.1535734202974;
        Fri, 31 Aug 2018 09:50:02 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id k126-v6sm17597249pgk.26.2018.08.31.09.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 09:50:02 -0700 (PDT)
Date:   Fri, 31 Aug 2018 09:50:02 -0700 (PDT)
X-Google-Original-Date: Fri, 31 Aug 2018 16:49:49 GMT
Message-Id: <82b7680a2e3f85685950ac288534b8c6575bcd63.1535734192.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.29.git.gitgitgadget@gmail.com>
References: <pull.29.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 6/8] trace2: demonstrate instrumenting threaded preload_index
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

Add trace2_region_enter() and _leave() around the entire preload_index()
call.  Also add thread-specific events in the preload_thread() threadproc.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 preload-index.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/preload-index.c b/preload-index.c
index 71cd2437a3..2483d92c61 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -40,10 +40,14 @@ static void *preload_thread(void *_data)
 	struct cache_entry **cep = index->cache + p->offset;
 	struct cache_def cache = CACHE_DEF_INIT;
 
+	trace2_thread_start("preload_thread");
+
 	nr = p->nr;
 	if (nr + p->offset > index->cache_nr)
 		nr = index->cache_nr - p->offset;
 
+	trace2_printf("preload {offset %7d}{count %7d}", p->offset, nr);
+
 	do {
 		struct cache_entry *ce = *cep++;
 		struct stat st;
@@ -70,6 +74,9 @@ static void *preload_thread(void *_data)
 		mark_fsmonitor_valid(ce);
 	} while (--nr > 0);
 	cache_def_clear(&cache);
+
+	trace2_thread_exit();
+
 	return NULL;
 }
 
@@ -118,6 +125,9 @@ int read_index_preload(struct index_state *index,
 {
 	int retval = read_index(index);
 
+	trace2_region_enter("preload_index");
 	preload_index(index, pathspec);
+	trace2_region_leave("preload_index");
+
 	return retval;
 }
-- 
gitgitgadget

