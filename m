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
	by dcvr.yhbt.net (Postfix) with ESMTP id 06BF11F461
	for <e@80x24.org>; Sat, 24 Aug 2019 22:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfHXWKt (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 18:10:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55515 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbfHXWKr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 18:10:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id f72so12015092wmf.5
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 15:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HnGSI0wllQLc9UBBCmuSWO2u8+DV7Duylo8NXHAbGpU=;
        b=hjwnyq4A+ZEJ8IVCrqmjs8V/eQ6QDAx58CplJPWIBd5Eh7Y052wbBv3lQhxSPbgvYK
         RbSjH7ttEhgrYKgtMcE5mdy2fcxEePW6wwDSYY6curt12YqxpSciq+QwOP3/jx0b2JL4
         gUtkY7B5Tix6MDH4eIy+AafbRDi+vQ92CPGd9wy9lZydB2bbGb4QPdVPb2eRqnujr4+S
         koy1Ul0nXit2ZsD+deGmMDN3ATQ9+guui8FwXTNzLUIz5osX0lc5E/ePLCbZFzGCXm0i
         uvrm+01v0GhyOFCEkvnuwkL9diXsIwX9JgXu6i1kSNMJjBrltSXO8QIAVXwt3dyn8KGN
         Bo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HnGSI0wllQLc9UBBCmuSWO2u8+DV7Duylo8NXHAbGpU=;
        b=qIZmR4OBnHlicuOPpGHQn2JzXxFqqLYr4Z3Pcy5yF/W+MOa2cBSN+cy9y1zvb8BSyI
         0jg6PbNr3Xge7LJ74aqSwJNQIKp8xR/vsV7YDYMInnmk6kATJ/SLlckTe2OaIFiIPrZe
         5RaBN7Gq90ys5ywl4kbabwTrZbfKqi8NRyjEoeEGhyKRuB8tTJNe//axseOSqC09YmVV
         JnqR0S/P3eHbiKu4gFNlrBVF8UsKd9jk8rZ1dgCM+Acurcp7tDD4ywK+6wTO3w1dnwji
         xKH3bVjM4lRwfe/OmNt8tarUpPWZ9MZ+12BLOlUqDJ00FFCJevZBZK565TSJ7I9qW/Ya
         1jgw==
X-Gm-Message-State: APjAAAUzUHQzZ233FxTd2t+h3sKc+G7nuL3JZFJy8SEUvbwIYVfTlcYh
        QohGxuKHXV1Vd+Mjky0CWH+6GmZc
X-Google-Smtp-Source: APXvYqwwJeHj1WhUtILzyPIDfRQTSlh7Mhounf2p5Vtfewv/nonVCoUhRyIiSeqYxptxX92zOq2ASw==
X-Received: by 2002:a1c:200a:: with SMTP id g10mr11848206wmg.160.1566684645932;
        Sat, 24 Aug 2019 15:10:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10sm13382144wrd.26.2019.08.24.15.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 15:10:45 -0700 (PDT)
Date:   Sat, 24 Aug 2019 15:10:45 -0700 (PDT)
X-Google-Original-Date: Sat, 24 Aug 2019 22:10:42 GMT
Message-Id: <e27a58d363c11c941a1e7b921dae8487a9d062df.1566684643.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.141.git.gitgitgadget@gmail.com>
References: <pull.141.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] Fix .git/ discovery at the root of UNC shares
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

A very common assumption in Git's source code base is that
offset_1st_component() returns either 0 for relative paths, or 1 for
absolute paths that start with a slash. In other words, the return value
is either 0 or points just after the dir separator.

This assumption is not fulfilled when calling offset_1st_component()
e.g. on UNC paths on Windows, e.g. "//my-server/my-share". In this case,
offset_1st_component() returns the length of the entire string (which is
correct, because stripping the last "component" would not result in a
valid directory), yet the return value still does not point just after a
dir separator.

This assumption is most prominently seen in the
setup_git_directory_gently_1() function, where we want to append a
".git" component and simply assume that there is already a dir
separator. In the UNC example given above, this assumption is incorrect.

As a consequence, Git will fail to handle a worktree at the top of a UNC
share correctly.

Let's fix this by adding a dir separator specifically for that case: we
found that there is no first component in the path and it does not end
in a dir separator? Then add it.

This fixes https://github.com/git-for-windows/git/issues/1320

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/setup.c b/setup.c
index a803b3ade3..3d24de15dd 100644
--- a/setup.c
+++ b/setup.c
@@ -934,6 +934,12 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 	if (ceil_offset < 0)
 		ceil_offset = min_offset - 2;
 
+	if (min_offset && min_offset == dir->len &&
+	    !is_dir_sep(dir->buf[min_offset - 1])) {
+		strbuf_addch(dir, '/');
+		min_offset++;
+	}
+
 	/*
 	 * Test in the following order (relative to the dir):
 	 * - .git (file containing "gitdir: <path>")
-- 
gitgitgadget

