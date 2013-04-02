From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH V3 1/5] Show help: -a and -g option, and 'git help <concept>' usage.
Date: Tue,  2 Apr 2013 23:39:48 +0100
Message-ID: <1364942392-576-2-git-send-email-philipoakley@iee.org>
References: <1364942392-576-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	David Aguilar <davvid@gmail.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 03 00:40:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN9sB-0002tS-Ng
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 00:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933678Ab3DBWjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 18:39:42 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:25698 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933450Ab3DBWjl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 18:39:41 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmwJAPtcW1FOl3a6/2dsb2JhbABDgweCbb1WBAGBBBd0giABBVYjEAhJOR4GE4gYsWuQE41VJ4EdB4NAA6d2gS+BXTuBLg
X-IronPort-AV: E=Sophos;i="4.87,396,1363132800"; 
   d="scan'208";a="419706605"
Received: from host-78-151-118-186.as13285.net (HELO localhost) ([78.151.118.186])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 02 Apr 2013 23:39:39 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1364942392-576-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219894>

Prepare for the addition of the -g --guides option to git help
and show that help is available for both concept guides, and commands.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 git.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 39ba6b1..2f8aa41 100644
--- a/git.c
+++ b/git.c
@@ -13,7 +13,9 @@ const char git_usage_string[] =
 	"           <command> [<args>]";
 
 const char git_more_info_string[] =
-	N_("See 'git help <command>' for more information on a specific command.");
+	N_("'git help -a' and 'git help -g' lists available subcommands and some\n"
+	   "concept guides. See 'git help <command>' or 'git help <concept>'\n"
+	   "to read about a specific subcommand or concept.");
 
 static struct startup_info git_startup_info;
 static int use_pager = -1;
-- 
1.8.1.msysgit.1
