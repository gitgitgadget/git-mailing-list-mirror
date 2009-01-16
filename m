From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 3/5] bash: add missing format-patch command line options
Date: Fri, 16 Jan 2009 17:02:04 +0100
Message-ID: <1232121724-10188-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 16 17:04:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNrAT-0007OE-4A
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 17:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716AbZAPQCJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 11:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754696AbZAPQCH
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 11:02:07 -0500
Received: from francis.fzi.de ([141.21.7.5]:55206 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753945AbZAPQCF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 11:02:05 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Jan 2009 17:02:03 +0100
X-Mailer: git-send-email 1.6.1.198.geb475f
X-OriginalArrivalTime: 16 Jan 2009 16:02:03.0974 (UTC) FILETIME=[C604EE60:01C977F3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105968>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index c35f86d..fc16aaa 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -838,6 +838,8 @@ _git_format_patch ()
 			--not --all
 			--cover-letter
 			--no-prefix --src-prefix=3D --dst-prefix=3D
+			--inline --suffix=3D --ignore-if-in-upstream
+			--subject-prefix=3D
 			"
 		return
 		;;
--=20
1.6.1.198.geb475f
