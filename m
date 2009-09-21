From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC PATCH 7/8] Add documentation for git gui variables for email and delete after push
Date: Mon, 21 Sep 2009 15:06:54 +0200
Message-ID: <bbe878f82f987a36fd1edf77ff6921f2717ad092.1253481338.git.hvoigt@hvoigt.net>
References: <cover.1253481338.git.hvoigt@hvoigt.net>
 <f52bb968bf977dbbed78ce48856cd41d0add708f.1253481338.git.hvoigt@hvoigt.net>
 <711bc3257266372b0a0f01ac335fa95be7def077.1253481338.git.hvoigt@hvoigt.net>
 <3ee2f1d36ed3c4b716f9bdb2a8f7fcde9a5f9357.1253481338.git.hvoigt@hvoigt.net>
 <1e2889356b0992c64fe0d5efefa4c9c47af2513f.1253481338.git.hvoigt@hvoigt.net>
 <0f2d6dac74105f84defebf23dd74c40846d304a3.1253481338.git.hvoigt@hvoigt.net>
 <48c17b5cc7f2e143187a11c4e146649721bb2b0f.1253481338.git.hvoigt@hvoigt.net>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 15:07:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpicH-0002uk-Ay
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 15:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135AbZIUNHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 09:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756121AbZIUNHS
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 09:07:18 -0400
Received: from darksea.de ([83.133.111.250]:35701 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756096AbZIUNGz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 09:06:55 -0400
Received: (qmail 28837 invoked from network); 21 Sep 2009 15:06:58 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 21 Sep 2009 15:06:58 +0200
X-Mailer: git-send-email 1.6.5.rc1.12.gc72fe
In-Reply-To: <48c17b5cc7f2e143187a11c4e146649721bb2b0f.1253481338.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1253481338.git.hvoigt@hvoigt.net>
References: <cover.1253481338.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128884>

---
 Documentation/config.txt |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c6f09f8..4174ab4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -957,6 +957,36 @@ gui.blamehistoryctx::
 	Context` menu item is invoked from 'git gui blame'. If this
 	variable is set to zero, the whole history is shown.
 
+gui.emailafterpush::
+	The push dialog can compose a review email if you push a feature
+	branch. If this option is set to true the checkbox will be
+	automatically enabled when you select a feature branch. The
+	upstream (main) branch is determined from the
+	`gui.upstreambranch` option.
+
+gui.deleteafterpush::
+	If you push a branch in git gui you can enable a checkbox which
+	will open the remote delete branch dialog after a push. Setting
+	this variable to true will automatically check that checkbox
+	when you select to push the upstream (main) branch. The upstream
+	branch can be configured using the `gui.upstreambranch` configuration
+	variable.
+
+gui.upstreambranch::
+	This configures which branchname will be referred to as the
+	upstream (main) branch on remote repositories. Currently this
+	option is used in combination with the options
+	`gui.emailafterpush` and `gui.deleteafterpush`.
+
+gui.fetchonstartup::
+	Boolean, if set all branches from remote determined by
+	`gui.defaulremote` will be fetched on startup of git gui.
+
+gui.defaultremote::
+	String variable which determines from which remote git gui will
+	automatically start a fetch on startup. If this variable is not
+	set the automatic fetch is disabled.
+
 guitool.<name>.cmd::
 	Specifies the shell command line to execute when the corresponding item
 	of the linkgit:git-gui[1] `Tools` menu is invoked. This option is
-- 
1.6.5.rc1.12.gc72fe
