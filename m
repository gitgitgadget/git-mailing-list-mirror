From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: support branch's new '--merged' and '--unmerged' options
Date: Thu, 17 Apr 2008 13:34:00 +0200
Message-ID: <1208432040-26271-1-git-send-email-szeder@ira.uka.de>
References: <12084250231245-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 13:34:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmSOB-0004qg-7a
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 13:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755696AbYDQLeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2008 07:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755591AbYDQLeF
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 07:34:05 -0400
Received: from francis.fzi.de ([141.21.7.5]:25065 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755527AbYDQLeE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 07:34:04 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 17 Apr 2008 13:33:59 +0200
X-Mailer: git-send-email 1.5.5.90.g17e355
In-Reply-To: <12084250231245-git-send-email-hjemli@gmail.com>
X-OriginalArrivalTime: 17 Apr 2008 11:33:59.0854 (UTC) FILETIME=[EDF37CE0:01C8A07E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79785>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
> These options filter the output from git branch to only include branc=
hes
> whose tip is either merged or not merged into HEAD.
I really like the idea, thanks!
How about making it easier to type?

 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 4d81963..c44f9f4 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -543,7 +543,7 @@ _git_branch ()
 	--*)
 		__gitcomp "
 			--color --no-color --verbose --abbrev=3D --no-abbrev
-			--track --no-track
+			--track --no-track --merged --unmerged
 			"
 		;;
 	*)
--=20
1.5.5.90.g17e355
