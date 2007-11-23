From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Remove git-status from list of scripts as it is builtin
Date: Fri, 23 Nov 2007 15:35:08 -0500
Message-ID: <20071123203508.GA6797@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 21:35:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvfFP-0008HA-8x
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 21:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109AbXKWUfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 15:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755048AbXKWUfO
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 15:35:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57246 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857AbXKWUfN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 15:35:13 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IvfEs-00030H-04; Fri, 23 Nov 2007 15:35:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 555E020FBD9; Fri, 23 Nov 2007 15:35:08 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65923>

Now that git-status is builtin on Cygwin this compiles as
git-status.exe.  We cannot continue to include git-status
as a Makefile target as it will never be built.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I apologize if this is a dupe; I haven't had a chance to read
 the list traffic to see what has been posted and what hasn't.
 I'll be offline for the next few days so I figured I should get
 this out there now, just in case anyone else might run into the
 same problem I did.

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 313f9a2..a5a40ce 100644
--- a/Makefile
+++ b/Makefile
@@ -233,7 +233,7 @@ SCRIPT_PERL = \
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
-	  git-status git-instaweb
+	  git-instaweb
 
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS = \
-- 
1.5.3.6.1936.gc44a9
