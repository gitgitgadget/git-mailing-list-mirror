From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH] remote: document the 'rm' subcommand
Date: Sat, 7 Jul 2007 11:22:43 -0400
Message-ID: <20070707152242.GC19782@crux.rdu.redhat.com>
References: <Pine.LNX.4.64.0707052338150.9789@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 07 17:22:51 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7C7W-0003M9-Ef
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 17:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbXGGPWs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 11:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbXGGPWs
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 11:22:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44509 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbXGGPWr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 11:22:47 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l67FMhXx007954;
	Sat, 7 Jul 2007 11:22:43 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l67FMhQw032143;
	Sat, 7 Jul 2007 11:22:43 -0400
Received: from crux (crux.rdu.redhat.com [172.16.59.80])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l67FMhtf016255;
	Sat, 7 Jul 2007 11:22:43 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707052338150.9789@racer.site>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51817>

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---

So I still think 'git remote rm' would be nice to have. Here's a bit of
documentation for it.

 Documentation/git-remote.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 61a6022..fff40ca 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git-remote'
 'git-remote' add [-t <branch>] [-m <branch>] [-f] <name> <url>
+'git-remote' rm <name>
 'git-remote' show <name>
 'git-remote' prune <name>
 'git-remote' update [group]
@@ -46,6 +47,11 @@ With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
 up to point at remote's `<master>` branch instead of whatever
 branch the `HEAD` at the remote repository actually points at.
 
+'rm'::
+
+Remove the remote named <name>. All remote tracking branches and
+configuration settings for the remote are removed.
+
 'show'::
 
 Gives some information about the remote <name>.
-- 
1.5.3.rc0.838.gdf39a-dirty
