From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 7/7] contrib/subtree: Make the Manual Directory if Needed
Date: Tue,  8 Jan 2013 06:09:57 -0600
Message-ID: <1357646997-28675-8-git-send-email-greened@obbligato.org>
References: <1357646997-28675-1-git-send-email-greened@obbligato.org>
Cc: "Jesper L. Nielsen" <lyager@gmail.com>,
	"David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 13:11:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsY1o-0002Gu-BW
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 13:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119Ab3AHMLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 07:11:12 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:51763 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755964Ab3AHMLK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 07:11:10 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TsY8y-0003z5-44; Tue, 08 Jan 2013 06:19:00 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1357646997-28675-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: "Jesper L. Nielsen" <lyager@gmail.com> Before install
    git-subtree documentation, make sure the manpage directory exists. Signed-off-by:
    Jesper L. Nielsen <lyager@gmail.com> [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212959>

From: "Jesper L. Nielsen" <lyager@gmail.com>

Before install git-subtree documentation, make sure the manpage
directory exists.

Signed-off-by: Jesper L. Nielsen <lyager@gmail.com>

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/Makefile |    1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 36ae3e4..b507505 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -35,6 +35,7 @@ install: $(GIT_SUBTREE)
 install-doc: install-man
 
 install-man: $(GIT_SUBTREE_DOC)
+	$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
 	$(INSTALL) -m 644 $^ $(DESTDIR)$(man1dir)
 
 $(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
-- 
1.7.10.4
