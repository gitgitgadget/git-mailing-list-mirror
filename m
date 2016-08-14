Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B07C71FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 21:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbcHNVqm (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 17:46:42 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:59436 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbcHNVqk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 17:46:40 -0400
Received: from localhost.localdomain ([92.22.48.2])
	by smtp.talktalk.net with SMTP
	id Z3Esb3wiWcpskZ3EsbC7Dr; Sun, 14 Aug 2016 22:46:39 +0100
X-Originating-IP: [92.22.48.2]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=dUEO/agNDYQW2w9YSFWSZw==:117
 a=dUEO/agNDYQW2w9YSFWSZw==:17 a=xtxXYLxNAAAA:8 a=T70BPjvxQS9tRP5GIwEA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Subject: [PATCH v1 1/3] doc: commit: --fixup/--squash can take a commit revision
Date:	Sun, 14 Aug 2016 22:46:28 +0100
Message-Id: <20160814214630.1312-2-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160814214630.1312-1-philipoakley@iee.org>
References: <20160814214630.1312-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfBEXZBgul3s6TW+7Z+Dwqw3kPs1HuiADwqDv3gckMK8kv/HQ7FyZwn0K3S7Vqo2LLV4H2us1mudvqfhN1Yfa97/jm8h3AXglzGz+8Y0im0ESz7qaNbfc
 Vt3DMfxgO3Sbgzdh4YoLt60n7iXCjmTut7oZw9AfaoGookffu0Ctdnsu
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Be clearer that the --fixup/--squash options can take any of the
gitrevisions methods of specifying a commit, not just a 'hash'.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
v1
It's not immediately obvious what different forms the <commit>
option can take. Spell out, and refer to the git revisions guide,
that any of the revision methods will work.

On a side note, if one looks at the glossary, a <commit> links to
<commit object> which links to <object> (and only tangentially
"about" revisions) which then says "uniquely identified by the SHA-1",
so it is easy to think one should use the sha1 here.

I only discovered this misunderstanding while following up
other parts of this series!
---
 Documentation/git-commit.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index e704953..3600929 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -81,15 +81,15 @@ OPTIONS
 --fixup=<commit>::
 	Construct a commit message for use with `rebase --autosquash`.
 	The commit message will be the subject line from the specified
-	commit with a prefix of "fixup! ".  See linkgit:git-rebase[1]
-	for details.
+	commit revision with a prefix of "fixup! ".  See linkgit:git-rebase[1]
+	and linkgit:gitrevisions[7] for details.
 
 --squash=<commit>::
 	Construct a commit message for use with `rebase --autosquash`.
 	The commit message subject line is taken from the specified
-	commit with a prefix of "squash! ".  Can be used with additional
+	commit revision with a prefix of "squash! ".  Can be used with additional
 	commit message options (`-m`/`-c`/`-C`/`-F`). See
-	linkgit:git-rebase[1] for details.
+	linkgit:git-rebase[1] and linkgit:gitrevisions[7] for details.
 
 --reset-author::
 	When used with -C/-c/--amend options, or when committing after a
-- 
2.9.0.windows.1

