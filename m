From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2 (RFC)] Documentation/SubmittingPatches: discuss first then submit
Date: Sun, 03 Feb 2008 17:00:16 -0800
Message-ID: <7v3as9pmcf.fsf_-_@gitster.siamese.dyndns.org>
References: <r6ft1sd1.fsf@blue.sea.net>
	<7v7ihlpmkm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 02:01:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLphq-0003mF-1K
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 02:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494AbYBDBAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 20:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754443AbYBDBAd
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 20:00:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42362 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228AbYBDBAc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 20:00:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DBA31409;
	Sun,  3 Feb 2008 20:00:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D9D131408;
	Sun,  3 Feb 2008 20:00:28 -0500 (EST)
In-Reply-To: <7v7ihlpmkm.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 03 Feb 2008 16:55:21 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72442>

This is something I've had in mind for some time.  I get enough
e-mails as-is, and I suspect the workflow to get list members
involved would work better if we get the discussion concluded on
the list first before patches hit my tree (even 'next').

---
On top of the previous one to talk about [PATCH v2] and friends...

 Documentation/SubmittingPatches |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index cd80148..0661293 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -34,9 +34,9 @@ Checklist (and a short version for the impatient):
 	- if your name is not writable in ASCII, make sure that
 	  you send off a message in the correct encoding.
 	- send the patch to the list (git@vger.kernel.org) and the
-	  maintainer (gitster@pobox.com). If you use
-	  git-send-email(1), please test it first by sending
-	  email to yourself.
+	  maintainer (gitster@pobox.com) if (and only if) the patch
+	  is ready for inclusion. If you use git-send-email(1),
+	  please test it first by sending email to yourself.
 
 Long version:
 
@@ -162,7 +162,8 @@ Note that your maintainer does not necessarily read everything
 on the git mailing list.  If your patch is for discussion first,
 send it "To:" the mailing list, and optionally "cc:" him.  If it
 is trivially correct or after the list reached a consensus, send
-it "To:" the maintainer and optionally "cc:" the list.
+it "To:" the maintainer and optionally "cc:" the list for
+inclusion.
 
 Also note that your maintainer does not actively involve himself in
 maintaining what are in contrib/ hierarchy.  When you send fixes and
