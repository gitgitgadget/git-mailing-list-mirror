From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] Add #include <limits.h> so that git compiles under Solaris
Date: Fri, 6 May 2005 15:36:54 +0200
Message-ID: <20050506133654.GH11506@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 06 15:31:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU2v1-0006lY-JJ
	for gcvg-git@gmane.org; Fri, 06 May 2005 15:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVEFNhb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 09:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVEFNhb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 09:37:31 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:50416 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261222AbVEFNg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 09:36:56 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j46DasS8009111
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 6 May 2005 13:36:55 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j46DasP7009110
	for git@vger.kernel.org; Fri, 6 May 2005 15:36:54 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Add #include <limits.h> so that git compiles under Solaris

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
