From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 4/9] test-bzr.sh, test-hg.sh: prepare for change to push.default=simple
Date: Sun, 17 Nov 2013 23:12:45 -0500
Message-ID: <1384747970-25481-5-git-send-email-rhansen@bbn.com>
References: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
 <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Cc: git@vger.kernel.org, felipe.contreras@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 18 05:13:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViGDS-00040D-7f
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 05:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420Ab3KRENd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 23:13:33 -0500
Received: from smtp.bbn.com ([128.33.1.81]:59306 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974Ab3KRENX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 23:13:23 -0500
Received: from socket.bbn.com ([192.1.120.102]:45049)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1ViGDA-000PlK-Gr; Sun, 17 Nov 2013 23:13:20 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id BBDD640222
X-Mailer: git-send-email 1.8.5.rc1.208.g8ff7964
In-Reply-To: <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237969>

Change 'git push <remote>' to 'git push <remote> <branch>' in one of
the test-bzr.sh tests to ensure that the test continues to pass when
the default value of push.default changes to simple.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
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
