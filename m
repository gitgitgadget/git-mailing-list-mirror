From: drafnel@gmail.com
Subject: [PATCH 3/4] git-reflog.txt: Document new commands --updateref and --rewrite
Date: Sun,  2 Mar 2008 14:58:50 -0600
Message-ID: <15643506.1204491509692.JavaMail.teamon@b308.teamon.com>
References: <1204491531-29758-1-git-send-email-drafnel@gmail.com>
 <1204491531-29758-2-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 02 22:13:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVvVG-0004De-F7
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 22:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756567AbYCBVMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 16:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756454AbYCBVMw
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 16:12:52 -0500
Received: from www.teamon.com ([216.34.91.250]:39862 "EHLO b308.teamon.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756058AbYCBVMu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 16:12:50 -0500
X-Greylist: delayed 822 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Mar 2008 16:12:47 EST
Received: from b308.teamon.com (localhost [127.0.0.1])
	by b308.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m22KwT022392;
	Sun, 2 Mar 2008 20:58:29 GMT
X-Mailer: git-send-email 1.5.4.3.412.gcd100
In-Reply-To: <1204491531-29758-2-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75842>

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 Documentation/git-reflog.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 5719039..047e3ce 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -80,6 +80,15 @@ them.
 --all::
 	Instead of listing <refs> explicitly, prune all refs.
 
+--updateref::
+	Update the ref with the sha1 of the top reflog entry (i.e.
+	<ref>@\{0\}) after expiring or deleting.
+
+--rewrite::
+	While expiring or deleting, adjust each reflog entry to ensure
+	that the `old` sha1 field points to the `new` sha1 field of the
+	previous entry.
+
 --verbose::
 	Print extra information on screen.
 
-- 
1.5.4.3.412.gcd100

