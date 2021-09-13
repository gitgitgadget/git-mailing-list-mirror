Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CFAC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 21:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4AF60EE5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 21:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242427AbhIMVYc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 17:24:32 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:45015 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhIMVYb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 17:24:31 -0400
Received: from localhost.localdomain ([84.13.154.214])
        by smtp.talktalk.net with SMTP
        id PtPom5Wee2YhLPtPom0YzF; Mon, 13 Sep 2021 22:23:01 +0100
X-Originating-IP: [84.13.154.214]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZcxjyfdA c=1 sm=1 tr=0 a=nZAgPUNe/8GoCGAv1ndepQ==:117
 a=nZAgPUNe/8GoCGAv1ndepQ==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=pGLkceISAAAA:8
 a=1t1RqGfraEY5Ky9BNKcA:9 a=QEXdDO2ut3YA:10
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Philip Oakley <philipoakley@iee.email>
Subject: [PATCH] doc: config, tell readers of `git help --config`
Date:   Mon, 13 Sep 2021 22:23:05 +0100
Message-Id: <20210913212305.1832-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfD9jGnS3In2sP8aOVOkrNJtMRs8nMmR5lbBNJaOw7IQNg5NKLqoVkSfLo9ECvsHv3M4WyuaiNMY6mQa7Ct7sA6QmZiMFAMkB8fTQ5DtiEPOUQEaEabRU
 uG0h7wc41aI2WSyNMEoCDDY9Ee8DEMPAg/2xuH4j9FsuwVQ3159UfFIN4T6QyRRvA86OSysX671hb9VKyWxB4mm/HP0m5etjuFlm4oI+Uz4PgtZSVYCSzv2X
 mzitPmtzcschF80dEJakvg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git help` command gained the ability to list config variables in
3ac68a93fd (help: add --config to list all available config, 2018-05-26)
but failed to tell readers of the config documenation itself.

Provide that cross reference.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
I noticed this omission while reviewing Ævar Arnfjörð Bjarmason's
[PATCH v2 2/5] help: correct usage & behavior of "git help --guides"
<patch-v2-2.5-039639a0dd3-20210910T112545Z-avarab@gmail.com>.

My initial comment is in <2493437c-01c5-ddcc-6a61-666f87e70f20@iee.email>
and follow up, that is was out of scope to Ævar's series, in
<8c72d383-4ae2-b96c-6886-7c36153d8991@iee.email>.

This patch is independednt of the ab/help-config-vars series.
---
 Documentation/git-config.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 2dc4bae6da..992225f612 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -71,6 +71,9 @@ codes are:
 
 On success, the command returns the exit code 0.
 
+A list of all available configuration variables can be obtained using the
+`git help --config` command.
+
 [[OPTIONS]]
 OPTIONS
 -------
-- 
2.33.0.windows.2

