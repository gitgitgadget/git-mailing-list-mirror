Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CA9EE021E
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 03:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbjINDZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 23:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbjINDZK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 23:25:10 -0400
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C794F1BDD
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 20:25:06 -0700 (PDT)
From:   Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1694661904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YU+IKeC9fXu3OHg2k/5SWAN+m0pv66xYqczvotMLbIg=;
        b=jv/UF2DS3M/PADdTTncSOmF7hyEGdaR1zw1P9EJI6pTZ3VKRqKdqk4Br6fE6KBXRdS7d6Z
        aNQ3bh5jzXIWjuHKJEYqwJE9uRWd+Zg0CFzkowJPkM5Isyn0bBimHMyFzsW0VP4gb9AAjY
        s9gv1iO/6Ig6cEe77YDvlYaBAaQ0vl6Fqw8R6Tk3Bj85Raf5dZuLnIxjAsofXkVdqPy3jk
        p3/zNVM33Kb9Ca4H+VFVN8rcxKghC8qBNFhFagiu/D9S6mLJqHoCIu6LirW4MO0X1ApX8O
        2i9G9Bv/ZCM+pG290UHTGnKGYmrtUV/yWoz9wvvNGGRUvw6ECyI544bZb3Nzxw==
To:     git@vger.kernel.org
Subject: [PATCH] doc: pull: improve rebase=false documentation
Date:   Thu, 14 Sep 2023 05:25:02 +0200
Message-Id: <226cc3ed753ee809a77ac7bfe958add7a4363390.1694661788.git.dsimic@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mention in the documentation that --rebase defaults to false.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 Documentation/git-pull.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 0e14f8b5b2..d28790388e 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -116,7 +116,8 @@ When set to `merges`, rebase using `git rebase --rebase-merges` so that
 the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
 +
-When false, merge the upstream branch into the current branch.
+When false, merge the upstream branch into the current branch. This is
+the default.
 +
 When `interactive`, enable the interactive mode of rebase.
 +
