From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] Documentation: config: add "browser.<tool>.path".
Date: Mon, 28 Jan 2008 08:02:23 +0100
Message-ID: <20080128080223.de8a67d2.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jan 28 07:57:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJNvU-0004HS-LX
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 07:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbYA1G4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 01:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbYA1G4W
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 01:56:22 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:50810 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbYA1G4V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 01:56:21 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B4E191AB2EB;
	Mon, 28 Jan 2008 07:56:19 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 092B91AB2E2;
	Mon, 28 Jan 2008 07:56:18 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71852>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 877eda9..c2fedd1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -367,6 +367,10 @@ branch.<name>.rebase::
 	it unless you understand the implications (see linkgit:git-rebase[1]
 	for details).
 
+browser.<tool>.path::
+	Override the path for the given tool that may be used to
+	browse help. See linkgit:git-help[1].
+
 clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f
 	or -n.   Defaults to true.
-- 
1.5.4.rc4.16.g1009
