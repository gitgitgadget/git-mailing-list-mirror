From: Neil Roberts <bpeeluk@yahoo.co.uk>
Subject: [PATCH] config.mak.in: Pass on LDFLAGS from configure
Date: Thu, 21 Aug 2008 20:38:23 +0100
Message-ID: <20080821193823.GA13293@janet.wally>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 21:39:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWG0C-0004qE-TC
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 21:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222AbYHUTiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 15:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756272AbYHUTiV
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 15:38:21 -0400
Received: from smtpout.karoo.kcom.com ([212.50.160.34]:57004 "EHLO
	smtpout.karoo.kcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755003AbYHUTiU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 15:38:20 -0400
X-IronPort-AV: E=Sophos;i="4.32,246,1217804400"; 
   d="scan'208";a="22550567"
Received: from unknown (HELO localhost) ([91.84.60.59])
  by smtpout.karoo.kcom.com with ESMTP; 21 Aug 2008 20:33:49 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93189>

The configure script allows you to specify flags to pass to the linker
step in the LDFLAGS environment variable but this was being ignored in
the Makefile. Now a make variable gets set to the value passed down
from the configure script.

Signed-off-by: Neil Roberts <bpeeluk@yahoo.co.uk>
---

I'm sending this again because I am incompetent. Sorry.

 config.mak.in |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index b776149..f67d673 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -3,6 +3,7 @@
 
 CC = @CC@
 CFLAGS = @CFLAGS@
+LDFLAGS = @LDFLAGS@
 AR = @AR@
 TAR = @TAR@
 #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
-- 
1.5.4.3
