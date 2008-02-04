From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] Documentation/SubmittingPatches: What's Acked-by and Tested-by?
Date: Sun, 03 Feb 2008 17:02:28 -0800
Message-ID: <7vwsplo7ob.fsf_-_@gitster.siamese.dyndns.org>
References: <r6ft1sd1.fsf@blue.sea.net>
	<7v7ihlpmkm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 02:03:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLpjp-0004Ac-7Q
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 02:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686AbYBDBCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 20:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754018AbYBDBCg
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 20:02:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbYBDBCf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 20:02:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DBBB41417;
	Sun,  3 Feb 2008 20:02:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 63E291416;
	Sun,  3 Feb 2008 20:02:30 -0500 (EST)
In-Reply-To: <7v7ihlpmkm.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 03 Feb 2008 16:55:21 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72444>

We used to talk about "internal company procedures", but this
document is about submitting patches to the git mailing list.

More useful information is when to say Acked-by: and Tested-by:.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 7900223..0661293 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -216,10 +216,18 @@ then you just add a line saying
 This line can be automatically added by git if you run the git-commit
 command with the -s option.
 
-Some people also put extra tags at the end.  They'll just be ignored for
-now, but you can do this to mark internal company procedures or just
-point out some special detail about the sign-off.
-
+Notice that you can place your own Signed-off-by: line when
+forwarding somebody else's patch with the above rules for
+D-C-O.  Indeed you are encouraged to do so.  Do not forget to
+place an in-body "From: " line at the beginning to properly attribute
+the change to its true author (see (2) above).
+
+Some people also put extra tags at the end.
+
+"Acked-by:" says that the patch was reviewed by the person who
+is more familiar with the issues and the area the patch attempts
+to modify.  "Tested-by:" says the patch was tested by the person
+and found to have the desired effect.
 
 ------------------------------------------------
 MUA specific hints
