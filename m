From: Teemu Matilainen <teemu.matilainen@iki.fi>
Subject: [PATCH 2/3] completion: commit --fixup and --squash
Date: Thu,  6 Oct 2011 21:40:30 +0300
Message-ID: <1317926431-609-2-git-send-email-teemu.matilainen@iki.fi>
References: <1317926431-609-1-git-send-email-teemu.matilainen@iki.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 20:50:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBt1M-0004ig-Qm
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 20:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965264Ab1JFSuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 14:50:09 -0400
Received: from mx.reaktor.fi ([82.203.205.80]:43169 "EHLO mx.reaktor.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758990Ab1JFSuG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 14:50:06 -0400
Received: from localhost.localdomain (v18-46.openvpn.reaktor.fi [10.1.18.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx.reaktor.fi (Postfix) with ESMTPSA id 0CF523BAD0;
	Thu,  6 Oct 2011 21:41:22 +0300 (EEST)
X-Mailer: git-send-email 1.7.7.138.g7f41b6
In-Reply-To: <1317926431-609-1-git-send-email-teemu.matilainen@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183017>

Signed-off-by: Teemu Matilainen <teemu.matilainen@iki.fi>
---
 contrib/completion/git-completion.bash |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 656297d..847e6e9 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1259,7 +1259,8 @@ _git_commit ()
 			" "" "${cur##--cleanup=}"
 		return
 		;;
-	--reuse-message=*|--reedit-message=*)
+	--reuse-message=*|--reedit-message=*|\
+	--fixup=*|--squash=*)
 		__gitcomp "$(__git_refs)" "" "${cur#*=}"
 		return
 		;;
@@ -1274,7 +1275,7 @@ _git_commit ()
 			--dry-run --reuse-message= --reedit-message=
 			--reset-author --file= --message= --template=
 			--cleanup= --untracked-files --untracked-files=
-			--verbose --quiet
+			--verbose --quiet --fixup= --squash=
 			"
 		return
 	esac
-- 
1.7.7.138.g7f41b6
