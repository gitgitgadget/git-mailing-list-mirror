Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CF821F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 18:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJJBtv (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 21:49:51 -0400
Received: from mail.weplayciv.com ([162.221.200.53]:60530 "EHLO
        mail.weplayciv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeJJBtv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 21:49:51 -0400
Received: from localhost.localdomain (c-3985e555.02-149-6c6b7013.bbcust.telenor.se [85.229.133.57])
        by mail.weplayciv.com (Postfix) with ESMTPSA id 0C22194E081;
        Tue,  9 Oct 2018 11:31:32 -0700 (PDT)
From:   Daniels Umanovskis <daniels@umanovskis.se>
To:     git@vger.kernel.org
Cc:     Daniels Umanovskis <daniels@umanovskis.se>
Subject: [PATCH 2/2] doc/git-branch: Document the --current option
Date:   Tue,  9 Oct 2018 20:31:14 +0200
Message-Id: <20181009183114.16477-2-daniels@umanovskis.se>
X-Mailer: git-send-email 2.19.1.274.g059d67db4.dirty
In-Reply-To: <20181009183114.16477-1-daniels@umanovskis.se>
References: <20181009183114.16477-1-daniels@umanovskis.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Daniels Umanovskis <daniels@umanovskis.se>
---
 Documentation/git-branch.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index bf5316ffa..a7167df74 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git branch' [--color[=<when>] | --no-color] [-r | -a]
-	[--list] [-v [--abbrev=<length> | --no-abbrev]]
+	[--list] [--current] [-v [--abbrev=<length> | --no-abbrev]]
 	[--column[=<options>] | --no-column] [--sort=<key>]
 	[(--merged | --no-merged) [<commit>]]
 	[--contains [<commit]] [--no-contains [<commit>]]
@@ -160,6 +160,10 @@ This option is only applicable in non-verbose mode.
 	branch --list 'maint-*'`, list only the branches that match
 	the pattern(s).
 
+--current::
+	Print the name of the current branch. In detached HEAD state,
+	or if otherwise impossible to resolve the branch name, print
+	"HEAD".
 -v::
 -vv::
 --verbose::
-- 
2.19.1.274.g059d67db4.dirty

