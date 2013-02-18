From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 8/8] Remove test artifaces from clean rule
Date: Mon, 18 Feb 2013 14:56:53 -0600
Message-ID: <1361221013-12756-9-git-send-email-greened@obbligato.org>
References: <1361221013-12756-1-git-send-email-greened@obbligato.org>
Cc: "David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>,
	James Nylen <jnylen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:58:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7XnS-0005b4-Vk
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 21:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879Ab3BRU6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 15:58:16 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:45295 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755131Ab3BRU6N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 15:58:13 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1U7Xoo-0000E4-UY; Mon, 18 Feb 2013 15:00:11 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1361221013-12756-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: "David A. Greene" <greened@obbligato.org> There should
    be no need to remove 'mainline' nd 'subproj' in the Makefile as these should
    always be created under the test directory. Signed-off-by: David A. Greene
    <greened@obbligato.org> --- contrib/subtree/Makefile | 1 - 1 file changed,
    1 deletion(-) [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through t 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216529>

From: "David A. Greene" <greened@obbligato.org>

There should be no need to remove 'mainline' nd 'subproj'
in the Makefile as these should always be created under the
test directory.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/Makefile |    1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index b507505..09f4c9d 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -50,4 +50,3 @@ test:
 
 clean:
 	rm -f *~ *.xml *.html *.1
-	rm -rf subproj mainline
-- 
1.7.10.4
