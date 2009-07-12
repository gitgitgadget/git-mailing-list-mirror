From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] gitweb: update Git homepage URL
Date: Sun, 12 Jul 2009 14:31:28 +0200
Message-ID: <1247401888-27185-1-git-send-email-win@wincent.com>
Cc: jnareb@gmail.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 12 14:32:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPyDw-0005NV-Kr
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 14:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbZGLMbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 08:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbZGLMby
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 08:31:54 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:58943 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbZGLMbx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 08:31:53 -0400
Received: from localhost.localdomain (13.Red-83-60-144.dynamicIP.rima-tde.net [83.60.144.13])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n6CCVkAR013723
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Jul 2009 08:31:48 -0400
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123148>

git-scm.com is now the "official" Git project page, having taken over
from git.or.cz, so update the default link accordingly. This saves a
redirect when people hit git.or.cz.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6a1b5b5..7fbd5ff 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -94,7 +94,7 @@ our $favicon = "++GITWEB_FAVICON++";
 # URI and label (title) of GIT logo link
 #our $logo_url = "http://www.kernel.org/pub/software/scm/git/docs/";
 #our $logo_label = "git documentation";
-our $logo_url = "http://git.or.cz/";
+our $logo_url = "http://git-scm.com/";
 our $logo_label = "git homepage";
 
 # source of projects list
-- 
1.6.3.3
