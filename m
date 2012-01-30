From: Adrian Weimann <adrian.weimann@googlemail.com>
Subject: [PATCH] completion: --edit and --no-edit for git-merge
Date: Mon, 30 Jan 2012 20:29:33 +0100
Message-ID: <1327951773-7813-1-git-send-email-adrian.weimann@googlemail.com>
References: <7vhazdcazt.fsf@alter.siamese.dyndns.org>
Cc: Adrian Weimann <adrian.weimann@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 30 20:30:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrwvx-0002tP-9Q
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 20:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314Ab2A3Ta3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 14:30:29 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42193 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab2A3Ta2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 14:30:28 -0500
Received: by eaal13 with SMTP id l13so1231970eaa.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 11:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3vMLoLFp9sF1SSzG3oacR0CurBbggLD3U57lpVB8HVU=;
        b=ppeaOrcxl0EccQ/qaS/xlRO6LSDxR/O2i9Wt2Qtxfq+MUA51ymja96Afpa7fATrJUp
         RESQ36AEhqjpsXiUbBMA2tIH5ri0C0M2cAWlCrjjIJS/+vaf1jF/tNAqrC5ok73E7OMj
         vVpfwScqp0laWyvP7UhIcTOrwL0TB7RO78Rak=
Received: by 10.213.98.71 with SMTP id p7mr263784ebn.101.1327951826844;
        Mon, 30 Jan 2012 11:30:26 -0800 (PST)
Received: from localhost.localdomain (dslb-178-003-128-181.pools.arcor-ip.net. [178.3.128.181])
        by mx.google.com with ESMTPS id y54sm76226127eef.8.2012.01.30.11.30.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 11:30:25 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <7vhazdcazt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189406>

Signed-off-by: Adrian Weimann <adrian.weimann@googlemail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1496c6d..78be195 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1622,7 +1622,7 @@ _git_log ()
 
 __git_merge_options="
 	--no-commit --no-stat --log --no-log --squash --strategy
-	--commit --stat --no-squash --ff --no-ff --ff-only
+	--commit --stat --no-squash --ff --no-ff --ff-only --edit --no-edit
 "
 
 _git_merge ()
-- 
1.7.9
