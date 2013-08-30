From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/6] reset: trivial style cleanup
Date: Fri, 30 Aug 2013 16:56:48 -0500
Message-ID: <1377899810-1818-5-git-send-email-felipe.contreras@gmail.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 00:01:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFWlG-0006zB-9V
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 00:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756093Ab3H3WBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 18:01:39 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:40704 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665Ab3H3WBi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 18:01:38 -0400
Received: by mail-ob0-f176.google.com with SMTP id uz19so2458427obc.35
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JG4N24DqqO2ECTbPxXUsSf2WLChea2pGjBDLOwCw700=;
        b=XDOuFvlU5hCJoJ+zIKvp/JyIIf8QLP+t2THIyw4NsX41a8JFoYJr2d8pEA6pIBonob
         U8ptMBh0WKqNAyViBYJDiKjH3dLE8cze22Phw7Cq3Ldqkz+uAuJzDiAMckJj/BrdEW5n
         FZifiYui78EmpZua5TIkRgQGwERRW00shevvolrj4ceq7mJGh4HxEo1GlGC9/cOi4QD3
         G0eF0b3APLBe3ij0SpsUrt4rPmZZIwfdr9KjcyAK6mztiWcTBSYBhEPa+NwkHHu9yqWP
         oVKPtO4eAiaD/fi5Wh1m4dFj8CDwlF7gNVdPlMyda2r5LW/esjtwszvEI7A/cVMc4cEa
         LwYQ==
X-Received: by 10.182.225.162 with SMTP id rl2mr8474106obc.72.1377900098270;
        Fri, 30 Aug 2013 15:01:38 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm142895oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 15:01:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233478>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 225e3f1..7e65934 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -323,7 +323,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		die_if_unmerged_cache(reset_type);
 
 	if (reset_type != SOFT) {
-		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+		struct lock_file *lock = xcalloc(1, sizeof(*lock));
 		int newfd = hold_locked_index(lock, 1);
 		if (reset_type == MIXED) {
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
-- 
1.8.4-fc
