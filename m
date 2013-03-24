From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 03/15] t7811: remove test_config implementation
Date: Sun, 24 Mar 2013 22:06:02 +0100
Message-ID: <4b3024f2678000dd8edfa35047c68438f5119cd5.1364158574.git.ydroneaud@opteya.com>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <cover.1364158574.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:26:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJsQT-00077k-Iy
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab3CXVZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:25:34 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:45705 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754808Ab3CXVZd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:25:33 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 4AD63940241;
	Sun, 24 Mar 2013 22:25:23 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2OL6e60007275;
	Sun, 24 Mar 2013 22:06:40 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2OL6dvf007274;
	Sun, 24 Mar 2013 22:06:39 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
References: <cover.1364158574.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218989>

test_config is provided by the test library,
a private version is not needed.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 t/t7811-grep-open.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index a895778..e1951a5 100755
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -125,11 +125,6 @@ test_expect_success 'modified file' '
 	test_cmp empty out
 '
 
-test_config() {
-	git config "$1" "$2" &&
-	test_when_finished "git config --unset $1"
-}
-
 test_expect_success 'copes with color settings' '
 	rm -f actual &&
 	echo grep.h >expect &&
-- 
1.7.11.7
