From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 6/7] test-hg.sh: help user correlate verbose output with email test
Date: Sun, 10 Nov 2013 23:05:11 -0500
Message-ID: <1384142712-2936-7-git-send-email-rhansen@bbn.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 05:08:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfinS-0004V7-2c
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 05:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568Ab3KKEIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 23:08:14 -0500
Received: from smtp.bbn.com ([128.33.0.80]:49759 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892Ab3KKEIM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 23:08:12 -0500
Received: from socket.bbn.com ([192.1.120.102]:57646)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VfinM-0004e3-0W; Sun, 10 Nov 2013 23:08:12 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 575183FF72
X-Mailer: git-send-email 1.8.5.rc1.207.gc17dd22
In-Reply-To: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237603>

It's hard to tell which author conversion test failed when the email
addresses look similar.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 contrib/remote-helpers/test-hg.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 84c67ff..5eda265 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -209,16 +209,16 @@ test_expect_success 'authors' '
 
 	>../expected &&
 	author_test alpha "" "H G Wells <wells@example.com>" &&
-	author_test beta "test" "test <unknown>" &&
-	author_test beta "test <test@example.com> (comment)" "test <test@example.com>" &&
-	author_test gamma "<test@example.com>" "Unknown <test@example.com>" &&
-	author_test delta "name<test@example.com>" "name <test@example.com>" &&
-	author_test epsilon "name <test@example.com" "name <test@example.com>" &&
-	author_test zeta " test " "test <unknown>" &&
-	author_test eta "test < test@example.com >" "test <test@example.com>" &&
-	author_test theta "test >test@example.com>" "test <test@example.com>" &&
-	author_test iota "test < test <at> example <dot> com>" "test <unknown>" &&
-	author_test kappa "test@example.com" "Unknown <test@example.com>"
+	author_test beta "beta" "beta <unknown>" &&
+	author_test beta "beta <test@example.com> (comment)" "beta <test@example.com>" &&
+	author_test gamma "<gamma@example.com>" "Unknown <gamma@example.com>" &&
+	author_test delta "delta<test@example.com>" "delta <test@example.com>" &&
+	author_test epsilon "epsilon <test@example.com" "epsilon <test@example.com>" &&
+	author_test zeta " zeta " "zeta <unknown>" &&
+	author_test eta "eta < test@example.com >" "eta <test@example.com>" &&
+	author_test theta "theta >test@example.com>" "theta <test@example.com>" &&
+	author_test iota "iota < test <at> example <dot> com>" "iota <unknown>" &&
+	author_test kappa "kappa@example.com" "Unknown <kappa@example.com>"
 	) &&
 
 	git clone "hg::hgrepo" gitrepo &&
-- 
1.8.5.rc1.207.gc17dd22
