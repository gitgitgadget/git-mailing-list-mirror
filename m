From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 5/5] Help doc: Include --guide option description
Date: Sun,  3 Mar 2013 20:21:12 +0000
Message-ID: <1362342072-1412-6-git-send-email-philipoakley@iee.org>
References: <1362342072-1412-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 03 21:21:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCFPu-0001hv-Gb
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 21:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab3CCUVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 15:21:17 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:45920 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753454Ab3CCUVB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Mar 2013 15:21:01 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAEauM1FZ8rke/2dsb2JhbABFhWe8Y30Xc4IgAQVWMwhJORABDQYTiBfGf48kg0ADpzKDCA
X-IronPort-AV: E=Sophos;i="4.84,774,1355097600"; 
   d="scan'208";a="420373185"
Received: from host-89-242-185-30.as13285.net (HELO localhost) ([89.242.185.30])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 03 Mar 2013 20:20:59 +0000
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1362342072-1412-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217357>

Note that the ability to display an individual guide was
always possible. Include this in the update.

Also tell readers how git(1) can be accessed, especially for
Git for Windows users who do not have the 'man' command.
Likewise include a commentary on how to access this page (Catch 22).

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/git-help.txt | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index e07b6dc..498a94e 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -8,31 +8,45 @@ git-help - Display help information about Git
 SYNOPSIS
 --------
 [verse]
-'git help' [-a|--all|-i|--info|-m|--man|-w|--web] [COMMAND]
+'git help' [-a|--all] [-g|--guide]
+	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
 
 DESCRIPTION
 -----------
 
-With no options and no COMMAND given, the synopsis of the 'git'
+With no options and no COMMAND|GUIDE given, the synopsis of the 'git'
 command and a list of the most commonly used Git commands are printed
 on the standard output.
 
 If the option '--all' or '-a' is given, then all available commands are
 printed on the standard output.
 
-If a Git subcommand is named, a manual page for that subcommand is brought
-up. The 'man' program is used by default for this purpose, but this
-can be overridden by other options or configuration variables.
+If the option '--guide' or '-g' is given then, a list of the useful
+Git guides is also printed on the standard output.
 
-Note that `git --help ...` is identical to `git help ...` because the
+If a Git subcommand, or a Git guide, is given, a manual page for that
+subcommand is brought up. The 'man' program is used by default for this
+purpose, but this can be overridden by other options or configuration
+variables.
+
+Note that 'git --help ...' is identical to 'git help ...' because the
 former is internally converted into the latter.
 
+To display the linkgit:git[1] man page use 'git help git'.
+
+This page can be displayed with 'git help help' or 'git help --help'
+
 OPTIONS
 -------
 -a::
 --all::
 	Prints all the available commands on the standard output. This
-	option supersedes any other option.
+	option overides any given command or guide name.
+
+-g::
+--guides::
+	Prints a list of useful guides on the standard output. This
+	option overides any given command or guide name.
 
 -i::
 --info::
-- 
1.8.1.msysgit.1
