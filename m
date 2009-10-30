From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] bash completion: remove "diff.renameLimit." (with trailing dot)
Date: Fri, 30 Oct 2009 17:53:31 +0100
Message-ID: <1256921611-20171-1-git-send-email-markus.heidelberg@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Markus Heidelberg <markus.heidelberg@web.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 17:54:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3uju-000465-DQ
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 17:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbZJ3QyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 12:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbZJ3QyF
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 12:54:05 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:60728 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932624AbZJ3QyC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 12:54:02 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 62CD713BA0DCF;
	Fri, 30 Oct 2009 17:54:06 +0100 (CET)
Received: from [89.59.69.28] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1N3ujm-00074P-00; Fri, 30 Oct 2009 17:54:06 +0100
X-Mailer: git-send-email 1.6.5.2.86.g61663
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/XFGH7OFcpVSt70d9hNXlDPFLZJFaH0d+dlwWO
	CnmVVJDtqUmnjqbdLmF7OkQeupl7xop9VG1Pnif8zxp1Km6m2X
	7aExikXdo3iJ/RyX+7tw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131715>

This was accidentally added with commit 98171a0 (bash completion: Sync
config variables with their man pages).

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 contrib/completion/git-completion.bash |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e3ddecc..e129ef9 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1641,7 +1641,6 @@ _git_config ()
 		diff.external
 		diff.mnemonicprefix
 		diff.renameLimit
-		diff.renameLimit.
 		diff.renames
 		diff.suppressBlankEmpty
 		diff.tool
-- 
1.6.5.2.86.g61663
