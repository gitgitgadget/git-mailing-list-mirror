Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8519E1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 16:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935520AbdACQGd (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 11:06:33 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:47960 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935425AbdACQG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 11:06:29 -0500
Received: from [217.91.110.92] (helo=localhost.localdomain)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:AES128-SHA256:128)
        (Exim 4.84)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1cORQT-0002Go-3n; Tue, 03 Jan 2017 16:55:01 +0100
From:   Marc Strapetz <marc.strapetz@syntevo.com>
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>
Subject: [PATCH 1/2] stash: fix USAGE text
Date:   Tue,  3 Jan 2017 07:53:55 -0800
Message-Id: <20170103155356.11213-1-marc.strapetz@syntevo.com>
X-Mailer: git-send-email 2.11.0
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing usage description for stash subcommands
'create' and 'store'.

Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
 git-stash.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 10c284d1a..c6b9db694 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -9,7 +9,9 @@ USAGE="list [<options>]
    or: $dashless branch <branchname> [<stash>]
    or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
 		       [-u|--include-untracked] [-a|--all] [<message>]]
-   or: $dashless clear"
+   or: $dashless clear
+   or: $dashless create [<message>]
+   or: $dashless store [-m|--message <message>] [-q|--quiet] <commit>"
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
-- 
2.11.0

