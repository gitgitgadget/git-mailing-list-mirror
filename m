From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/5] bash: removed unnecessary checks for long options with
	argument
Date: Fri, 16 Jan 2009 17:01:57 +0100
Message-ID: <1232121717-10145-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 16 17:03:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNrAI-0007JH-Mz
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 17:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbZAPQB7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 11:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945AbZAPQB7
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 11:01:59 -0500
Received: from francis.fzi.de ([141.21.7.5]:55186 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753931AbZAPQB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 11:01:58 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Jan 2009 17:01:56 +0100
X-Mailer: git-send-email 1.6.1.198.geb475f
X-OriginalArrivalTime: 16 Jan 2009 16:01:56.0630 (UTC) FILETIME=[C1A45360:01C977F3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105967>

__gitcomp takes care of it since 5447aac7 (bash: fix long option with
argument double completion, 2008-03-05)

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 4292b23..c35f86d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -643,7 +643,6 @@ _git_branch ()
 	done
=20
 	case "${COMP_WORDS[COMP_CWORD]}" in
-	--*=3D*)	COMPREPLY=3D() ;;
 	--*)
 		__gitcomp "
 			--color --no-color --verbose --abbrev=3D --no-abbrev
@@ -1692,7 +1691,6 @@ _git ()
=20
 	if [ -z "$command" ]; then
 		case "${COMP_WORDS[COMP_CWORD]}" in
-		--*=3D*) COMPREPLY=3D() ;;
 		--*)   __gitcomp "
 			--paginate
 			--no-pager
--=20
1.6.1.198.geb475f
