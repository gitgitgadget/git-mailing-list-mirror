From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Update config file example for snapshot feature in gitweb/INSTALL
Date: Thu,  1 Nov 2007 13:45:33 +0100
Message-ID: <1193921133-17022-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 13:43:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InZOK-0004ux-Ul
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 13:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212AbXKAMnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 08:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756106AbXKAMnF
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 08:43:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:22501 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755733AbXKAMnD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 08:43:03 -0400
Received: by ug-out-1314.google.com with SMTP id z38so459698ugc
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=hY4vfjV/c6PctnKXll5YkJ28qsFz9sKqS4nWnwFKneI=;
        b=YbCTc/ncxdD1URKtUVZqcIfsvPjnqRVeZxCDNSNguPSaTrstWMO+/aXe6eLdB0i8EIpxw8peetcLyoio4Esfm9dgEtQYsTJlmNkLS4gb4cLrGN1MhKxHTN+bnHhmQsB9y8YVep5nHGSeSL+JjKK9S8+5dEZXvJc18mKuNrM0gBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=cR9cPOaim7mR8aIO9U6o8fbrvgAOUI+H8AcSUnyB0U672qRIPZqsSiDdOUOh3BqDBav967HHxFBhabAlqCdhg6X4mK+rZnGGLriVJ7OHOvmK1Ol3Mfre4Msc7/xCeye9FHkIsnt1mCTt6eWS0NsEYVx4Aexxm1WE16pr9ZU8Juw=
Received: by 10.67.32.14 with SMTP id k14mr78227ugj.1193920982284;
        Thu, 01 Nov 2007 05:43:02 -0700 (PDT)
Received: from roke.D-201 ( [83.8.199.125])
        by mx.google.com with ESMTPS id 23sm2235465ugf.2007.11.01.05.43.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 05:43:01 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lA1CjXds017037;
	Thu, 1 Nov 2007 13:45:34 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lA1CjXOQ017036;
	Thu, 1 Nov 2007 13:45:33 +0100
X-Mailer: git-send-email 1.5.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62948>

Commit a3c8ab30a54c30a6a434760bedf04548425416ef by Matt McCutchen
  "gitweb: snapshot cleanups & support for offering multiple formats"
introduced new format of $feature{'snapshot'}{'default'} value. Update
"Config file example" in gitweb/INSTALL accordingly.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/INSTALL |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 6328e26..9cd5b0a 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -116,7 +116,7 @@ GITWEB_CONFIG file:
 	$feature{'pickaxe'}{'default'} = [1];
 	$feature{'pickaxe'}{'override'} = 1;
 
-	$feature{'snapshot'}{'default'} = ['x-gzip', 'gz', 'gzip'];
+	$feature{'snapshot'}{'default'} = ['zip', 'tgz'];
 	$feature{'snapshot'}{'override'} = 1;
 
 
-- 
1.5.3.5
