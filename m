Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64EDC48BDF
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 02:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57DA6120D
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 02:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbhFSCni (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 22:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhFSCnh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 22:43:37 -0400
X-Greylist: delayed 447 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Jun 2021 19:41:27 PDT
Received: from mail.smlavine.com (unknown [IPv6:2001:19f0:5:202c:5400:3ff:fe12:53e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3342AC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 19:41:27 -0700 (PDT)
Received: from archlinux-white.fios-router.home (pool-74-110-57-72.bflony.fios.verizon.net [74.110.57.72])
        by mail.smlavine.com (Postfix) with ESMTPSA id 0868D84418;
        Sat, 19 Jun 2021 02:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=smlavine.com; s=mail;
        t=1624070037; bh=a3eGXkSDzB5MLDtyj3P/5HtYFn81d36hcNnIeXtjNsE=;
        h=From:To:Cc:Subject:Date:From;
        b=bkHyRLINll2dze0Vhfu23cet9dTrlF2Lfa8dlpwGUpl1GpBDX88l3UkY0nViiVpdR
         QdlPBOZvFmyMjHk0TjFtB6oXDbP1+rjnTQYsNoDYMrKwvxQs9MWcRn0leu/7+Clnyz
         vYD/vppB/p/4isHY6Gzgg1yulujLG6DLh1HdwcJS2B4JOm4Cg8I+xNVNpg7z0yIyHA
         6SPI2QiY5836p7LtKFep44xNowVluEGNmdpAXaDP6Oq27RZYQfBPx7rk2g0A49cYxY
         jUxQAkNkSrE6xgJ+A3aQBpL14EoydhdugrDSuMOLpLLP8u7+aqXI27S5FuOXCq3bXi
         +muI+rKGP0pFQ==
From:   Sebastian LaVine <mail@smlavine.com>
To:     git@vger.kernel.org
Cc:     emilyshaffer@google.com, Sebastian LaVine <mail@smlavine.com>
Subject: [PATCH] myfirstcontrib: update links to IRC channels
Date:   Fri, 18 Jun 2021 22:33:11 -0400
Message-Id: <20210619023310.1342809-1-mail@smlavine.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Git project now uses Libera Chat, not Freenode. A similar change was
made in git-scm.com commit b1f3d65 (community: update links to IRC
server, 2021-05-26).

Signed-off-by: Sebastian LaVine <mail@smlavine.com>
---
 Documentation/MyFirstContribution.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index af0a9da62e..015cf24631 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -47,7 +47,7 @@ Veteran contributors who are especially interested in helping mentor newcomers
 are present on the list. In order to avoid search indexers, group membership is
 required to view messages; anyone can join and no approval is required.
 
-==== https://webchat.freenode.net/#git-devel[#git-devel] on Freenode
+==== https://web.libera.chat/#git-devel[#git-devel] on Libera Chat
 
 This IRC channel is for conversations between Git contributors. If someone is
 currently online and knows the answer to your question, you can receive help
@@ -827,7 +827,7 @@ either examining recent pull requests where someone has been granted `/allow`
 (https://github.com/gitgitgadget/git/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+%22%2Fallow%22[Search:
 is:pr is:open "/allow"]), in which case both the author and the person who
 granted the `/allow` can now `/allow` you, or by inquiring on the
-https://webchat.freenode.net/#git-devel[#git-devel] IRC channel on Freenode
+https://web.libera.chat/#git-devel[#git-devel] IRC channel on Libera Chat
 linking your pull request and asking for someone to `/allow` you.
 
 If the CI fails, you can update your changes with `git rebase -i` and push your
-- 
2.32.0

