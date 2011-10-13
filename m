From: mhagger@alum.mit.edu
Subject: [PATCH 06/14] resolve_gitlink_ref(): improve docstring
Date: Thu, 13 Oct 2011 09:58:27 +0200
Message-ID: <1318492715-5931-7-git-send-email-mhagger@alum.mit.edu>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 09:59:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REGCA-0001qc-UQ
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 09:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615Ab1JMH7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 03:59:09 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:34360 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587Ab1JMH7G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 03:59:06 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1REG6O-0002Mo-Nx; Thu, 13 Oct 2011 09:53:16 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183449>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/refs.h b/refs.h
index c6b8749..d9c90cf 100644
--- a/refs.h
+++ b/refs.h
@@ -132,7 +132,11 @@ extern char *shorten_unambiguous_ref(const char *refname, int strict);
 /** rename ref, return 0 on success **/
 extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
 
-/** resolve ref in nested "gitlink" repository */
+/**
+ * Resolve refname in the nested "gitlink" repository that is located
+ * at name.  If the resolution is successful, return 0 and set sha1 to
+ * the name of the object; otherwise, return a non-zero value.
+ */
 extern int resolve_gitlink_ref(const char *name, const char *refname, unsigned char *sha1);
 
 /** lock a ref and then write its file */
-- 
1.7.7.rc2
