Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BB541F4B7
	for <e@80x24.org>; Sat, 24 Aug 2019 22:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfHXWKt (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 18:10:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42292 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbfHXWKs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 18:10:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so11776680wrq.9
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 15:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cs8KRpvTpzJm9vZ5IHyTbW87I/269ebb020JNe76mzA=;
        b=f/ybRwNlv4gxh8pkz3xERqeshdQNTzc48dxlx7UXuPBJ/npHfTM6HfyeEqsHi/suVD
         GujClNfUMpYixnFu06uzDYEXoH4zwveMpm/IMCWTs4QWpay249sypQeKWctlYFfbQ35G
         dgwTPrOY+84O098/bbxq0hCG/urK/+8p6gj15sNz25T65J/9/4rn5lKNhiCVqVC7Ahic
         UhgHya4bwI62SlpQA/n4KWN6G/brCiV1JgXM0GUrCFSzbN3VOOVZ0h3raXcIWDoJbz3H
         DaBM7JytX5Lluu9uSBwylysfpH7lWPNF6XBphx3/7LSN1L/3i8C+P95nAL9EkKvvN7mk
         VkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cs8KRpvTpzJm9vZ5IHyTbW87I/269ebb020JNe76mzA=;
        b=rzknJ+EsavxoTCf+8lhiPQlJv2yXXnKvPXSpH1OP3o1LT/p399W5VB/k0yHp+yDvs7
         gihwuAI1IkZa/BI/q+1usmehIeXeu0JRn9SOcooIu7aG8FqkoJ0c++snMWBn/yEK7y8s
         WAnhnQFGV7eDeEkb3LWxUe2ATBQ7PmMbC1rTMcPJOtF3eUyXS9nSv0iqQPuNN9XbZuOk
         vbeCq2xn2mqaxvMHSwNCGQ7SrMDeMKMi/pFFnD4gM1b2DoFDYrUppHVLK6Yfkvy8aFNq
         8VFfRCkXCUALIZVbSI7Ezk3kgPNIm+90ZaBBlM0LrZmFSu/DsQT2yWnoc63HORpwW6M2
         0xXg==
X-Gm-Message-State: APjAAAUV5oAZBJzGTBrW+EKQ2tRs+jrVjSD1DfngnoOlew6eAbQ+t+vE
        8Jz8ruZuumGQNPdfXOrg8j/w9NyC
X-Google-Smtp-Source: APXvYqxGzAKpA2f2jsCFfuocSyMx0lhA7xo4sT+JlShV5ie6lYlCb+dx355YQpdi6Att18EMQdFiYw==
X-Received: by 2002:adf:8364:: with SMTP id 91mr12952526wrd.13.1566684646638;
        Sat, 24 Aug 2019 15:10:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e13sm5754114wmh.44.2019.08.24.15.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 15:10:46 -0700 (PDT)
Date:   Sat, 24 Aug 2019 15:10:46 -0700 (PDT)
X-Google-Original-Date: Sat, 24 Aug 2019 22:10:43 GMT
Message-Id: <80b5535dc096a6ce0efac5aa4adf7a933fc22062.1566684643.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.141.git.gitgitgadget@gmail.com>
References: <pull.141.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] setup_git_directory(): handle UNC root paths correctly
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

When working in the root directory of a file share (this is only
possible in Git Bash and Powershell, but not in CMD), the current
directory is reported without a trailing slash.

This is different from Unix and standard Windows directories: both / and
C:\ are reported with a trailing slash as current directories.

If a Git worktree is located there, Git is not quite prepared for that:
while it does manage to find the .git directory/file, it returns as
length of the top-level directory's path *one more* than the length of
the current directory, and setup_git_directory_gently() would then
return an undefined string as prefix.

In practice, this undefined string usually points to NUL bytes, and does
not cause much harm. Under rare circumstances that are really involved
to reproduce (and not reliably so), the reported prefix could be a
suffix string of Git's exec path, though.

A careful analysis determined that this bug is unlikely to be
exploitable, therefore we mark this as a regular bug fix.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 3d24de15dd..c8c6bf3f49 100644
--- a/setup.c
+++ b/setup.c
@@ -784,7 +784,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 		set_git_dir(gitdir);
 	inside_git_dir = 0;
 	inside_work_tree = 1;
-	if (offset == cwd->len)
+	if (offset >= cwd->len)
 		return NULL;
 
 	/* Make "offset" point past the '/' (already the case for root dirs) */
-- 
gitgitgadget
