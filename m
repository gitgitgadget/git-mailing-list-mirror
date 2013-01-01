From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 4/4] t9020: which is not portable
Date: Tue, 1 Jan 2013 22:42:03 +0100
Message-ID: <201301012242.05602.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 22:43:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq9cQ-0001Kv-4T
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 22:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481Ab3AAVnL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2013 16:43:11 -0500
Received: from mout.web.de ([212.227.15.3]:58950 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460Ab3AAVnK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jan 2013 16:43:10 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MXpqx-1TUNzv3Gkh-00WCiT; Tue, 01 Jan 2013 22:43:08 +0100
X-Provags-ID: V02:K0:hwZnby3kS8uwRV20C8ap0iHNy3mve7bBgcaGJUeNFjH
 iDnrj9ROZMv31rF89IAj/1oSYYTzL+Rw9PkcWmXkWmOj/DqnJ/
 NGbEvmb8bGPhHfH0O7eSLilNjbs7Jec9A23WTRs/qjCPtkgI+N
 +jsdvvnQmMtRBXK/781w7PKNGeYFLJIHO+1b4iXfJX9tZXokhz
 SD1+Gexl3ojZgrVxHe15g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212451>

Use type instead

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t9020-remote-svn.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
index 4f2dfe0..dbaecbc 100755
--- a/t/t9020-remote-svn.sh
+++ b/t/t9020-remote-svn.sh
@@ -32,8 +32,8 @@ fi
=20
 test_debug '
 	git --version
-	which git
-	which svnrdump
+	type git
+	type svnrdump
 '
=20
 test_expect_success REMOTE_SVN 'simple fetch' '
--=20
1.8.0.197.g5a90748
