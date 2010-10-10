From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] bash: offer refs for 'git bisect start'
Date: Sun, 10 Oct 2010 23:39:33 +0200
Message-ID: <1286746774-7877-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 10 23:39:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P53cb-0002vY-0F
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 23:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab0JJVjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 17:39:40 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:63340 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab0JJVjk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 17:39:40 -0400
Received: from [127.0.1.1] (p5B130D54.dip0.t-ipconnect.de [91.19.13.84])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MgaZf-1PJ8WM0SvP-00Nzg2; Sun, 10 Oct 2010 23:39:37 +0200
X-Mailer: git-send-email 1.7.3.1.148.g2fffa
X-Provags-ID: V02:K0:ZJIu9Opv9/p5oYHL1ZZXbodtLPjjz8GCwgNp3weAq0s
 n517vRu4A7/3lxKsJDhpE06sso99Av6mUiOzWYdXsUdKRy/obc
 /EfkHV2nImwxIpZzXH9sHpVvMUJrPGDcpmlmda/rIhyphRNjwN
 CrhRZznR/aJ/GkOFmEuGowWuXPufNypxw0PKrfvV6Dlx2GB+SL
 k7lRRRe2h6PJIfZa77rnQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158714>

The completion script only offered path completion after 'git bisect
start', although bad and good refs could also be specified before the
doubledash.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6756990..eb8ef47 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -912,7 +912,7 @@ _git_bisect ()
 	fi
=20
 	case "$subcommand" in
-	bad|good|reset|skip)
+	bad|good|reset|skip|start)
 		__gitcomp "$(__git_refs)"
 		;;
 	*)
--=20
1.7.3.1.148.g2fffa
