From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 4/4] t9020: which is not portable
Date: Tue, 1 Jan 2013 22:42:54 +0100
Message-ID: <201301012242.56075.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 22:43:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq9ca-0001Ow-8D
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 22:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495Ab3AAVnW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2013 16:43:22 -0500
Received: from mout.web.de ([212.227.17.11]:60183 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460Ab3AAVnV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jan 2013 16:43:21 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MRD4x-1TSC8e245v-00Tyiz; Tue, 01 Jan 2013 22:43:19 +0100
X-Provags-ID: V02:K0:fmRAWhakmxHf5vaUYAWtQrFpuQcqMkixAErJG0Bf98R
 jRO+ror3I90JrJCT6C2NPMk+UpMwXDa3H4ekme4UMTX3s6BQvE
 VkmnwR+2A64dGc00Y7z+G9JIqfb5C0QMB/a36N9kKw+5RqXlzL
 fTnJX/uyFnrDnUs9c7rSwPrSE1ohB/s1AikeH84cbMVVJyRW3k
 K/3ENH0ZMHV94uUXB4hBQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212452>

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
