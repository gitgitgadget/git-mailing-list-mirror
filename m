From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 8/9] test-hg.sh: help user correlate verbose output with email test
Date: Sun, 17 Nov 2013 23:12:49 -0500
Message-ID: <1384747970-25481-9-git-send-email-rhansen@bbn.com>
References: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
 <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Cc: git@vger.kernel.org, felipe.contreras@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 18 05:13:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViGDc-000452-RE
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 05:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468Ab3KRENn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 23:13:43 -0500
Received: from smtp.bbn.com ([128.33.1.81]:43504 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab3KRENZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 23:13:25 -0500
Received: from socket.bbn.com ([192.1.120.102]:45053)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1ViGDD-000Ple-Su; Sun, 17 Nov 2013 23:13:23 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 27BD340222
X-Mailer: git-send-email 1.8.5.rc1.208.g8ff7964
In-Reply-To: <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237974>

It's hard to tell which author conversion test failed when the email
addresses look similar.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index eb72db8..642ad93 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -206,16 +206,16 @@ test_expect_success 'authors' '
 
 	>../expected &&
 	author_test alpha "" "H G Wells <wells@example.com>" &&
-	author_test beta "test" "test <unknown>" &&
-	author_test gamma "test <test@example.com> (comment)" "test <test@example.com>" &&
-	author_test delta "<test@example.com>" "Unknown <test@example.com>" &&
-	author_test epsilon "name<test@example.com>" "name <test@example.com>" &&
-	author_test zeta "name <test@example.com" "name <test@example.com>" &&
-	author_test eta " test " "test <unknown>" &&
-	author_test theta "test < test@example.com >" "test <test@example.com>" &&
-	author_test iota "test >test@example.com>" "test <test@example.com>" &&
-	author_test kappa "test < test <at> example <dot> com>" "test <unknown>" &&
-	author_test lambda "test@example.com" "Unknown <test@example.com>"
+	author_test beta "beta" "beta <unknown>" &&
+	author_test gamma "gamma <test@example.com> (comment)" "gamma <test@example.com>" &&
+	author_test delta "<delta@example.com>" "Unknown <delta@example.com>" &&
+	author_test epsilon "epsilon<test@example.com>" "epsilon <test@example.com>" &&
+	author_test zeta "zeta <test@example.com" "zeta <test@example.com>" &&
+	author_test eta " eta " "eta <unknown>" &&
+	author_test theta "theta < test@example.com >" "theta <test@example.com>" &&
+	author_test iota "iota >test@example.com>" "iota <test@example.com>" &&
+	author_test kappa "kappa < test <at> example <dot> com>" "kappa <unknown>" &&
+	author_test lambda "lambda@example.com" "Unknown <lambda@example.com>"
 	) &&
 
 	git clone "hg::hgrepo" gitrepo &&
-- 
1.8.5.rc1.208.g8ff7964
