From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] Add #include <limits.h> so that git compiles under Solaris
Date: Sat, 7 May 2005 10:41:41 +0200
Message-ID: <20050507084141.GD23680@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat May 07 10:39:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUKpu-0008SN-2x
	for gcvg-git@gmane.org; Sat, 07 May 2005 10:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbVEGIpF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 04:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbVEGIna
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 04:43:30 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:57788 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262802AbVEGIls (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 04:41:48 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j478ffS8001727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 7 May 2005 08:41:41 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j478ffvt001726;
	Sat, 7 May 2005 10:41:41 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Add #include <limits.h> so that git compiles under Solaris

Signed-Off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>

--- a/diff-tree-helper.c
+++ b/diff-tree-helper.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2005 Junio C Hamano
  */
+#include <limits.h>
 #include "cache.h"
 #include "strbuf.h"
 #include "diff.h"
--- a/diff.c
+++ b/diff.c
@@ -4,6 +4,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <signal.h>
+#include <limits.h>
 #include "cache.h"
 #include "diff.h"
 
--- a/local-pull.c
+++ b/local-pull.c
@@ -5,6 +5,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <stdlib.h>
+#include <limits.h>
 #include "cache.h"
 #include "commit.h"
 #include <errno.h>
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -7,6 +7,7 @@
  * creation etc.
  */
 #include <stdarg.h>
+#include <limits.h>
 #include "cache.h"
 
 const char *sha1_file_directory = NULL;
-
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
