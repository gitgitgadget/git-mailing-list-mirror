Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6931D1F4B9
	for <e@80x24.org>; Sun, 15 Sep 2019 16:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfIOQzf (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 12:55:35 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:22092 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfIOQzf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 12:55:35 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46Wb9018xHz5tl9;
        Sun, 15 Sep 2019 18:55:31 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 266994AA2;
        Sun, 15 Sep 2019 18:55:30 +0200 (CEST)
To:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2] diff, log doc: say "patch text" instead of "patches"
Message-ID: <fac55175-dc1e-addf-194b-97aaf6a33e3b@kdbg.org>
Date:   Sun, 15 Sep 2019 18:55:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A poster on Stackoverflow was confused that the documentation of git-log
promised to generate "patches" or "patch files" with -p, but there were
none to be found. Rewrite the corresponding paragraph to talk about
"patch text" to avoid the confusion.

Shorten the language to say "X does Y" in place of "X does not Z, but Y".

Cross-reference the referred-to commands like the rest of the file does.

Mention porcelain commands before plumbing commands because I guess that
the paragraph is read more frequently in their context.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I do not have the toolchain to check that a correct result is produced.

 Documentation/diff-generate-patch.txt | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index f10ca410ad..c6bbb2ac22 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -1,11 +1,12 @@
-Generating patches with -p
---------------------------
-
-When "git-diff-index", "git-diff-tree", or "git-diff-files" are run
-with a `-p` option, "git diff" without the `--raw` option, or
-"git log" with the "-p" option, they
-do not produce the output described above; instead they produce a
-patch file.  You can customize the creation of such patches via the
+Generating patch text with -p
+-----------------------------
+
+Running
+linkgit:git-diff[1] without the `--raw` option,
+or linkgit:git-log[1], linkgit:git-diff-index[1], linkgit:git-diff-tree[1],
+or linkgit:git-diff-files[1] with the `-p` option
+produces patch text instead of the usual output.
+You can customize the creation of patch text via the
 `GIT_EXTERNAL_DIFF` and the `GIT_DIFF_OPTS` environment variables.
 
 What the -p option produces is slightly different from the traditional
-- 
2.23.0.93.g91d3f15def
