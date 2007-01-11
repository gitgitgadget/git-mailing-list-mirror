From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] OSX ends with "install: git-init.1: No such file or directory"
Date: Wed, 10 Jan 2007 22:47:33 -0800
Message-ID: <7vmz4q5abe.fsf@assigned-by-dhcp.cox.net>
References: <8664bedsbc.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jan 11 07:48:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4tjP-00025F-PB
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 07:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965295AbXAKGrv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 01:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965302AbXAKGrv
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 01:47:51 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:41520 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965295AbXAKGru (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 01:47:50 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070111064749.EVZV19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jan 2007 01:47:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9imy1W0081kojtg0000000; Thu, 11 Jan 2007 01:46:58 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <8664bedsbc.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "10 Jan 2007 21:51:35 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36550>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> If I cd into Documentation, and try to make "git-init.1", I get this:
>
>     % make git-init.1
>     asciidoc -b docbook -d manpage -f asciidoc.conf git-init.txt
>     xmlto -m callouts.xsl man git-init.xml
>     Note: meta date   : No date. Using generated date       git-init-db
>     Note: meta source : No productname or alternative       git-init-db
>     Note: meta source : No refmiscinfo@class=source         git-init-db
>     Note: meta version: No productnumber or alternative     git-init-db
>     Note: meta version: No refmiscinfo@class=version        git-init-db
>     Warn: meta source : No valid fallback. Leaving empty    git-init-db
>     Note: meta manual : No ancestor with title              git-init-db
>     Note: meta manual : No refmiscinfo@class=manual         git-init-db
>     Warn: meta manual : No valid fallback. Leaving empty    git-init-db
>     Note: Writing git-init-db.1
>     rm git-init.xml
>
> That's not good. Making git-init-db when it wants git-init.

Not good.  I am _very_ tempted to do this.

;-)

---
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 36838c7..30d9834 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -1 +1,17 @@
-include::git-init-db.txt[]
+git-init(1)
+===========
+
+NAME
+----
+git-init - Creates an empty git repository
+
+SYNOPSIS
+--------
+'git-init' [--template=<template_directory>] [--shared[=<permissions>]]
+
+
+DESCRIPTION
+-----------
+
+This is a silly synonym for gitlink:git-init-db[1].  Learn to use that
+command instead.
