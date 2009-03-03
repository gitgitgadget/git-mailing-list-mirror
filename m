From: Jeff King <peff@peff.net>
Subject: [PATCH] doc: clarify how -S works
Date: Tue, 3 Mar 2009 10:40:41 -0500
Message-ID: <20090303154041.GA31265@coredump.intra.peff.net>
References: <49AD3E78.1050706@sneakemail.com> <20090303152333.GB24593@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Valdemar =?utf-8?B?TcO4cmNoIChMaXN0cyk=?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 16:42:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeWlZ-00038r-Uy
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 16:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677AbZCCPkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 10:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754151AbZCCPkq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 10:40:46 -0500
Received: from peff.net ([208.65.91.99]:53412 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754086AbZCCPkp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 10:40:45 -0500
Received: (qmail 17263 invoked by uid 107); 3 Mar 2009 15:40:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 10:40:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 10:40:41 -0500
Content-Disposition: inline
In-Reply-To: <20090303152333.GB24593@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112090>

The existing text was very vague about what exactly it means
for difference to "contain" a change. This seems to cause
confusion on the mailing list every month or two.

To fix it we:

  1. use "introduce or remove an instance of" instead of
     "contain"

  2. point the user to gitdiffcore(7), which contains a more
     complete explanation

Signed-off-by: Jeff King <peff@peff.net>
---
I wonder if "gitdiffcore" is a little scary for new people who just want
to use "-S", but hopefully point (1) above will get rid of most of the
confusion, and those who follow the link want to learn all about diff.

 Documentation/diff-options.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 813a7b1..9276fae 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -176,7 +176,10 @@ override configuration settings.
 	number.
 
 -S<string>::
-	Look for differences that contain the change in <string>.
+	Look for differences that introduce or remove an instance of
+	<string>. Note that this is different than the string simply
+	appearing in diff output; see the 'pickaxe' entry in
+	linkgit:gitdiffcore[7] for more details.
 
 --pickaxe-all::
 	When -S finds a change, show all the changes in that
-- 
1.6.2.rc2.330.gba39e
