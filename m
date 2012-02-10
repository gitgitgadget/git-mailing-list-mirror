From: Namhyung Kim <namhyung.kim@lge.com>
Subject: [PATCH 1/2] ctype.c only wants git-compat-util.h
Date: Fri, 10 Feb 2012 11:13:30 +0900
Message-ID: <1328840011-19028-1-git-send-email-namhyung.kim@lge.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 03:13:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvfzA-0001cE-5F
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 03:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757864Ab2BJCNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 21:13:11 -0500
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:57395 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683Ab2BJCNL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 21:13:11 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Feb 2012 21:13:10 EST
X-AuditID: 9c930179-b7cf1ae000000e40-6f-4f3479ad7b5f
Received: from MultiCore.156.147.1.1 ( [165.186.175.80])
	by LGEMRELSE6Q.lge.com (Symantec Brightmail Gateway) with SMTP id 8E.1C.03648.EA9743F4; Fri, 10 Feb 2012 10:58:06 +0900 (KST)
X-Mailer: git-send-email 1.7.9
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190365>

The implementation of sane ctype macros only depends on symbols in
git-compat-util.h not cache.h

Signed-off-by: Namhyung Kim <namhyung.kim@lge.com>
---
 ctype.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ctype.c b/ctype.c
index b5d856f..af722f9 100644
--- a/ctype.c
+++ b/ctype.c
@@ -3,7 +3,7 @@
  *
  * No surprises, and works with signed and unsigned chars.
  */
-#include "cache.h"
+#include "git-compat-util.h"
 
 enum {
 	S = GIT_SPACE,
-- 
1.7.9
