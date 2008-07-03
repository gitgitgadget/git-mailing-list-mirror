From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 09/15] manpages: italicize command names in synopses
Date: Thu, 3 Jul 2008 00:36:04 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807030030320.16085@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <7viqvqov01.fsf@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Dan McGee <dpmcgee@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Michele Ballabio <barra_cuda@katamail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 09:02:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEIpi-0003HF-CO
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 09:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608AbYGCG7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753099AbYGCG6E
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:58:04 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:59774 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812AbYGCFgo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 01:36:44 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m635a54p023294;
	Thu, 3 Jul 2008 00:36:05 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m635a5na019159;
	Thu, 3 Jul 2008 00:36:05 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87229>

To tell command names from options in a glance.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/git-reflog.txt |   10 +++++-----
 Documentation/git-remote.txt |   10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index d963c51..1710626 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -16,12 +16,12 @@ The command takes various subcommands, and different options
 depending on the subcommand:
 
 [verse]
-git reflog expire [--dry-run] [--stale-fix] [--verbose]
+'git reflog expire' [--dry-run] [--stale-fix] [--verbose]
 	[--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...
-
-git reflog delete ref@\{specifier\}...
-
-git reflog [show] [log-options] [<ref>]
++
+'git reflog delete' ref@\{specifier\}...
++
+'git reflog' ['show'] [log-options] [<ref>]
 
 Reflog is a mechanism to record when the tip of branches are
 updated.  This command is to manage the information recorded in it.
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 3634efd..bb99810 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,11 +10,11 @@ SYNOPSIS
 --------
 [verse]
 'git remote' [-v | --verbose]
-'git remote' add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
-'git remote' rm <name>
-'git remote' show [-n] <name>
-'git remote' prune [-n | --dry-run] <name>
-'git remote' update [group]
+'git remote add' [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
+'git remote rm' <name>
+'git remote show' [-n] <name>
+'git remote prune' [-n | --dry-run] <name>
+'git remote update' [group]
 
 DESCRIPTION
 -----------
-- 
1.5.5.GIT
