From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Documentation/merge-options.txt: order options in alphabetical groups
Date: Thu, 22 Oct 2009 12:24:52 +0300
Message-ID: <87iqe7zspn.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 11:30:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0tzp-0000vO-Vw
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 11:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726AbZJVJaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 05:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754719AbZJVJaC
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 05:30:02 -0400
Received: from lo.gmane.org ([80.91.229.12]:34626 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754711AbZJVJaB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 05:30:01 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N0tzf-0000qt-Rz
	for git@vger.kernel.org; Thu, 22 Oct 2009 11:30:03 +0200
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 11:30:03 +0200
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 11:30:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:CBz7jh+5IpDwnxDGd1JMaST0Zqc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131013>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/merge-options.txt |   79 ++++++++++++++++++++-------------------
 1 files changed, 41 insertions(+), 38 deletions(-)

The --option and --no-options have been grouped together as in:

    --option
    --no-option

The alphabetical order is according to the --option.

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index adadf8e..f1fdb65 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -1,43 +1,42 @@
--q::
---quiet::
-	Operate quietly.
-
--v::
---verbose::
-	Be verbose.
+--commit::
+--no-commit::
+	Perform the merge and commit the result. This option can
+	be used to override --no-commit.
 
---stat::
-	Show a diffstat at the end of the merge. The diffstat is also
-	controlled by the configuration option merge.stat.
+	With --no-commit perform the merge but pretend the merge
+	failed and do not autocommit, to give the user a chance to
+	inspect and further tweak the merge result before committing.
 
--n::
---no-stat::
-	Do not show a diffstat at the end of the merge.
+--ff::
+--no-ff::
+	Do not generate a merge commit if the merge resolved as
+	a fast-forward, only update the branch pointer. This is
+	the default behavior of git-merge.
 
---summary::
---no-summary::
-	Synonyms to --stat and --no-stat; these are deprecated and will be
-	removed in the future.
+	With --no-ff Generate a merge commit even if the merge
+	resolved as a fast-forward.
 
 --log::
+--no-log::
 	In addition to branch names, populate the log message with
 	one-line descriptions from the actual commits that are being
 	merged.
 
---no-log::
-	Do not list one-line descriptions from the actual commits being
-	merged.
+	With --no-log do not list one-line descriptions from the
+	actual commits being merged.
 
---no-commit::
-	Perform the merge but pretend the merge failed and do
-	not autocommit, to give the user a chance to inspect and
-	further tweak the merge result before committing.
 
---commit::
-	Perform the merge and commit the result. This option can
-	be used to override --no-commit.
+--stat::
+-n::
+--no-stat::
+	Show a diffstat at the end of the merge. The diffstat is also
+	controlled by the configuration option merge.stat.
+
+	With -n or --no-stat do not show a diffstat at the end of the
+	merge.
 
 --squash::
+--no-squash::
 	Produce the working tree and index state as if a real
 	merge happened (except for the merge information),
 	but do not actually make a commit or
@@ -47,18 +46,9 @@
 	top of the current branch whose effect is the same as
 	merging another branch (or more in case of an octopus).
 
---no-squash::
-	Perform the merge and commit the result. This option can
-	be used to override --squash.
 
---no-ff::
-	Generate a merge commit even if the merge resolved as a
-	fast-forward.
-
---ff::
-	Do not generate a merge commit if the merge resolved as
-	a fast-forward, only update the branch pointer. This is
-	the default behavior of git-merge.
+	With --no-squash perform the merge and commit the result. This
+	option can be used to override --squash.
 
 -s <strategy>::
 --strategy=<strategy>::
@@ -67,3 +57,16 @@
 	If there is no `-s` option, a built-in list of strategies
 	is used instead ('git-merge-recursive' when merging a single
 	head, 'git-merge-octopus' otherwise).
+
+--summary::
+--no-summary::
+	Synonyms to --stat and --no-stat; these are deprecated and will be
+	removed in the future.
+
+-q::
+--quiet::
+	Operate quietly.
+
+-v::
+--verbose::
+	Be verbose.
-- 
1.6.4.3
