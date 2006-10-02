From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] escape tilde in Documentation/git-rev-parse.txt
Date: Mon, 2 Oct 2006 20:55:05 +0200 (CEST)
Message-ID: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 02 20:58:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUSz2-0002NF-Tc
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 20:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWJBS5l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 14:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWJBS5l
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 14:57:41 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:31410 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S964854AbWJBS5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 14:57:40 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.41] ([83.221.230.151])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id k92IvRGO003520
	for <git@vger.kernel.org>; Mon, 2 Oct 2006 20:57:34 +0200
To: git@vger.kernel.org
Content-Disposition: INLINE
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28227>

fixes a failure to build the git-rev-parse manpage,
seen with asciidoc 8.0.0

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index b761b4b..671b4e3 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -138,7 +138,7 @@ syntax.
   'rev{caret}0' means the commit itself and is used when 'rev' is the
   object name of a tag object that refers to a commit object.
 
-* A suffix '~<n>' to a revision parameter means the commit
+* A suffix '$$~$$<n>' to a revision parameter means the commit
   object that is the <n>th generation grand-parent of the named
   commit object, following only the first parent.  I.e. rev~3 is
   equivalent to rev{caret}{caret}{caret} which is equivalent to\
