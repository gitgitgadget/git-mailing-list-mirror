Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFCBC433E1
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF2E2075F
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388745AbgEYVox (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 17:44:53 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:39831 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388348AbgEYVow (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 17:44:52 -0400
Received: from localhost.localdomain ([89.243.191.101])
        by smtp.talktalk.net with SMTP
        id dKm0jC4AIIndsdKm1jhP2q; Mon, 25 May 2020 22:36:41 +0100
X-Originating-IP: [89.243.191.101]
X-Spam: 0
X-OAuthority: v=2.3 cv=QYIYQfTv c=1 sm=1 tr=0 a=5KGm1Kp77X3djDixdaHiLg==:117
 a=5KGm1Kp77X3djDixdaHiLg==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=17mK-hWjcDJIySpHdNYA:9
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
From:   Philip Oakley <philipoakley@iee.email>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] doc: fixup/squash: remove ellipsis marks, use <line> for clarify
Date:   Mon, 25 May 2020 22:36:32 +0100
Message-Id: <20200525213632.1626-3-philipoakley@iee.email>
X-Mailer: git-send-email 2.26.2.windows.1.13.g9dddff6983
In-Reply-To: <20200525213632.1626-1-philipoakley@iee.email>
References: <9a9e7432-7a74-f46e-9a77-b8acaa9a974f@iee.email>
 <20200525213632.1626-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPvfo84edlVVru6jFcucucps12gYOMusUar0/MVu2kqoF30RAgAMcv/RwYnsfF+3r4zSEYapKQPr7E+Sr/Hvk0JsdCjv9d+Iih0AoMhj3hJpHT0C/Q4/
 KU/g3bi+uObfGMaL1Nxslsc46nOkpJ0YGYXkSblxj3J0Q5P9FnTlJUXx26T0SOwm/sLYqFgh6w35nw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ellipsis marks fail to hint at the typoe or style of the missing content.

Tell the reader what is missing, for easier comprehension.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---

The fixup/squash process could probably benefit from its own section
as there are many places for user interaction with the process.
This is a minimal shift toward such an improvement.
---
 Documentation/git-rebase.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index dfd3d6d0ef..1d8237bfc6 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -534,15 +534,15 @@ See also INCOMPATIBLE OPTIONS below.
 
 --autosquash::
 --no-autosquash::
-	When the commit log message begins with "squash! ..." (or
-	"fixup! ..."), and there is already a commit in the todo list that
-	matches the same `...`, automatically modify the todo list of rebase
+	When the commit log message begins with "squash! <line>" (or
+	"fixup! <line>"), and there is already a commit in the todo list that
+	matches the same `<line>`, automatically modify the todo list of rebase
 	-i so that the commit marked for squashing comes right after the
 	commit to be modified, and change the action of the moved commit
 	from `pick` to `squash` (or `fixup`).
 +
-A commit matches the `...` if
-the commit subject matches, or if the `...` refers to the commit's
+A commit matches the `<line>` if
+the commit subject matches, or if the `<line>` refers to the commit's
 hash. As a fall-back, partial matches of the commit subject work,
 too.  The recommended way to create fixup/squash commits is by using
 the `--fixup`/`--squash` options of linkgit:git-commit[1].
-- 
2.26.2.windows.1.13.g9dddff6983

