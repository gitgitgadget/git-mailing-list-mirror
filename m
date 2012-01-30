From: Adrian Weimann <adrian.weimann@googlemail.com>
Subject: [PATCH] completion: --edit option for git-merge
Date: Mon, 30 Jan 2012 14:37:50 +0100
Message-ID: <1327930670-32396-1-git-send-email-adrian.weimann@googlemail.com>
Cc: Adrian Weimann <adrian.weimann@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 30 14:38:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrrRE-0002a4-Mn
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 14:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594Ab2A3NiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 08:38:24 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38388 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab2A3NiY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 08:38:24 -0500
Received: by eaal13 with SMTP id l13so1116736eaa.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 05:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=8oHxgcDiVQO65MWp4+3ZHPNDXT5ZVRn93bwf6Lfb0xo=;
        b=J2/dbGgGV7pq6pwEN6II+965u+C/qytXhIfK5R7PWCbPLsHJ810NxlHQLOAv5IEEyi
         Cp4iWbJR7UzrMyNaKpLjBw9L4ygPyUQJsmJ6q2/NV3k/fDH9tdMhvuCemuISEKkf47Oz
         /mZ3wBG6Se831VXDTP98gSCI47IY9EXnaLlY8=
Received: by 10.213.113.138 with SMTP id a10mr1241758ebq.25.1327930702836;
        Mon, 30 Jan 2012 05:38:22 -0800 (PST)
Received: from localhost.localdomain (dslb-178-003-128-181.pools.arcor-ip.net. [178.3.128.181])
        by mx.google.com with ESMTPS id n56sm72708565eeh.6.2012.01.30.05.38.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 05:38:22 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189358>

Signed-off-by: Adrian Weimann <adrian.weimann@googlemail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1496c6d..be1fcea 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1622,7 +1622,7 @@ _git_log ()
 
 __git_merge_options="
 	--no-commit --no-stat --log --no-log --squash --strategy
-	--commit --stat --no-squash --ff --no-ff --ff-only
+	--commit --stat --no-squash --ff --no-ff --ff-only --edit
 "
 
 _git_merge ()
-- 
1.7.9
