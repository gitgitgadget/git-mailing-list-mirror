From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: add '--abort' to 'git am' options
Date: Wed, 23 Jul 2008 19:15:45 +0200
Message-ID: <1216833345-16008-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 19:16:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLhxG-0008NH-DS
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 19:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbYGWRPq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 13:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbYGWRPq
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 13:15:46 -0400
Received: from francis.fzi.de ([141.21.7.5]:44385 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751797AbYGWRPp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 13:15:45 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 23 Jul 2008 19:15:44 +0200
X-Mailer: git-send-email 1.6.0.rc0.36.g3c05
X-OriginalArrivalTime: 23 Jul 2008 17:15:44.0461 (UTC) FILETIME=[BDB7F7D0:01C8ECE7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89719>

We have 'git am --abort' since commit 3e5057a8, but no completion
support for it.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 8b1426a..3a99c40 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -489,7 +489,7 @@ _git_am ()
 {
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}" dir=3D"$(__gitdir)"
 	if [ -d "$dir"/rebase-apply ]; then
-		__gitcomp "--skip --resolved"
+		__gitcomp "--skip --resolved --abort"
 		return
 	fi
 	case "$cur" in
--=20
1.6.0.rc0.36.g3c05
