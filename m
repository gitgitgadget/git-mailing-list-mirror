From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Documentation/fetch-options.txt: order options alphabetically
Date: Wed, 21 Oct 2009 23:07:49 +0300
Message-ID: <87eiow1pey.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 22:08:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0hTv-0007Oz-T2
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 22:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbZJUUIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 16:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753283AbZJUUIR
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 16:08:17 -0400
Received: from lo.gmane.org ([80.91.229.12]:52915 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233AbZJUUIR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 16:08:17 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N0hTo-0007Mg-RA
	for git@vger.kernel.org; Wed, 21 Oct 2009 22:08:20 +0200
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 22:08:20 +0200
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 22:08:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:EE4XXLmhAQjPQLjNmXnzQ163Nnk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130957>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/fetch-options.txt |   48 +++++++++++++++++++-------------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 5eb2b0e..2886874 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -1,25 +1,13 @@
-ifndef::git-pull[]
--q::
---quiet::
-	Pass --quiet to git-fetch-pack and silence any other internally
-	used git commands.
-
--v::
---verbose::
-	Be verbose.
-endif::git-pull[]
-
 -a::
 --append::
 	Append ref names and object names of fetched refs to the
 	existing contents of `.git/FETCH_HEAD`.  Without this
 	option old data in `.git/FETCH_HEAD` will be overwritten.
 
---upload-pack <upload-pack>::
-	When given, and the repository to fetch from is handled
-	by 'git-fetch-pack', '--exec=<upload-pack>' is passed to
-	the command to specify non-default path for the command
-	run on the other end.
+--depth=<depth>::
+	Deepen the history of a 'shallow' repository created by
+	`git clone` with `--depth=<depth>` option (see linkgit:git-clone[1])
+	by the specified number of commits.
 
 -f::
 --force::
@@ -29,6 +17,10 @@ endif::git-pull[]
 	fetches is a descendant of `<lbranch>`.  This option
 	overrides that check.
 
+-k::
+--keep::
+	Keep downloaded pack.
+
 ifdef::git-pull[]
 --no-tags::
 endif::git-pull[]
@@ -49,10 +41,6 @@ endif::git-pull[]
 	flag lets all tags and their associated objects be
 	downloaded.
 
--k::
---keep::
-	Keep downloaded pack.
-
 -u::
 --update-head-ok::
 	By default 'git-fetch' refuses to update the head which
@@ -62,7 +50,19 @@ endif::git-pull[]
 	implementing your own Porcelain you are not supposed to
 	use it.
 
---depth=<depth>::
-	Deepen the history of a 'shallow' repository created by
-	`git clone` with `--depth=<depth>` option (see linkgit:git-clone[1])
-	by the specified number of commits.
+--upload-pack <upload-pack>::
+	When given, and the repository to fetch from is handled
+	by 'git-fetch-pack', '--exec=<upload-pack>' is passed to
+	the command to specify non-default path for the command
+	run on the other end.
+
+ifndef::git-pull[]
+-q::
+--quiet::
+	Pass --quiet to git-fetch-pack and silence any other internally
+	used git commands.
+
+-v::
+--verbose::
+	Be verbose.
+endif::git-pull[]
-- 
1.6.4.3
