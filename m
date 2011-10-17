From: mhagger@alum.mit.edu
Subject: [PATCH v2 12/14] resolve_gitlink_ref(): improve docstring
Date: Mon, 17 Oct 2011 09:39:21 +0200
Message-ID: <1318837163-27112-13-git-send-email-mhagger@alum.mit.edu>
References: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 09:40:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFhoX-0008BI-DG
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 09:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001Ab1JQHkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 03:40:01 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:33662 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992Ab1JQHkA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 03:40:00 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RFhhi-0000eM-Ts; Mon, 17 Oct 2011 09:33:46 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183786>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/refs.h b/refs.h
index c6b8749..b5084ed 100644
--- a/refs.h
+++ b/refs.h
@@ -132,8 +132,12 @@ extern char *shorten_unambiguous_ref(const char *refname, int strict);
 /** rename ref, return 0 on success **/
 extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
 
-/** resolve ref in nested "gitlink" repository */
-extern int resolve_gitlink_ref(const char *name, const char *refname, unsigned char *sha1);
+/**
+ * Resolve refname in the nested "gitlink" repository that is located
+ * at path.  If the resolution is successful, return 0 and set sha1 to
+ * the name of the object; otherwise, return a non-zero value.
+ */
+extern int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1);
 
 /** lock a ref and then write its file */
 enum action_on_err { MSG_ON_ERR, DIE_ON_ERR, QUIET_ON_ERR };
-- 
1.7.7.rc2
