From: Stefan Tatschner <stefan@sevenbyte.org>
Subject: [PATCH] Documentation: Fix inconsistent quotes
Date: Wed, 29 Apr 2015 20:08:52 +0200
Message-ID: <1430330932-10578-1-git-send-email-stefan@sevenbyte.org>
Cc: git@vger.kernel.org, Stefan Tatschner <stefan@sevenbyte.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 29 20:28:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnWj8-0004vl-K2
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 20:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbbD2S2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 14:28:49 -0400
Received: from mail.sevenbyte.org ([5.9.90.188]:43892 "EHLO mail.sevenbyte.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621AbbD2S2s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 14:28:48 -0400
X-Greylist: delayed 1188 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Apr 2015 14:28:47 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.sevenbyte.org (Postfix) with ESMTP id 6753F126062E;
	Wed, 29 Apr 2015 20:08:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at sevenbyte.org
Received: from mail.sevenbyte.org ([127.0.0.1])
	by localhost (mail.sevenbyte.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id btqP2biOQKer; Wed, 29 Apr 2015 20:08:56 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267990>

While reading 'man git' I realized that the highlighting of the
environment variables is not consistent. This patch adds missing single
quotes and substitutes backticks with the proper quotes as well.

Signed-off-by: Stefan Tatschner <stefan@sevenbyte.org>
---
 Documentation/git.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 959c9d4..bb345a4 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1000,7 +1000,7 @@ Unsetting the variable, or setting it to empty, "0" or
 	cloning of shallow repositories.
 	See 'GIT_TRACE' for available trace output options.
 
-GIT_LITERAL_PATHSPECS::
+'GIT_LITERAL_PATHSPECS'::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs literally, rather than as glob patterns. For example,
 	running `GIT_LITERAL_PATHSPECS=1 git log -- '*.c'` will search
@@ -1009,15 +1009,15 @@ GIT_LITERAL_PATHSPECS::
 	literal paths to Git (e.g., paths previously given to you by
 	`git ls-tree`, `--raw` diff output, etc).
 
-GIT_GLOB_PATHSPECS::
+'GIT_GLOB_PATHSPECS'::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs as glob patterns (aka "glob" magic).
 
-GIT_NOGLOB_PATHSPECS::
+'GIT_NOGLOB_PATHSPECS'::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs as literal (aka "literal" magic).
 
-GIT_ICASE_PATHSPECS::
+'GIT_ICASE_PATHSPECS'::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs as case-insensitive.
 
@@ -1031,7 +1031,7 @@ GIT_ICASE_PATHSPECS::
 	variable when it is invoked as the top level command by the
 	end user, to be recorded in the body of the reflog.
 
-`GIT_REF_PARANOIA`::
+'GIT_REF_PARANOIA'::
 	If set to `1`, include broken or badly named refs when iterating
 	over lists of refs. In a normal, non-corrupted repository, this
 	does nothing. However, enabling it may help git to detect and
-- 
2.3.7
