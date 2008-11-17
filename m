From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2 v2] Documentation: user-manual: add information about
 "git help" at the beginning
Date: Mon, 17 Nov 2008 16:42:47 +0100
Message-ID: <20081117164247.52181daf.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 16:42:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L26Ew-0004Bf-Oj
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 16:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbYKQPkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 10:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbYKQPkt
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 10:40:49 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:54811 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbYKQPks (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 10:40:48 -0500
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 21E4D172A2;
	Mon, 17 Nov 2008 16:40:47 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g19.free.fr (Postfix) with SMTP id E3DBD19759;
	Mon, 17 Nov 2008 16:40:44 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101229>

Talking about "git help" is useful because it has a few more
features (like when using it without arguments or with "-a") and
it may work on non unix like platforms.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/user-manual.txt |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

	Here is a new version of this patch series with the changes
	from Junio.

	Thanks,
	Christian.

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 645d752..c0d8caf 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -18,12 +18,22 @@ People needing to do actual development will also want to read
 Further chapters cover more specialized topics.
 
 Comprehensive reference documentation is available through the man
-pages.  For a command such as "git clone <repo>", just use
+pages, or linkgit:git-help[1] command.  For example, for the command
+"git clone <repo>", you can either use:
 
 ------------------------------------------------
 $ man git-clone
 ------------------------------------------------
 
+or:
+
+------------------------------------------------
+$ git help clone
+------------------------------------------------
+
+With the latter, you can use the manual viewer of your choice; see
+linkgit:git-help[1] for more information.
+
 See also <<git-quick-start>> for a brief overview of git commands,
 without any explanation.
 
-- 
1.6.0.4.617.g621cb
