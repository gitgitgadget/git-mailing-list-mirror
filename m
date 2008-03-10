From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: add new 'git stash' subcommands
Date: Mon, 10 Mar 2008 16:02:24 +0100
Message-ID: <1205161345-21120-3-git-send-email-szeder@ira.uka.de>
References: <1205161345-21120-1-git-send-email-szeder@ira.uka.de>
 <1205161345-21120-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 16:04:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYjXD-0003YV-Op
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 16:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbYCJPCb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2008 11:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYCJPCb
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 11:02:31 -0400
Received: from francis.fzi.de ([141.21.7.5]:44346 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751420AbYCJPC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 11:02:29 -0400
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 10 Mar 2008 16:02:24 +0100
X-Mailer: git-send-email 1.5.4.4.481.g5075
In-Reply-To: <1205161345-21120-2-git-send-email-szeder@ira.uka.de>
X-OriginalArrivalTime: 10 Mar 2008 15:02:24.0845 (UTC) FILETIME=[BFCF2FD0:01C882BF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76737>

Namely 'save', 'drop', 'pop' and 'create'

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 0feed97..c194972 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1127,7 +1127,7 @@ _git_show ()
=20
 _git_stash ()
 {
-	local subcommands=3D'list show apply clear'
+	local subcommands=3D'save list show apply clear drop pop create'
 	if [ -z "$(__git_find_subcommand "$subcommands")" ]; then
 		__gitcomp "$subcommands"
 	fi
--=20
1.5.4.4.481.g5075
