From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/2] completion: complete merge-base options
Date: Sat, 11 Jan 2014 14:27:12 +0000
Message-ID: <8a66d7faa732647badcb7ac76c6e90ff7e694686.1389450433.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 11 15:33:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1zcf-0004K5-Cl
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jan 2014 15:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbaAKOdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jan 2014 09:33:09 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:47834 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbaAKOdH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jan 2014 09:33:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id C59642C97B;
	Sat, 11 Jan 2014 14:27:30 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GhNhYaSPSIAk; Sat, 11 Jan 2014 14:27:29 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 4BCBD2C986;
	Sat, 11 Jan 2014 14:27:25 +0000 (GMT)
X-Mailer: git-send-email 1.8.5.226.g0d60d77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240330>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 contrib/completion/git-completion.bash | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4fe5ce3..e74d402 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1499,6 +1499,12 @@ _git_mergetool ()
 
 _git_merge_base ()
 {
+	case "$cur" in
+	--*)
+		__gitcomp "--octopus --independent --is-ancestor --fork-point"
+		return
+		;;
+	esac
 	__gitcomp_nl "$(__git_refs)"
 }
 
-- 
1.8.5.226.g0d60d77
