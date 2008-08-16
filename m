From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] t9300: replace '!' with test_must_fail
Date: Sat, 16 Aug 2008 17:17:42 +0200
Message-ID: <1218899862-14017-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 17:19:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUNYS-0006dT-Kc
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 17:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbYHPPRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 11:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbYHPPRM
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 11:17:12 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:42549 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbYHPPRL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 11:17:11 -0400
Received: from vmobile.example.net (dsl5401C01F.pool.t-online.hu [84.1.192.31])
	by yugo.frugalware.org (Postfix) with ESMTP id 6E5251DDC5B;
	Sat, 16 Aug 2008 17:17:09 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 59FF81A5FBF; Sat, 16 Aug 2008 17:17:42 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92549>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

I hope no more details are needed, this is similar to 03b9dfb, but this
time for fast-import.

 t/t9300-fast-import.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 1fc06c5..c6bc0a6 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1045,7 +1045,7 @@ DATA
 INPUT_END
 
 test_expect_success 'P: fail on inline gitlink' '
-    ! git-fast-import <input'
+    test_must_fail git-fast-import <input'
 
 test_tick
 cat >input <<INPUT_END
@@ -1068,6 +1068,6 @@ M 160000 :1 sub
 INPUT_END
 
 test_expect_success 'P: fail on blob mark in gitlink' '
-    ! git-fast-import <input'
+    test_must_fail git-fast-import <input'
 
 test_done
-- 
1.6.0.rc0.14.g95f8.dirty
