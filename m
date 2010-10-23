From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] CodingGuidelines: add a note to help contributors catch some errors earlier.
Date: Sat, 23 Oct 2010 16:17:14 +0200
Message-ID: <1287843434-10890-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 23 16:19:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9ew2-0003Fq-3b
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 16:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164Ab0JWOR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 10:17:29 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:39998 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756981Ab0JWOR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 10:17:28 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id C7953D480AD;
	Sat, 23 Oct 2010 16:17:22 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P9euP-0002q9-L4; Sat, 23 Oct 2010 16:17:21 +0200
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159786>

It is a bit of a shame to wait for other's review before noticing
decl-after-stmt situations, whereas a quick check could have found it.
There are probably a number of other autoamted checks which could be
described here, but that's a start.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 Documentation/CodingGuidelines |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 09ffc46..7ecd4f3 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -139,3 +139,8 @@ For C programs:
 
  - When we pass <string, length> pair to functions, we should try to
    pass them in that order.
+
+ - C code is expected to compile when the build is launched with the
+   following command:
+
+   make CFLAGS="-Wall -Wdeclaration-after-statement -Werror"
-- 
1.7.2.3
