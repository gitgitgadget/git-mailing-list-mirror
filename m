Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93706C636D4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 02:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjBDC1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 21:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBDC1o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 21:27:44 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6CA4955A
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 18:27:42 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso7231471wms.5
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 18:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jKAv4XjZ+TpyuVx5ULaYUW4PGzq1fLR+GvQr4QSZU7w=;
        b=XINTaHGOLmnXEZJcYj60sjyurJGwNc1iqhCRDHhfw1bi8kwXbSxGVwfIwR3Z002OgC
         7Oj65GhwQ6AIX0YOYFPkNZ3f3SenQYjYdycT/xih7Zm5B8rab406gQC0SnWsRIpzUYci
         1DmGbhGuR9QxxrcP1eGuvSHATYOG+FeJu0NbwBwm2Dm9zJt9CB4eegMVeOzw4lclu/xA
         u/AyYhfoFjZdzKtJ/8ja21tN/iR1cn9GfD7NZrUoXUh2VK1rPFFlT07UgYocTB4GVz2b
         ND25DIvB7+hDFuyIYWLLadsqllj3prEXK0mmEB1nIjMZp4qWhp2DYVRH7ER338WDABZ0
         lNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKAv4XjZ+TpyuVx5ULaYUW4PGzq1fLR+GvQr4QSZU7w=;
        b=qGSFLkIjUk7IVQ9YcTrpRe1Wg2TDV2w/KnkgKkwqKfeHWxCx5LHfqbzYoese6vJi0b
         mPwxcF20pkQ/aQxX15bZs5dD6CXkmwW60vY7HoaQW2QrstYlzdiDI8kZ9pt86cvQwcPO
         BreTLk6laAVu+RNdmyogKDStrXzLNJzZrAtTf5R0lhJCGgWokDfbjzHzsyBZWL58cKmh
         wpb9KqKMzMMxcwr9dFP/+3jVkKpZ6PQC8LcPARMZb3Rhcd+qW3b9LuF9G0n3mSEEbZkc
         L1xSpSZzEFKlgcqqeFfONLucUyeSSK8mi8biQHnJSZq7YBAZROyVIPXXWMczdn97m9Qp
         k00g==
X-Gm-Message-State: AO0yUKXPrcVKqYmh9Zi54ZkM5+cFaUihPm65xfgVSWthQcpQiNobyEbH
        tDnJlT1TRtRhV5uaMRvIOQ37h/EyhKw=
X-Google-Smtp-Source: AK7set933PSP8h4+CGq1jE45AmGuo40d122zAvOdzCPgKPVgFIv8oJsDiuHfN4JdI6M/e/XfzTmMAw==
X-Received: by 2002:a05:600c:1d28:b0:3df:efdc:6505 with SMTP id l40-20020a05600c1d2800b003dfefdc6505mr808153wms.0.1675477661053;
        Fri, 03 Feb 2023 18:27:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c358200b003dc4ecfc4d7sm4553495wmq.29.2023.02.03.18.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 18:27:40 -0800 (PST)
Message-Id: <pull.1451.git.git.1675477659972.gitgitgadget@gmail.com>
From:   "Wes Lord via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Feb 2023 02:27:39 +0000
Subject: [PATCH] new-command.txt: update reference to builtin docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Wes Lord <weslord@gmail.com>, Wes Lord <weslord@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Wes Lord <weslord@gmail.com>

Commit ec14d4ecb5 (builtin.h: take over documentation from
api-builtin.txt, 2017-08-02) deleted api-builtin.txt and moved the
contents into builtin.h, but new-command.txt still references the old
file.

Signed-off-by: Wes Lord <weslord@gmail.com>
---
    new-command.txt: update reference to builtin docs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1451%2Fweslord%2Fdoc-builtin-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1451/weslord/doc-builtin-v1
Pull-Request: https://github.com/git/git/pull/1451

 Documentation/howto/new-command.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/howto/new-command.txt b/Documentation/howto/new-command.txt
index 15a4c8031f1..880c51112ba 100644
--- a/Documentation/howto/new-command.txt
+++ b/Documentation/howto/new-command.txt
@@ -1,13 +1,13 @@
 From: Eric S. Raymond <esr@thyrsus.com>
 Abstract: This is how-to documentation for people who want to add extension
- commands to Git.  It should be read alongside api-builtin.txt.
+ commands to Git.  It should be read alongside builtin.h.
 Content-type: text/asciidoc
 
 How to integrate new subcommands
 ================================
 
 This is how-to documentation for people who want to add extension
-commands to Git.  It should be read alongside api-builtin.txt.
+commands to Git.  It should be read alongside builtin.h.
 
 Runtime environment
 -------------------

base-commit: 2fc9e9ca3c7505bc60069f11e7ef09b1aeeee473
-- 
gitgitgadget
