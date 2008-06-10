From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH] Add target "install-html" the the top level Makefile
Date: Tue, 10 Jun 2008 11:34:25 +0300
Message-ID: <20080610083425.GA8804@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 10:35:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5zK8-0004I8-W6
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 10:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbYFJIeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 04:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754001AbYFJIeb
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 04:34:31 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:55465 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753550AbYFJIea (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 04:34:30 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.5.014)
        id 483E832F00951E0A; Tue, 10 Jun 2008 11:34:28 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K5zJB-0002IQ-Ow; Tue, 10 Jun 2008 11:34:25 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84483>

This makes it possible to install html documents from the top level
directory. Previously such target was only in Documentation/Makefile.

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---

I'm wondering why this target doesn't exist. Is this sane and safe
thing to do?


 Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 1937507..b2b8bef 100644
--- a/Makefile
+++ b/Makefile
@@ -1290,6 +1290,9 @@ endif
 install-doc:
 	$(MAKE) -C Documentation install
 
+install-html:
+	$(MAKE) -C Documentation install-html
+
 install-info:
 	$(MAKE) -C Documentation install-info
 
-- 
1.5.6.rc2.26.g3c446
