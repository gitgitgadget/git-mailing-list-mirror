From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Cleanup subcommand documentation for git-remote.
Date: Sat, 3 Feb 2007 23:02:59 -0500
Message-ID: <20070204040259.GA16955@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 05:03:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDYau-00065O-HR
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 05:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbXBDEDG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 23:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbXBDEDG
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 23:03:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50681 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbXBDEDF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 23:03:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDYaX-0002vH-Ka; Sat, 03 Feb 2007 23:02:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1DE2F20FBAE; Sat,  3 Feb 2007 23:03:00 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38645>

Jakub Narebski pointed out the positional notation in git-remote's
documentation was very confusing, especially now that we have 3
supported subcommands.  Instead of referring to subcommands by
position, refer to them by name.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-remote.txt |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 817651e..a60c31a 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -19,18 +19,33 @@ DESCRIPTION
 
 Manage the set of repositories ("remotes") whose branches you track.
 
-With no arguments, shows a list of existing remotes.
 
-In the second form, adds a remote named <name> for the repository at
+COMMANDS
+--------
+
+With no arguments, shows a list of existing remotes.  Several
+subcommands are available to perform operations on the remotes.
+
+'add'::
+
+Adds a remote named <name> for the repository at
 <url>.  The command `git fetch <name>` can then be used to create and
 update remote-tracking branches <name>/<branch>.
 
-In the third form, gives some information about the remote <name>.
+'show'::
 
-In the fourth form, deletes all stale tracking branches under <name>.
+Gives some information about the remote <name>.
+
+'prune'::
+
+Deletes all stale tracking branches under <name>.
 These stale branches have already been removed from the remote repository
 referenced by <name>, but are still locally available in "remotes/<name>".
 
+
+DISCUSSION
+----------
+
 The remote configuration is achieved using the `remote.origin.url` and
 `remote.origin.fetch` configuration variables.  (See
 gitlink:git-config[1]).
-- 
1.5.0.rc3.22.g5057
