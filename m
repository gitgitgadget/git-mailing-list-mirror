From: Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH/RFC 2/7] contrib/subtree: Ignore testing directory
Date: Sun, 13 Jan 2013 09:52:33 +0800
Message-ID: <1358041958-1998-3-git-send-email-techlivezheng@gmail.com>
References: <1358041958-1998-1-git-send-email-techlivezheng@gmail.com>
Cc: apenwarr@gmail.com, greened@obbligato.org,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 13 02:59:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuCrC-0000w2-VM
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 02:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315Ab3AMB7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 20:59:07 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:47442 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab3AMB7F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 20:59:05 -0500
Received: by mail-pb0-f49.google.com with SMTP id un15so1578938pbc.36
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 17:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=UUsAa2LTT7GUU+5e/yE5c3Y9+UggYxTMx/08MwvtChk=;
        b=TXPNKhCqYTkKSQQt2ZY3F+D+lYHowU/tsLNFHjd/m/c5B6GyFuU547FwSgEMI1OyuC
         UYZ1AgxcWQWlpDZm5UGTX/4IutAENt9CrXyzCqAVbHcROiJIRIbiYGV3SDl8BZ75JJ34
         U+ZkOpTvG0vsgSKbAjPweAC6p2hZDAtPl1vifO2kkF3+gSS4OvvJWkLB4h2+yqy9bSTv
         arnnXf4mc9jhKzWliZFVQvvnDYZRicv6A6H7nMpZhLLMbBtIkcvT8ux6CD0JBHR0dAHA
         Ju13E05VXK6tzS6Kd148+fnvK7jEzEatxt3GBVRQm+1ahTclWHv91CwX40WL8CuA7KoK
         7Rgg==
X-Received: by 10.68.132.98 with SMTP id ot2mr241229226pbb.39.1358042345344;
        Sat, 12 Jan 2013 17:59:05 -0800 (PST)
Received: from home.techlive.me ([122.244.155.16])
        by mx.google.com with ESMTPS id d8sm5908882pax.23.2013.01.12.17.59.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Jan 2013 17:59:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <1358041958-1998-1-git-send-email-techlivezheng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213323>

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
---
 contrib/subtree/.gitignore | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/.gitignore b/contrib/subtree/.gitignore
index 91360a3..59aeeb4 100644
--- a/contrib/subtree/.gitignore
+++ b/contrib/subtree/.gitignore
@@ -1,6 +1,5 @@
 *~
 git-subtree
-git-subtree.xml
 git-subtree.1
-mainline
-subproj
+git-subtree.xml
+t/trash\ directory.*
-- 
1.8.1
