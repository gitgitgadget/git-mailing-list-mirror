From: Michael Krelin <hacker@klever.net>
Subject: [PATCH] git-svn: favor ~/.subversion/ ssl client cert settings
Date: Fri, 22 Jun 2007 01:15:43 +0200
Message-ID: <11824677432401-git-send-email-hacker@klever.net>
Cc: Michael Krelin <hacker@klever.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 01:59:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1WYU-00087c-UO
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 01:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbXFUX7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 19:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbXFUX7J
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 19:59:09 -0400
Received: from argo.arachnion.zzZZzz.net ([62.27.45.185]:39389 "EHLO
	argo.arachnion.zzZZzz.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbXFUX7I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 19:59:08 -0400
X-Greylist: delayed 1784 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jun 2007 19:59:08 EDT
Received: from pd953b8fa.dip0.t-ipconnect.de ([217.83.184.250] helo=olympus.klever.net)
	by argo.arachnion.zzZZzz.net with esmtpa (Exim 4.42)
	id 1I1Vtd-0002cj-7Y; Fri, 22 Jun 2007 01:17:01 +0200
Received: from hacker by olympus.klever.net with local (Exim 4.60)
	(envelope-from <hacker@olympus.klever.net>)
	id 1I1VsN-0004WL-9q; Fri, 22 Jun 2007 01:15:43 +0200
X-Mailer: git-send-email 1.5.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50659>

---
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 50128d7..9dfea97 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2925,6 +2925,7 @@ sub new {
 	    SVN::Client::get_ssl_server_trust_file_provider(),
 	    SVN::Client::get_simple_prompt_provider(
 	      \&Git::SVN::Prompt::simple, 2),
+	    SVN::Client::get_ssl_client_cert_file_provider(),
 	    SVN::Client::get_ssl_client_cert_prompt_provider(
 	      \&Git::SVN::Prompt::ssl_client_cert, 2),
 	    SVN::Client::get_ssl_client_cert_pw_prompt_provider(
-- 
1.5.2.2
