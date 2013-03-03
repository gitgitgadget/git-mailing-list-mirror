From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 2/5] Help.c use OPT_COUNTUP
Date: Sun,  3 Mar 2013 23:44:17 +0000
Message-ID: <1362354260-3772-3-git-send-email-philipoakley@iee.org>
References: <1362354260-3772-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	David Aguilar <davvid@gmail.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 04 00:44:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCIZn-0005LE-Af
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 00:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788Ab3CCXnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 18:43:42 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:45559 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754763Ab3CCXni (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Mar 2013 18:43:38 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAMTAM1FZ8rke/2dsb2JhbABFhWe8Y30Xc4IgAQVWIxAISTkeBhOIF8cPjUqBUweDQAOgKocIgwiBaQ
X-IronPort-AV: E=Sophos;i="4.84,774,1355097600"; 
   d="scan'208";a="420384605"
Received: from host-89-242-185-30.as13285.net (HELO localhost) ([89.242.185.30])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 03 Mar 2013 23:43:36 +0000
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1362354260-3772-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217375>

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
