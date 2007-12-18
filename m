From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH] Fix some documentation typos.
Date: Tue, 18 Dec 2007 13:12:30 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071218121230.GA15831@ins.uni-bonn.de>
References: <20071218060736.GA24024@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 13:13:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4bK0-0006mj-Qk
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 13:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbXLRMMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 07:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbXLRMMx
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 07:12:53 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:43848 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072AbXLRMMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 07:12:52 -0500
Received: from localhost.localdomain (xdsl-87-78-164-226.netcologne.de [87.78.164.226])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 202884000025C
	for <git@vger.kernel.org>; Tue, 18 Dec 2007 13:12:51 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1J4bJG-00047m-SM
	for git@vger.kernel.org; Tue, 18 Dec 2007 13:12:30 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071218060736.GA24024@ins.uni-bonn.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68735>

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---
Found some more.  If you haven't pushed yet, please squash this in with
the other patch, thanks.

Cheers,
Ralf

 Documentation/git-help.txt |    2 +-
 Documentation/git-init.txt |    2 +-
 Documentation/git.txt      |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index c370ee9..a8ffcbe 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -72,7 +72,7 @@ line option:
 * "web" or "html" correspond to '-w|--web',
 
 The 'help.browser', 'web.browser' and 'browser.<tool>.path' will also
-be checked if the 'web' format is choosen (either by command line
+be checked if the 'web' format is chosen (either by command line
 option or configuration variable). See '-w|--web' in the OPTIONS
 section above.
 
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 07484a4..e51351d 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -52,7 +52,7 @@ is given:
  - 'all' (or 'world' or 'everybody'): Same as 'group', but make the repository
    readable by all users.
 
-By default, the configuration flag receive.denyNonFastforward is enabled
+By default, the configuration flag receive.denyNonFastForwards is enabled
 in shared repositories, so that you cannot force a non fast-forwarding push
 into it.
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index e0f9a44..37235b9 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -502,7 +502,7 @@ as tags and branch heads.
 
 The object database contains objects of three main types: blobs, which
 hold file data; trees, which point to blobs and other trees to build up
-directory heirarchies; and commits, which each reference a single tree
+directory hierarchies; and commits, which each reference a single tree
 and some number of parent commits.
 
 The commit, equivalent to what other systems call a "changeset" or
@@ -522,7 +522,7 @@ efficiency may later be compressed together into "pack files".
 Named pointers called refs mark interesting points in history.  A ref
 may contain the SHA1 name of an object or the name of another ref.  Refs
 with names beginning `ref/head/` contain the SHA1 name of the most
-recent commit (or "head") of a branch under developement.  SHA1 names of
+recent commit (or "head") of a branch under development.  SHA1 names of
 tags of interest are stored under `ref/tags/`.  A special ref named
 `HEAD` contains the name of the currently checked-out branch.
 
-- 
1.5.4.rc0.56.g6fbe
