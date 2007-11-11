From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/6] push: mention --verbose option in documentation
Date: Sun, 11 Nov 2007 15:01:43 +0100
Message-ID: <11947897083381-git-send-email-prohaska@zib.de>
References: <1194789708646-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:06:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrDRg-0003eX-Ti
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 15:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbXKKOFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 09:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbXKKOFg
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 09:05:36 -0500
Received: from mailer.zib.de ([130.73.108.11]:58094 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbXKKOFf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 09:05:35 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lABE1mhu021595;
	Sun, 11 Nov 2007 15:04:43 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lABE1mlV027967;
	Sun, 11 Nov 2007 15:01:48 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <1194789708646-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64462>

From: Steffen Prohaska <gitster@pobox.com>

Before this commit, only '-v' was documented.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/git-push.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index e5dd4c1..4a68aab 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-push' [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
-           [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]
+           [--repo=all] [-f | --force] [-v | --verbose] [<repository> <refspec>...]
 
 DESCRIPTION
 -----------
@@ -95,7 +95,7 @@ the remote repository.
 	transfer spends extra cycles to minimize the number of
 	objects to be sent and meant to be used on slower connection.
 
--v::
+-v, \--verbose::
 	Run verbosely.
 
 include::urls-remotes.txt[]
-- 
1.5.3.5.578.g886d
