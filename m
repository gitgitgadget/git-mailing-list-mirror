From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/5] git-completion.bash: lexical sorting for diff.statGraphWidth
Date: Sun, 21 Apr 2013 18:35:47 +0530
Message-ID: <1366549551-18763-2-git-send-email-artagnon@gmail.com>
References: <1366549551-18763-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 15:06:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTty7-000783-KL
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 15:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368Ab3DUNGC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 09:06:02 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:41805 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab3DUNGB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 09:06:01 -0400
Received: by mail-pb0-f47.google.com with SMTP id rq13so210083pbb.20
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 06:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=PAgOPqte3dZahvPF6tf7FTnLWleZmzT16kW0J5sx+FA=;
        b=tJdg1rogo9l58S9gs765seo5xGMQvNK/Zf+mrd7hkDOIGZhbOkqsHoc8G1E2NT2S2f
         eqKEZguitvgBFMMgNwWE/wd+KTnmUGMuVILUfRR6QZz27oy7DS0ORecibXUXe03tafQK
         ygNE18HzekzAIIe86fjE3yOxT8Trf6C12kpfOW/16qL6NvTwtTG0sie9yr1+0A/Mg4rd
         ik1YWi/2warNqXTozoKQlmHF+8DdWQLM08oc7L2GGjXnYU7ziS42w4Ivs0p051JCDeDB
         ve22WBjTYr7SdWSCJ4sEzNg/bP/cE7vzXqLalfReMLZzGpDGTlMTHnDbPXjKxqQEvwhq
         sD9w==
X-Received: by 10.66.155.102 with SMTP id vv6mr7389503pab.64.1366549560736;
        Sun, 21 Apr 2013 06:06:00 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id aa8sm1570112pad.14.2013.04.21.06.05.58
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 06:05:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366549551-18763-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221949>

df44483a (diff --stat: add config option to limit graph width,
2012-03-01) added the option diff.startGraphWidth to the list of
configuration variables in git-completion.bash, but failed to notice
that the list is sorted alphabetically.  Move it to its rightful place
in the list.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6df62c2..6bfb9ad 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2058,13 +2058,13 @@ _git_config ()
 		core.whitespace
 		core.worktree
 		diff.autorefreshindex
-		diff.statGraphWidth
 		diff.external
 		diff.ignoreSubmodules
 		diff.mnemonicprefix
 		diff.noprefix
 		diff.renameLimit
 		diff.renames
+		diff.statGraphWidth
 		diff.suppressBlankEmpty
 		diff.tool
 		diff.wordRegex
-- 
1.8.2.1.501.gd2949c7
