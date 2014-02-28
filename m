From: Sandy Carter <sandy.carter@savoirfairelinux.com>
Subject: [PATCH] i18n: proposed command missing leading dash
Date: Fri, 28 Feb 2014 15:52:46 -0500
Message-ID: <1393620766-17582-1-git-send-email-sandy.carter@savoirfairelinux.com>
Cc: Sandy Carter <sandy.carter@savoirfairelinux.com>, jn.avila@free.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 21:57:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJUUr-0005fi-Du
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 21:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbaB1U5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 15:57:25 -0500
Received: from mail.savoirfairelinux.com ([209.172.62.77]:58971 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbaB1U5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 15:57:24 -0500
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2014 15:57:24 EST
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 47C7610D73F5;
	Fri, 28 Feb 2014 15:51:10 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7xngqMk3A5QQ; Fri, 28 Feb 2014 15:51:10 -0500 (EST)
Received: from scarter-X220.mtl.sfl (mtl.savoirfairelinux.net [208.88.110.46])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 09B3A10D73F2;
	Fri, 28 Feb 2014 15:51:10 -0500 (EST)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243016>

Add missing leading dash to proposed commands in french output when
using the command:
git branch --set-upstream remotename/branchname

Signed-off-by: Sandy Carter <sandy.carter@savoirfairelinux.com>
---
 po/fr.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/fr.po b/po/fr.po
index e10263f..7b44229 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -3266,7 +3266,7 @@ msgstr "    git branch -d %s\n"
 #: builtin/branch.c:1027
 #, c-format
 msgid "    git branch --set-upstream-to %s\n"
-msgstr "    git branch -set-upstream-to %s\n"
+msgstr "    git branch --set-upstream-to %s\n"
 
 #: builtin/bundle.c:47
 #, c-format
-- 
1.9.0
