From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: add '--merge' to 'git reset'
Date: Mon, 29 Dec 2008 16:05:46 +0100
Message-ID: <1230563146-18958-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 29 16:24:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHJz5-0003gy-1y
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 16:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbYL2PXZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Dec 2008 10:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbYL2PXZ
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 10:23:25 -0500
Received: from viefep32-int.chello.at ([62.179.121.50]:12213 "EHLO
	viefep32-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbYL2PXY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 10:23:24 -0500
X-Greylist: delayed 1048 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Dec 2008 10:23:24 EST
Received: from edge01.upc.biz ([192.168.13.236]) by viefep16-int.chello.at
          (InterMail vM.7.09.01.00 201-2219-108-20080618) with ESMTP
          id <20081229150550.BZDZ1339.viefep16-int.chello.at@edge01.upc.biz>;
          Mon, 29 Dec 2008 16:05:50 +0100
Received: from [127.0.1.1] ([213.222.129.51])
	by edge01.upc.biz with edge
	id x35n1a00l16ghSl0135otq; Mon, 29 Dec 2008 16:05:50 +0100
X-SourceIP: 213.222.129.51
X-Mailer: git-send-email 1.6.1.57.gdceb8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104103>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 3491fd0..f6c3755 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1408,7 +1408,7 @@ _git_reset ()
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
-		__gitcomp "--mixed --hard --soft"
+		__gitcomp "--merge --mixed --hard --soft"
 		return
 		;;
 	esac
--=20
1.6.1.57.gdceb8
