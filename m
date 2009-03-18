From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH v2 2/3] document --force-rebase
Date: Wed, 18 Mar 2009 21:53:39 +0100
Message-ID: <1237409619-4229-1-git-send-email-barra_cuda@katamail.com>
References: <7v63i6fzgc.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 18 21:47:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk2fG-0004gr-Q9
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 21:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbZCRUpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 16:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752982AbZCRUpO
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 16:45:14 -0400
Received: from smtp.katamail.com ([62.149.157.154]:53769 "HELO smtp1.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752459AbZCRUpM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 16:45:12 -0400
Received: (qmail 23830 invoked by uid 89); 18 Mar 2009 20:45:03 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.228)
  by smtp1-pc with SMTP; 18 Mar 2009 20:45:03 -0000
X-Mailer: git-send-email 1.6.2.22.gc2ac
In-Reply-To: <7v63i6fzgc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113658>

Words by Junio.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 Documentation/git-rebase.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 57bd333..276f151 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -258,6 +258,13 @@ OPTIONS
 	context exist they all must match.  By default no context is
 	ever ignored.
 
+-f::
+--force-rebase::
+	Force the rebase even if the current branch is a descendant
+	of the commit you are rebasing onto.  Normally the command will
+	exit with the message "Current branch is up to date" in such a
+	situation.
+
 --whitespace=<option>::
 	This flag is passed to the 'git-apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
-- 
1.6.2.22.gc2ac
