From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v5 11/10] test-hg.sh: tests are now expected to pass
Date: Mon, 11 Nov 2013 00:09:01 -0500
Message-ID: <1384146541-11607-1-git-send-email-rhansen@bbn.com>
References: <1383212197-14259-2-git-send-email-felipe.contreras@gmail.com>
Cc: felipe.contreras@gmail.com, srabbelier@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 06:09:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfjkk-0004Vz-Iq
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 06:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236Ab3KKFJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 00:09:24 -0500
Received: from smtp.bbn.com ([128.33.1.81]:54320 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab3KKFJX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 00:09:23 -0500
Received: from socket.bbn.com ([192.1.120.102]:44767)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VfjkV-000JiY-UT; Mon, 11 Nov 2013 00:09:20 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 085303FFDE
X-Mailer: git-send-email 1.8.5.rc1.207.gc17dd22
In-Reply-To: <1383212197-14259-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237606>

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 contrib/remote-helpers/test-hg.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 9f5066b..e6e3fed 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -604,7 +604,7 @@ test_expect_success 'remote big push fetch first' '
 	)
 '
 
-test_expect_failure 'remote big push force' '
+test_expect_success 'remote big push force' '
 	test_when_finished "rm -rf hgrepo gitrepo*" &&
 
 	setup_big_push
@@ -634,7 +634,7 @@ test_expect_failure 'remote big push force' '
 	check_bookmark hgrepo new_bmark six
 '
 
-test_expect_failure 'remote big push dry-run' '
+test_expect_success 'remote big push dry-run' '
 	test_when_finished "rm -rf hgrepo gitrepo*" &&
 
 	setup_big_push
-- 
1.8.5.rc1.207.gc17dd22
