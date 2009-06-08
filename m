From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 2/2] bash: add support for 'git stash pop --index' option
Date: Tue,  9 Jun 2009 00:57:39 +0200
Message-ID: <e380823e9e6c895eeb375b2c5f021ff022798d30.1244501726.git.szeder@ira.uka.de>
References: <d07a10275620808bc378340cc8450d3e8de8cf7e.1244501726.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 09 00:57:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDnmq-0001ox-BZ
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 00:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993AbZFHW5m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 18:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756005AbZFHW5l
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 18:57:41 -0400
Received: from francis.fzi.de ([141.21.7.5]:47167 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755824AbZFHW5l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 18:57:41 -0400
Received: from [127.0.1.1] ([91.19.66.149]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 9 Jun 2009 00:57:42 +0200
X-Mailer: git-send-email 1.6.3.2.252.g5b6b0
In-Reply-To: <d07a10275620808bc378340cc8450d3e8de8cf7e.1244501726.git.szeder@ira.uka.de>
In-Reply-To: <d07a10275620808bc378340cc8450d3e8de8cf7e.1244501726.git.szeder@ira.uka.de>
References: <d07a10275620808bc378340cc8450d3e8de8cf7e.1244501726.git.szeder@ira.uka.de>
X-OriginalArrivalTime: 08 Jun 2009 22:57:42.0863 (UTC) FILETIME=[87D3A5F0:01C9E88C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121127>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index fa899eb..edeedda 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1884,10 +1884,10 @@ _git_stash ()
 		save,--*)
 			__gitcomp "--keep-index"
 			;;
-		apply,--*)
+		apply,--*|pop,--*)
 			__gitcomp "--index"
 			;;
-		show,--*|drop,--*|pop,--*|branch,--*)
+		show,--*|drop,--*|branch,--*)
 			COMPREPLY=3D()
 			;;
 		show,*|apply,*|drop,*|pop,*|branch,*)
--=20
1.6.3.2.252.g5b6b0
