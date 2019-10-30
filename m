Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C2AB1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 20:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfJ3UgI (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 16:36:08 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:57673 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfJ3UgI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 16:36:08 -0400
X-Originating-IP: 1.186.12.42
Received: from localhost.localdomain (unknown [1.186.12.42])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 5D733FF804
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 20:36:06 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Subject: [PATCH] git-shortlog.txt: mention commit filtering options
Date:   Thu, 31 Oct 2019 02:06:03 +0530
Message-Id: <20191030203603.27497-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-shortlog, like git-log, supports options to filter what commits are
used to generate the log. These options come from git-rev-list. Add a
pointer to these options in the documentation page so readers can know
these filtering options can be used with git-shortlog too.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
Since [0] didn't get any responses, I figured a patch might get some
more attention since it is something concrete to comment on.

[0] https://public-inbox.org/git/20191024191709.gqkjljuibyashtma@yadavpratyush.com/

 Documentation/git-shortlog.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index bc80905a8a..acae695388 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -76,6 +76,11 @@ them.
 Paths may need to be prefixed with `--` to separate them from
 options or the revision range, when confusion arises.

+In addition to the options above, 'git shortlog' also supports a range of
+options to select which subset of commits will be used to generate the
+shortlog. A list of these options can be found in the "Commit Limiting"
+section of linkgit:git-rev-list[1].
+
 MAPPING AUTHORS
 ---------------

--
2.21.0

