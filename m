From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] bash: add '--merges' to common 'git log' options
Date: Mon, 13 Jul 2009 17:11:45 +0200
Message-ID: <48eaed566b8db43b6552893da52d76649d6c7f77.1247497864.git.szeder@ira.uka.de>
References: <0f4a962e946f68ec0d7a4c2e568fb3e5ae2a10bc.1247497864.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 13 17:12:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQNCM-0005rM-5J
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 17:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102AbZGMPMD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jul 2009 11:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756137AbZGMPMD
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 11:12:03 -0400
Received: from francis.fzi.de ([141.21.7.5]:14702 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756136AbZGMPMC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 11:12:02 -0400
Received: from [127.0.1.1] ([141.21.12.127]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 13 Jul 2009 17:12:01 +0200
X-Mailer: git-send-email 1.6.4.rc0.78.g75597
In-Reply-To: <0f4a962e946f68ec0d7a4c2e568fb3e5ae2a10bc.1247497864.git.szeder@ira.uka.de>
In-Reply-To: <0f4a962e946f68ec0d7a4c2e568fb3e5ae2a10bc.1247497864.git.szeder@ira.uka.de>
References: <0f4a962e946f68ec0d7a4c2e568fb3e5ae2a10bc.1247497864.git.szeder@ira.uka.de>
X-OriginalArrivalTime: 13 Jul 2009 15:12:01.0756 (UTC) FILETIME=[461651C0:01CA03CC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123197>

=2E.. so it's available for git log, shortlog and gitk.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 90edc8c..bc2d8b4 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1114,7 +1114,7 @@ _git_ls_tree ()
 __git_log_common_options=3D"
 	--not --all
 	--branches --tags --remotes
-	--first-parent --no-merges
+	--first-parent --merges --no-merges
 	--max-count=3D
 	--max-age=3D --since=3D --after=3D
 	--min-age=3D --until=3D --before=3D
--=20
1.6.4.rc0.78.g75597
