From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-index-merge: clarify synopsis
Date: Fri, 22 Feb 2008 08:55:29 +0000
Message-ID: <20080222085530.20537.qmail@d4fd609604fc20.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 09:56:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSTh9-0002Tm-6X
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 09:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbYBVIzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 03:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbYBVIzO
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 03:55:14 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:41471 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751001AbYBVIzN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 03:55:13 -0500
Received: (qmail 20538 invoked by uid 1000); 22 Feb 2008 08:55:30 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74704>

The options following <merge-program> are not -a, --, or <file>...,
but either -a, or -- <file>..., while -- is optional.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Documentation/git-merge-index.txt |    2 +-
 merge-index.c                     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 5d816d0..19ee017 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -8,7 +8,7 @@ git-merge-index - Run a merge for files needing merging
 
 SYNOPSIS
 --------
-'git-merge-index' [-o] [-q] <merge-program> (-a | \-- | <file>\*)
+'git-merge-index' [-o] [-q] <merge-program> (-a | [--] <file>\*)
 
 DESCRIPTION
 -----------
diff --git a/merge-index.c b/merge-index.c
index bbb700b..7491c56 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -91,7 +91,7 @@ int main(int argc, char **argv)
 	signal(SIGCHLD, SIG_DFL);
 
 	if (argc < 3)
-		usage("git-merge-index [-o] [-q] <merge-program> (-a | <filename>*)");
+		usage("git-merge-index [-o] [-q] <merge-program> (-a | [--] <filename>*)");
 
 	setup_git_directory();
 	read_cache();
-- 
1.5.4.2
