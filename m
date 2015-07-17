From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] branch: fix usage string for specific git-branch options
Date: Fri, 17 Jul 2015 20:17:00 +0200
Message-ID: <1437157020-16672-1-git-send-email-ralf.thielow@gmail.com>
Cc: Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 20:17:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGAC9-0001dS-IN
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 20:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbbGQSRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 14:17:08 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35023 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbbGQSRH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 14:17:07 -0400
Received: by wgav7 with SMTP id v7so22614694wga.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 11:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=L11GUgmxfC/y8TUQi5N5saO6d2OWKoqu/aY8ZYGXOYA=;
        b=JpMLonWiFsgYuXilbiM7dubDj4AEqKyytd3kjX5pGIPVS04JdtAO//D7lXhFpl15YT
         p60UPEW9uL4qwy9cA2QWjR4hCLFlNyUpMNlQ5fnK5qFTSb1G2iJ0R1XYxlNubs+00in1
         XdPswz2ZW1fCqHmRLmQhAG9xteWP4GwsXbfasPtkhqUb0TJQEVJUwZmQhU64wUjLcmGY
         0SIHZnQiMZwS5g3QzkWhKHq4lMBwTSUTQ/aehkaxk4D2GzLU8ErFVHBfD8Ou1GZlIPGA
         K4v/nU+eGKYcQAQu+ZTI9r6jYvTGGxsEp18LGGf1E5+B6IqnnrtvqtdW34sjxehqwne0
         cS/w==
X-Received: by 10.194.206.65 with SMTP id lm1mr32378753wjc.117.1437157026041;
        Fri, 17 Jul 2015 11:17:06 -0700 (PDT)
Received: from localhost ([95.168.155.35])
        by smtp.gmail.com with ESMTPSA id e7sm9506756wib.22.2015.07.17.11.17.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 11:17:05 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.379.ga7d8b34
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274094>

The usage string of git-branch shows generic options and specific
options. However, the specific options are called "actions".
Call them both options.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 1d15037..709dfc4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -844,7 +844,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		},
 		OPT__ABBREV(&abbrev),
 
-		OPT_GROUP(N_("Specific git-branch actions:")),
+		OPT_GROUP(N_("Specific git-branch options:")),
 		OPT_SET_INT('a', "all", &kinds, N_("list both remote-tracking and local branches"),
 			REF_REMOTE_BRANCH | REF_LOCAL_BRANCH),
 		OPT_BIT('d', "delete", &delete, N_("delete fully merged branch"), 1),
-- 
2.5.0.rc2.379.ga7d8b34
