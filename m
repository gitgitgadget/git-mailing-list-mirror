From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] Documentation: config: add "browser.<tool>.path".
Date: Tue, 29 Jan 2008 07:08:22 +0100
Message-ID: <20080129070822.15d5830f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 07:03:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJjYc-0004Xm-OS
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 07:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbYA2GCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 01:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754413AbYA2GCT
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 01:02:19 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:39388 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762AbYA2GCS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 01:02:18 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 0DE791AB2CD;
	Tue, 29 Jan 2008 07:02:18 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id BE14E1AB2C2;
	Tue, 29 Jan 2008 07:02:17 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71952>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 877eda9..477b2d9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -367,6 +367,10 @@ branch.<name>.rebase::
 	it unless you understand the implications (see linkgit:git-rebase[1]
 	for details).
 
+browser.<tool>.path::
+	Override the path for the given tool that may be used to
+	browse HTML help. See '-w' option in linkgit:git-help[1].
+
 clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f
 	or -n.   Defaults to true.
-- 
1.5.4.rc1.24.gf78d
