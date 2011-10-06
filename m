From: Teemu Matilainen <teemu.matilainen@iki.fi>
Subject: [PATCH 3/3] completion: push --set-upstream
Date: Thu,  6 Oct 2011 21:40:31 +0300
Message-ID: <1317926431-609-3-git-send-email-teemu.matilainen@iki.fi>
References: <1317926431-609-1-git-send-email-teemu.matilainen@iki.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 20:50:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBt1X-0004nJ-HU
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 20:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221Ab1JFSuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 14:50:07 -0400
Received: from mx.reaktor.fi ([82.203.205.80]:43171 "EHLO mx.reaktor.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758979Ab1JFSuG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 14:50:06 -0400
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Oct 2011 14:50:06 EDT
Received: from localhost.localdomain (v18-46.openvpn.reaktor.fi [10.1.18.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx.reaktor.fi (Postfix) with ESMTPSA id ECDC43BACE;
	Thu,  6 Oct 2011 21:41:26 +0300 (EEST)
X-Mailer: git-send-email 1.7.7.138.g7f41b6
In-Reply-To: <1317926431-609-1-git-send-email-teemu.matilainen@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183018>

Signed-off-by: Teemu Matilainen <teemu.matilainen@iki.fi>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 847e6e9..344119b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1730,7 +1730,7 @@ _git_push ()
 	--*)
 		__gitcomp "
 			--all --mirror --tags --dry-run --force --verbose
-			--receive-pack= --repo=
+			--receive-pack= --repo= --set-upstream
 		"
 		return
 		;;
-- 
1.7.7.138.g7f41b6
