From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Adjust .gitignore for 5884f1(Rename
 'git-help--browse.sh'...)
Date: Fri, 8 Feb 2008 13:33:51 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802081333060.11591@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 08 14:34:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNTMw-0004tQ-MA
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 14:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272AbYBHNdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 08:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755127AbYBHNdp
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 08:33:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:45029 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754508AbYBHNdp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 08:33:45 -0500
Received: (qmail invoked by alias); 08 Feb 2008 13:33:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 08 Feb 2008 14:33:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7gpJWwlT7ciSkmRBL9pcf9J59K3vxZu64CUtzmP
	H07XdDC0K+O95c
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73087>


Since git-help--browse was renamed, we should ignore git-web--browse
instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index 1a73de0..a85d2e7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -51,7 +51,6 @@ git-gc
 git-get-tar-commit-id
 git-grep
 git-hash-object
-git-help--browse
 git-http-fetch
 git-http-push
 git-imap-send
@@ -137,6 +136,7 @@ git-upload-pack
 git-var
 git-verify-pack
 git-verify-tag
+git-web--browse
 git-whatchanged
 git-write-tree
 git-core-*/?*
-- 
1.5.4.1261.g18335
