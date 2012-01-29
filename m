From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH] completion: --edit-description option for git-branch
Date: Sun, 29 Jan 2012 13:55:33 +0100
Message-ID: <1327841733-999-1-git-send-email-ralf.thielow@googlemail.com>
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@googlemail.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jan 29 13:55:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrUIN-0004at-9m
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 13:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239Ab2A2Mzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 07:55:43 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48590 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab2A2Mzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 07:55:42 -0500
Received: by eaal13 with SMTP id l13so795450eaa.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 04:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=3rTAOhHTutt1u29nDWp10+uz4qk7qQ1c9LpajTzyVak=;
        b=JM+imgzn+E3L+i6bJu0qHMl1GqCEU682B/zoBLpBLudFUmrDNtHo66YptEYF5hCk0k
         VAhj3NgjYvrCAnf/uC1ONoATicoaHmw707rZCuoTNl33e9ZH7+h5zFO+DSthQ+XKCMWj
         BoV1Aob5MnnKgHosqAZ7UZwyS4Y37YVwYouWU=
Received: by 10.213.20.131 with SMTP id f3mr2240227ebb.35.1327841741515;
        Sun, 29 Jan 2012 04:55:41 -0800 (PST)
Received: from ralf-ubuntu.zw.xcom.de (dslb-094-223-179-054.pools.arcor-ip.net. [94.223.179.54])
        by mx.google.com with ESMTPS id e12sm58025644eea.5.2012.01.29.04.55.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jan 2012 04:55:40 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189287>

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1496c6d..e44eefd 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1152,7 +1152,7 @@ _git_branch ()
 		__gitcomp "
 			--color --no-color --verbose --abbrev= --no-abbrev
 			--track --no-track --contains --merged --no-merged
-			--set-upstream
+			--set-upstream --edit-description
 			"
 		;;
 	*)
-- 
1.7.9.dirty
