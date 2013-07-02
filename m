From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH 4/4] git-blame.el: Change the default prefix format
Date: Tue,  2 Jul 2013 19:34:37 +0200
Message-ID: <1372786477-13122-5-git-send-email-sojkam1@fel.cvut.cz>
References: <1372786477-13122-1-git-send-email-sojkam1@fel.cvut.cz>
Cc: =?UTF-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>,
	Lawrence Mitchell <wence@gmx.li>,
	=?UTF-8?q?R=C3=BCdiger=20Sonderfeld?= <ruediger@c-plusplus.de>,
	Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 02 19:43:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu4bo-0007jb-5a
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 19:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319Ab3GBRnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 13:43:15 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:55258 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758Ab3GBRnO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 13:43:14 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jul 2013 13:43:14 EDT
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id BD90419F363D;
	Tue,  2 Jul 2013 19:36:01 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id 4ZVWK3VIFZ4f; Tue,  2 Jul 2013 19:35:57 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id EFCD519F3613;
	Tue,  2 Jul 2013 19:35:55 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.80)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1Uu4Ud-0003Ve-7H; Tue, 02 Jul 2013 19:35:55 +0200
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1372786477-13122-1-git-send-email-sojkam1@fel.cvut.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229405>

Now, the format resembles more the default format of `git blame`.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 contrib/emacs/git-blame.el | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 5c8933e..74b1486 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -102,7 +102,7 @@
   :group 'git-blame)
 
 (defcustom git-blame-prefix-format
-  "%h %20A:"
+  "%h %t %a"
   "The format of the prefix added to each line in `git-blame'
 mode. The format is passed to `format-spec' with the following format keys:
 
-- 
1.8.3.1
