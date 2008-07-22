From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t4116-apply-reverse.sh: use $TAR rather than tar
Date: Tue, 22 Jul 2008 16:16:25 -0500
Message-ID: <TE3N1FoSy-vEEv0qsAyvBwBMMq2RuJCWYw7DNLBC7mEh6PxM1LCsOw@cipher.nrlssc.navy.mil>
References: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:19:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPG8-00084W-Cz
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757152AbYGVVQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756673AbYGVVQv
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:16:51 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54015 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757152AbYGVVQv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:16:51 -0400
Received: by mail.nrlssc.navy.mil id m6MLGPHi020391; Tue, 22 Jul 2008 16:16:25 -0500
In-Reply-To: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Jul 2008 21:16:25.0961 (UTC) FILETIME=[331C3D90:01C8EC40]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89535>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t4116-apply-reverse.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index 1459a90..2298ece 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -48,12 +48,12 @@ test_expect_success 'apply in reverse' '
 
 test_expect_success 'setup separate repository lacking postimage' '
 
-	git tar-tree initial initial | tar xf - &&
+	git tar-tree initial initial | $TAR xf - &&
 	(
 		cd initial && git init && git add .
 	) &&
 
-	git tar-tree second second | tar xf - &&
+	git tar-tree second second | $TAR xf - &&
 	(
 		cd second && git init && git add .
 	)
-- 
1.6.0.rc0.38.g8b8fb7
