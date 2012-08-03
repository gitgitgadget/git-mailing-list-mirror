From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-remote-mediawiki: replace TODO-list in comment by appropriate link
Date: Fri,  3 Aug 2012 10:40:23 +0200
Message-ID: <1343983223-20592-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 03 10:40:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxDR0-0001Un-PL
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 10:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab2HCIke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 04:40:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35120 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846Ab2HCIkb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 04:40:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q738bbZq031348
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 3 Aug 2012 10:37:37 +0200
Received: from fema.imag.fr ([129.88.43.130])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SxDQo-0006R6-IV; Fri, 03 Aug 2012 10:40:26 +0200
Received: from moy by fema.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SxDQo-0005Mm-GM; Fri, 03 Aug 2012 10:40:26 +0200
X-Mailer: git-send-email 1.7.12.rc0.32.g9fb4847.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 03 Aug 2012 10:37:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q738bbZq031348
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1344587859.38771@Mfrm796q4ZOGn6L1BSU4PA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202821>

My account on Github is now used as wiki and issue tracking. This will be
more flexible than in-tree management of a TODO-list.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 8647c92..68555d4 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -9,20 +9,7 @@
 # License: GPL v2 or later
 
 # Gateway between Git and MediaWiki.
-#   https://github.com/Bibzball/Git-Mediawiki/wiki
-#
-# Known limitations:
-#
-# - Several strategies are provided to fetch modifications from the
-#   wiki, but no automatic heuristics is provided, the user has
-#   to understand and chose which strategy is appropriate for him.
-#
-# - Git renames could be turned into MediaWiki renames (see TODO
-#   below)
-#
-# - No way to import "one page, and all pages included in it"
-#
-# - Multiple remote MediaWikis have not been very well tested.
+# Documentation & bugtracker: https://github.com/moy/Git-Mediawiki/
 
 use strict;
 use MediaWiki::API;
-- 
1.7.12.rc0.32.g9fb4847.dirty
