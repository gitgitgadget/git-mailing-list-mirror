From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] bash: add support for 'git stash pop --index' option
Date: Mon,  8 Jun 2009 18:28:51 +0200
Message-ID: <3456b3a568969b2e0451cdc7a9beebfeb5763039.1244475542.git.szeder@ira.uka.de>
References: <27f7124b574aa6ac4391b9bd029242ceb5874447.1244475542.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:29:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDhig-0001aY-Lb
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 18:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772AbZFHQ2y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 12:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754872AbZFHQ2x
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 12:28:53 -0400
Received: from francis.fzi.de ([141.21.7.5]:59309 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751257AbZFHQ2x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 12:28:53 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Jun 2009 18:28:54 +0200
X-Mailer: git-send-email 1.6.3.2.247.gc361f.dirty
In-Reply-To: <27f7124b574aa6ac4391b9bd029242ceb5874447.1244475542.git.szeder@ira.uka.de>
In-Reply-To: <27f7124b574aa6ac4391b9bd029242ceb5874447.1244475542.git.szeder@ira.uka.de>
References: <27f7124b574aa6ac4391b9bd029242ceb5874447.1244475542.git.szeder@ira.uka.de>
X-OriginalArrivalTime: 08 Jun 2009 16:28:54.0847 (UTC) FILETIME=[373EE4F0:01C9E856]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121084>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index fa899eb..480d85e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1887,7 +1887,10 @@ _git_stash ()
 		apply,--*)
 			__gitcomp "--index"
 			;;
-		show,--*|drop,--*|pop,--*|branch,--*)
+		pop,--*)
+			__gitcomp "--index"
+			;;
+		show,--*|drop,--*|branch,--*)
 			COMPREPLY=3D()
 			;;
 		show,*|apply,*|drop,*|pop,*|branch,*)
--=20
1.6.3.2.247.gc361f.dirty
