From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 4/9] test-bzr.sh, test-hg.sh: prepare for change to push.default=simple
Date: Tue, 12 Nov 2013 00:54:43 -0500
Message-ID: <1384235688-9655-5-git-send-email-rhansen@bbn.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
 <1384235688-9655-1-git-send-email-rhansen@bbn.com>
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 06:55:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg6we-0008KE-06
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 06:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780Ab3KLFzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 00:55:17 -0500
Received: from smtp.bbn.com ([128.33.0.80]:55866 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534Ab3KLFzO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 00:55:14 -0500
Received: from socket.bbn.com ([192.1.120.102]:57710)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vg6wT-000Lq5-Ng; Tue, 12 Nov 2013 00:55:13 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 02D514004D
X-Mailer: git-send-email 1.8.5.rc1.208.g8ff7964
In-Reply-To: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237686>

Change 'git push <remote>' to 'git push <remote> <branch>' in one of
the test-bzr.sh tests to ensure that the test continues to pass when
the default value of push.default changes to simple.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 contrib/remote-helpers/test-bzr.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index 1e850c3..1e53ff9 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -379,7 +379,7 @@ test_expect_success 'export utf-8 authors' '
 	git add content &&
 	git commit -m one &&
 	git remote add bzr "bzr::../bzrrepo" &&
-	git push bzr
+	git push bzr master
 	) &&
 
 	(
-- 
1.8.5.rc1.208.g8ff7964
