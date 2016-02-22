From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: fix mis-indentation in _git_stash()
Date: Mon, 22 Feb 2016 14:02:50 +0100
Message-ID: <1456146170-17556-1-git-send-email-szeder@ira.uka.de>
References: <20160126093718.GC77046@wagland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Wagland <paul@kungfoocoder.org>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 14:03:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXq9K-0007XN-Cf
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 14:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316AbcBVNDa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 08:03:30 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:50942 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751809AbcBVND3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 08:03:29 -0500
Received: from x4db0d734.dyn.telefonica.de ([77.176.215.52] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aXq96-0002YF-D1; Mon, 22 Feb 2016 14:03:26 +0100
X-Mailer: git-send-email 2.7.1.384.g61d9461
In-Reply-To: <20160126093718.GC77046@wagland.net>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456146206.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286930>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 45ec47f2b1b4..e3918c87e3ad 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2415,8 +2415,8 @@ _git_stash ()
 		show,--*|branch,--*)
 			;;
 		branch,*)
-		  if [ $cword -eq 3 ]; then
-			__gitcomp_nl "$(__git_refs)";
+			if [ $cword -eq 3 ]; then
+				__gitcomp_nl "$(__git_refs)";
 			else
 				__gitcomp_nl "$(git --git-dir=3D"$(__gitdir)" stash list \
 						| sed -n -e 's/:.*//p')"
--=20
2.7.1.384.g61d9461
