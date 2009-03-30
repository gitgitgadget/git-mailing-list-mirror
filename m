From: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
Subject: [PATCH 4/5] Header includes cleanup
Date: Mon, 30 Mar 2009 02:55:24 -0700
Message-ID: <1238406925-15907-5-git-send-email-nathaniel.dawson@gmail.com>
References: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com>
 <1238406925-15907-2-git-send-email-nathaniel.dawson@gmail.com>
 <1238406925-15907-3-git-send-email-nathaniel.dawson@gmail.com>
 <1238406925-15907-4-git-send-email-nathaniel.dawson@gmail.com>
Cc: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 11:57:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoEFJ-0001ZQ-M0
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 11:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758582AbZC3Jz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 05:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758578AbZC3Jz4
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 05:55:56 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:32233 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758558AbZC3Jzl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 05:55:41 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1907093ywb.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 02:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=R/WVz9nk1or1ZCi1Gfeed68f/MFZpcOxOOeFUpr84U8=;
        b=cPPmlU+HM9EbHt1KEKK2WwQDJffXbeaEoZpzQzslFTVgn9d6hfpN6+0otnFI/F2mEL
         /SUyQMe4G2a9Qa4LNeFVyiEf37/q5PKEvvDe2ELMqjNk5y1nKnjF42LyOgDW8W0AJatF
         LTqKtrs6NemlFJ9hD6qsaZpFZnEfb6bwjD1tI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rGiMGDPJdhoTHsJc1h+EWfnXz7uKjMbooyEgoorY+MImjoiyVrQGn4Mvd8ZQgi+JIi
         +BAFXoEDsXnCv7LoEgI81giQnTi/qWomg6ToMqrbVN2MlWeKKZcQF62/U5Q6cEAdjXV3
         s8GOLEtFLiAN+QQk1ffT5FikM/7Aibg2Wgnig=
Received: by 10.101.71.3 with SMTP id y3mr3782843ank.62.1238406939219;
        Mon, 30 Mar 2009 02:55:39 -0700 (PDT)
Received: from localhost (ip68-98-113-49.ph.ph.cox.net [68.98.113.49])
        by mx.google.com with ESMTPS id c14sm135291ana.21.2009.03.30.02.55.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 02:55:38 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1238406925-15907-4-git-send-email-nathaniel.dawson@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115126>

Deleted header includes of object.h, tree.h, strbuf.h, and decorate.h where commit.h was included since commit.h includes them.

Signed-off-by: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
---
 alloc.c                |    1 -
 builtin-receive-pack.c |    1 -
 builtin-reset.c        |    2 --
 builtin.h              |    2 --
 bundle.c               |    1 -
 fsck.c                 |    3 +--
 index-pack.c           |    1 -
 list-objects.c         |    1 -
 object.c               |    1 -
 read-cache.c           |    1 -
 revision.c             |    2 --
 server-info.c          |    1 -
 sha1_file.c            |    1 -
 sha1_name.c            |    1 -
 tag.c                  |    1 -
 tree.c                 |    3 +--
 upload-pack.c          |    1 -
 walker.c               |    1 -
 wt-status.c            |    3 +--
 19 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/alloc.c b/alloc.c
index 5b3d4a2..af0dd88 100644
--- a/alloc.c
+++ b/alloc.c
@@ -11,7 +11,6 @@
  */
 #include "cache.h"
 #include "blob.h"
-#include "tree.h"
 #include "commit.h"
 #include "tag.h"
 
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index a970b39..e95aa41 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -5,7 +5,6 @@
 #include "run-command.h"
 #include "exec_cmd.h"
 #include "commit.h"
-#include "object.h"
 #include "remote.h"
 #include "transport.h"
 
diff --git a/builtin-reset.c b/builtin-reset.c
index c0cb915..d44c935 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -9,13 +9,11 @@
  */
 #include "cache.h"
 #include "tag.h"
-#include "object.h"
 #include "commit.h"
 #include "run-command.h"
 #include "refs.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "tree.h"
 #include "branch.h"
 #include "parse-options.h"
 
diff --git a/builtin.h b/builtin.h
index 1495cf6..b9ef9fc 100644
--- a/builtin.h
+++ b/builtin.h
@@ -1,8 +1,6 @@
 #ifndef BUILTIN_H
 #define BUILTIN_H
 
-#include "git-compat-util.h"
-#include "strbuf.h"
 #include "cache.h"
 #include "commit.h"
 
