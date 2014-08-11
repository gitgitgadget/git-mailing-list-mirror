From: Sergey Organov <sorganov@gmail.com>
Subject: [PATCH] Documentation/git-rebase.txt: fix -f description to match
 actual git behavior.
Date: Tue, 12 Aug 2014 00:22:48 +0400
Message-ID: <87bnrq22uf.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 22:22:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGw7L-0003EQ-GA
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 22:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbaHKUWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 16:22:52 -0400
Received: from mail.javad.com ([54.86.164.124]:53753 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429AbaHKUWv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 16:22:51 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 1E26C61814;
	Mon, 11 Aug 2014 20:22:50 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1XGw7E-0000En-C0; Tue, 12 Aug 2014 00:22:48 +0400
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255138>

Previous description of -f option was wrong as "git rebase" does not
require -f to perform rebase when "current branch is a descendant of
the commit you are rebasing onto", provided commit(s) to be rebased
contain merge(s).

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/git-rebase.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 2a93c64..62dac31 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -316,10 +316,9 @@ which makes little sense.
 
 -f::
 --force-rebase::
-	Force the rebase even if the current branch is a descendant
-	of the commit you are rebasing onto.  Normally non-interactive rebase will
-	exit with the message "Current branch is up to date" in such a
-	situation.
+	Force the rebase even if the result will only change commit
+	timestamps. Normally non-interactive rebase will exit with the
+	message "Current branch is up to date" in such a situation.
 	Incompatible with the --interactive option.
 +
 You may find this (or --no-ff with an interactive rebase) helpful after
-- 
1.9.3
