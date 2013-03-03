From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 1/5] Show 'git help <guide>' usage, with examples
Date: Sun,  3 Mar 2013 20:21:08 +0000
Message-ID: <1362342072-1412-2-git-send-email-philipoakley@iee.org>
References: <1362342072-1412-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 03 21:21:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCFPf-0001Sf-L4
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 21:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450Ab3CCUU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 15:20:58 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:60933 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753367Ab3CCUU5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Mar 2013 15:20:57 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FABGqM1FZ8rke/2dsb2JhbABFhWe8Y30Xc4IgAQVWMwhJORABDQYTiBfHAo1KgVqDQAOnMoMIgWk
X-IronPort-AV: E=Sophos;i="4.84,774,1355097600"; 
   d="scan'208";a="410723223"
Received: from host-89-242-185-30.as13285.net (HELO localhost) ([89.242.185.30])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 03 Mar 2013 20:20:55 +0000
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1362342072-1412-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217352>

The git(1) man page must be accessed via 'git help git' on Git for Windows
as it has no 'man' command. And it prompts users to read the git(1) page,
rather than hoping they follow a subsidiary link within another
documentation page. The 'tutorial' is an obvious guide to suggest.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 git.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git.c b/git.c
index b10c18b..d9b71c1 100644
--- a/git.c
+++ b/git.c
@@ -13,7 +13,9 @@ const char git_usage_string[] =
 	"           <command> [<args>]";
 
 const char git_more_info_string[] =
-	N_("See 'git help <command>' for more information on a specific command.");
+	N_("See 'git help <command>' for more information on a specific command.\n"
+	   "While 'git help <guide>', will show the selected Git concept guide.\n"
+	   "Examples: 'git help git', 'git help branch', 'git help tutorial'...");
 
 static struct startup_info git_startup_info;
 static int use_pager = -1;
-- 
1.8.1.msysgit.1
