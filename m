From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 8/8] change quoting in test t1006-cat-file.sh
Date: Fri, 23 May 2008 16:19:43 +0200
Message-ID: <1211552384-29636-9-git-send-email-barra_cuda@katamail.com>
References: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Cc: git@vger.kernel.org
To: aroben@apple.com
X-From: git-owner@vger.kernel.org Fri May 23 16:17:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzY5A-00066y-0l
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 16:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbYEWOQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 10:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754614AbYEWOQ2
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 10:16:28 -0400
Received: from smtp.katamail.com ([62.149.157.154]:51931 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754110AbYEWOQT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 10:16:19 -0400
Received: (qmail 769 invoked by uid 89); 23 May 2008 14:15:00 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.207)
  by smtp1-pc with SMTP; 23 May 2008 14:14:59 -0000
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82709>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 t/t1006-cat-file.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d569676..cb1fbe5 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -199,9 +199,9 @@ $tag_content
 deadbeef missing
  missing"
 
-test_expect_success \
-    "--batch with multiple sha1s gives correct format" \
-    "test \"\$(maybe_remove_timestamp \"$batch_output\" 1)\" = \"\$(maybe_remove_timestamp \"\$(echo_without_newline \"$batch_input\" | git cat-file --batch)\" 1)\""
+test_expect_success '--batch with multiple sha1s gives correct format' '
+	test "$(maybe_remove_timestamp "$batch_output" 1)" = "$(maybe_remove_timestamp "$(echo_without_newline "$batch_input" | git cat-file --batch)" 1)"
+'
 
 batch_check_input="$hello_sha1
 $tree_sha1
-- 
1.5.5.1
