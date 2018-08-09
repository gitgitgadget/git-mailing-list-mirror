Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A231F405
	for <e@80x24.org>; Thu,  9 Aug 2018 17:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbeHIUBX (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 16:01:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37225 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731115AbeHIUBW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 16:01:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id a26-v6so3178493pfo.4
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0rwo4tO3a8FLE2lVxF0N8lqS89Sky3lWuWa++5hN5dk=;
        b=gCKX/7wnN4r1sk8aBK1e7YmPMLyVCqJKcax5i5kAG/m5ARwCtr7RM4bCKS+egUN69O
         2Lv5kgZvVOG3Gg/Tt9fhvIvhTxcv5oHdgB5VXVeUBTPqhCdFjkgzSiVhQSznQ4scR0jj
         9pHpNN4kp3s8i+aYPnjqVm+4w1F/Tu5E/2AifIycq3te1WFqIdSWYUw+8tvFqpipRxXt
         FGnGqd/P9+Y5LrRDaRgGHnN+tnnV+2UMRFiHdIqJvsS2FGUN2lHehxm1xVcQFoL96CrM
         m14JkFpX5xdjPuU1wUIXfFrnqwq6JpWONreNoMYu3NanijAc2n5QdW80peLjWveLuL+Q
         CtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0rwo4tO3a8FLE2lVxF0N8lqS89Sky3lWuWa++5hN5dk=;
        b=Tp1+ZSQ2sLB5XvEZ3y/KvAUoAP3thRuEBwyaTa4n329OxR5n2xn0baqB9lImHFw/qA
         4nJ52oAcg6gJtMi8V153ygGEZ/HRUxTBmwIWEaoILN1lyGhvNC190r9mak1rOJ62FDuL
         y+Z8/vkuGoflfH7Y4XMCJrmvtmaNhOvpuLdLf7hvSYOyAAQTQ47Ztk1/MYOICohBdIPE
         wkdSRaGsb96JE1Kl/zKKPjxDgMGY1LENV3aNtfze5+HSa/5LsNAm7bdo3Did5wBSgeXo
         Tv3OMTvi7UGAHQGh5AJ5bhncXf6SXE0XnCOtPJZupTlgTk50pDUG2wrZhtSdQKqx+pGC
         l/1A==
X-Gm-Message-State: AOUpUlE9zVNuM1UCcR/hZ0tN4Jta90ZdFCVXPro866DIgg7GT41+b1I7
        NeQbWCQ57LlZggLcBEQtZ6sJTmBT
X-Google-Smtp-Source: AA+uWPw16miWDjV6XLuSPcfvPtrual6XYLafP23+XuKE3YUl9BdMdH5z8ZkMft73TmaA4A3ESgpMVw==
X-Received: by 2002:a62:f909:: with SMTP id o9-v6mr3351687pfh.141.1533836129478;
        Thu, 09 Aug 2018 10:35:29 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id y69-v6sm23864804pfd.36.2018.08.09.10.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 10:35:28 -0700 (PDT)
Date:   Thu, 09 Aug 2018 10:35:28 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Aug 2018 17:35:20 GMT
Message-Id: <a53e72198ad690a968c12d22e9f2639130a36d78.1533836122.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.17.git.gitgitgadget@gmail.com>
References: <pull.17.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/4] trace: lock the trace file to avoid racy trace_write()
 calls
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When multiple processes try to write to the same file, it is not
guaranteed that everything works as expected: those writes can overlap,
and in the worst case even lose messages.

This happens in t/t5552-skipping-fetch-negotiator.sh, where we abuse the
`GIT_TRACE` facility to write traces of two concurrent processes (`git
fetch` and `git upload-pack`) to the same file, and then verify that the
trace contains certain expected breadcrumbs.

To remedy this, let's lock the file descriptors for exclusive writing,
using the function we just introduced in the previous commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 trace.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/trace.c b/trace.c
index fc623e91f..6f97dde27 100644
--- a/trace.c
+++ b/trace.c
@@ -114,11 +114,20 @@ static int prepare_trace_line(const char *file, int line,
 
 static void trace_write(struct trace_key *key, const void *buf, unsigned len)
 {
-	if (write_in_full(get_trace_fd(key), buf, len) < 0) {
+	int fd = get_trace_fd(key), locked;
+
+	locked = !lock_or_unlock_fd_for_appending(fd, 1);
+	if (!locked && errno != EBADF)
+		warning("unable to lock file descriptor for %s: %s",
+			key->key, strerror(errno));
+	if (write_in_full(fd, buf, len) < 0) {
 		warning("unable to write trace for %s: %s",
 			key->key, strerror(errno));
 		trace_disable(key);
 	}
+	if (locked && lock_or_unlock_fd_for_appending(fd, 0) < 0)
+		warning("failed to remove lock on fd for %s: %s",
+			key->key, strerror(errno));
 }
 
 void trace_verbatim(struct trace_key *key, const void *buf, unsigned len)
-- 
gitgitgadget

