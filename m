From: sorganov@gmail.com
Subject: [PATCH] Documentation/git-merge.txt: improve SYNOPSIS
Date: Tue, 21 Apr 2015 14:08:08 +0300
Message-ID: <1429614488-20731-1-git-send-email-sorganov@gmail.com>
Cc: gitster@pobox.com, Sergey Organov <sorganov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 13:14:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkW84-00085z-Vf
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 13:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbbDULOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 07:14:08 -0400
Received: from mail.javad.com ([54.86.164.124]:56029 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441AbbDULOH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 07:14:07 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Apr 2015 07:14:07 EDT
Received: from localhost6.localdomain6 (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id AA93D6189D;
	Tue, 21 Apr 2015 11:08:17 +0000 (UTC)
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
	by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id t3LB8DXB020775;
	Tue, 21 Apr 2015 14:08:14 +0300
Received: (from osv@localhost)
	by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id t3LB88Wt020771;
	Tue, 21 Apr 2015 14:08:08 +0300
X-Mailer: git-send-email 1.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267523>

From: Sergey Organov <sorganov@gmail.com>

Get rid of outdated explicit list of options.

Reflect that the obsolete form:

'git merge' <msg> HEAD <commit>...

could also have options.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/git-merge.txt | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 1f94908..1de61a4 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -9,10 +9,8 @@ git-merge - Join two or more development histories together
 SYNOPSIS
 --------
 [verse]
-'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
-	[-s <strategy>] [-X <strategy-option>] [-S[<key-id>]]
-	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
-'git merge' <msg> HEAD <commit>...
+'git merge' [options] [-m <msg>] [<commit>...]
+'git merge' [options] <msg> HEAD <commit>...
 'git merge' --abort
 
 DESCRIPTION
-- 
1.9.3
