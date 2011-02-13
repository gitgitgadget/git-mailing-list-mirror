From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] git-gui: document the gui.maxfilesdisplayed variable
Date: Sun, 13 Feb 2011 13:53:24 +0100
Message-ID: <20110213125324.GA31986@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 13:53:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PobSG-00075y-NM
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 13:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145Ab1BMMx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 07:53:28 -0500
Received: from darksea.de ([83.133.111.250]:45916 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753168Ab1BMMx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 07:53:26 -0500
Received: (qmail 13846 invoked from network); 13 Feb 2011 13:53:24 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 13 Feb 2011 13:53:24 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166663>

This removes a TODO item in the git-gui source.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
I am not sure how we should go about this patch. Should I split it in
two since it removes the TODO line in git-gui and adds the
documentation in git?

Cheers Heiko

 Documentation/config.txt |    5 +++++
 git-gui/git-gui.sh       |    1 -
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 722e00a..d8edeeb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1122,6 +1122,11 @@ gui.matchtrackingbranch::
 	default to tracking remote branches with matching names or
 	not. Default: "false".
 
+gui.maxfilesdisplayed::
+	Configures the amount of changed files after which git gui will
+	issue a warning that there are more changes than can be
+	displayed.
+
 gui.newbranchtemplate::
 	Is used as suggested name when creating new branches using the
 	linkgit:git-gui[1].
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index e03eda0..db09f00 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -838,7 +838,6 @@ set default_config(gui.newbranchtemplate) {}
 set default_config(gui.spellingdictionary) {}
 set default_config(gui.fontui) [font configure font_ui]
 set default_config(gui.fontdiff) [font configure font_diff]
-# TODO: this option should be added to the git-config documentation
 set default_config(gui.maxfilesdisplayed) 5000
 set default_config(gui.usettk) 1
 set default_config(gui.warndetachedcommit) 1
-- 
1.7.4.rc3.4.g155c4
