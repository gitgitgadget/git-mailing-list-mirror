From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: removed unnecessary checks for long options with argument
Date: Fri, 14 Mar 2008 12:15:13 +0100
Message-ID: <1205493313-4717-2-git-send-email-szeder@ira.uka.de>
References: <1205493313-4717-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 12:16:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja7tp-00037J-3f
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 12:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbYCNLPj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 07:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbYCNLP2
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 07:15:28 -0400
Received: from francis.fzi.de ([141.21.7.5]:56294 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752367AbYCNLPR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 07:15:17 -0400
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 14 Mar 2008 12:15:13 +0100
X-Mailer: git-send-email 1.5.4.4.532.ga6828
In-Reply-To: <1205493313-4717-1-git-send-email-szeder@ira.uka.de>
X-OriginalArrivalTime: 14 Mar 2008 11:15:13.0507 (UTC) FILETIME=[AC8D1330:01C885C4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77207>

__gitcomp takes care of it since 5447aac7 (bash: fix long option with
argument double completion, 2008-03-05)

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 2265757..0bb78e7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -539,7 +539,6 @@ _git_branch ()
 	done
=20
 	case "${COMP_WORDS[COMP_CWORD]}" in
-	--*=3D*)	COMPREPLY=3D() ;;
 	--*)
 		__gitcomp "
 			--color --no-color --verbose --abbrev=3D --no-abbrev
@@ -1288,7 +1287,6 @@ _git ()
=20
 	if [ -z "$command" ]; then
 		case "${COMP_WORDS[COMP_CWORD]}" in
-		--*=3D*) COMPREPLY=3D() ;;
 		--*)   __gitcomp "
 			--paginate
 			--no-pager
--=20
1.5.4.4.532.ga6828
