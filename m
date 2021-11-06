Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE01C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2116A611EE
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhKFSwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 14:52:31 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:1078 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234847AbhKFSw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 14:52:29 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 8340A19F5A3;
        Sat,  6 Nov 2021 19:49:44 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/10] doc: use three dots for indicating repetition instead of star
Date:   Sat,  6 Nov 2021 19:48:54 +0100
Message-Id: <20211106184858.11500-7-jn.avila@free.fr>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211106184858.11500-1-jn.avila@free.fr>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
 <20211106184858.11500-1-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is how it is specified in CodingGuidelines.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-fsck.txt        | 2 +-
 Documentation/git-merge-index.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index bd596619c0..5088783dcc 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
 	 [--[no-]full] [--strict] [--verbose] [--lost-found]
 	 [--[no-]dangling] [--[no-]progress] [--connectivity-only]
-	 [--[no-]name-objects] [<object>*]
+	 [--[no-]name-objects] [<object>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 2ab84a91e5..eea56b3154 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -9,7 +9,7 @@ git-merge-index - Run a merge for files needing merging
 SYNOPSIS
 --------
 [verse]
-'git merge-index' [-o] [-q] <merge-program> (-a | [--] <file>*)
+'git merge-index' [-o] [-q] <merge-program> (-a | ( [--] <file>...) )
 
 DESCRIPTION
 -----------
-- 
2.33.1

