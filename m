From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 02/15] t7810: remove test_config implementation
Date: Sun, 24 Mar 2013 22:06:01 +0100
Message-ID: <737a11bd025649bec5fcc7d31534a125c849b842.1364158574.git.ydroneaud@opteya.com>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <cover.1364158574.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:07:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJs8J-0007cw-F6
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706Ab3CXVGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:06:49 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:51607 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754654Ab3CXVGs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:06:48 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id D2A7C94019F;
	Sun, 24 Mar 2013 22:06:39 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2OL6bGL007271;
	Sun, 24 Mar 2013 22:06:37 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2OL6bvi007270;
	Sun, 24 Mar 2013 22:06:37 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
References: <cover.1364158574.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218981>

test_config is provided by the test library,
a private version is not needed.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 t/t7810-grep.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index f698001..500eb50 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1084,11 +1084,6 @@ test_expect_success 'grep -E pattern with grep.patternType=fixed' '
 	test_cmp expected actual
 '
 
-test_config() {
-	git config "$1" "$2" &&
-	test_when_finished "git config --unset $1"
-}
-
 cat >expected <<EOF
 hello.c<RED>:<RESET>int main(int argc, const char **argv)
 hello.c<RED>-<RESET>{
-- 
1.7.11.7
