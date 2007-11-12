From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH,RFC 2/2] Remove hint to use "git help -a"
Date: Sun, 11 Nov 2007 19:57:57 -0500
Message-ID: <1194829077-14320-2-git-send-email-tytso@mit.edu>
References: <20071111235819.GB7392@thunk.org>
 <1194829077-14320-1-git-send-email-tytso@mit.edu>
Cc: Git Mailing List <git@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 02:00:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrNet-0004wL-Mp
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 02:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbXKLA74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 19:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbXKLA7z
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 19:59:55 -0500
Received: from thunk.org ([69.25.196.29]:60682 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbXKLA7y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 19:59:54 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IrNn8-0002jM-TA; Sun, 11 Nov 2007 20:10:34 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1IrNcj-0003jL-C7; Sun, 11 Nov 2007 19:57:57 -0500
X-Mailer: git-send-email 1.5.3.5.623.g91546-dirty
In-Reply-To: <1194829077-14320-1-git-send-email-tytso@mit.edu>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64545>

The newbie user will run away screaming when they see all possible
commands.  The expert user will already know about the -a option from
reading the git man page.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 help.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/help.c b/help.c
index 1cd33ec..f539b80 100644
--- a/help.c
+++ b/help.c
@@ -162,7 +162,6 @@ static void list_common_cmds_help(void)
 		mput_char(' ', longest - strlen(common_cmds[i].name));
 		puts(common_cmds[i].help);
 	}
-	puts("(use 'git help -a' to get a list of all installed git commands)");
 }
 
 static void show_man_page(const char *git_cmd)
-- 
1.5.3.5.623.g91546-dirty
