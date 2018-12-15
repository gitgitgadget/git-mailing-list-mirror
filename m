Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFCFA1F405
	for <e@80x24.org>; Sat, 15 Dec 2018 22:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbeLOWEE (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Dec 2018 17:04:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38989 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeLOWED (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Dec 2018 17:04:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so4312100pgl.6
        for <git@vger.kernel.org>; Sat, 15 Dec 2018 14:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=299dIjLX58lSabJ4iiXIVH3v9XP2lY9mVFUWrelhkH4=;
        b=GkEGFu4P1ydVZ73r2+FwaQ3U8MN7MQD6Ap4vjTUagQDW6D5mbfGYpXJNwNcICsGShb
         is2TiDTlmWlUeNayOIRBssIGNpvm9FCyI/8o5f5LKbtKwi6qzTs+2lav11G8LT5mlqjl
         ORT4CZIZHMo1CmbmcQY5HRd6mRqoT2T9tQNIt52VBpqLr17DwWuXjff06HTA0MSHAI1d
         b2oQFTDxtSt5vdKgqtVVtf1vct2rW9Mw9n5PDUsTgmBQIs+tQHNnsVKSYlpGaSohb531
         Alk0Q2Dn+mdaMx82HBcwHLY8m4RPSY2wgCJbRWeTq2AhgWjSLwCD8hoNMWWNiLd5cSvg
         G8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=299dIjLX58lSabJ4iiXIVH3v9XP2lY9mVFUWrelhkH4=;
        b=qddXRd2B2VLSZE5qd/Ip+MBwj4sRppQV4l0vM+4MmqZ1V7bPGpnZoxuFxRzrYIe7t0
         uNyx2Ax1n4qioyAbk7OjVQR4hxWrVvswaAmz0QgnvIpc1wBiZPd7YO/zddKh88LBUv7O
         duAiPfO2aqVPZHl3MQflUOlxq238JHbgH6zqMsxiI0/XZ3b1L+hI5Q7S8ZkGB7eRRaxJ
         yIKHDUHuGWp3diF5a9M65BIX1vq7hSeKBn4uyUEQM+g9D9TztbubtQFd3b7leb6vhhZ+
         x4QEpJWL/20Ln1jfNxX3QIQ3Z6FcTV7fAMrPXpITQyp8zXdkukVL9q5V6IqloHOCxiIF
         T9CQ==
X-Gm-Message-State: AA+aEWbvtDS78fRqKC4Oywg55njmb2MHvqO+UKIB3RTUCkOifr2kT9rY
        EdVX7oIW5VnZ2G/5PZ2I/5hAkEmK
X-Google-Smtp-Source: AFSGD/UWUez0g/X7jeAF4IEScXuHKcOTdETme640kPgCI/qw5vNtJMCZVl7lQZmMDyHJyODWEg19Rw==
X-Received: by 2002:a62:1f53:: with SMTP id f80mr7756667pff.92.1544911441883;
        Sat, 15 Dec 2018 14:04:01 -0800 (PST)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id c7sm14792737pfh.18.2018.12.15.14.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 14:04:01 -0800 (PST)
Date:   Sat, 15 Dec 2018 14:04:01 -0800 (PST)
X-Google-Original-Date: Sat, 15 Dec 2018 22:03:57 GMT
Message-Id: <7eee3d107927b30bd3e1ec422e833111627252ce.1544911438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.95.git.gitgitgadget@gmail.com>
References: <pull.95.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] gc/repack: release packs when needed
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

On Windows, files cannot be removed nor renamed if there are still
handles held by a process. To remedy that, we introduced the
close_all_packs() function.

Earlier, we made sure that the packs are released just before `git gc`
is spawned, in case that gc wants to remove no-longer needed packs.

But this developer forgot that gc itself also needs to let go of packs,
e.g. when consolidating all packs via the --aggressive option.

Likewise, `git repack -d` wants to delete obsolete packs and therefore
needs to close all pack handles, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/gc.c     | 4 +++-
 builtin/repack.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 871a56f1c5..df90fd7f51 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -659,8 +659,10 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	report_garbage = report_pack_garbage;
 	reprepare_packed_git(the_repository);
-	if (pack_garbage.nr > 0)
+	if (pack_garbage.nr > 0) {
+		close_all_packs(the_repository->objects);
 		clean_pack_garbage();
+	}
 
 	if (gc_write_commit_graph)
 		write_commit_graph_reachable(get_object_directory(), 0,
diff --git a/builtin/repack.c b/builtin/repack.c
index 45583683ee..f9319defe4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -419,6 +419,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (!names.nr && !po_args.quiet)
 		printf("Nothing new to pack.\n");
 
+	close_all_packs(the_repository->objects);
+
 	/*
 	 * Ok we have prepared all new packfiles.
 	 * First see if there are packs of the same name and if so
-- 
gitgitgadget
