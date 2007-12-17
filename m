From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Document diff.external and mergetool.<tool>.path
Date: Mon, 17 Dec 2007 12:21:22 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712171220540.9446@racer.site>
References: <E6DFE65BB5ADFE44BE13CCC976124447D5BB8D@fue-email2.ad.mc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Schuberth, Sebastian" <sschuberth@visageimaging.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 13:22:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Ez5-0002wy-BH
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 13:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935671AbXLQMVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 07:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935746AbXLQMVi
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 07:21:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:39851 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934874AbXLQMVh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 07:21:37 -0500
Received: (qmail invoked by alias); 17 Dec 2007 12:21:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 17 Dec 2007 13:21:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18zCi5/Ovszgjox2llHDOq2+/MOzeoHPIZzl0Xffp
	jbgSqjlFVyMsp5
X-X-Sender: gene099@racer.site
In-Reply-To: <E6DFE65BB5ADFE44BE13CCC976124447D5BB8D@fue-email2.ad.mc.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68553>


There was no documentation for the config variables diff.external
and mergetool.<tool>.path.

Noticed by Sebastian Schuberth.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ce16fc7..8a0df57 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -448,6 +448,13 @@ diff.autorefreshindex::
 	affects only `git diff` Porcelain, and not lower level
 	`diff` commands, such as `git diff-files`.
 
+diff.external::
+	If this config variable is set, diff generation is not
+	performed using the internal diff machinery, but using the
+	given command.  Note: if you want to use an external diff
+	program only on a subset of your files, you might want to
+	use gitlink:gitattributes[5] instead.
+
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
 	detection; equivalent to the git diff option '-l'.
@@ -671,6 +678,10 @@ merge.<driver>.recursive::
 	performing an internal merge between common ancestors.
 	See gitlink:gitattributes[5] for details.
 
+mergetool.<tool>.path::
+	Override the path for the given tool.  This is useful in case
+	your tool is not in the PATH.
+
 pack.window::
 	The size of the window used by gitlink:git-pack-objects[1] when no
 	window size is given on the command line. Defaults to 10.
-- 
1.5.4.rc0.36.g7680
