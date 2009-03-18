From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 2/3] document --force-rebase
Date: Wed, 18 Mar 2009 19:05:57 +0100
Message-ID: <1237399558-27289-2-git-send-email-barra_cuda@katamail.com>
References: <1237399558-27289-1-git-send-email-barra_cuda@katamail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 18:59:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk03M-0000s2-1n
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 18:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872AbZCRR5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 13:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755123AbZCRR5e
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 13:57:34 -0400
Received: from smtp.katamail.com ([62.149.157.154]:53118 "HELO smtp2.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754161AbZCRR5c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 13:57:32 -0400
Received: (qmail 21843 invoked by uid 89); 18 Mar 2009 17:57:25 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.57.140)
  by smtp2-pc with SMTP; 18 Mar 2009 17:57:24 -0000
X-Mailer: git-send-email 1.6.2.22.gc2ac
In-Reply-To: <1237399558-27289-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113640>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 Documentation/git-rebase.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 57bd333..6cb902a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -258,6 +258,12 @@ OPTIONS
 	context exist they all must match.  By default no context is
 	ever ignored.
 
+-f::
+--force-rebase::
+	Force the rebase even if the current branch is up to date.
+	Normally, if the current branch is up to date, the rebase is
+	aborted.
+
 --whitespace=<option>::
 	This flag is passed to the 'git-apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
-- 
1.6.2.22.gc2ac
