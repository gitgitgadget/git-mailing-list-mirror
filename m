From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH] git.c: make usage match manual page
Date: Mon, 11 Mar 2013 21:44:15 +0200
Message-ID: <1363031055-13562-1-git-send-email-kevin@bracey.fi>
Cc: Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 20:45:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF8ec-0008Oo-RX
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 20:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498Ab3CKTob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 15:44:31 -0400
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:44575 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751468Ab3CKToa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 15:44:30 -0400
X-Greylist: delayed 3178 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Mar 2013 15:44:30 EDT
Received: from mail420.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id F0692FF9339
	for <git@vger.kernel.org>; Mon, 11 Mar 2013 21:01:04 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 11 Mar 2013 21:44:25 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 11 Mar 2013 21:44:24 +0200
X-Ovh-Mailout: 178.32.228.1 (mo1.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.rc3.7.g1100d09.dirty
X-Ovh-Tracer-Id: 3753750291142709470
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 52
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrfeejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecuudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlhedvmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 52
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrfeejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecuudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlhedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217904>

Re-ordered option list in command-line usage to match the manual page.
Also makes it less than 80-characters wide.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 git.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index d33f9b3..2a98624 100644
--- a/git.c
+++ b/git.c
@@ -6,10 +6,10 @@
 #include "run-command.h"
 
 const char git_usage_string[] =
-	"git [--version] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
+	"git [--version] [--help] [-c name=value]\n"
+	"           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 	"           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]\n"
 	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
-	"           [-c name=value] [--help]\n"
 	"           <command> [<args>]";
 
 const char git_more_info_string[] =
-- 
1.8.2.rc3.7.g1100d09.dirty
