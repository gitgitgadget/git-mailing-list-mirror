From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] git-reflog: document --verbose
Date: Thu, 4 Oct 2007 14:26:54 +0200
Message-ID: <200710041426.54195.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:37:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdZKO-0003zr-2u
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 00:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760393AbXJDWhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 18:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760394AbXJDWhr
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 18:37:47 -0400
Received: from slim-3a.inet.it ([213.92.5.124]:53746 "EHLO slim-3a.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759081AbXJDWhr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 18:37:47 -0400
Received: from host187-57-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.57.187]) by slim-3a.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.57.187+BCGX2Mb5TJq; Fri, 05 Oct 2007 00:37:43 +0200
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60017>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 Documentation/git-reflog.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 5180f68..5c7316c 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -16,7 +16,7 @@ The command takes various subcommands, and different options
 depending on the subcommand:
 
 [verse]
-git reflog expire [--dry-run] [--stale-fix]
+git reflog expire [--dry-run] [--stale-fix] [--verbose]
 	[--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...
 
 git reflog [show] [log-options]
@@ -68,6 +68,9 @@ them.
 --all::
 	Instead of listing <refs> explicitly, prune all refs.
 
+--verbose::
+	Print extra information on screen.
+
 Author
 ------
 Written by Junio C Hamano <junkio@cox.net>
-- 
1.5.3.4
