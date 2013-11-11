From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH] fixup! transport-helper: add 'force' to 'export' helpers
Date: Mon, 11 Nov 2013 00:01:07 -0500
Message-ID: <1384146067-9575-1-git-send-email-rhansen@bbn.com>
References: <1383212197-14259-7-git-send-email-felipe.contreras@gmail.com>
Cc: felipe.contreras@gmail.com, srabbelier@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 06:01:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfjdD-0002N1-V5
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 06:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075Ab3KKFB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 00:01:29 -0500
Received: from smtp.bbn.com ([128.33.0.80]:53463 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878Ab3KKFB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 00:01:28 -0500
Received: from socket.bbn.com ([192.1.120.102]:57652)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vfjcs-0004zZ-Oi; Mon, 11 Nov 2013 00:01:26 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id EBBF63FFDE
X-Mailer: git-send-email 1.8.5.rc1.207.gc17dd22
In-Reply-To: <1383212197-14259-7-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237605>

defend against force=foo in the user's environment

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 git-remote-testgit.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
index 6d2f282..1cfdea2 100755
--- a/git-remote-testgit.sh
+++ b/git-remote-testgit.sh
@@ -15,6 +15,8 @@ test -z "$refspec" && prefix="refs"
 
 export GIT_DIR="$url/.git"
 
+force=
+
 mkdir -p "$dir"
 
 if test -z "$GIT_REMOTE_TESTGIT_NO_MARKS"
-- 
1.8.5.rc1.207.gc17dd22
