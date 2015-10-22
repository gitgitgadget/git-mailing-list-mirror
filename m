From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 3/5] diff: remove unused #include "sigchain.h"
Date: Thu, 22 Oct 2015 14:43:28 +0200
Message-ID: <1445517810-13998-4-git-send-email-tklauser@distanz.ch>
References: <1445517810-13998-1-git-send-email-tklauser@distanz.ch>
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 14:43:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpFDh-00078L-KX
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 14:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757423AbbJVMnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 08:43:40 -0400
Received: from mail.zhinst.com ([212.126.164.98]:42961 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756896AbbJVMne (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 08:43:34 -0400
Received: from ziws06.zhinst.com ([10.42.0.71])
	by mail.zhinst.com (Kerio Connect 8.5.2);
	Thu, 22 Oct 2015 14:43:30 +0200
X-Mailer: git-send-email 2.6.1.148.g7927db1
In-Reply-To: <1445517810-13998-1-git-send-email-tklauser@distanz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280048>

After switching to use the tempfile module in commit 284098f1
(diff: use tempfile module), no declarations from sigchain.h are used in
diff.c anymore. Thus, remove the #include.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 diff.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/diff.c b/diff.c
index 46260ed..df47592 100644
--- a/diff.c
+++ b/diff.c
@@ -13,7 +13,6 @@
 #include "run-command.h"
 #include "utf8.h"
 #include "userdiff.h"
-#include "sigchain.h"
 #include "submodule-config.h"
 #include "submodule.h"
 #include "ll-merge.h"
-- 
2.6.1.148.g7927db1
