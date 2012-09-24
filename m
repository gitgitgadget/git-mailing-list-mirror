From: "Jonathan \"Duke\" Leto" <jonathan@leto.net>
Subject: [PATCH] Improve the description of GIT_PS1_SHOWUPSTREAM
Date: Mon, 24 Sep 2012 10:41:26 -0700
Message-ID: <1348508486-63176-1-git-send-email-jonathan@leto.net>
Cc: "Jonathan \"Duke\" Leto" <jonathan@leto.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 19:41:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGCfM-0004tm-WB
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 19:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755403Ab2IXRls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 13:41:48 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33797 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757311Ab2IXRlr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 13:41:47 -0400
Received: by pbbrr4 with SMTP id rr4so7551401pbb.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=xgs0oYTTi4wzfaVMRfjx0/VRUZC1Lniay8pvBPz9tZM=;
        b=UfPWxpLUGHz0QfMJWzwL+ojalHqodLUJYU5DXbPA//RuJ/tMaWv031YlfWo7IaO5h4
         /PM70M/kqtpUasjs3AsvugOlMMgOaNsb8mbr00p83MeSJyhzC2Y81JYdcXbbLAqx6k5U
         s0/CN7ylBjjZt1/0M57KW4ZP2010m2nAFccAkxj0yUwDwFjhfK/4CwKOU6YFPdp4BjfZ
         +b0aT70TJzAT7fC8LJmoccAGCgMf91K6V6Pn/h4xAMNqBYYKDQb7VhDI00fY1Ya6QGAk
         rh357bS6uwPBqjk8B0RYoObcoG55VRW7fUyX8y0hY6MHi8C+p59t/Gj+LVKXd4yvM/pt
         n1ig==
Received: by 10.68.129.72 with SMTP id nu8mr22925926pbb.29.1348508507227;
        Mon, 24 Sep 2012 10:41:47 -0700 (PDT)
Received: from localhost.localdomain (c-76-105-213-157.hsd1.or.comcast.net. [76.105.213.157])
        by mx.google.com with ESMTPS id kt1sm9937701pbc.45.2012.09.24.10.41.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 24 Sep 2012 10:41:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.397.gbdf37ee
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206300>

From: "Jonathan \"Duke\" Leto" <jonathan@leto.net>

Describe what '=' means in the output of __git_ps1 when using
GIT_PS1_SHOWUPSTREAM, which was not previously described.

Signed-off-by: Jonathan "Duke" Leto <jonathan@leto.net>
---
 contrib/completion/git-prompt.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 29b1ec9..bf20491 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -34,9 +34,10 @@
 #
 # If you would like to see the difference between HEAD and its upstream,
 # set GIT_PS1_SHOWUPSTREAM="auto".  A "<" indicates you are behind, ">"
-# indicates you are ahead, and "<>" indicates you have diverged.  You
-# can further control behaviour by setting GIT_PS1_SHOWUPSTREAM to a
-# space-separated list of values:
+# indicates you are ahead, "<>" indicates you have diverged and "="
+# indicates that there is no difference. You can further control
+# behaviour by setting GIT_PS1_SHOWUPSTREAM to a space-separated list
+# of values:
 #
 #     verbose       show number of commits ahead/behind (+/-) upstream
 #     legacy        don't use the '--count' option available in recent
-- 
1.7.12.1.397.gbdf37ee
