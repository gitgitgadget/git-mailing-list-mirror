From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] git-rm.txt: Fix quoting
Date: Wed,  8 Dec 2010 12:15:07 +0100
Message-ID: <73d13b752212b557c0dc157edea9a62122840e93.1291806379.git.git@drmicha.warpmail.net>
References: <20101207172542.GA25827@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 12:17:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQI1f-0004ph-W8
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 12:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991Ab0LHLRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 06:17:31 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53710 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751723Ab0LHLRa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 06:17:30 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 64DA02CB;
	Wed,  8 Dec 2010 06:17:30 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 08 Dec 2010 06:17:30 -0500
X-Sasl-enc: h7fLOcQnE4MCJFJEcooreKF5x+Er/SlZs1NG+FYPuOwn 1291807049
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D024C401480;
	Wed,  8 Dec 2010 06:17:29 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.660.g7cc83
In-Reply-To: <20101207172542.GA25827@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163189>

Literal " produces typographically incorrect quotations, but "works" in
most circumstances. In the subheadings of git-rm.txt, it "works" for the
html backend but not for the docbook conversion to nroff: double "" and
spurious double spaces appear in the output.

Replace "incorrect" quotations by ``correct'' ones, and fix other
"quotations" which are really 'command names' resp. plain words.

This should make git-rm.txt "-clean.

Reported-by: Jeff King <peff@peff.net>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

---
While we don't need to match the underlines to the header's length, it
looks nicer. So v2 incorporates this and the other changes:
- untar is not a command on proper OSs
- rsync is not a complete command line (implicit style guide...)

 Documentation/git-rm.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 71e3d9f..0adbe8b 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -89,8 +89,8 @@ the paths that have disappeared from the filesystem. However,
 depending on the use case, there are several ways that can be
 done.
 
-Using "git commit -a"
-~~~~~~~~~~~~~~~~~~~~~
+Using ``git commit -a''
+~~~~~~~~~~~~~~~~~~~~~~~
 If you intend that your next commit should record all modifications
 of tracked files in the working tree and record all removals of
 files that have been removed from the working tree with `rm`
@@ -98,8 +98,8 @@ files that have been removed from the working tree with `rm`
 automatically notice and record all removals.  You can also have a
 similar effect without committing by using `git add -u`.
 
-Using "git add -A"
-~~~~~~~~~~~~~~~~~~
+Using ``git add -A''
+~~~~~~~~~~~~~~~~~~~~
 When accepting a new code drop for a vendor branch, you probably
 want to record both the removal of paths and additions of new paths
 as well as modifications of existing paths.
@@ -111,8 +111,8 @@ tree using this command:
 git ls-files -z | xargs -0 rm -f
 ----------------
 
-and then "untar" the new code in the working tree. Alternately
-you could "rsync" the changes into the working tree.
+and then untar the new code in the working tree. Alternately
+you could 'rsync' the changes into the working tree.
 
 After that, the easiest way to record all removals, additions, and
 modifications in the working tree is:
-- 
1.7.3.2.662.g6fd5b8.dirty
