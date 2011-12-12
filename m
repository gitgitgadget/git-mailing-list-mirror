From: mhagger@alum.mit.edu
Subject: [PATCH v2 11/51] resolve_gitlink_ref(): improve docstring
Date: Mon, 12 Dec 2011 06:38:18 +0100
Message-ID: <1323668338-1764-12-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:40:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZycb-0000Sq-DT
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572Ab1LLFj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:39:58 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34604 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab1LLFjs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:39:48 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aO015577;
	Mon, 12 Dec 2011 06:39:33 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186833>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/refs.h b/refs.h
index 4c5d570..d498291 100644
--- a/refs.h
+++ b/refs.h
@@ -133,8 +133,12 @@ extern char *shorten_unambiguous_ref(const char *refname, int strict);
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
1.7.8
