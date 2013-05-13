From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 4/4] coverage: build coverage-untested-functions by default
Date: Mon, 13 May 2013 23:27:28 +0200
Message-ID: <4669d2876582766465ea069bb29f36ac6e4a1380.1368479988.git.trast@inf.ethz.ch>
References: <cover.1368479988.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 13 23:27:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc0HS-0004k6-PL
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 23:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131Ab3EMV1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 17:27:35 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:52715 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab3EMV1e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 17:27:34 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 13 May
 2013 23:27:29 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 13 May
 2013 23:27:30 +0200
X-Mailer: git-send-email 1.8.3.rc1.400.g07d6e4a
In-Reply-To: <cover.1368479988.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224205>

Change the 'coverage' target to build coverage-untested-functions by
default, so as to make it more discoverable.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 153d24d..6f9d1c7 100644
--- a/Makefile
+++ b/Makefile
@@ -2529,7 +2529,7 @@ check-builtins::
 
 coverage:
 	$(MAKE) coverage-test
-	$(MAKE) coverage-report
+	$(MAKE) coverage-untested-functions
 
 object_dirs := $(sort $(dir $(OBJECTS)))
 coverage-clean-results:
-- 
1.8.3.rc1.400.g07d6e4a
