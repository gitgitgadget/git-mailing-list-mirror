From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH v3 2/3] document --force-rebase
Date: Thu, 19 Mar 2009 16:28:47 +0100
Message-ID: <1237476528-6040-1-git-send-email-barra_cuda@katamail.com>
References: <fabb9a1e0903190401k1127dc8ev7704c8a7bd381c99@mail.gmail.com>
Cc: git@vger.kernel.org
To: srabbelier@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 19 16:24:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkK4P-0003bI-3R
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 16:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbZCSPUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 11:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755371AbZCSPUc
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 11:20:32 -0400
Received: from smtp.katamail.com ([62.149.157.154]:55045 "HELO smtp2.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753029AbZCSPUb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 11:20:31 -0400
Received: (qmail 19365 invoked by uid 89); 19 Mar 2009 15:20:18 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.113)
  by smtp2-pc with SMTP; 19 Mar 2009 15:20:13 -0000
X-Mailer: git-send-email 1.6.2.22.gc2ac
In-Reply-To: <fabb9a1e0903190401k1127dc8ev7704c8a7bd381c99@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113782>

Words by Junio.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---

On Thursday 19 March 2009, Sverre Rabbelier wrote:
> Awesome, thanks! Perhaps you could, for extra brownie points, add a
> line to the --whitespace=fix documentation that it implies
> --force-rebase?

You're right, I resent 3/3 for the same reason.

 Documentation/git-rebase.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 57bd333..7ffeec8 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -258,10 +258,19 @@ OPTIONS
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
 	Incompatible with the --interactive option.
+	If the option `fix` (or its equivalent `strip`) is used, it implies
+	--force-rebase.
 
 -i::
 --interactive::
-- 
1.6.2.22.gc2ac
