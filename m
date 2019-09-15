Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3EA11F463
	for <e@80x24.org>; Sun, 15 Sep 2019 16:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbfIOQ5v (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 12:57:51 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:25293 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfIOQ5u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 12:57:50 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46WbCc74wTz5tlB;
        Sun, 15 Sep 2019 18:57:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A9E2E4AA2;
        Sun, 15 Sep 2019 18:57:48 +0200 (CEST)
Subject: [PATCH 2/2] diff, log doc: small grammer, format, and language fixes
From:   Johannes Sixt <j6t@kdbg.org>
To:     Git Mailing List <git@vger.kernel.org>
References: <fac55175-dc1e-addf-194b-97aaf6a33e3b@kdbg.org>
Message-ID: <4e9892b1-9d9e-f088-9e56-70f3b02fc9e1@kdbg.org>
Date:   Sun, 15 Sep 2019 18:57:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fac55175-dc1e-addf-194b-97aaf6a33e3b@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

- Replace "SHA-1" by "object name", the modern name for hashes.

- Correct a few grammar weaknesses.

- Do not accidentally format a phrase in teletype font where quotes are
  intended.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I do not have the toolchain to check that a correct result is produced.

 Documentation/diff-generate-patch.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index c6bbb2ac22..ece1a2b66e 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -50,7 +50,7 @@ similarity index value of 100% is thus reserved for two equal
 files, while 100% dissimilarity means that no line from the old
 file made it into the new one.
 +
-The index line includes the SHA-1 checksum before and after the change.
+The index line includes the blob object names before and after the change.
 The <mode> is included if the file mode does not change; otherwise,
 separate lines indicate the old and the new mode.
 
@@ -71,7 +71,7 @@ separate lines indicate the old and the new mode.
       rename to a
 
 
-combined diff format
+Combined diff format
 --------------------
 
 Any diff-generating command can take the `-c` or `--cc` option to
@@ -81,7 +81,7 @@ linkgit:git-show[1]. Note also that you can give the `-m` option to any
 of these commands to force generation of diffs with individual parents
 of a merge.
 
-A 'combined diff' format looks like this:
+A "combined diff" format looks like this:
 
 ------------
 diff --combined describe.c
@@ -114,11 +114,11 @@ index fabadb8,cc95eb0..4866510
 ------------
 
 1.   It is preceded with a "git diff" header, that looks like
-     this (when `-c` option is used):
+     this (when the `-c` option is used):
 
        diff --combined file
 +
-or like this (when `--cc` option is used):
+or like this (when the `--cc` option is used):
 
        diff --cc file
 
@@ -161,7 +161,7 @@ parents.
 4.   Chunk header format is modified to prevent people from
      accidentally feeding it to `patch -p1`. Combined diff format
      was created for review of merge commit changes, and was not
-     meant for apply. The change is similar to the change in the
+     meant to be applied. The change is similar to the change in the
      extended 'index' header:
 
        @@@ <from-file-range> <from-file-range> <to-file-range> @@@
-- 
2.23.0.93.g91d3f15def
