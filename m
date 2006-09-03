From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Update GIT_TRACE documentation.
Date: Sun, 3 Sep 2006 17:32:24 +0200
Message-ID: <20060903173224.3395b405.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 00:18:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GK0Ie-000574-1j
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 00:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWICWR2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 18:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWICWQ7
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 18:16:59 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:54430 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751311AbWICP1A (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Sep 2006 11:27:00 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with SMTP id D128D543A6;
	Sun,  3 Sep 2006 17:26:57 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26387>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git.txt |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 76b41c8..744c38d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -634,9 +634,18 @@ other
 	This environment variable overrides `$PAGER`.
 
 'GIT_TRACE'::
-	If this variable is set git will print `trace:` messages on
+	If this variable is set to "1", "2" or "true" (comparison
+	is case insensitive), git will print `trace:` messages on
 	stderr telling about alias expansion, built-in command
 	execution and external command execution.
+	If this variable is set to an integer value greater than 1
+	and lower than 10 (strictly) then git will interpret this
+	value as an open file descriptor and will try to write the
+	trace messages into this file descriptor.
+	Alternatively, if this variable is set to an absolute path
+	(starting with a '/' character), git will interpret this
+	as a file path and will try to write the trace messages
+	into it.
 
 Discussion[[Discussion]]
 ------------------------
-- 
1.4.2.g0f2c-dirty

-- 
VGER BF report: S 0.99915
