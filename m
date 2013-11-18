From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 7/9] test-hg.sh: fix duplicate content strings in author tests
Date: Sun, 17 Nov 2013 23:12:48 -0500
Message-ID: <1384747970-25481-8-git-send-email-rhansen@bbn.com>
References: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
 <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Cc: git@vger.kernel.org, felipe.contreras@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 18 05:13:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViGDc-000452-99
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 05:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467Ab3KRENk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 23:13:40 -0500
Received: from smtp.bbn.com ([128.33.1.81]:25224 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab3KRENZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 23:13:25 -0500
Received: from socket.bbn.com ([192.1.120.102]:45052)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1ViGDD-000Pla-2h; Sun, 17 Nov 2013 23:13:23 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 46CB13FFEF
X-Mailer: git-send-email 1.8.5.rc1.208.g8ff7964
In-Reply-To: <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237972>

"beta" was used twice.  Change the second copy to "gamma" and
increment the remaining content strings.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 5535e8c..eb72db8 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -207,15 +207,15 @@ test_expect_success 'authors' '
 	>../expected &&
 	author_test alpha "" "H G Wells <wells@example.com>" &&
 	author_test beta "test" "test <unknown>" &&
-	author_test beta "test <test@example.com> (comment)" "test <test@example.com>" &&
-	author_test gamma "<test@example.com>" "Unknown <test@example.com>" &&
-	author_test delta "name<test@example.com>" "name <test@example.com>" &&
-	author_test epsilon "name <test@example.com" "name <test@example.com>" &&
-	author_test zeta " test " "test <unknown>" &&
-	author_test eta "test < test@example.com >" "test <test@example.com>" &&
-	author_test theta "test >test@example.com>" "test <test@example.com>" &&
-	author_test iota "test < test <at> example <dot> com>" "test <unknown>" &&
-	author_test kappa "test@example.com" "Unknown <test@example.com>"
+	author_test gamma "test <test@example.com> (comment)" "test <test@example.com>" &&
+	author_test delta "<test@example.com>" "Unknown <test@example.com>" &&
+	author_test epsilon "name<test@example.com>" "name <test@example.com>" &&
+	author_test zeta "name <test@example.com" "name <test@example.com>" &&
+	author_test eta " test " "test <unknown>" &&
+	author_test theta "test < test@example.com >" "test <test@example.com>" &&
+	author_test iota "test >test@example.com>" "test <test@example.com>" &&
+	author_test kappa "test < test <at> example <dot> com>" "test <unknown>" &&
+	author_test lambda "test@example.com" "Unknown <test@example.com>"
 	) &&
 
 	git clone "hg::hgrepo" gitrepo &&
-- 
1.8.5.rc1.208.g8ff7964
