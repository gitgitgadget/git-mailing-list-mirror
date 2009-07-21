From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 2/2] Replace remaining git-* calls in git stash
Date: Tue, 21 Jul 2009 22:06:17 +0200
Message-ID: <1248206777-6984-2-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <1248206777-6984-1-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:14:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLj8-0006et-4g
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617AbZGUUOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754461AbZGUUOG
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:14:06 -0400
Received: from odin.auto.tuwien.ac.at ([128.130.60.3]:60337 "EHLO
	mail.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbZGUUOF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:14:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.auto.tuwien.ac.at (Postfix) with ESMTP id 17D2F130396E;
	Tue, 21 Jul 2009 22:06:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at odin.auto.tuwien.ac.at
Received: from mail.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (odin.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pVWCni5JcwgI; Tue, 21 Jul 2009 22:06:18 +0200 (CEST)
Received: from thor.localdomain (thor.auto.tuwien.ac.at [128.130.60.15])
	by mail.auto.tuwien.ac.at (Postfix) with ESMTP id 06639130396F;
	Tue, 21 Jul 2009 22:06:18 +0200 (CEST)
Received: by thor.localdomain (Postfix, from userid 3001)
	id 016856800645; Tue, 21 Jul 2009 22:06:17 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.3
In-Reply-To: <1248206777-6984-1-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123690>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 git-stash.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 5b4b4e6..03e589f 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -203,7 +203,7 @@ apply_stash () {
 		git diff-tree --binary $s^2^..$s^2 | git apply --cached
 		test $? -ne 0 &&
 			die 'Conflicts in index. Try without --index.'
-		unstashed_index_tree=$(git-write-tree) ||
+		unstashed_index_tree=$(git write-tree) ||
 			die 'Could not save index tree'
 		git reset
 	fi
@@ -297,7 +297,7 @@ apply_to_branch () {
 	fi
 	stash=$2
 
-	git-checkout -b $branch $stash^ &&
+	git checkout -b $branch $stash^ &&
 	apply_stash --index $stash &&
 	drop_stash $stash
 }
-- 
1.5.6.5
