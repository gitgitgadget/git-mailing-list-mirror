From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH 1/4] [trivial] Fix comment typo
Date: Wed, 13 Nov 2013 00:17:42 +0900
Message-ID: <1384269465-23352-1-git-send-email-standby24x7@gmail.com>
Cc: Masanari Iida <standby24x7@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 16:18:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgFjx-0002sB-5E
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 16:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755645Ab3KLPS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 10:18:28 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:58245 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab3KLPST (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 10:18:19 -0500
Received: by mail-pd0-f169.google.com with SMTP id y13so4199715pdi.0
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 07:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Yyydhosa9DV0770NYL53Az74CILZT4y5Oj88Kog4bGo=;
        b=Y1jczS0ttgt6XHRa1UrF77e3cMAhytUw5tRwurpV9kTy+pOCYoKeeNxTqik3LF2Xd4
         CP6uGjIHC1WyWZyeETTuESAegAOfRkrMJc5XlOYt/sI33xGgU6CF5dWDaYpVL5xwPElI
         LATbPHTdIZX/MbeHmBtIqwI27KlCf6xJWkwePjJHeohaCP/MDLQkdAG7NOIcvedvJrpM
         81FGbtWsbvvND/Otm8JyIySh+N0rf55cQX23QBCZ2tQ+LRL4o8FJLg1nosNwg2L4+8wx
         M/ykOGKdTEq1ld4vYjSPPIWFw+QFb74fSNUEZRxQN9pYJlQvKg7/NwTIqEMIAkembSRk
         njjw==
X-Received: by 10.68.134.6 with SMTP id pg6mr36267068pbb.67.1384269497894;
        Tue, 12 Nov 2013 07:18:17 -0800 (PST)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by mx.google.com with ESMTPSA id xn12sm44612325pac.12.2013.11.12.07.18.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 07:18:17 -0800 (PST)
Received: by masabert (Postfix, from userid 1000)
	id AA18664945; Wed, 13 Nov 2013 00:18:09 +0900 (JST)
X-Mailer: git-send-email 1.8.5.rc1.17.g0ecd94d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237714>

Correct spelling typo

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 git-bisect.sh | 2 +-
 pathspec.c    | 4 ++--
 wrapper.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 9f064b6..ebac284 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -137,7 +137,7 @@ bisect_start() {
 			# cogito usage, and cogito users should understand
 			# it relates to cg-seek.
 			[ -s "$GIT_DIR/head-name" ] &&
-				die "$(gettext "won't bisect on seeked tree")"
+				die "$(gettext "won't bisect on sought tree")"
 			start_head="${head#refs/heads/}"
 			;;
 		*)
diff --git a/pathspec.c b/pathspec.c
index ad1a9f5..be962d4 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -193,11 +193,11 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	magic |= short_magic;
 	*p_short_magic = short_magic;
 
-	/* --noglob-pathspec adds :(literal) _unless_ :(glob) is specifed */
+	/* --noglob-pathspec adds :(literal) _unless_ :(glob) is specified */
 	if (noglob_global && !(magic & PATHSPEC_GLOB))
 		global_magic |= PATHSPEC_LITERAL;
 
-	/* --glob-pathspec is overriden by :(literal) */
+	/* --glob-pathspec is overridden by :(literal) */
 	if ((global_magic & PATHSPEC_GLOB) && (magic & PATHSPEC_LITERAL))
 		global_magic &= ~PATHSPEC_GLOB;
 
diff --git a/wrapper.c b/wrapper.c
index 9a6aaaf..0cc5636 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -133,7 +133,7 @@ void *xcalloc(size_t nmemb, size_t size)
 /*
  * Limit size of IO chunks, because huge chunks only cause pain.  OS X
  * 64-bit is buggy, returning EINVAL if len >= INT_MAX; and even in
- * the absense of bugs, large chunks can result in bad latencies when
+ * the absence of bugs, large chunks can result in bad latencies when
  * you decide to kill the process.
  */
 #define MAX_IO_SIZE (8*1024*1024)
-- 
1.8.5.rc1.17.g0ecd94d
