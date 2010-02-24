From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] commit: quote the user name in the example
Date: Tue, 23 Feb 2010 18:54:09 -0800
Message-ID: <1266980049-5835-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 04:17:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk7kQ-000857-V9
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 04:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518Ab0BXDRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 22:17:09 -0500
Received: from zoom.lafn.ORG ([206.117.18.8]:45489 "EHLO zoom.lafn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754434Ab0BXDRH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 22:17:07 -0500
X-Greylist: delayed 1347 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Feb 2010 22:17:07 EST
Received: from macbookpro (pool-71-254-176-161.lsanca.fios.verizon.net [71.254.176.161])
	(authenticated bits=0)
	by zoom.lafn.org (8.14.3/8.14.2) with ESMTP id o1O2sIss043151
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 23 Feb 2010 18:54:19 -0800 (PST)
	(envelope-from kraai@ftbfs.org)
Received: from kraai by macbookpro with local (Exim 4.71)
	(envelope-from <kraai@ftbfs.org>)
	id 1Nk7O8-0001X3-Et; Tue, 23 Feb 2010 18:54:12 -0800
X-Mailer: git-send-email 1.7.0
X-Virus-Scanned: clamav-milter 0.95.3 at zoom.lafn.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140893>

If the user runs

 git config --global user.name Your Name

as suggested, user.name will be set to "Your".  With this patch, the
suggested command will be

 git config --global user.name 'Your Name'

which will set user.name to "Your Name" and hopefully help users avoid
the former mistake.

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 builtin-commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 55676fd..1ec89d1 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -41,7 +41,7 @@ static const char implicit_ident_advice[] =
 "on your username and hostname. Please check that they are accurate.\n"
 "You can suppress this message by setting them explicitly:\n"
 "\n"
-"    git config --global user.name Your Name\n"
+"    git config --global user.name 'Your Name'\n"
 "    git config --global user.email you@example.com\n"
 "\n"
 "If the identity used for this commit is wrong, you can fix it with:\n"
-- 
1.7.0
