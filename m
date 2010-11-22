From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] rebase -i: remove undocumented '--verify' flag
Date: Mon, 22 Nov 2010 07:48:24 +0100
Message-ID: <1290408504-14639-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 13:48:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKVov-0004Tu-MG
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 13:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099Ab0KVMsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 07:48:30 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35670 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755471Ab0KVMs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 07:48:28 -0500
Received: by vws13 with SMTP id 13so3265777vws.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 04:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=SXvgbrAsg2iAUeR9IbxTN+Wrh0wriSWN7xPAasTffsU=;
        b=oJ+OBuj0HWrtFh27g8714gkgmpZkUvm+ZwmhIKYAILGLPUerpHewrppX2FInaKpgJM
         F5A+qvhaerCmDJUOyGmrIMlYUztSap17fSD81SAsBFM3qpTHnf/0XwqCiQ1h8Vztsxst
         FquO2OAs/4xgQ2i8d4uaYPKs7a/lAQF9gHt+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=EcwO9q5nMeJdo7tyJx4jWlZg0ExL7VNd3FiZ03pF3wIjkPQXHovU/7TH3XVQ0ZzhtA
         92bXwbaGU8qu+kXil81iciZbE8Dxt+5biKKy7okWbwyjWH8F1Ov4zNRK+5jQGCuw0DC7
         OD/pgb4KpB28/7ly6BopmIhV6ko7Kh2URxCNk=
Received: by 10.220.188.68 with SMTP id cz4mr1453734vcb.74.1290430104638;
        Mon, 22 Nov 2010 04:48:24 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id q3sm948731vcr.27.2010.11.22.04.48.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 04:48:23 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.190.gfb4ae
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161886>

Remove the undocumented and unused '--verify' flag from interactive
rebase.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
This tiny and almost pointless patch has been in my refactor-rebase
branch for quite some time. As it's not really related to the
refactoring, I'm sending it off separately instead.

 git-rebase--interactive.sh |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a27952d..f7171e8 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -726,8 +726,6 @@ do
 	--no-verify)
 		OK_TO_SKIP_PRE_REBASE=yes
 		;;
-	--verify)
-		;;
 	--continue)
 		is_standalone "$@" || usage
 		get_saved_options
-- 
1.7.3.2.190.gfb4ae
