From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 1/4] Documentation: fix typos and spelling in git-replace
	documentation
Date: Sun, 22 Nov 2009 07:56:41 +0100
Message-ID: <20091122065645.4811.96823.chriscool@tuxfamily.org>
References: <20091122064652.4811.38993.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 07:55:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NC6MT-0000Ul-PE
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 07:55:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbZKVGz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 01:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbZKVGzX
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 01:55:23 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:38952 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872AbZKVGzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 01:55:22 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 44FB581805D;
	Sun, 22 Nov 2009 07:55:18 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 37734818075;
	Sun, 22 Nov 2009 07:55:16 +0100 (CET)
X-git-sha1: 448a1dd0145680a913e2914d75902d97a6b66883 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091122064652.4811.38993.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133424>

This patch fix a missing "s" at the end of an occurence of
"--no-replace-objects" and, while at it, it also improves spelling
and rendering of the git-replace man page.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

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
