Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6230C433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA93611C0
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhKFSwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 14:52:30 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:64816 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234853AbhKFSw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 14:52:26 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 488CF19F59D;
        Sat,  6 Nov 2021 19:49:41 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/10] doc: git-ls-files: express options as optional alternatives
Date:   Sat,  6 Nov 2021 19:48:53 +0100
Message-Id: <20211106184858.11500-6-jn.avila@free.fr>
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

That's how alternative options are expressed in general.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-ls-files.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 6d11ab506b..2e3d695fa2 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -10,9 +10,9 @@ SYNOPSIS
 --------
 [verse]
 'git ls-files' [-z] [-t] [-v] [-f]
-		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
-		(-[c|d|o|i|s|u|k|m])*
-		[--eol]
+		[-c|--cached] [-d|--deleted] [-o|--others] [-i|--|ignored]
+		[-s|--stage] [-u|--unmerged] [-k|--|killed] [-m|--modified]
+		[--directory [--no-empty-directory]] [--eol]
 		[--deduplicate]
 		[-x <pattern>|--exclude=<pattern>]
 		[-X <file>|--exclude-from=<file>]
-- 
2.33.1

