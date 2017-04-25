Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D79C207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 11:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947063AbdDYLiq (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 07:38:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:36290 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1946952AbdDYLio (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 07:38:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0FAFAAC2E
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 11:38:43 +0000 (UTC)
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] Add --indent-heuristic to bash completion.
Message-ID: <bbcbdf11-5065-8fcb-d78e-74db03814781@suse.cz>
Date:   Tue, 25 Apr 2017 13:37:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------5BA49415AE751679784E55AA"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------5BA49415AE751679784E55AA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello.

The patch adds BASH completion for a newly added option.

Thanks,
Martin

--------------5BA49415AE751679784E55AA
Content-Type: text/x-patch;
 name="0001-Add-indent-heuristic-to-bash-completion.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Add-indent-heuristic-to-bash-completion.patch"

From 316355276a9772cdfdd24a81f19400f176944df2 Mon Sep 17 00:00:00 2001
From: marxin <mliska@suse.cz>
Date: Tue, 25 Apr 2017 13:35:17 +0200
Subject: [PATCH] Add --indent-heuristic to bash completion.

Signed-off-by: Martin Liska <mliska@suse.cz>
---
 contrib/completion/git-completion.bash | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1150164d5..8fb25594c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1395,7 +1395,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--quiet --ext-diff --no-ext-diff
 			--no-prefix --src-prefix= --dst-prefix=
 			--inter-hunk-context=
-			--patience --histogram --minimal
+			--patience --histogram --indent-heuristic --minimal
 			--raw --word-diff --word-diff-regex=
 			--dirstat --dirstat= --dirstat-by-file
 			--dirstat-by-file= --cumulative
@@ -1482,6 +1482,7 @@ __git_format_patch_options="
 	--not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
 	--inline --suffix= --ignore-if-in-upstream --subject-prefix=
 	--output-directory --reroll-count --to= --quiet --notes
+	--indent-heuristic
 "
 
 _git_format_patch ()
@@ -1681,6 +1682,7 @@ __git_log_common_options="
 	--min-age= --until= --before=
 	--min-parents= --max-parents=
 	--no-min-parents --no-max-parents
+	--indent-heuristic
 "
 # Options that go well for log and gitk (not shortlog)
 __git_log_gitk_options="
-- 
2.12.2


--------------5BA49415AE751679784E55AA--
