From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] Documentation: fix typos and spelling in replace
	documentation
Date: Thu, 19 Nov 2009 07:13:15 +0100
Message-ID: <20091119061317.3581.2135.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 07:20:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB0Nj-0001dc-4k
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 07:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbZKSGUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 01:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbZKSGUI
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 01:20:08 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:57345 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbZKSGUH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 01:20:07 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id AD19E818087;
	Thu, 19 Nov 2009 07:20:04 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 41367818096;
	Thu, 19 Nov 2009 07:20:01 +0100 (CET)
X-git-sha1: b6bd50a5610d0c2f077055b3ce43a88e9c132aa9 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133213>

This patch fix a missing "s" at the end of an occurence of
"--no-replace-objects" and, while at it, it also improves spelling
and rendering.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

	This is a fix that could go into 'maint'.

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 8adc1ef..69f704f 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -17,31 +17,32 @@ DESCRIPTION
 Adds a 'replace' reference in `.git/refs/replace/`
 
 The name of the 'replace' reference is the SHA1 of the object that is
-replaced. The content of the replace reference is the SHA1 of the
+replaced. The content of the 'replace' reference is the SHA1 of the
 replacement object.
 
-Unless `-f` is given, the replace reference must not yet exist in
+Unless `-f` is given, the 'replace' reference must not yet exist in
 `.git/refs/replace/` directory.
 
-Replace references will be used by default by all git commands except
-those doing reachability traversal (prune, pack transfer and fsck).
+Replacement references will be used by default by all git commands
+except those doing reachability traversal (prune, pack transfer and
+fsck).
 
-It is possible to disable use of replacement refs for any command
-using the --no-replace-objects option just after "git".
+It is possible to disable use of replacement references for any
+command using the `--no-replace-objects` option just after 'git'.
 
-For example if commit "foo" has been replaced by commit "bar":
+For example if commit 'foo' has been replaced by commit 'bar':
 
 ------------------------------------------------
-$ git --no-replace-object cat-file commit foo
+$ git --no-replace-objects cat-file commit foo
 ------------------------------------------------
 
-show information about commit "foo", while:
+shows information about commit 'foo', while:
 
 ------------------------------------------------
 $ git cat-file commit foo
 ------------------------------------------------
 
-show information about commit "bar".
+shows information about commit 'bar'.
 
 OPTIONS
 -------
-- 
1.6.5.1.gaf97d
