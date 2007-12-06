From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] Documentation: color.* = true means "auto"
Date: Wed,  5 Dec 2007 18:05:03 -0800
Message-ID: <1196906706-11170-1-git-send-email-gitster@pobox.com>
References: <475697BC.2090701@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 06 03:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J067X-0004ZH-TF
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 03:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbXLFCFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 21:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbXLFCFK
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 21:05:10 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:46599 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbXLFCFI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 21:05:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20071206020507.ZLED20016.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Wed, 5 Dec 2007 21:05:07 -0500
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id ME561Y00M1gtr5g0000000; Wed, 05 Dec 2007 21:05:06 -0500
X-Mailer: git-send-email 1.5.3.7-2132-gbd1cf
In-Reply-To: <475697BC.2090701@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67219>

We forgot to document the earlier sanity-fix.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 72a33e9..0e45ec5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -359,8 +359,8 @@ clean.requireForce::
 
 color.branch::
 	A boolean to enable/disable color in the output of
-	gitlink:git-branch[1]. May be set to `true` (or `always`),
-	`false` (or `never`) or `auto`, in which case colors are used
+	gitlink:git-branch[1]. May be set to `always`,
+	`false` (or `never`) or `auto` (or `true`), in which case colors are used
 	only when the output is to a terminal. Defaults to false.
 
 color.branch.<slot>::
@@ -378,9 +378,9 @@ second is the background.  The position of the attribute, if any,
 doesn't matter.
 
 color.diff::
-	When true (or `always`), always use colors in patch.
-	When false (or `never`), never.  When set to `auto`, use
-	colors only when the output is to the terminal.
+	When set to `always`, always use colors in patch.
+	When false (or `never`), never.  When set to `true` or `auto`, use
+	colors only when the output is to the terminal. Defaults to false.
 
 color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>` specifies
@@ -397,8 +397,8 @@ color.pager::
 
 color.status::
 	A boolean to enable/disable color in the output of
-	gitlink:git-status[1]. May be set to `true` (or `always`),
-	`false` (or `never`) or `auto`, in which case colors are used
+	gitlink:git-status[1]. May be set to `always`,
+	`false` (or `never`) or `auto` (or `true`), in which case colors are used
 	only when the output is to a terminal. Defaults to false.
 
 color.status.<slot>::
-- 
1.5.3.7-2132-gbd1cf
