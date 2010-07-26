From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Fix 'git' wrapper usage string
Date: Mon, 26 Jul 2010 10:36:24 +0200
Message-ID: <4318a25a007ab63b34cb2e34a18e38b30332102a.1280133352.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 26 10:36:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdJB4-0008MG-DG
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 10:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455Ab0GZIgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 04:36:45 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:37812 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121Ab0GZIgp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 04:36:45 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 26 Jul
 2010 10:36:44 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.0.702.0; Mon, 26 Jul
 2010 10:36:23 +0200
X-Mailer: git-send-email 1.7.2.300.ga4b76.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151817>

8b1fa77 (Allow passing of configuration parameters in the command
line, 2010-03-26) forgot the closing ']' for the -c option.

While we're there, also rewrap.  Instead of folding the last two lines
together, try to highlight that COMMAND is required by starting a line
with it.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 1753811..f37028b 100644
--- a/git.c
+++ b/git.c
@@ -8,8 +8,8 @@
 	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path]\n"
 	"           [-p|--paginate|--no-pager] [--no-replace-objects]\n"
 	"           [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]\n"
-	"           [-c name=value\n"
-	"           [--help] COMMAND [ARGS]";
+	"           [-c name=value] [--help]\n"
+	"           COMMAND [ARGS]";
 
 const char git_more_info_string[] =
 	"See 'git help COMMAND' for more information on a specific command.";
-- 
1.7.2.300.ga4b76.dirty
