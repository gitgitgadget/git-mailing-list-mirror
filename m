From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Fix some documentation typos.
Date: Tue, 18 Dec 2007 07:07:36 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071218060736.GA24024@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 07:08:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Vcx-0001z4-86
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 07:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbXLRGH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 01:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbXLRGH7
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 01:07:59 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:54973 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbXLRGH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 01:07:58 -0500
Received: from localhost.localdomain (xdsl-87-78-134-196.netcologne.de [87.78.134.196])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 90878400002A2
	for <git@vger.kernel.org>; Tue, 18 Dec 2007 07:07:56 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1J4Vc8-0006Kd-Sx
	for git@vger.kernel.org; Tue, 18 Dec 2007 07:07:36 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68701>

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---
 Documentation/config.txt         |    2 +-
 Documentation/git-help.txt       |    6 +++---
 Documentation/git-rev-list.txt   |    2 +-
 Documentation/git-send-email.txt |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ce16fc7..75ed4d3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -469,7 +469,7 @@ fetch.unpackLimit::
 
 format.numbered::
 	A boolean which can enable sequence numbers in patch subjects.
-	Seting this option to "auto" will enable it only if there is
+	Setting this option to "auto" will enable it only if there is
 	more than one patch.  See --numbered option in
 	gitlink:git-format-patch[1].
 
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index da3f718..c370ee9 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -21,7 +21,7 @@ printed on the standard output.
 
 If a git command is named, a manual page for that command is brought
 up. The 'man' program is used by default for this purpose, but this
-can be overriden by other options or configuration variables.
+can be overridden by other options or configuration variables.
 
 Note that 'git --help ...' is identical as 'git help ...' because the
 former is internally converted into the latter.
@@ -30,7 +30,7 @@ OPTIONS
 -------
 -a|--all::
 	Prints all the available commands on the standard output. This
-	option superseeds any other option.
+	option supersedes any other option.
 
 -i|--info::
 	Use the 'info' program to display the manual page, instead of
@@ -50,7 +50,7 @@ The web browser can be specified using the configuration variable
 these config variables is set, the 'git-help--browse' helper script
 (called by 'git-help') will pick a suitable default.
 +
-You can explicitly provide a full path to your prefered browser by
+You can explicitly provide a full path to your preferred browser by
 setting the configuration variable 'browser.<tool>.path'. For example,
 you can configure the absolute path to firefox by setting
 'browser.firefox.path'. Otherwise, 'git-help--browse' assumes the tool
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 989fbf3..a03f9fe 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -274,7 +274,7 @@ limiting may be applied.
 --quiet::
 
 	Don't print anything to standard output.  This form of
-	git-rev-list is primarly meant to allow the caller to
+	git-rev-list is primarily meant to allow the caller to
 	test the exit status to see if a range of objects is fully
 	connected (or not).  It is faster than redirecting stdout
 	to /dev/null as the output does not have to be formatted.
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 659215a..f0bd285 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -148,7 +148,7 @@ sendemail.identity::
 	'sendemail.<identity>.<item>' will have higher precedence than
 	'sendemail.<item>'. This is useful to declare multiple SMTP
 	identities and to hoist sensitive authentication information
-	out of the repository and into the global configuation file.
+	out of the repository and into the global configuration file.
 
 sendemail.aliasesfile::
 	To avoid typing long email addresses, point this to one or more
-- 
1.5.3.6.950.g92b7b
