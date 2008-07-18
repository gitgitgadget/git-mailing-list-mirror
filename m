From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/2] archive: remove unused headers
Date: Fri, 18 Jul 2008 16:30:47 +0200
Message-ID: <4880A917.2090803@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 16:32:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJr05-0006Z0-9p
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 16:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbYGROav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 10:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbYGROav
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 10:30:51 -0400
Received: from india601.server4you.de ([85.25.151.105]:48974 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbYGROau (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 10:30:50 -0400
Received: from [10.0.1.200] (p57B7EF64.dip.t-dialin.net [87.183.239.100])
	by india601.server4you.de (Postfix) with ESMTPSA id A0AFE2F8092;
	Fri, 18 Jul 2008 16:30:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89043>

Remove obsolete #includes.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-tar.c     |    2 --
 archive-zip.c     |    5 -----
 builtin-archive.c |    2 --
 3 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index f9eb726..1302961 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -2,9 +2,7 @@
  * Copyright (c) 2005, 2006 Rene Scharfe
  */
 #include "cache.h"
-#include "commit.h"
 #include "tar.h"
-#include "builtin.h"
 #include "archive.h"
 
 #define RECORDSIZE	(512)
diff --git a/archive-zip.c b/archive-zip.c
index fb12398..cf28504 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -2,11 +2,6 @@
  * Copyright (c) 2006 Rene Scharfe
  */
 #include "cache.h"
-#include "commit.h"
-#include "blob.h"
-#include "tree.h"
-#include "quote.h"
-#include "builtin.h"
 #include "archive.h"
 
 static int zip_date;
diff --git a/builtin-archive.c b/builtin-archive.c
index cff6ce7..df97724 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -7,10 +7,8 @@
 #include "archive.h"
 #include "commit.h"
 #include "tree-walk.h"
-#include "exec_cmd.h"
 #include "pkt-line.h"
 #include "sideband.h"
-#include "attr.h"
 
 static const char archive_usage[] = \
 "git archive --format=<fmt> [--prefix=<prefix>/] [--verbose] [<extra>] <tree-ish> [path...]";
-- 
1.5.6.2.212.g08b51
