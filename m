Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D0FB20248
	for <e@80x24.org>; Mon, 25 Mar 2019 21:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfCYVlk (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 17:41:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44976 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbfCYVlj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 17:41:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id x10so8888302edh.11
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rkEvoXJrrwfqkqoOTp3FBKfzo5rvyl3eaBIGbualSHk=;
        b=TOmcy1ARODePmhQwivKapuC7uY3BFy8kuueGTRRxdbJYlSDG3iYPV1bKNePdLpqEXh
         vdhquGaAvjiXWXccMHFHRVENS8DMjk68hg+yGMHN0nm96eF4sp/Ugq9HcP1Vv/5IDJvy
         XwMOCHl6TLk2EweCW1oW6luStdTOA9eTET16PfnQnPu8QVZbNpjGQqV+Duhkz4dOBpN7
         UCb2Vbz8YzEluVS3dnfzqSkRIlnqByhFfn5BsetLAVqaWj9pOgobi+J0KXzH+bso/DRz
         4Mhr4SfSBU3fJ548sUUhyQPtx9KZjSq7uiP9r5Pp6/lgZER3Sp1xFixa8ex+hSbLoKYC
         TwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rkEvoXJrrwfqkqoOTp3FBKfzo5rvyl3eaBIGbualSHk=;
        b=GgWrZNhCuo+BWEzqnx3pKbzYhNlY/0hpcOYIfbPWWIfVIrhujGPzdRNn0JLwrRhyMW
         5tQK+QpnUgc+gvklbIxnKNccWQ6R+bHDm1QugETqZOoMuvxKP5SVySpDNOmNg2XxGvYu
         ctYv7S54DmmI6T2RMtkKk499gOlKZAXr2jbLZ9OGTbLEBD4GTekFArA0T24ILQfdKvub
         /HO+5t3cwCGibUlbclFXy1S0GMkf6ETUbXI5n0JZuIXdfJVcvzYJw5RLNPLdeR2Hbusi
         mbQdyRv7awL2tfFmw16K95wvQ5MVacTfrV59SFkQfvAJFTY8Robi9fQEpXZXBvF9w5jM
         E+rQ==
X-Gm-Message-State: APjAAAWKGfwtwyi128ma4PLWnBbvjLnGFHt3CxFO1udAobTcpNbG0ofD
        /adT7P0mgzOWyEtlHvzD3KkD57rk
X-Google-Smtp-Source: APXvYqyaGpUfYKrXFarV+XMggq/Tv0f7qfdC0l7ZkAGaDn6B75C/ffYYm9R69C33lf4IMXD3qdggSg==
X-Received: by 2002:a50:9154:: with SMTP id f20mr17330355eda.68.1553550096774;
        Mon, 25 Mar 2019 14:41:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g27sm5963336edg.77.2019.03.25.14.41.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:41:36 -0700 (PDT)
Date:   Mon, 25 Mar 2019 14:41:36 -0700 (PDT)
X-Google-Original-Date: Mon, 25 Mar 2019 21:41:30 GMT
Message-Id: <0ad38649c0f30c980074a817bdfeab18ff5648c7.1553550094.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.162.v2.git.gitgitgadget@gmail.com>
References: <pull.162.git.gitgitgadget@gmail.com>
        <pull.162.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/5] docs: move gitremote-helpers into section 7
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is currently in section 1, but that section is intended for
"Executable programs or shell commands".

A more appropriate place is section 7: "Miscellaneous (including macro
packages and conventions), e.g. man(7), groff(7)".

This issue should have been detected earlier by `make check-docs`, but
was missed due to a bug in that Makefile target (that we are about to
fix).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/Makefile                | 2 +-
 Documentation/git-remote-ext.txt      | 2 +-
 Documentation/git-remote-fd.txt       | 2 +-
 Documentation/git-remote-helpers.txto | 2 +-
 Documentation/git-remote-testgit.txt  | 2 +-
 Documentation/gitremote-helpers.txt   | 2 +-
 Documentation/urls.txt                | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 26a2342bea..af0e2cf11a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -12,7 +12,6 @@ MAN1_TXT += $(filter-out \
 		$(wildcard git-*.txt))
 MAN1_TXT += git.txt
 MAN1_TXT += gitk.txt
-MAN1_TXT += gitremote-helpers.txt
 MAN1_TXT += gitweb.txt
 
 MAN5_TXT += gitattributes.txt
@@ -30,6 +29,7 @@ MAN7_TXT += gitdiffcore.txt
 MAN7_TXT += giteveryday.txt
 MAN7_TXT += gitglossary.txt
 MAN7_TXT += gitnamespaces.txt
+MAN7_TXT += gitremote-helpers.txt
 MAN7_TXT += gitrevisions.txt
 MAN7_TXT += gitsubmodules.txt
 MAN7_TXT += gittutorial-2.txt
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index 3fc5d94336..790e2ca3fe 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -118,7 +118,7 @@ begins with `ext::`.  Examples:
 
 SEE ALSO
 --------
-linkgit:gitremote-helpers[1]
+linkgit:gitremote-helpers[7]
 
 GIT
 ---
diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
index 80afca866c..0451ceb8a2 100644
--- a/Documentation/git-remote-fd.txt
+++ b/Documentation/git-remote-fd.txt
@@ -52,7 +52,7 @@ EXAMPLES
 
 SEE ALSO
 --------
-linkgit:gitremote-helpers[1]
+linkgit:gitremote-helpers[7]
 
 GIT
 ---
diff --git a/Documentation/git-remote-helpers.txto b/Documentation/git-remote-helpers.txto
index 49233f5d26..6f353ebfd3 100644
--- a/Documentation/git-remote-helpers.txto
+++ b/Documentation/git-remote-helpers.txto
@@ -1,7 +1,7 @@
 git-remote-helpers
 ==================
 
-This document has been moved to linkgit:gitremote-helpers[1].
+This document has been moved to linkgit:gitremote-helpers[7].
 
 Please let the owners of the referring site know so that they can update the
 link you clicked to get here.
diff --git a/Documentation/git-remote-testgit.txt b/Documentation/git-remote-testgit.txt
index f791d73c05..b45bfebba5 100644
--- a/Documentation/git-remote-testgit.txt
+++ b/Documentation/git-remote-testgit.txt
@@ -23,7 +23,7 @@ The best way to learn more is to read the comments and source code in
 
 SEE ALSO
 --------
-linkgit:gitremote-helpers[1]
+linkgit:gitremote-helpers[7]
 
 GIT
 ---
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 9d1459aac6..34a3e60d08 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -1,4 +1,4 @@
-gitremote-helpers(1)
+gitremote-helpers(7)
 ====================
 
 NAME
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index b05da95788..bc354fe2dc 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -62,7 +62,7 @@ may be used:
 
 where <address> may be a path, a server and path, or an arbitrary
 URL-like string recognized by the specific remote helper being
-invoked. See linkgit:gitremote-helpers[1] for details.
+invoked. See linkgit:gitremote-helpers[7] for details.
 
 If there are a large number of similarly-named remote repositories and
 you want to use a different format for them (such that the URLs you
-- 
gitgitgadget

