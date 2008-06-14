From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Use 'trash directory' thoroughly in t/test-lib.sh
Date: Sat, 14 Jun 2008 20:14:12 +0200
Message-ID: <1213467252-26334-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 20:15:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7aHY-0007t0-S0
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 20:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbYFNSOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 14:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753799AbYFNSOU
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 14:14:20 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:22594 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587AbYFNSOT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 14:14:19 -0400
Received: by an-out-0708.google.com with SMTP id d40so1076466and.103
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer;
        bh=VX+s9jyGhaxZQnYMAbdnJa6Gjbh/Nem35h8ZFuT9X9c=;
        b=v7cG+koo++eaNFj3zgxoguFp88JqEETSIMi/wcR0kJatrtC+KY27FbG+HNNwac+EFy
         xRIUJoNQ0DPE/GVW/oqPyx2u3BVtNNOOhjmtw32J08ECvrnmnMWXcQejC6B4iARIP5ja
         oDZVjL4R9XtOS9uQ4hpd1WLT78VKF/vYMLQ4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=lnQJHUyy286xG20YVprou2iVziwEeU0CkAz7KN/PMX7SjNupYusxbjd7u1WYaqgq8y
         RhnXhp+loBnjawbkoaZkUqYB4JkQ2aAGIXRMXqOL1OV6ohlC8jy4zTnPNPQpaSJRwD02
         q2mnsnt6JnJSleBud02pWIwOnaw2fhBAsbd1Q=
Received: by 10.100.167.14 with SMTP id p14mr6037374ane.121.1213467258804;
        Sat, 14 Jun 2008 11:14:18 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.239.84])
        by mx.google.com with ESMTPS id c15sm7369218anc.1.2008.06.14.11.14.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 11:14:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5EIEDpQ026357;
	Sat, 14 Jun 2008 20:14:13 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5EIECv5026356;
	Sat, 14 Jun 2008 20:14:12 +0200
X-Mailer: git-send-email 1.5.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85030>

...also in comments.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
 mode change 100644 => 100755 t/test-lib.sh

diff --git a/t/test-lib.sh b/t/test-lib.sh
old mode 100644
new mode 100755
index 7a8bd27..2b83e24
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -386,7 +386,7 @@ test_done () {
 }
 
 # Test the binaries we have just built.  The tests are kept in
-# t/ subdirectory and are run in trash subdirectory.
+# t/ subdirectory and are run in 'trash directory' subdirectory.
 PATH=$(pwd)/..:$PATH
 GIT_EXEC_PATH=$(pwd)/..
 GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
-- 
1.5.5.3
