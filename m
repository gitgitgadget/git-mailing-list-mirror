From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH] t/t9001-send-email.sh: fix stderr redirection in 'Invalid In-Reply-To'
Date: Tue, 19 Oct 2010 11:50:39 +0200
Message-ID: <1287481839-8789-1-git-send-email-ospite@studenti.unina.it>
Cc: Antonio Ospite <ospite@studenti.unina.it>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 19 11:50:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P88qO-0005t0-3x
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 11:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758163Ab0JSJuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 05:50:50 -0400
Received: from smtp208.alice.it ([82.57.200.104]:36262 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756596Ab0JSJuu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 05:50:50 -0400
Received: from jcn (82.57.81.162) by smtp208.alice.it (8.5.124.08)
        id 4C1A27160805CD93; Tue, 19 Oct 2010 11:50:46 +0200
Received: from ao2 by jcn with local (Exim 4.72)
	(envelope-from <ospite@studenti.unina.it>)
	id 1P88qD-0002IG-Im; Tue, 19 Oct 2010 11:50:45 +0200
X-Mailer: git-send-email 1.7.2.3
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159317>

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

Please CC me if there is any comment, I am not subscribed to the list.

Thanks,
   Antonio Ospite
   http://ao2.it

 t/t9001-send-email.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 6f67da4..a298eb0 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -279,7 +279,7 @@ test_expect_success $PREREQ 'Invalid In-Reply-To' '
 		--to=nobody@example.com \
 		--in-reply-to=" " \
 		--smtp-server="$(pwd)/fake.sendmail" \
-		$patches
+		$patches \
 		2>errors
 	! grep "^In-Reply-To: < *>" msgtxt1
 '
-- 
1.7.1
