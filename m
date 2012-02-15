From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH] completion: --list option for git-branch
Date: Wed, 15 Feb 2012 21:36:58 +0100
Message-ID: <1329338218-9822-1-git-send-email-ralf.thielow@googlemail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Feb 15 21:37:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxlbH-0002VR-Vt
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 21:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443Ab2BOUhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 15:37:11 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34033 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab2BOUhI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 15:37:08 -0500
Received: by bkcjm19 with SMTP id jm19so1351792bkc.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 12:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=9PHjaWIedKrXi79RsQifLnn6xx/I4jOPN8jQbPgb2tk=;
        b=kzTo+W83FmmMQNI3d9H0Yhz2sPgnmvuDdRmQstUiTj9vzEzpZ/87sd6Xttr00FZCqZ
         XFXpVil8woGkhtZyBSSoZo4YcI5waAEB1QMQc7Kr/JFFBppabENV+rhvOi/tMmmLKt3c
         XUDKPUdcorSVJhmW/AzGf38q4iTPZTx8ioPrc=
Received: by 10.205.137.136 with SMTP id io8mr12538879bkc.106.1329338226188;
        Wed, 15 Feb 2012 12:37:06 -0800 (PST)
Received: from ralf-ubuntu.zw.xcom.de (dslb-094-223-179-054.pools.arcor-ip.net. [94.223.179.54])
        by mx.google.com with ESMTPS id e13sm8635114bku.12.2012.02.15.12.37.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 12:37:05 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190851>

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d7367e9..1505cff 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1137,7 +1137,7 @@ _git_branch ()
 		__gitcomp "
 			--color --no-color --verbose --abbrev= --no-abbrev
 			--track --no-track --contains --merged --no-merged
-			--set-upstream --edit-description
+			--set-upstream --edit-description --list
 			"
 		;;
 	*)
-- 
1.7.9.1
