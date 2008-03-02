From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Fix doc typos.
Date: Mon, 3 Mar 2008 00:07:47 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20080302230747.GA19822@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 00:36:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVxjF-000430-Rt
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 00:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbYCBXft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 18:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbYCBXft
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 18:35:49 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:50572 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbYCBXfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 18:35:48 -0500
X-Greylist: delayed 1673 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Mar 2008 18:35:48 EST
Received: from localhost.localdomain (xdsl-87-78-162-153.netcologne.de [87.78.162.153])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 4FB27400004A7
	for <git@vger.kernel.org>; Mon,  3 Mar 2008 00:07:53 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1JVxHY-0005mw-6F
	for git@vger.kernel.org; Mon, 03 Mar 2008 00:07:48 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75856>

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---
 Documentation/git-grep.txt                  |    2 +-
 Documentation/technical/api-run-command.txt |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 71a7335..a97f055 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -78,7 +78,7 @@ OPTIONS
 -l | --files-with-matches | --name-only | -L | --files-without-match::
 	Instead of showing every matched line, show only the
 	names of files that contain (or do not contain) matches.
-	For better compatability with git-diff, --name-only is a
+	For better compatibility with git-diff, --name-only is a
 	synonym for --files-with-matches.
 
 -c | --count::
diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index dfbf9ac..fde3b45 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -49,7 +49,7 @@ Functions
 
 `finish_async`::
 
-	Wait for the completeion of an asynchronous function that was
+	Wait for the completion of an asynchronous function that was
 	started with start_async().
 
 
@@ -121,8 +121,8 @@ string pointers (NULL terminated) in .env:
 . If the string is of the form "VAR=value", i.e. it contains '='
   the variable is added to the child process's environment.
 
-. If the string does not contain '=', it names an environement
-  variable that will be removed from the child process's envionment.
+. If the string does not contain '=', it names an environment
+  variable that will be removed from the child process's environment.
 
 To specify a new initial working directory for the sub-process,
 specify it in the .dir member.
-- 
1.5.4.3.366.g56462

