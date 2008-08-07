From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH] Documentation: clarify that git-commit only works with
 tracked files
Date: Wed, 6 Aug 2008 19:15:35 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808061906490.24977@harper.uchicago.edu>
References: <Pine.GSO.4.62.0808061603340.18817@harper.uchicago.edu>
 <20080806214747.GY32057@genesis.frugalware.org>
 <Pine.GSO.4.62.0808061725450.21683@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Aug 07 02:16:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQtBV-0000mI-Tn
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 02:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbYHGAPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 20:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752952AbYHGAPs
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 20:15:48 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:36702 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbYHGAPr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 20:15:47 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m770FbH5000976;
	Wed, 6 Aug 2008 19:15:37 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m770FZpe025370;
	Wed, 6 Aug 2008 19:15:35 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0808061725450.21683@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91550>

A user unfamiliar with CVS might not realize that a git-add is
needed before commiting new files.  So emphasize that "git commit
<path>..." only commits files already in the index.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
	I keep on forgetting and getting annoyed when "git commit
	newfile.c" does not work.  From the same confusion I suggested
	git commit -A without really thinking about what it meant.
	This change should make the behavior easier to understand
	and remember.  Thanks for the help.

 Documentation/git-commit.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0e25bb8..9b00ccb 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -27,9 +27,10 @@ The content to be added can be specified in several ways:
 2. by using 'git-rm' to remove files from the working tree
    and the index, again before using the 'commit' command;
 
-3. by listing files as arguments to the 'commit' command, in which
-   case the commit will ignore changes staged in the index, and instead
-   record the current content of the listed files;
+3. by listing some known files as arguments to the 'commit'
+   command, in which case the commit will ignore changes staged
+   in the index and instead record the current content of the
+   listed files;
 
 4. by using the -a switch with the 'commit' command to automatically
    "add" changes from all known files (i.e. all files that are already
-- 
1.6.0.rc1.91.gf0c3
