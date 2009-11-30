From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH v2 3/6] t/README: Document GIT_TEST_INSTALLED and GIT_TEST_EXEC_PATH
Date: Sun, 29 Nov 2009 23:19:28 -0700
Message-ID: <1259561971-25730-4-git-send-email-mmogilvi_git@miniinfo.net>
References: <1259561971-25730-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-3-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 30 07:20:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEzcm-0000zV-92
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 07:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbZK3GUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 01:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbZK3GUC
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 01:20:02 -0500
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:47171 "EHLO
	QMTA01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752601AbZK3GT4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 01:19:56 -0500
Received: from OMTA05.emeryville.ca.mail.comcast.net ([76.96.30.43])
	by QMTA01.emeryville.ca.mail.comcast.net with comcast
	id BJFz1d00E0vp7WLA1JKAst; Mon, 30 Nov 2009 06:19:10 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA05.emeryville.ca.mail.comcast.net with comcast
	id BJL31d0015FCJCg8RJL3cq; Mon, 30 Nov 2009 06:20:04 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 18E6789114;
	Sun, 29 Nov 2009 23:20:02 -0700 (MST)
X-Mailer: git-send-email 1.6.4.GIT
In-Reply-To: <1259561971-25730-3-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134052>

These were added without documentation in 2009-03-16 (6720721).

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 t/README |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index d8f6c7d..4e1d7dd 100644
--- a/t/README
+++ b/t/README
@@ -75,6 +75,19 @@ appropriately before running "make".
 	As the names depend on the tests' file names, it is safe to
 	run the tests with this option in parallel.
 
+You can also set the GIT_TEST_INSTALLED environment variable to
+the bindir of an existing git installation to test that installation.
+You still need to have built this git sandbox, from which various
+test-* support programs, templates, and perl libraries are used.
+If your installed git is incomplete, it will silently test parts of
+your built version instead.
+
+When using GIT_TEST_INSTALLED, you can also set GIT_TEST_EXEC_PATH to
+override the location of the dashed-form subcommands (what
+GIT_EXEC_PATH would be used for during normal operation).
+GIT_TEST_EXEC_PATH defaults to `$GIT_TEST_INSTALLED/git --exec-path`.
+
+
 Skipping Tests
 --------------
 
-- 
1.6.4.GIT
