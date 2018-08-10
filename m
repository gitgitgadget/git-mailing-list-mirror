Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A97291F404
	for <e@80x24.org>; Fri, 10 Aug 2018 19:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeHJWSm (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 18:18:42 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37918 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeHJWSk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 18:18:40 -0400
Received: by mail-pl0-f67.google.com with SMTP id u11-v6so4450921plq.5
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8g2Pte8//JWTXomFBO/i7HkNULR5yKTQtvDFNVOFm/U=;
        b=tfT4Q/Eda6yynResYQiaNOS5iyEU6DMiPT0KY2LsXw9JgmeGGbzz9eaIAZrbXnaWgH
         6IYfkGt/fCRmrweD3f2JH66YPckz2fx06UY8PMP8SDKqfUq7n3k6IEEIBJwIFWyyhEyM
         FOSN28G+70hqT6bdmZWNLodfMlj0OyBhl3sJPp5LpUYN9HIl9ikjed2FPMYj7vYBb8ni
         L2oezPHdUVdEQMElp0lUgGlvpuId5FbKzUxYBJAD2GIGanEPusiL2B3QwZTl+CEpm/ji
         sDHPaL3gEpJzxxqhb5IhMgLDRy/wnvFqAaw74OfDx7YMET5psQsBJuwnZ6c16Z7nxwQA
         b4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8g2Pte8//JWTXomFBO/i7HkNULR5yKTQtvDFNVOFm/U=;
        b=aYj9QZOJ470DZ7SngbjYhY4ynXr9pzAV0nRtPOwugw5QRbIFWpMCaoLcj6u5yt3+kA
         hcsEJTaojy25up6dyWgw84UBP7IPuOooe/Y3VZMnuIsqV9x0xnfHMonG2CWKflPR99zl
         UzQbOj9cI2F789UZpp/GmhugIqZxCgz0hnJXVkZSN//FfPIekIe2U6Kjp3xttsVI5ISi
         RrCxxaBH2/1CiAbDEjcfLeTFap+l4+u5NlNx6A24TrxzkoKLadDPWw6m1r0fwzfkKBsI
         XFuLfbNBOiWwd5Hnh3e4m/TcXFpBdrV3bdQaITxV54/oGCZVk8n8ftT+pMIZdmy4Aih3
         oLnw==
X-Gm-Message-State: AOUpUlF8/kWksHDRHt9Cw38URGz3cNrBp33vfX31sf14ZP8QlBJyQlZH
        Rrt6BlsWjg2c9oR/Wu6V26mUKSE7
X-Google-Smtp-Source: AA+uWPzqob+2g8QWdqU5mhthVNYuORIGXxP5A2yNy/4/uzZonaW42mFt0IO2SMt9VxhFjpOjOkG3pA==
X-Received: by 2002:a17:902:aa8f:: with SMTP id d15-v6mr7369370plr.64.1533930444236;
        Fri, 10 Aug 2018 12:47:24 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id k123-v6sm10217390pga.21.2018.08.10.12.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 12:47:23 -0700 (PDT)
Date:   Fri, 10 Aug 2018 12:47:23 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 19:47:15 GMT
Message-Id: <1f5c15c7ed3914b733ccf8a4457fef50d2eff1c5.1533930437.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.17.v2.git.gitgitgadget@gmail.com>
References: <pull.17.git.gitgitgadget@gmail.com>
        <pull.17.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/4] trace: lock the trace file to avoid racy trace_write()
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

Note: while the POSIX documentation of fcntl() at
http://pubs.opengroup.org/onlinepubs/9699919799/functions/fcntl.html
suggests that the `errno` is set to `EINVAL` when being asked to
lock a file descriptor that cannot be locked, on macOS it results in
`EBADF` when trying to lock a redirected `stdout` (which the
documentation claims should indicate that the file descriptor is not
valid for writing).

To cover all our bases, we simply treat both `EINVAL` and `EBADF` as
indicators that we cannot lock/unlock this file descriptor.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 trace.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/trace.c b/trace.c
index fc623e91f..16abdb816 100644
--- a/trace.c
+++ b/trace.c
@@ -114,11 +114,20 @@ static int prepare_trace_line(const char *file, int line,
 
 static void trace_write(struct trace_key *key, const void *buf, unsigned len)
 {
-	if (write_in_full(get_trace_fd(key), buf, len) < 0) {
+	int fd = get_trace_fd(key), locked;
+
+	locked = !lock_or_unlock_fd_for_appending(fd, 1);
+	if (!locked && errno != EBADF && errno != EINVAL)
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

