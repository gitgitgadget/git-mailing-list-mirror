From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] Fix formatting in git-config(1)
Date: Sat, 23 Jun 2012 15:18:00 +0200
Message-ID: <m27guy5fqv.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 23 15:18:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiQED-0004mA-Fo
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 15:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119Ab2FWNSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jun 2012 09:18:03 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:53337 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab2FWNSB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 09:18:01 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3WKHJJ2F8Yz3hhcq
	for <git@vger.kernel.org>; Sat, 23 Jun 2012 15:17:52 +0200 (CEST)
Received: from igel.home (ppp-88-217-109-173.dynamic.mnet-online.de [88.217.109.173])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3WKHJS3hxZz4KKBF
	for <git@vger.kernel.org>; Sat, 23 Jun 2012 15:18:00 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 1FD1ECA2A5; Sat, 23 Jun 2012 15:18:00 +0200 (CEST)
X-Yow: Yow!!  "Janitor trapped in sewer uses ESP to find decayed burger"!!
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200501>

This fixes two formatting bugs in the git-config documentation:

- in the column.ui entry don't indent the last paragraph so that it isn't
  formatted as a literal paragraph
- in the push.default entry separate the last paragraph from the
  nested list.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 Documentation/config.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 915cb5a..b059851 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -880,7 +880,7 @@ column.ui::
 	make equal size columns
 --
 +
-	This option defaults to 'never'.
+This option defaults to 'never'.
 
 column.branch::
 	Specify whether to output branch listing in `git branch` in columns.
@@ -1720,6 +1720,7 @@ push.default::
 	no refspec is implied by any of the options given on the command
 	line. Possible values are:
 +
+--
 * `nothing` - do not push anything.
 * `matching` - push all branches having the same name in both ends.
   This is for those who prepare all the branches into a publishable
@@ -1739,12 +1740,13 @@ push.default::
   option and is well-suited for beginners. It will become the default
   in Git 2.0.
 * `current` - push the current branch to a branch of the same name.
-  +
-  The `simple`, `current` and `upstream` modes are for those who want to
-  push out a single branch after finishing work, even when the other
-  branches are not yet ready to be pushed out. If you are working with
-  other people to push into the same shared repository, you would want
-  to use one of these.
+--
++
+The `simple`, `current` and `upstream` modes are for those who want to
+push out a single branch after finishing work, even when the other
+branches are not yet ready to be pushed out. If you are working with
+other people to push into the same shared repository, you would want
+to use one of these.
 
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
-- 
1.7.11.1


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
