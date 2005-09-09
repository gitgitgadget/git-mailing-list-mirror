From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: [PATCH] remove duplicate git-send-email-script.perl target in Makefile
Date: Fri, 9 Sep 2005 20:08:50 +0200
Message-ID: <20050909180850.GA14072@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Fri Sep 09 20:11:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDnJ7-0007cE-Mh
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 20:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbVIISIz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Sep 2005 14:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbVIISIz
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Sep 2005 14:08:55 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:12432 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1030310AbVIISIy
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 9 Sep 2005 14:08:54 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.52)
	id 1EDnIw-0003fW-H6
	for git@vger.kernel.org; Fri, 09 Sep 2005 20:08:50 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8248>

Remove duplicate git-send-email-perl target in Makefile.

When WITH_SEND_EMAIL was defined, as in the Debian 'deb' target,
git-send-email-perl was added twice to SCRIPT_PERL, leading to a
duplicate definition in the Makefile. Creating a ".deb" then failed.

Signed-off-by: Marco Roeland <marco.roeland@xs4all.nl>
---

 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

922fb98e1c1cfed0c5075256f328fd8d01587c61
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -77,7 +77,7 @@ SCRIPT_SH = \
 
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
-	git-rename.perl git-send-email.perl git-shortlog.perl
+	git-rename.perl git-shortlog.perl
 
 # The ones that do not have to link with lcrypto nor lz.
 SIMPLE_PROGRAMS = \