diff --git a/bundle.c b/bundle.c
index d0dd818..14966f8 100644
--- a/bundle.c
+++ b/bundle.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "bundle.h"
-#include "object.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/fsck.c b/fsck.c
index e903f6a..8cbb6aa 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,8 +1,7 @@
 #include "cache.h"
 #include "blob.h"
-#include "tree.h"
-#include "tree-walk.h"
 #include "commit.h"
+#include "tree-walk.h"
 #include "tag.h"
 #include "fsck.h"
 
diff --git a/index-pack.c b/index-pack.c
index 7546822..ac6fc84 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -5,7 +5,6 @@
 #include "blob.h"
 #include "commit.h"
 #include "tag.h"
-#include "tree.h"
 #include "progress.h"
 #include "fsck.h"
 #include "exec_cmd.h"
diff --git a/list-objects.c b/list-objects.c
index c8b8375..6446f81 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "tag.h"
 #include "commit.h"
-#include "tree.h"
 #include "blob.h"
 #include "diff.h"
 #include "tree-walk.h"
diff --git a/object.c b/object.c
index 380652f..83f786c 100644
--- a/object.c
+++ b/object.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "blob.h"
-#include "tree.h"
 #include "commit.h"
 #include "tag.h"
 
diff --git a/read-cache.c b/read-cache.c
index 3f58711..b50b02e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -8,7 +8,6 @@
 #include "cache-tree.h"
 #include "refs.h"
 #include "dir.h"
-#include "tree.h"
 #include "commit.h"
 #include "diff.h"
 #include "diffcore.h"
diff --git a/revision.c b/revision.c
index f5771c7..827108d 100644
--- a/revision.c
+++ b/revision.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "tag.h"
 #include "blob.h"
-#include "tree.h"
 #include "commit.h"
 #include "diff.h"
 #include "refs.h"
@@ -10,7 +9,6 @@
 #include "grep.h"
 #include "reflog-walk.h"
 #include "patch-ids.h"
-#include "decorate.h"
 #include "log-tree.h"
 
 volatile show_early_output_fn_t show_early_output;
diff --git a/server-info.c b/server-info.c
index 66b0d9d..3d54c44 100644
--- a/server-info.c
+++ b/server-info.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "refs.h"
-#include "object.h"
 #include "commit.h"
 #include "tag.h"
 
diff --git a/sha1_file.c b/sha1_file.c
index 54972f9..77e6f54 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -12,7 +12,6 @@
 #include "blob.h"
 #include "commit.h"
 #include "tag.h"
-#include "tree.h"
 #include "refs.h"
 #include "pack-revindex.h"
 #include "sha1-lookup.h"
diff --git a/sha1_name.c b/sha1_name.c
index 2f75179..c98cd30 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "tag.h"
 #include "commit.h"
-#include "tree.h"
 #include "blob.h"
 #include "tree-walk.h"
 #include "refs.h"
diff --git a/tag.c b/tag.c
index 4470d2b..94e2903 100644
--- a/tag.c
+++ b/tag.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "tag.h"
 #include "commit.h"
-#include "tree.h"
 #include "blob.h"
 
 const char *tag_type = "tag";
diff --git a/tree.c b/tree.c
index 25d2e29..b9e427d 100644
--- a/tree.c
+++ b/tree.c
@@ -1,8 +1,7 @@
 #include "cache.h"
 #include "cache-tree.h"
-#include "tree.h"
-#include "blob.h"
 #include "commit.h"
+#include "blob.h"
 #include "tag.h"
 #include "tree-walk.h"
 
diff --git a/upload-pack.c b/upload-pack.c
index a49d872..9a91b14 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -3,7 +3,6 @@
 #include "pkt-line.h"
 #include "sideband.h"
 #include "tag.h"
-#include "object.h"
 #include "commit.h"
 #include "exec_cmd.h"
 #include "diff.h"
diff --git a/walker.c b/walker.c
index e57630e..67ddcf6 100644
--- a/walker.c
+++ b/walker.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "walker.h"
 #include "commit.h"
-#include "tree.h"
 #include "tree-walk.h"
 #include "tag.h"
 #include "blob.h"
diff --git a/wt-status.c b/wt-status.c
index 929b00f..125a4c4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1,9 +1,8 @@
 #include "cache.h"
 #include "wt-status.h"
 #include "color.h"
-#include "object.h"
-#include "dir.h"
 #include "commit.h"
+#include "dir.h"
 #include "diff.h"
 #include "revision.h"
 #include "diffcore.h"
-- 
1.6.1.3
