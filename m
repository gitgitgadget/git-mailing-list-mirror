Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0040E20248
	for <e@80x24.org>; Thu, 14 Mar 2019 13:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfCNN65 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 09:58:57 -0400
Received: from nautica.notk.org ([91.121.71.147]:50562 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbfCNN65 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 09:58:57 -0400
Received: from [192.168.0.31] (lns-bzn-36-82-251-17-131.adsl.proxad.net [82.251.17.131])
        by nautica.notk.org (Postfix) with ESMTPSA id AA990C009
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 14:58:55 +0100 (CET)
To:     git@vger.kernel.org
From:   Christophe Coevoet <stof@notk.org>
Subject: [PATCH] Add the completion for the --color-moved option
Message-ID: <3d2892e5-1bc5-b40c-b4c8-1b5d7a972e2d@notk.org>
Date:   Thu, 14 Mar 2019 14:58:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Christophe Coevoet <stof@notk.org>
---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 499e56f83d..715f388721 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1432,7 +1432,8 @@ __git_diff_submodule_formats="diff log short"
 
 __git_diff_common_options="--stat --numstat --shortstat --summary
 			--patch-with-stat --name-only --name-status --color
-			--no-color --color-words --no-renames --check
+			--no-color --color-words --color-moved
+			--no-renames --check
 			--full-index --binary --abbrev --diff-filter=
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
-- 
2.21.0

