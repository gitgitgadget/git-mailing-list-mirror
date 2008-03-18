From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] documentation: help: add "man.<tool>.path" config
 variable
Date: Tue, 18 Mar 2008 06:22:48 +0100
Message-ID: <20080318062248.8c5bb66e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pascal Obry <pascal@obry.net>,
	Xavier Maillard <xma@gnu.org>,
	=?UTF-8?Q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97?=
	 =?UTF-8?Q?=E3=81=AA=E3=81=AA=E3=81=93?=
X-From: git-owner@vger.kernel.org Tue Mar 18 06:18:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbUD2-0001ZC-Ej
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 06:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbYCRFRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2008 01:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbYCRFRO
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Mar 2008 01:17:14 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:38021 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059AbYCRFRO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2008 01:17:14 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 291151AB2BD;
	Tue, 18 Mar 2008 06:17:13 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id CEB1C1AB2B6;
	Tue, 18 Mar 2008 06:17:12 +0100 (CET)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77490>

This patch documents the "man.<tool>.path" configuration
variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt   |    4 ++++
 Documentation/git-help.txt |    9 +++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f156b1d..32689b8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -761,6 +761,10 @@ man.viewer::
 	Specify the programs that may be used to display help in the
 	'man' format. See linkgit:git-help[1].
 
+man.<tool>.path::
+	Override the path for the given tool that may be used to
+	display help in the 'man' format. See linkgit:git-help[1].
+
 merge.summary::
 	Whether to include summaries of merged commits in newly created
 	merge commit messages. False by default.
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
1.5.4.4.685.g3070a.dirty
