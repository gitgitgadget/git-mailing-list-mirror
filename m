Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7573C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5974611C0
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhKFSwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 14:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbhKFSwN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 14:52:13 -0400
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969A5C061205
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 11:49:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 1EF0919F4F3;
        Sat,  6 Nov 2021 19:49:27 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/10] doc: fix git credential synopsis
Date:   Sat,  6 Nov 2021 19:48:49 +0100
Message-Id: <20211106184858.11500-2-jn.avila@free.fr>
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

The subcommand of git credential is not optional.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-credential.txt | 2 +-
 builtin/credential.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 206e3c5f40..f18673017f 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -8,7 +8,7 @@ git-credential - Retrieve and store user credentials
 SYNOPSIS
 --------
 ------------------
-git credential <fill|approve|reject>
+'git credential' (fill|approve|reject)
 ------------------
 
 DESCRIPTION
diff --git a/builtin/credential.c b/builtin/credential.c
index d75dcdc64a..d7b304fa08 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -4,7 +4,7 @@
 #include "config.h"
 
 static const char usage_msg[] =
-	"git credential [fill|approve|reject]";
+	"git credential (fill|approve|reject)";
 
 int cmd_credential(int argc, const char **argv, const char *prefix)
 {
-- 
2.33.1

