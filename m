From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 2/5] Help.c use OPT_COUNTUP
Date: Sun,  3 Mar 2013 20:21:09 +0000
Message-ID: <1362342072-1412-3-git-send-email-philipoakley@iee.org>
References: <1362342072-1412-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 03 21:21:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCFPt-0001hv-Hi
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 21:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab3CCUVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 15:21:14 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:63751 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753408Ab3CCUU6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Mar 2013 15:20:58 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah0FAPWUM1FZ8rke/2dsb2JhbABEhWe8Y30Xc4IgAQVWMwhJOR4GE4gXxwONSoFag0ADoCqHCIMIgWk
X-IronPort-AV: E=Sophos;i="4.84,774,1355097600"; 
   d="scan'208";a="420950758"
Received: from host-89-242-185-30.as13285.net (HELO localhost) ([89.242.185.30])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 03 Mar 2013 20:20:56 +0000
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1362342072-1412-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217356>

rename deprecated option in preparation for 'git help --guides'.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 builtin/help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/help.c b/builtin/help.c
index d1d7181..d10cbed 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -39,7 +39,7 @@ static int show_all = 0;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static struct option builtin_help_options[] = {
-	OPT_BOOLEAN('a', "all", &show_all, N_("print all available commands")),
+	OPT_COUNTUP('a', "all", &show_all, N_("print all available commands")),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
 			HELP_FORMAT_WEB),
-- 
1.8.1.msysgit.1
