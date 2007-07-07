From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Add [verse] to the SYNOPSIS section of git-submodule.txt.
Date: Fri,  6 Jul 2007 17:56:31 -0700
Message-ID: <11837697912125-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 07 02:56:50 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6ybR-0000oL-Hy
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 02:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbXGGA4h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 20:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbXGGA4h
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 20:56:37 -0400
Received: from neon.ftbfs.org ([83.168.236.214]:45833 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950AbXGGA4g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 20:56:36 -0400
Received: from pool-71-104-149-201.lsanca.dsl-w.verizon.net ([71.104.149.201] helo=asturias.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1I6yk1-000781-JH; Fri, 06 Jul 2007 18:05:42 -0700
Received: from kraai by asturias.ftbfs.org with local (Exim 4.67)
	(envelope-from <kraai@ftbfs.org>)
	id 1I6yb9-0001dA-V0; Fri, 06 Jul 2007 17:56:31 -0700
X-Mailer: git-send-email 1.5.2.3
X-Spam-Score: -3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51794>

The SYNOPSIS section of git-submodule.txt contains two forms.  Since
it doesn't use the verse style, the line boundary between them is not
preserved and the second form can appear on the same line as the first
form.  Adding [verse] enables the verse style, which preserves the
line boundary between them.

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 Documentation/git-submodule.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 7f0904e..d76ae47 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -8,6 +8,7 @@ git-submodule - Initialize, update or inspect submodules
 
 SYNOPSIS
 --------
+[verse]
 'git-submodule' [--quiet] [-b branch] add <repository> [<path>]
 'git-submodule' [--quiet] [--cached] [status|init|update] [--] [<path>...]
 
-- 
1.5.2.3
