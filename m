From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH] git-send-email: fix missing space in error message
Date: Fri, 29 Apr 2011 20:23:24 +0200
Message-ID: <1304101404-4571-1-git-send-email-sylvain@abstraction.fr>
Cc: Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 20:23:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFsLz-0003gU-Dm
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 20:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757216Ab1D2SXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 14:23:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44741 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755762Ab1D2SXa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 14:23:30 -0400
Received: by wya21 with SMTP id 21so3027322wya.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 11:23:29 -0700 (PDT)
Received: by 10.216.59.147 with SMTP id s19mr508168wec.51.1304101409211;
        Fri, 29 Apr 2011 11:23:29 -0700 (PDT)
Received: from localhost.localdomain ([85.69.155.32])
        by mx.google.com with ESMTPS id n2sm1489638wej.22.2011.04.29.11.23.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2011 11:23:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172487>

Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 76565de..98ab33a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1091,7 +1091,7 @@ X-Mailer: git-send-email $gitversion
 			    "VALUES: server=$smtp_server ",
 			    "encryption=$smtp_encryption ",
 			    "hello=$smtp_domain",
-			    defined $smtp_server_port ? "port=$smtp_server_port" : "";
+			    defined $smtp_server_port ? " port=$smtp_server_port" : "";
 		}
 
 		if (defined $smtp_authuser) {
-- 
1.7.5
