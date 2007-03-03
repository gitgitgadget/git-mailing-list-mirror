From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Document the config variable format.suffix
Date: Sun, 4 Mar 2007 00:17:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703040016500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Mar 04 00:17:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNdTj-0004kp-OM
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 00:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbXCCXRZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 18:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbXCCXRZ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 18:17:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:37725 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750756AbXCCXRY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 18:17:24 -0500
Received: (qmail invoked by alias); 03 Mar 2007 23:17:23 -0000
X-Provags-ID: V01U2FsdGVkX19oyhcp/sdoajssvqfxLZRtMf0WqYkDu3s2D+cYeL
	Y74AFrr3EyzdOM
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41339>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Documentation/config.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b809772..5408dd6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -348,6 +348,11 @@ format.headers::
 	Additional email headers to include in a patch to be submitted
 	by mail.  See gitlink:git-format-patch[1].
 
+format.suffix::
+	The default for format-patch is to output files with the suffix
+	`.patch`. Use this variable to change that suffix (make sure to
+	include the dot if you want it).
+
 gc.packrefs::
 	`git gc` does not run `git pack-refs` in a bare repository by
 	default so that older dumb-transport clients can still fetch
