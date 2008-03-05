From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] bash: add missing 'git stash save' subcommand
Date: Wed,  5 Mar 2008 20:16:03 +0100
Message-ID: <9956781bfd3f6ec8776c055aa21a4d3d4a504623.1204725800.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, spearce@spearce.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 20:17:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWz71-0006Ni-RV
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 20:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362AbYCETQH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 14:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755352AbYCETQG
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 14:16:06 -0500
Received: from francis.fzi.de ([141.21.7.5]:17731 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754645AbYCETQF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 14:16:05 -0500
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 5 Mar 2008 20:16:02 +0100
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
X-OriginalArrivalTime: 05 Mar 2008 19:16:02.0472 (UTC) FILETIME=[5A280A80:01C87EF5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76250>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 8f70e1e..d138bda 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1087,7 +1087,7 @@ _git_show ()
=20
 _git_stash ()
 {
-	__gitcomp 'list show apply clear'
+	__gitcomp 'save list show apply clear'
 }
=20
 _git_submodule ()
--=20
1.5.4.3

