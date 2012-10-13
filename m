From: Richard Fearn <richardfearn@gmail.com>
Subject: [PATCH] Fix spelling error in post-receive-email hook
Date: Sat, 13 Oct 2012 23:14:04 +0100
Message-ID: <CAA-kXAG5wkQQ=nxHoKq_LtE7cNUD0sLdKkW-YbNUW3d5JTmGUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 00:14:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TN9yT-0004ZD-5m
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 00:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200Ab2JMWOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 18:14:07 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45296 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166Ab2JMWOG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 18:14:06 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3881387obb.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 15:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ZtSxOZSsLbbKPr0rLQIJ2SGj9gzH/RvqOwtuFZyEBoU=;
        b=KfcwpDVGy0ochxw2b6+OzyAAs8QDdme0+ko9OKGV6f9yRAEelF5S8MCcWdUchKZIfA
         1Py8pEiWfMdCBG73bF2oPzccHKKXLO4eWIQN4meSE39FILxNNoTCUsfE8OaUJYnIaUdu
         COPyN1NY23JyefLz1P+Uts/GdwzQ8Ul/2lPYp+xcdU9aBxOLPFInBoP2s2S+u9d5Wp1w
         tMeahs234EZ2Lbu5/ZiF0VkiiV+SVMG+4RsXkbDHviFfgClvk7UqNpwJQ35/fqWzH6c4
         /FBI59UOYnjYIXGV3meawMPjLY9cymnsF6vp4SJQTL50bht7vwx82MZtv7OgdCRq8tYr
         Fn0g==
Received: by 10.60.172.233 with SMTP id bf9mr6303218oec.99.1350166444803; Sat,
 13 Oct 2012 15:14:04 -0700 (PDT)
Received: by 10.182.4.147 with HTTP; Sat, 13 Oct 2012 15:14:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207582>

Signed-off-by: Richard Fearn <richardfearn@gmail.com>
---
 contrib/hooks/post-receive-email | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 01af9df..b2171a0 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -403,7 +403,7 @@ generate_update_branch_email()
 			echo "            \\"
 			echo "             O -- O -- O ($oldrev)"
 			echo ""
-			echo "The removed revisions are not necessarilly gone - if another
reference"
+			echo "The removed revisions are not necessarily gone - if another reference"
 			echo "still refers to them they will stay in the repository."
 			rewind_only=1
 		else
-- 
1.7.11.7
