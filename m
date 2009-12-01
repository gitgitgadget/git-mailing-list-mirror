From: David Soria Parra <sn_@gmx.net>
Subject: [PATCH v2 2/2] Documentation: Add --track option to the git clone manpage
Date: Tue,  1 Dec 2009 23:51:05 +0100
Message-ID: <1259707865-6561-3-git-send-email-sn_@gmx.net>
References: <1259707865-6561-1-git-send-email-sn_@gmx.net>
Cc: David Soria Parra <dsp@php.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 23:51:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFbZ4-0005ib-QR
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 23:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbZLAWvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 17:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754527AbZLAWvK
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 17:51:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:42945 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754568AbZLAWvI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 17:51:08 -0500
Received: (qmail invoked by alias); 01 Dec 2009 22:51:14 -0000
Received: from e180068007.adsl.alicedsl.de (EHLO localhost.localdomain) [85.180.68.7]
  by mail.gmx.net (mp049) with SMTP; 01 Dec 2009 23:51:14 +0100
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX1+Y3LZRqcCYtPKSYTi/Qk10bQTjZ40kt84gcfx4K4
	JVgB/y0Jxxxw+l
X-Mailer: git-send-email 1.6.6.rc0.268.g1c272
In-Reply-To: <1259707865-6561-1-git-send-email-sn_@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134265>

From: David Soria Parra <dsp@php.net>

Signed-off-by: David Soria Parra <dsp@php.net>
---
 Documentation/git-clone.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 7ccd742..c2ab645 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git clone' [--template=<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
-	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
+	  [-o <name>] [-b <name>] [-t <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--depth <depth>] [--recursive] [--] <repository> [<directory>]
 
 DESCRIPTION
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
