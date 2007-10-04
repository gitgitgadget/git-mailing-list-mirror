From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] git-archive: document --exec
Date: Fri, 5 Oct 2007 00:41:11 +0200
Message-ID: <200710050041.11625.barra_cuda@katamail.com>
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
	id 1IdZKO-0003zr-Q8
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 00:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760407AbXJDWht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 18:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760482AbXJDWht
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 18:37:49 -0400
Received: from slim-3a.inet.it ([213.92.5.124]:53765 "EHLO slim-3a.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760367AbXJDWhr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 18:37:47 -0400
Received: from host187-57-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.57.187]) by slim-3a.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.57.187+8nvva3R2jhI; Fri, 05 Oct 2007 00:37:45 +0200
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60016>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 Documentation/git-archive.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index e1e2d60..7cbd1c7 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git-archive' --format=<fmt> [--list] [--prefix=<prefix>/] [<extra>]
-	      [--remote=<repo>] <tree-ish> [path...]
+	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
+	      [path...]
 
 DESCRIPTION
 -----------
@@ -52,6 +53,10 @@ OPTIONS
 	Instead of making a tar archive from local repository,
 	retrieve a tar archive from a remote repository.
 
+--exec=<git-upload-archive>::
+	Used with --remote to specify the path to the
+	git-upload-archive executable on the remote side.
+
 <tree-ish>::
 	The tree or commit to produce an archive for.
 
-- 
1.5.3.4
