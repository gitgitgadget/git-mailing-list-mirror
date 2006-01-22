From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Document git-ls-files --directory
Date: Sun, 22 Jan 2006 01:22:30 +0100
Message-ID: <20060122002230.6662.18396.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 22 01:21:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0Sye-0004mU-5c
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 01:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWAVAVA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 19:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWAVAVA
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 19:21:00 -0500
Received: from w241.dkm.cz ([62.24.88.241]:33968 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751242AbWAVAU7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 19:20:59 -0500
Received: (qmail 6680 invoked from network); 22 Jan 2006 01:22:30 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 22 Jan 2006 01:22:30 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15032>

Add the appropriate bit of documentation.

I did not review GIT patches for missing documentation updates during
Christmas and around the New Year, but I guess that I will have to start
again. ;-)

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-ls-files.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index e42af5e..e433407 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -46,6 +46,10 @@ OPTIONS
 -s|--stage::
 	Show stage files in the output
 
+--directory::
+	If a whole directory is classified as "other", show just its
+	name (with a trailing slash) and not its whole contents.
+
 -u|--unmerged::
 	Show unmerged files in the output (forces --stage)
 
