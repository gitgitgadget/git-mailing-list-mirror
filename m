From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH] Documentation: remove {show,whatchanged}.difftree config options
Date: Fri, 27 Jun 2008 02:17:55 +0200
Message-ID: <1214525875-30954-1-git-send-email-dkr+ml.git@free.fr>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 02:18:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC1fh-0004eb-Fh
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 02:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbYF0ARj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 20:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755408AbYF0ARi
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 20:17:38 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:51039 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755344AbYF0ARi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 20:17:38 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 1190D12B6C2;
	Fri, 27 Jun 2008 02:17:37 +0200 (CEST)
Received: from localhost.localdomain (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id BED9812B6BF;
	Fri, 27 Jun 2008 02:17:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.77.gf9a08
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86507>

From: Olivier Marin <dkr@freesurf.fr>

This removes, from the documentation and the bash completion script, the
two config options that were introduced by the git-whatchanged.sh script
and lost in the C rewrite. Today, we can use aliases as an alternative.

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---
 Documentation/config.txt               |    8 --------
 contrib/completion/git-completion.bash |    2 --
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 90c8a45..6966384 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1007,10 +1007,6 @@ repack.usedeltabaseoffset::
 	Allow linkgit:git-repack[1] to create packs that uses
 	delta-base offset.  Defaults to false.
 
-show.difftree::
-	The default linkgit:git-diff-tree[1] arguments to be used
-	for linkgit:git-show[1].
-
 showbranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
 	See linkgit:git-show-branch[1].
@@ -1075,10 +1071,6 @@ user.signingkey::
 	unchanged to gpg's --local-user parameter, so you may specify a key
 	using any method that gpg supports.
 
-whatchanged.difftree::
-	The default linkgit:git-diff-tree[1] arguments to be used
-	for linkgit:git-whatchanged[1].
-
 imap::
 	The configuration variables in the 'imap' section are described
 	in linkgit:git-imap-send[1].
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ebf7cde..3f46149 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1041,7 +1041,6 @@ _git_config ()
 		pull.octopus
 		pull.twohead
 		repack.useDeltaBaseOffset
-		show.difftree
 		showbranch.default
 		tar.umask
 		transfer.unpackLimit
@@ -1050,7 +1049,6 @@ _git_config ()
 		user.name
 		user.email
 		user.signingkey
-		whatchanged.difftree
 		branch. remote.
 	"
 }
-- 
1.5.6.1.141.ge3ab.dirty
