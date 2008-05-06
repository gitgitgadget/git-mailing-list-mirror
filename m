From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] Documentation/config.txt: Add git-gui options
Date: Tue,  6 May 2008 21:39:05 +0200
Message-ID: <1210102745-7415-1-git-send-email-hendeby@isy.liu.se>
Cc: Gustaf Hendeby <hendeby@isy.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 21:40:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtT1C-0005zG-Od
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 21:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761579AbYEFTjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 15:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756867AbYEFTjK
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 15:39:10 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:43737 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762772AbYEFTjI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 15:39:08 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 7C8082593F
	for <git@vger.kernel.org>; Tue,  6 May 2008 21:39:06 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 06536-03; Tue,  6 May 2008 06:03:43 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id A043D25783;
	Tue,  6 May 2008 21:39:05 +0200 (MEST)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id 9271C177A0; Tue,  6 May 2008 21:39:05 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.274.g25dd
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81378>

The 'git gui' has a number of options that can be specified using the
options dialog. Sometimes it is convenient to be able to specify these
from the command line, therefor document these options.

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---

This manual update was initiated by the problem with git gui freezing
up at start when only aspell previous to version 0.6 is available.
For the moment a fix is to set gui.spellingdictionary="none", however
this option isn't documented anywhere but in code.  I think it would
be nice to have this option and other used by git gui documented
somewhere, even if for no other reason than to understand what is in
your .gitconfig.

This patch introduces some more of the git gui specific options in
config.txt with the reset of the git options (as suggested by Shawn.).
An option would be to put the documentation in git-gui.txt and link to
there from config.txt.  This way the config documentation does get
less cluttered, and it makes it possible to have different
documentation for different versions of git gui.  Does anyone have any
opinions?  Maybe it is only me that think the options needs to be
documented at?

/Gustaf


 Documentation/config.txt |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fe43b12..06ab05e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -673,6 +673,37 @@ specified as 'gitcvs.<access_method>.<varname>' (where 'access_method'
 is one of "ext" and "pserver") to make them apply only for the given
 access method.
 
+gui.commitmsgwidth::
+	Defines how wide the commit message window is in the
+	linkgit:git-gui[1]. "75" is the default.
+
+gui.diffcontext::
+	Specify how many context lines should be used by in calls to
+	diff made in the linkgit:git-gui[1]. The default is "5".
+
+gui.matchtrackingbranch::
+	Determine if new branches created with linkgit:git-gui[1] should
+	default to track remote branches with matching names. Default:
+	"false".
+
+gui.newbranchtemplate::
+	Is used as suggested name when creating new branches using the
+	linkgit:git-gui[1].
+
+gui.pruneduringfetch::
+	"true" if linkgit:git-gui[1] should prune tracking branches when
+	performing a fetch. The default value is "false".
+
+gui.trustmtime::
+	Determine if linkgit:git-gui[1] should trust the file modification
+	timestamp or not. By default the timestamps are not trusted.
+
+gui.spellingdictionary::
+	Specify the dictionary used for spell checking commit messages in
+	the linkgit:git-gui[1]. When set to "none" spelling is turned off,
+	making linkgit:git-gui[1] to start on systems with aspell previous
+	to version 0.6.
+
 help.browser::
 	Specify the browser that will be used to display help in the
 	'web' format. See linkgit:git-help[1].
-- 
1.5.5.1.273.g1810b
