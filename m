From: mduft@gentoo.org
Subject: [PATCH 2/2] Include unistd.h.
Date: Wed, 25 May 2011 16:15:24 +0200
Message-ID: <1306332924-28587-3-git-send-email-mduft@gentoo.org>
References: <1306332924-28587-1-git-send-email-mduft@gentoo.org>
Cc: Markus Duft <mduft@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 16:25:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPF21-0005IJ-DX
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 16:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932998Ab1EYOZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 10:25:41 -0400
Received: from smtp.salomon.at ([193.186.16.13]:57813 "EHLO sauxb.salomon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932553Ab1EYOZk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 10:25:40 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 May 2011 10:25:31 EDT
Received: from servex01.wamas.com (servex01.salomon.at [172.28.2.2])
	by sauxb.salomon.at (8.12.10/8.12.10) with ESMTP id p4PEFMJZ022198;
	Wed, 25 May 2011 16:15:49 +0200 (METDST)
Received: from s01en22 ([172.28.8.166]) by servex01.wamas.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 25 May 2011 16:15:35 +0200
Received: by s01en22 (sSMTP sendmail emulation); Wed, 25 May 2011 16:15:31 +0200
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1306332924-28587-1-git-send-email-mduft@gentoo.org>
X-OriginalArrivalTime: 25 May 2011 14:15:35.0909 (UTC) FILETIME=[3746D150:01CC1AE6]
X-Scanned-By: MIMEDefang 2.54 on 172.28.2.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174406>

At least on Interix, NULL is defined in unistd.h, and not including it
causes compilation failure.

Signed-off-by: Markus Duft <mduft@gentoo.org>
---
 compat/fnmatch/fnmatch.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch.c
index 14feac7..0238cca 100644
--- a/compat/fnmatch/fnmatch.c
+++ b/compat/fnmatch/fnmatch.c
@@ -25,6 +25,7 @@
 # define _GNU_SOURCE	1
 #endif
 
+#include <unistd.h>
 #include <errno.h>
 #include <fnmatch.h>
 #include <ctype.h>
-- 
1.7.3.4
