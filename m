From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 6/6] git p4: remove unneeded cmd initialization
Date: Fri, 23 Nov 2012 17:35:39 -0500
Message-ID: <1353710139-16207-7-git-send-email-pw@padd.com>
References: <1353710139-16207-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 23:37:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc1sj-0006GD-O7
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 23:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095Ab2KWWhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 17:37:43 -0500
Received: from honk.padd.com ([74.3.171.149]:35236 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932075Ab2KWWhn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 17:37:43 -0500
Received: from arf.padd.com (unknown [50.55.150.96])
	by honk.padd.com (Postfix) with ESMTPSA id 80E73E9A;
	Fri, 23 Nov 2012 14:37:42 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 1635A27578; Fri, 23 Nov 2012 17:37:40 -0500 (EST)
X-Mailer: git-send-email 1.8.0.360.gc68af86
In-Reply-To: <1353710139-16207-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210280>

It confuses pylint, and is never needed.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 9712082..551aec9 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3188,7 +3188,6 @@ def main():
         printUsage(commands.keys())
         sys.exit(2)
 
-    cmd = ""
     cmdName = sys.argv[1]
     try:
         klass = commands[cmdName]
-- 
1.8.0.276.gd9397fc
