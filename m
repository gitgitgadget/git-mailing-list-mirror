Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BA0C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 10:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349855AbiBCKQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 05:16:53 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:49812 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiBCKQx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 05:16:53 -0500
Received: from localhost.localdomain ([92.7.140.211])
        by smtp.talktalk.net with SMTP
        id FZAZn80QeVK79FZAZntkrB; Thu, 03 Feb 2022 10:16:51 +0000
X-Originating-IP: [92.7.140.211]
X-Spam: 0
X-OAuthority: v=2.3 cv=EcW2v8uC c=1 sm=1 tr=0 a=yoCDdHCNlh93eLCC9+FDTw==:117
 a=yoCDdHCNlh93eLCC9+FDTw==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=-zAIayXokWdfPZh1nkcA:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2] doc: check-ignore: code-quote an exclamation mark
Date:   Thu,  3 Feb 2022 10:16:43 +0000
Message-Id: <20220203101643.1987-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.35.1.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFRqonQJbGbwCG3nh1yiVhMIbFQ5R/t53MVXpZK9IdOOMhrym9oAkAbdsV9Zt1w7hIoJd3T+HOCK6KKiiHBTPWEjL4j45htBXdgSeFFi411UrzbMRUFJ
 ttuKCSo3hYkjUiuL96DRVTX7jSdmG9sCHBqJ6FWzSZUKvVxWP667wNKEdxGx9hyoCJ8DAaaGwsRyJd9Bj6AEOl3xkbQysaWgvc0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The plain quoted exclamation mark renders as italics in the
Windows pdf help manual.

Fix this with back-tick quoting and surrounding double quotes
as exemplified by the gitignore.txt guide.

While at it, fix  the surrounding double quotes for the other
special characters usages.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---

Since V1:
Corrected finger trouble with special character when copy-pasting.

 Documentation/git-check-ignore.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 0c3924a63d..2892799e32 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -33,7 +33,7 @@ OPTIONS
 	Instead of printing the paths that are excluded, for each path
 	that matches an exclude pattern, print the exclude pattern
 	together with the path.  (Matching an exclude pattern usually
-	means the path is excluded, but if the pattern begins with '!'
+	means the path is excluded, but if the pattern begins with "`!`"
 	then it is a negated pattern and matching it means the path is
 	NOT excluded.)
 +
@@ -77,7 +77,7 @@ If `--verbose` is specified, the output is a series of lines of the form:
 <pathname> is the path of a file being queried, <pattern> is the
 matching pattern, <source> is the pattern's source file, and <linenum>
 is the line number of the pattern within that source.  If the pattern
-contained a `!` prefix or `/` suffix, it will be preserved in the
+contained a "`!`" prefix or "`/`" suffix, it will be preserved in the
 output.  <source> will be an absolute path when referring to the file
 configured by `core.excludesFile`, or relative to the repository root
 when referring to `.git/info/exclude` or a per-directory exclude file.
-- 
2.35.1.windows.2

