From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/4] completion: add missing terminator in case statement
Date: Sat, 19 Jul 2014 10:45:54 +0100
Message-ID: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 19 11:46:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8RDi-0007wL-Q3
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 11:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502AbaGSJqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 05:46:13 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:36616 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875AbaGSJqM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 05:46:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 1F6FFCDA3A8;
	Sat, 19 Jul 2014 10:46:12 +0100 (BST)
X-Quarantine-ID: <m3K783PFFkhB>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m3K783PFFkhB; Sat, 19 Jul 2014 10:46:08 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id EB5A1CDA552;
	Sat, 19 Jul 2014 10:46:03 +0100 (BST)
X-Mailer: git-send-email 2.0.1.472.g6f92e5f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253871>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7a6e1d7..d0b2895 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1627,6 +1627,7 @@ _git_push ()
 	--repo)
 		__gitcomp_nl "$(__git_remotes)"
 		return
+		;;
 	esac
 	case "$cur" in
 	--repo=*)
-- 
2.0.1.472.g6f92e5f.dirty
