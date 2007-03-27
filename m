From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Makefile: remove test-chmtime program in target clean.
Date: Tue, 27 Mar 2007 09:38:43 +0000
Message-ID: <20070327093843.14074.qmail@7a32cdb4370c3b.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 11:39:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW89G-0000SO-UB
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 11:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466AbXC0JjY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 05:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464AbXC0JjY
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 05:39:24 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:46363 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753466AbXC0JjX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 05:39:23 -0400
Received: (qmail 14075 invoked by uid 1000); 27 Mar 2007 09:38:43 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43243>

While running 'make test', the test-chmtime program is created, and should
be cleaned up on 'make clean'.
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 51c1fed..9b988a5 100644
--- a/Makefile
+++ b/Makefile
@@ -963,7 +963,7 @@ dist-doc:
 
 clean:
 	rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
-		$(LIB_FILE) $(XDIFF_LIB)
+		test-chmtime $(LIB_FILE) $(XDIFF_LIB)
 	rm -f $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
 	rm -rf autom4te.cache
-- 
1.5.1-rc2.GIT
