From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Documentation/git-push: --all, --mirror, --tags can not be combined
Date: Tue, 17 Feb 2009 09:25:02 +0000
Message-ID: <20090217092503.9722.qmail@2ccfa080da4224.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 10:26:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZMDv-0004R2-NW
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 10:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbZBQJZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 04:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbZBQJZI
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 04:25:08 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:2710 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750870AbZBQJZH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 04:25:07 -0500
Received: (qmail 9723 invoked by uid 1000); 17 Feb 2009 09:25:03 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110344>

While b259f09 made git-push output a better error message for 'git-push
--all --tags', this commit fixes the synopsis in the documentation.

Inconsistency spotted and fix suggested by Jari Aalto through
 http://bugs.debian.org/502567

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Documentation/git-push.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 7d1eced..ac64211 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all | --mirror] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
+'git push' [--all | --mirror | --tags] [--dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [-v | --verbose]
 	   [<repository> <refspec>...]
 
-- 
1.6.1.3
