From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] Document conding style
Date: Wed, 27 Feb 2008 09:13:30 +0100
Message-ID: <12041000101604-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 09:14:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUHQk-000581-Rf
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 09:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbYB0INc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 03:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753626AbYB0INc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 03:13:32 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:35789 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbYB0INc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 03:13:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 6718A680BF8C;
	Wed, 27 Feb 2008 09:13:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aY70H7nmuwHu; Wed, 27 Feb 2008 09:13:30 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 42DDF680B59A; Wed, 27 Feb 2008 09:13:30 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75210>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
Documentation/CodingGuidelines |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 3b042db..e1b5d78 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -77,6 +77,30 @@ For C programs:
    of "else if" statements, it can make sense to add braces to
    single line blocks.
 
+ - Avoid trailing whitespaces
+
+ - Pointer to struct foo type is (struct foo *), not (struct foo*)
+
+ - One space each around comparison operator "=="
+
+ - One space around assignment operator "="
+
+ - One space after "if", "while", "switch" and friends before "("
+
+ - No space between function name and "("
+
+ - A function without parameter is "static void foo(void)", not
+   "static void foo()"
+
+ - Don't do any declaration after a statement.
+
+ - Multi-line comment is:
+
+        /*
+         * This is multi line comment
+         * and this is its second line.
+         */
+
  - Try to make your code understandable.  You may put comments
    in, but comments invariably tend to stale out when the code
    they were describing changes.  Often splitting a function
@@ -105,6 +129,9 @@ For C programs:
    changed and discussed.  Many git commands started out like
    that, and a few are still scripts.
 
+ - Consider checking your patches with checkpatch from the linux 
+   kernel. It helps you to spot trivial formating errors.
+
  - Avoid introducing a new dependency into git. This means you
    usually should stay away from scripting languages not already
    used in the git core command set (unless your command is clearly
-- 
1.5.4.3.ga3d8
