From: "Carlos R. Mafra" <crmafra@aei.mpg.de>
Subject: [PATCH] Makefile: clean block-sha1/ directory instead of
	mozilla-sha1/
Date: Sun, 11 Oct 2009 15:32:19 +0200
Message-ID: <20091011133219.GA28070@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 16:04:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwz28-0005jW-Rv
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 16:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517AbZJKOCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 10:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754458AbZJKOCu
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 10:02:50 -0400
Received: from ox1.aei.mpg.de ([194.94.224.6]:44268 "EHLO ox1.aei.mpg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754286AbZJKOCu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 10:02:50 -0400
X-Greylist: delayed 1716 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Oct 2009 10:02:49 EDT
Received: from Pilar.aei.mpg.de (unknown [172.18.254.253])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ox1.aei.mpg.de (Postfix) with ESMTP id 44B3A8853BD77
	for <git@vger.kernel.org>; Sun, 11 Oct 2009 15:33:36 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129926>


'make clean' should remove the object files from block-sha1/
instead of the non-existent mozilla-sha1/ directory.

Signed-off-by: Carlos R. Mafra <crmafra@aei.mpg.de>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index fea237b..42b7d60 100644
--- a/Makefile
+++ b/Makefile
@@ -1827,7 +1827,7 @@ distclean: clean
 	$(RM) configure
 
 clean:
-	$(RM) *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
+	$(RM) *.o block-sha1/*.o arm/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
 		$(LIB_FILE) $(XDIFF_LIB)
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
-- 
1.6.5
