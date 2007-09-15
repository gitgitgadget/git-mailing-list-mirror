From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Now that cache.h needs strbuf.h, remove useless includes.
Date: Sat, 15 Sep 2007 15:56:50 +0200
Message-ID: <20070916172233.9798318361@madism.org>
References: <20070916172134.GA26457@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 19:23:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWxpq-00082n-Qa
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 19:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbXIPRWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 13:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbXIPRWk
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 13:22:40 -0400
Received: from pan.madism.org ([88.191.52.104]:35180 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452AbXIPRWf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 13:22:35 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id F107C202AE;
	Sun, 16 Sep 2007 19:22:33 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 9798318361; Sun, 16 Sep 2007 19:22:33 +0200 (CEST)
In-Reply-To: <20070916172134.GA26457@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58329>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 archive-tar.c            |    1 -
 builtin-apply.c          |    1 -
 builtin-blame.c          |    1 -
 builtin-checkout-index.c |    1 -
 builtin-commit-tree.c    |    1 -
 builtin-fetch--tool.c    |    1 -
 builtin-rerere.c         |    1 -
 builtin-stripspace.c     |    1 -
 builtin-tag.c            |    1 -
 builtin-update-index.c   |    1 -
 cache-tree.c             |    1 -
 convert.c                |    1 -
 diff.c                   |    1 -
 fast-import.c            |    1 -
 fetch.c                  |    1 -
 imap-send.c              |    1 -
 mktag.c                  |    1 -
 mktree.c                 |    1 -
 sha1_file.c              |    1 -
 strbuf.c                 |    1 -
 20 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index cc94cf3..a87bc4b 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -3,7 +3,6 @@
  */
 #include "cache.h"
 #include "commit.h"
-#include "strbuf.h"
 #include "tar.h"
 #include "builtin.h"
 #include "archive.h"
diff --git a/builtin-apply.c b/builtin-apply.c
index 9735b47..ae708d7 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -12,7 +12,6 @@
 #include "blob.h"
 #include "delta.h"
 #include "builtin.h"
-#include "strbuf.h"
 
 /*
  *  --check turns on checking that the working tree matches the
diff --git a/builtin-blame.c b/builtin-blame.c
index b004f06..e364b6c 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -18,7 +18,6 @@
 #include "cache-tree.h"
 #include "path-list.h"
 #include "mailmap.h"
-#include "strbuf.h"
 
 static char blame_usage[] =
 "git-blame [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--contents <filename>] [--incremental] [commit] [--] file\n"
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 153ba7d..85e8efe 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -38,7 +38,6 @@
  */
 #include "builtin.h"
 #include "cache.h"
-#include "strbuf.h"
 #include "quote.h"
 #include "cache-tree.h"
 
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 325334f..88b0ab3 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -8,7 +8,6 @@
 #include "tree.h"
 #include "builtin.h"
 #include "utf8.h"
-#include "strbuf.h"
 
 #define BLOCKING (1ul << 14)
 
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 90bdc32..514a3cc 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -2,7 +2,6 @@
 #include "cache.h"
 #include "refs.h"
 #include "commit.h"
-#include "strbuf.h"
 
 static char *get_stdin(void)
 {
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 826d346..58288f6 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -1,7 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
 #include "path-list.h"
-#include "strbuf.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 
diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index c4cf2f0..1ce2847 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -1,6 +1,5 @@
 #include "builtin.h"
 #include "cache.h"
-#include "strbuf.h"
 
 /*
  * Returns the length of a line, without trailing spaces.
diff --git a/builtin-tag.c b/builtin-tag.c
index 9f29342..82ebda1 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -8,7 +8,6 @@
 
 #include "cache.h"
 #include "builtin.h"
-#include "strbuf.h"
 #include "refs.h"
 #include "tag.h"
 #include "run-command.h"
diff --git a/builtin-update-index.c b/builtin-update-index.c
index e02431c..0b60513 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -4,7 +4,6 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
-#include "strbuf.h"
 #include "quote.h"
 #include "cache-tree.h"
 #include "tree-walk.h"
diff --git a/cache-tree.c b/cache-tree.c
index 8f53c99..5471844 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "strbuf.h"
 #include "tree.h"
 #include "cache-tree.h"
 
diff --git a/convert.c b/convert.c
index 00a341c..508d30b 100644
--- a/convert.c
+++ b/convert.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "attr.h"
 #include "run-command.h"
-#include "strbuf.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
diff --git a/diff.c b/diff.c
index d46dd11..a5b69ed 100644
--- a/diff.c
+++ b/diff.c
@@ -9,7 +9,6 @@
 #include "xdiff-interface.h"
 #include "color.h"
 #include "attr.h"
-#include "strbuf.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
diff --git a/fast-import.c b/fast-import.c
index 2c0bfb9..1866d34 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -149,7 +149,6 @@ Format of STDIN stream:
 #include "pack.h"
 #include "refs.h"
 #include "csum-file.h"
-#include "strbuf.h"
 #include "quote.h"
 
 #define PACK_ID_BITS 16
diff --git a/fetch.c b/fetch.c
index dd6ed9e..c256e6f 100644
--- a/fetch.c
+++ b/fetch.c
@@ -6,7 +6,6 @@
 #include "tag.h"
 #include "blob.h"
 #include "refs.h"
-#include "strbuf.h"
 
 int get_tree = 0;
 int get_history = 0;
diff --git a/imap-send.c b/imap-send.c
index ecd4216..86e4a0f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -23,7 +23,6 @@
  */
 
 #include "cache.h"
-#include "strbuf.h"
 
 typedef struct store_conf {
 	char *name;
diff --git a/mktag.c b/mktag.c
index 7567f9e..b05260c 100644
--- a/mktag.c
+++ b/mktag.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "strbuf.h"
 #include "tag.h"
 
 /*
diff --git a/mktree.c b/mktree.c
index 3891cd9..5dab4bd 100644
--- a/mktree.c
+++ b/mktree.c
@@ -4,7 +4,6 @@
  * Copyright (c) Junio C Hamano, 2006
  */
 #include "cache.h"
-#include "strbuf.h"
 #include "quote.h"
 #include "tree.h"
 
diff --git a/sha1_file.c b/sha1_file.c
index 64b5b46..59325d4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -14,7 +14,6 @@
 #include "tag.h"
 #include "tree.h"
 #include "refs.h"
-#include "strbuf.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
diff --git a/strbuf.c b/strbuf.c
index ff551ac..c5f9e2a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "strbuf.h"
 
 void strbuf_init(struct strbuf *sb, size_t hint)
 {
-- 
1.5.3.1
