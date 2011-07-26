From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/19] Remove anachronism from comment
Date: Tue, 26 Jul 2011 16:12:46 +0200
Message-ID: <1311689582-3116-4-git-send-email-mhagger@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:32:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlig6-0005I5-9g
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319Ab1GZOb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:31:56 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40201 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab1GZObx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:31:53 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QliM6-0004aQ-Hx; Tue, 26 Jul 2011 16:11:30 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177873>

Setting attributes to arbitrary values ("attribute=value") is now
supported, so it is no longer necessary for this comment to justify
prohibiting '=' in an attribute name.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 attr.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/attr.c b/attr.c
index f6b3f7e..4a1244f 100644
--- a/attr.c
+++ b/attr.c
@@ -50,10 +50,8 @@ static unsigned hash_name(const char *name, int namelen)
 static int invalid_attr_name(const char *name, int namelen)
 {
 	/*
-	 * Attribute name cannot begin with '-' and from
-	 * [-A-Za-z0-9_.].  We'd specifically exclude '=' for now,
-	 * as we might later want to allow non-binary value for
-	 * attributes, e.g. "*.svg	merge=special-merge-program-for-svg"
+	 * Attribute name cannot begin with '-' and must consist of
+	 * characters from [-A-Za-z0-9_.].
 	 */
 	if (*name == '-')
 		return -1;
-- 
1.7.6.8.gd2879
