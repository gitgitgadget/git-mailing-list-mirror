From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Typo fix
Date: Thu, 13 Oct 2005 02:13:04 +0100
Message-ID: <20051013011304.GA31527@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 13 14:09:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ1rg-0005bJ-0s
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 14:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVJMMGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 08:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbVJMMGr
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 08:06:47 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:5385 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S1750767AbVJMMGq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 08:06:46 -0400
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9DC6iKg005452
	for <git@vger.kernel.org>; Thu, 13 Oct 2005 13:06:45 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9D1D69I001044
	for git@vger.kernel.org; Thu, 13 Oct 2005 02:13:06 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10069>

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/rsh.c b/rsh.c
--- a/rsh.c
+++ b/rsh.c
@@ -68,7 +68,7 @@ int setup_connection(int *fd_in, int *fd
 	if (!path) {
 		return error("Bad URL: %s", url);
 	}
-	/* $GIT_RSH <host> "env GIR_DIR=<path> <remote_prog> <args...>" */
+	/* $GIT_RSH <host> "env GIT_DIR=<path> <remote_prog> <args...>" */
 	sizen = COMMAND_SIZE;
 	posn = command;
 	of = 0;
