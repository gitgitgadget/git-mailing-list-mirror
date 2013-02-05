From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 08/13] contrib/subtree: Add vim modeline
Date: Tue,  5 Feb 2013 05:36:54 -0600
Message-ID: <1360064219-28789-9-git-send-email-greened@obbligato.org>
References: <1360064219-28789-1-git-send-email-greened@obbligato.org>
Cc: Techlive Zheng <techlivezheng@gmail.com>,
	"David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 12:38:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2grK-0000o6-Uv
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 12:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761Ab3BELiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 06:38:08 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:38212 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754409Ab3BELh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 06:37:58 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1U2gra-00055A-Dt; Tue, 05 Feb 2013 05:38:59 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1360064219-28789-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: Techlive Zheng <techlivezheng@gmail.com> Signed-off-by:
    Techlive Zheng <techlivezheng@gmail.com> Signed-off-by: David A. Greene <greened@obbligato.org>
    --- contrib/subtree/git-subtree.sh | 2 ++ contrib/subtree/t/t7900-subtree.sh
    | 2 ++ 2 files changed, 4 insertions(+) [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1. 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215488>

From: Techlive Zheng <techlivezheng@gmail.com>

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/git-subtree.sh     |    2 ++
 contrib/subtree/t/t7900-subtree.sh |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 6c3929b..c72af95 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -722,3 +722,5 @@ cmd_push()
 }
 
 "cmd_$command" "$@"
+
+# vim: set ts=4 sw=4 noet
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index e6a3702..e6bcd50 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -466,3 +466,5 @@ test_expect_success 'verify one file change per commit' '
 '
 
 test_done
+
+# vim: set ts=4 sw=4 noet
-- 
1.7.10.4
