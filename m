Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0E0C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B62FF2075F
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgEYV6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 17:58:02 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:5452 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgEYV6B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 17:58:01 -0400
Received: from localhost.localdomain ([89.243.191.101])
        by smtp.talktalk.net with SMTP
        id dL6djC8oOIndsdL6djhPZm; Mon, 25 May 2020 22:58:00 +0100
X-Originating-IP: [89.243.191.101]
X-Spam: 0
X-OAuthority: v=2.3 cv=QYIYQfTv c=1 sm=1 tr=0 a=5KGm1Kp77X3djDixdaHiLg==:117
 a=5KGm1Kp77X3djDixdaHiLg==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=8Dr0WGqUcui4J2EvmecA:9
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
From:   Philip Oakley <philipoakley@iee.email>
To:     git@vger.kernel.org
Subject: [PATCH 1/4] doc: blame: show the boundary commit '^' caret mark
Date:   Mon, 25 May 2020 22:57:48 +0100
Message-Id: <20200525215751.1735-2-philipoakley@iee.email>
X-Mailer: git-send-email 2.26.2.windows.1.13.g9dddff6983
In-Reply-To: <20200525215751.1735-1-philipoakley@iee.email>
References: <20200525215751.1735-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIegZ2fgzUsizcTil/8DQ9rxdXgn30ulXqPed8sdVaX5AGlnLCLsAxoyfzuPPPTlx0QnZ+VfjWe06qkWsio26m2cwdRq1DFDY9hya0+lP8KkZP5uZlJY
 cYpzWw5KCkMFrT+6RxZhFdYX3Cv3+fQj0KgwR48YoedDizgTnUZhy6rbrMeqAJhVR6vKAdQDCEb9EA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the boundary commits' ^ caret findable in the documentation.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/git-blame.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 7e81541996..02f9ad6fe9 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -87,8 +87,8 @@ include::blame-options.txt[]
 
 --abbrev=<n>::
 	Instead of using the default 7+1 hexadecimal digits as the
-	abbreviated object name, use <n>+1 digits. Note that 1 column
-	is used for a caret to mark the boundary commit.
+	abbreviated commit object name, use <n>+1 digits. Note that 1 column
+	is used for a caret (`^`) to mark boundary commits.
 
 
 THE PORCELAIN FORMAT
@@ -164,7 +164,7 @@ When revision range specifiers are used to limit the annotation,
 lines that have not changed since the range boundary (either the
 commit v2.6.18 or the most recent commit that is more than 3
 weeks old in the above example) are blamed for that range
-boundary commit.
+boundary commit (preceded by `^` if shown).
 
 A particularly useful way is to see if an added file has lines
 created by copy-and-paste from existing files.  Sometimes this
-- 
2.26.2.windows.1.13.g9dddff6983

