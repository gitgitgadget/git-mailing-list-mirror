From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: [PATCH] Document git-clone --use-separate-remote
Date: Thu, 8 Jun 2006 08:50:09 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060608065009.GA4173@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 08 08:50:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoELR-0001gG-AF
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 08:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWFHGuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 02:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWFHGuN
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 02:50:13 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:20408 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S932538AbWFHGuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 02:50:11 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FoELK-00015Z-9C
	for git@vger.kernel.org; Thu, 08 Jun 2006 08:50:10 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k586oAr04292
	for git@vger.kernel.org; Thu, 8 Jun 2006 08:50:10 +0200 (MEST)
To: git@vger.kernel.org
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21472>

Signed-off-by: Uwe Zeisberger <uzeisberger@io.fsforth.de>
---
 Documentation/git-clone.txt |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 94d9393..7572e4b 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git-clone' [--template=<template_directory>] [-l [-s]] [-q] [-n] [--bare]
 	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
-	  <repository> [<directory>]
+	  [--use-separate-remote] <repository> [<directory>]
 
 DESCRIPTION
 -----------
@@ -73,7 +73,7 @@ OPTIONS
 	files in `<directory>/.git`, make the `<directory>`
 	itself the `$GIT_DIR`. This implies `-n` option.  When
 	this option is used, neither the `origin` branch nor the
-	default	`remotes/origin` file is created.
+	default `remotes/origin` file is created.
 
 -o <name>::
 	Instead of using the branch name 'origin' to keep track
@@ -94,12 +94,17 @@ OPTIONS
 	if unset the templates are taken from the installation
 	defined default, typically `/usr/share/git-core/templates`.
 
+--use-separate-remote::
+	Save remotes heads under `$GIT_DIR/remotes/origin/' instead
+	of `$GIT_DIR/refs/heads/'.  Only the master branch is saved
+	in the latter.
+
 <repository>::
 	The (possibly remote) repository to clone from.  It can
 	be any URL git-fetch supports.
 
 <directory>::
-	The name of a new directory to clone into.  The	"humanish"
+	The name of a new directory to clone into.  The "humanish"
 	part of the source repository is used if no directory is
 	explicitly given ("repo" for "/path/to/repo.git" and "foo"
 	for "host.xz:foo/.git").  Cloning into an existing directory
-- 
1.3.3.g423a


-- 
Uwe Zeisberger

http://www.google.com/search?q=square+root+of+2
