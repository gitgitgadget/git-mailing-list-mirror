From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Move 'stupid' merge strategy to contrib.
Date: Sat,  5 Jul 2008 23:00:07 +0200
Message-ID: <1215291607-20781-1-git-send-email-vmiklos@frugalware.org>
References: <1215269031-19559-1-git-send-email-vmiklos@frugalware.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 23:00:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFEsH-0002k7-34
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 23:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbYGEU74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 16:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752874AbYGEU74
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 16:59:56 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:36043 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbYGEU7z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 16:59:55 -0400
Received: from vmobile.example.net (dsl5401C7D7.pool.t-online.hu [84.1.199.215])
	by yugo.frugalware.org (Postfix) with ESMTP id C2F141DDC5B;
	Sat,  5 Jul 2008 22:59:53 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id ACFDA1A9CEF; Sat,  5 Jul 2008 23:00:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.322.ge904b.dirty
In-Reply-To: <1215269031-19559-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87466>

As pointed out by Linus, this strategy tries to take the best merge
base, but 'recursive' just does it better. If one needs something more
than 'resolve' then he/she should really use 'recursive' and not
'stupid'.

Given that it may still serve as a good example, don't remove it, just
move it to contrib/examples.
---

n Sat, Jul 05, 2008 at 04:43:51PM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
> Here is one.

Oops, I forgot -M with format-patch.

 .gitignore                                         |    1 -
 Makefile                                           |    3 +--
 .../examples/git-merge-stupid.sh                   |    0
 3 files changed, 1 insertions(+), 3 deletions(-)
 rename git-merge-stupid.sh => contrib/examples/git-merge-stupid.sh (100%)

diff --git a/.gitignore b/.gitignore
index 4ff2fec..8054d9d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -75,7 +75,6 @@ git-merge-one-file
 git-merge-ours
 git-merge-recursive
 git-merge-resolve
-git-merge-stupid
 git-merge-subtree
 git-mergetool
 git-mktag
diff --git a/Makefile b/Makefile
index 78e08d3..bddd1a7 100644
--- a/Makefile
+++ b/Makefile
@@ -241,7 +241,6 @@ SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-merge.sh
-SCRIPT_SH += git-merge-stupid.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-parse-remote.sh
 SCRIPT_SH += git-pull.sh
@@ -1429,7 +1428,7 @@ check-docs::
 	do \
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
-		git-merge-resolve | git-merge-stupid | git-merge-subtree | \
+		git-merge-resolve | git-merge-subtree | \
 		git-fsck-objects | git-init-db | \
 		git-?*--?* ) continue ;; \
 		esac ; \
diff --git a/git-merge-stupid.sh b/contrib/examples/git-merge-stupid.sh
similarity index 100%
rename from git-merge-stupid.sh
rename to contrib/examples/git-merge-stupid.sh
-- 
1.5.6.1.322.ge904b.dirty
