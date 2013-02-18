From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 3/8] contrib/subtree: Ignore testing directory
Date: Mon, 18 Feb 2013 14:56:48 -0600
Message-ID: <1361221013-12756-4-git-send-email-greened@obbligato.org>
References: <1361221013-12756-1-git-send-email-greened@obbligato.org>
Cc: "David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>,
	James Nylen <jnylen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:58:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Xn8-0005LF-5M
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 21:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424Ab3BRU6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 15:58:00 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:45277 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755046Ab3BRU57 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 15:57:59 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1U7Xoa-0000E4-2M; Mon, 18 Feb 2013 14:59:56 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1361221013-12756-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: Techlive Zheng <techlivezheng@gmail.com> Signed-off-by:
    Techlive Zheng <techlivezheng@gmail.com> Signed-off-by: David A. Greene <greened@obbligato.org>
    --- contrib/subtree/.gitignore | 5 ++--- 1 file changed, 2 insertions(+),
    3 deletions(-) [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BOD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216523>

From: Techlive Zheng <techlivezheng@gmail.com>

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/.gitignore |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/.gitignore b/contrib/subtree/.gitignore
index 91360a3..59aeeb4 100644
--- a/contrib/subtree/.gitignore
+++ b/contrib/subtree/.gitignore
@@ -1,6 +1,5 @@
 *~
 git-subtree
-git-subtree.xml
 git-subtree.1
-mainline
-subproj
+git-subtree.xml
+t/trash\ directory.*
-- 
1.7.10.4
