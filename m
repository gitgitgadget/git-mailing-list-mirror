Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C91D31F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 08:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfAQI3Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 03:29:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41495 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfAQI3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 03:29:24 -0500
Received: by mail-ed1-f68.google.com with SMTP id a20so7624501edc.8
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 00:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YwgdwZqZCI1u71MUdNgzKZRcFxxsJcH+JyYijITZfks=;
        b=ee3l0MNEO3ZjdFCJqDJOFrN1+ymDeqrmSoirDwNCLZZr+9+uexSEe72h+X3AqyaeGQ
         OBuBkXvvS7sl/wojejaHUKtF0S+Q6U3xxAh2OdlokZ92/dLWzHYISq2PKeE6nAhzOzfC
         SsscdTvwRrfAZH9uXm2HyQDWnZfpWyKrSo8MPNQlFFy+9nJ1ijIe3T6Qh647LJYbyoF5
         p/0b8qq+f+1y/lehYTq+E8ujP7MjAWEtK4jUqoUcuhOjghemTTiprfd2vG4zelI1GbcM
         yrq+valCpcHZRj44/zN5jh45rFw0HBi4ONRca1DPoROU5c+RrLBgrwYTXigTrFf4GETA
         iJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YwgdwZqZCI1u71MUdNgzKZRcFxxsJcH+JyYijITZfks=;
        b=jpYz92m1agZaO7ahMGSfkD3vXp7DbuLT6TR9s9NIVBM69M4Ku5dWJDtfXtebaqtgC7
         ckpvhsE0gjJRysNFEr4Gsc/5uSpA1WT9hOD97cXntnsUhAsq6RCB7aOHN15K7hePn6M2
         WTJHJgpG6ihafMtrtipkIfou9S1aGUhQHUvls7rPXFf32pfAXm7Gwm4D/D0EpwtDxTp/
         6MtogY4721LM2qwOcTWiXERZTYsCpX7+Bu4y2ECqIpMdWs2hbl9ozCnYD+AomwrpRKoU
         Z3+LU3NkQr4XP8+MZtDYcAqN+qjJ4Rr8i4EowWAh34FtkqJiJ9L1hgK30zdHahnMZJvK
         0U7A==
X-Gm-Message-State: AJcUukcAM3eKC3BVHM3brDaLZL9phnbl++JcvlaVJavgXBNAN4S1ZEKv
        9g574yaW+Ip7x8BQpZ+bzCHRzboR
X-Google-Smtp-Source: ALg8bN40wHRFnHt8Fv5ex9jLaDgJAS8zli0hkogDzEH5QzrMKSCtxDOsm9X+GD7oDT4FMcHBNtP1UQ==
X-Received: by 2002:aa7:c594:: with SMTP id g20mr10255272edq.79.1547713762215;
        Thu, 17 Jan 2019 00:29:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k32sm6258792edb.42.2019.01.17.00.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 00:29:21 -0800 (PST)
Date:   Thu, 17 Jan 2019 00:29:21 -0800 (PST)
X-Google-Original-Date: Thu, 17 Jan 2019 08:29:19 GMT
Message-Id: <55b0a641d4cd3af37806300e10be36925716e86b.1547713759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.109.v2.git.gitgitgadget@gmail.com>
References: <pull.109.git.gitgitgadget@gmail.com>
        <pull.109.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] t6042: work around speed optimization on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When Git determines whether a file has changed, it looks at the mtime,
at the file size, and to detect changes even if the mtime is the same
(on Windows, the mtime granularity is 100ns, read: if two files are
written within the same 100ns time slot, they have the same mtime) and
even if the file size is the same, Git also looks at the inode/device
numbers.

This design obviously comes from a Linux background, where `lstat()`
calls were designed to be cheap.

On Windows, there is no `lstat()`. It has to be emulated. And while
obtaining the mtime and the file size is not all that expensive (you can
get both with a single `GetFileAttributesW()` call), obtaining the
equivalent of the inode and device numbers is very expensive (it
requires a call to `GetFileInformationByHandle()`, which in turn
requires a file handle, which is *a lot* more expensive than one might
imagine).

As it is very uncommon for developers to modify files within 100ns time
slots, Git for Windows chooses not to fill inode/device numbers
properly, but simply sets them to 0.

However, in t6042 the files file_v1 and file_v2 are typically written
within the same 100ns time slot, and they do not differ in file size. So
the minor modification is not picked up.

Let's work around this issue by avoiding the `git mv` calls in the
'mod6-setup: chains of rename/rename(1to2) and rename/rename(2to1)' test
case. The target files are overwritten anyway, so it is not like we
really rename those files. This fixes the issue because `git add` will
now add the files as new files (as opposed to existing, just renamed
files).

Functionally, we do not change anything because we replace two `git mv
<old> <new>` calls (where `<new>` is completely overwritten and `git
add`ed later anyway) by `git rm <old>` calls (removing other files, too,
that are also completely overwritten and `git add`ed later).

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6042-merge-rename-corner-cases.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 7cc34e7579..09dfa8bd92 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -1175,7 +1175,7 @@ test_expect_success 'setup nested conflicts from rename/rename(2to1)' '
 
 		# Handle the left side
 		git checkout L &&
-		git mv one three &&
+		git rm one two &&
 		mv -f file_v2 three &&
 		mv -f file_v5 two &&
 		git add two three &&
@@ -1183,7 +1183,7 @@ test_expect_success 'setup nested conflicts from rename/rename(2to1)' '
 
 		# Handle the right side
 		git checkout R &&
-		git mv two three &&
+		git rm one two &&
 		mv -f file_v3 one &&
 		mv -f file_v6 three &&
 		git add one three &&
-- 
gitgitgadget
