From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/5] documentation: help: add "man.<tool>.path" config
 variable
Date: Fri, 25 Apr 2008 08:24:41 +0200
Message-ID: <20080425082441.9f2c7732.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pascal Obry <pascal@obry.net>,
	Xavier Maillard <xma@gnu.org>,
	=?UTF-8?Q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97?=
	 =?UTF-8?Q?=E3=81=AA=E3=81=AA=E3=81=93?=
X-From: git-owner@vger.kernel.org Fri Apr 25 08:20:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpHIK-00016r-S2
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 08:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255AbYDYGTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 02:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755118AbYDYGTe
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 02:19:34 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:51092 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755098AbYDYGTd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 02:19:33 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 643A91AB2E1;
	Fri, 25 Apr 2008 08:19:32 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 0E9AC1AB2DA;
	Fri, 25 Apr 2008 08:19:32 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80323>

This patch documents the "man.<tool>.path" configuration
variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt   |    4 ++++
 Documentation/git-help.txt |    9 +++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b109bdf..c1c72e7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -773,6 +773,10 @@ man.viewer::
 	Specify the programs that may be used to display help in the
 	'man' format. See linkgit:git-help[1].
 
+man.<tool>.path::
+	Override the path for the given tool that may be used to
+	display help in the 'man' format. See linkgit:git-help[1].
+
 include::merge-config.txt[]
 
 mergetool.<tool>.path::
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index be2ae53..4c6cb21 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -104,6 +104,15 @@ DISPLAY is not set) and in that case emacs' woman mode will be tried.
 
 If everything fails the 'man' program will be tried anyway.
 
+man.<tool>.path
+~~~~~~~~~~~~~~~
+
+You can explicitly provide a full path to your preferred man viewer by
+setting the configuration variable 'man.<tool>.path'. For example, you
+can configure the absolute path to konqueror by setting
+'man.konqueror.path'. Otherwise, 'git help' assumes the tool is
+available in PATH.
+
 Note about git config --global
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
1.5.5.130.g3ab1e.dirty
