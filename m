From: Sergey Organov <sorganov@gmail.com>
Subject: [PATCH] Documentation/git-rebase.txt: make it explicit in the
 syntax there is no way to specify <branch> without <upstream>.
Date: Fri, 29 Aug 2014 17:51:46 +0400
Message-ID: <87fvfrlg86.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 17:48:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTuyu-0006Tw-Nq
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 17:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbaIPPrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 11:47:40 -0400
Received: from mail.javad.com ([54.86.164.124]:47170 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753050AbaIPPrk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 11:47:40 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id AFFB160BF3;
	Tue, 16 Sep 2014 15:47:38 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XTuyf-0003Bm-5R; Tue, 16 Sep 2014 19:47:37 +0400
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257131>

Current syntax description makes one wonder if there is any syntactic way
to distinguish between <branch> and <upstream> so that one can specify
<branch> but not <upstream>. The change makes it explicit that these
arguments are in fact positional.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f14100a..4138554 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
-	[<upstream>] [<branch>]
+	[<upstream> [<branch>]]
 'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
 'git rebase' --continue | --skip | --abort | --edit-todo
-- 
1.9.3
