From: David Soria Parra <sn_@gmx.net>
Subject: [PATCH 2/2] Documentation: Add --track option to the git clone manpage
Date: Mon, 30 Nov 2009 14:16:44 +0100
Message-ID: <1259587004-14633-3-git-send-email-sn_@gmx.net>
References: <1259587004-14633-1-git-send-email-sn_@gmx.net>
Cc: David Soria Parra <dsp@php.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 14:17:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF67v-0006Zw-2H
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 14:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbZK3NQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 08:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752305AbZK3NQr
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 08:16:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:39437 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752295AbZK3NQq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 08:16:46 -0500
Received: (qmail invoked by alias); 30 Nov 2009 13:16:51 -0000
Received: from e180064012.adsl.alicedsl.de (EHLO localhost.localdomain) [85.180.64.12]
  by mail.gmx.net (mp012) with SMTP; 30 Nov 2009 14:16:51 +0100
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX19xVe1Xvi5xUbE4Tp++7qkU5y/X0fpI7+oW81YLUP
	GLbc+06ex5lhqS
X-Mailer: git-send-email 1.6.6.rc0.268.g1c272
In-Reply-To: <1259587004-14633-1-git-send-email-sn_@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134099>

From: David Soria Parra <dsp@php.net>

Signed-off-by: David Soria Parra <dsp@php.net>
---
 Documentation/git-clone.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 7e7d9fc..3c2e1b8 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git clone' [--template=<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--depth <depth>] [--recursive] [--] <repository> [<directory>]
+	  [-t <name>] [--depth <depth>] [--recursive] [--] <repository> [<directory>]
 
 DESCRIPTION
 -----------
@@ -135,6 +135,12 @@ objects from the source repository into a pack in the cloned repository.
 	instead. In a non-bare repository, this is the branch that will
 	be checked out.
 
+--track <name>::
+-t <name>::
+	Instead of cloning the complete remote repository, only the given
+	remote branch `<name>` will be tracked and checked out.
+	This implies --branch `<name>`.
+
 --upload-pack <upload-pack>::
 -u <upload-pack>::
 	When given, and the repository to clone from is accessed
-- 
1.6.6.rc0.268.g1c272
