From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] doc: clarify --no-track option
Date: Mon, 13 Apr 2009 07:11:16 -0400
Message-ID: <20090413111116.GA15982@coredump.intra.peff.net>
References: <20090413110947.GA15647@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 13:12:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtK5q-0007W4-4l
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 13:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbZDMLLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 07:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753462AbZDMLLR
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 07:11:17 -0400
Received: from peff.net ([208.65.91.99]:43851 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241AbZDMLLR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 07:11:17 -0400
Received: (qmail 31703 invoked by uid 107); 13 Apr 2009 11:11:20 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 13 Apr 2009 07:11:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Apr 2009 07:11:16 -0400
Content-Disposition: inline
In-Reply-To: <20090413110947.GA15647@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116427>

It is not really about ignoring the config option; it is
about turning off tracking, _even if_ the config option is
set.

Signed-off-by: Jeff King <peff@peff.net>
---
This I just noticed while working in the area, and it bothered me.

 Documentation/git-branch.txt   |    3 ++-
 Documentation/git-checkout.txt |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index ba3dea6..19f1b0d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -124,7 +124,8 @@ OPTIONS
 	start-point is either a local or remote branch.
 
 --no-track::
-	Ignore the branch.autosetupmerge configuration variable.
+	Do not set up tracking configuration, even if the
+	branch.autosetupmerge configuration variable is true.
 
 --contains <commit>::
 	Only list branches which contain the specified commit.
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 223ea9c..4992fc6 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -90,7 +90,8 @@ guessing results in an empty name, the guessing is aborted.  You can
 explicitly give a name with '-b' in such a case.
 
 --no-track::
-	Ignore the branch.autosetupmerge configuration variable.
+	Do not set up tracking configuration, even if the
+	branch.autosetupmerge configuration variable is true.
 
 -l::
 	Create the new branch's reflog.  This activates recording of
-- 
1.6.3.rc0.148.g141203.dirty
