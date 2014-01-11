From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/2] completion: handle --[no-]fork-point options to git-rebase
Date: Sat, 11 Jan 2014 14:27:13 +0000
Message-ID: <5754a97b81fde0d3037a1b2a4a57a4bda5a6ebc6.1389450433.git.john@keeping.me.uk>
References: <8a66d7faa732647badcb7ac76c6e90ff7e694686.1389450433.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 11 15:33:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1zcl-0004RH-Os
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jan 2014 15:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbaAKOdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jan 2014 09:33:09 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:47835 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbaAKOdH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jan 2014 09:33:07 -0500
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Jan 2014 09:33:07 EST
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 590AB22BA0;
	Sat, 11 Jan 2014 14:27:37 +0000 (GMT)
X-Quarantine-ID: <UfLCU978h2fH>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UfLCU978h2fH; Sat, 11 Jan 2014 14:27:37 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id F30482C97C;
	Sat, 11 Jan 2014 14:27:32 +0000 (GMT)
X-Mailer: git-send-email 1.8.5.226.g0d60d77
In-Reply-To: <8a66d7faa732647badcb7ac76c6e90ff7e694686.1389450433.git.john@keeping.me.uk>
In-Reply-To: <8a66d7faa732647badcb7ac76c6e90ff7e694686.1389450433.git.john@keeping.me.uk>
References: <8a66d7faa732647badcb7ac76c6e90ff7e694686.1389450433.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240331>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e74d402..3c1a11f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1637,7 +1637,7 @@ _git_rebase ()
 			--preserve-merges --stat --no-stat
 			--committer-date-is-author-date --ignore-date
 			--ignore-whitespace --whitespace=
-			--autosquash
+			--autosquash --fork-point --no-fork-point
 			"
 
 		return
-- 
1.8.5.226.g0d60d77
