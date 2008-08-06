From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: remove redundant check for 'git stash apply' options
Date: Wed,  6 Aug 2008 17:45:23 +0200
Message-ID: <1218037523-32266-1-git-send-email-szeder@ira.uka.de>
References: <1217915438-6838-6-git-send-email-lee.marlow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Lee Marlow <lee.marlow@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 06 17:48:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQlFc-00077k-BS
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 17:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbYHFPpa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 11:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760957AbYHFPp3
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 11:45:29 -0400
Received: from francis.fzi.de ([141.21.7.5]:50013 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760765AbYHFPpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 11:45:25 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 Aug 2008 17:45:22 +0200
X-Mailer: git-send-email 1.6.0.rc1.104.gf5b36
In-Reply-To: <1217915438-6838-6-git-send-email-lee.marlow@gmail.com>
X-OriginalArrivalTime: 06 Aug 2008 15:45:22.0299 (UTC) FILETIME=[6FA434B0:01C8F7DB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91523>

It will never trigger anyway because of the first check, and even if it
would, it would not offer the command line option.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 447cb06..5d60f82 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1427,7 +1427,7 @@ _git_stash ()
 		apply,--*)
 			__gitcomp "--index"
 			;;
-		show,--*|apply,--*|drop,--*|pop,--*|branch,--*)
+		show,--*|drop,--*|pop,--*|branch,--*)
 			COMPREPLY=3D()
 			;;
 		show,*|apply,*|drop,*|pop,*|branch,*)
--=20
1.6.0.rc1.104.gf5b36
