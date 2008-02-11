From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-pull documentation: fix linkgit in the --rebase option description.
Date: Mon, 11 Feb 2008 11:10:33 -0800
Message-ID: <7vve4v8g2e.fsf@gitster.siamese.dyndns.org>
References: <20080211132800.GV25954@genesis.frugalware.org>
	<alpine.LSU.1.00.0802111514400.3870@racer.site>
	<20080211182907.GB25954@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 20:12:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOe59-0004NK-3S
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 20:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758262AbYBKTLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 14:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758288AbYBKTLU
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 14:11:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64743 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758262AbYBKTLD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 14:11:03 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3386D4063;
	Mon, 11 Feb 2008 14:11:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E539A230E;
	Mon, 11 Feb 2008 14:10:50 -0500 (EST)
In-Reply-To: <20080211182907.GB25954@genesis.frugalware.org> (Miklos Vajna's
	message of "Mon, 11 Feb 2008 19:29:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73566>

Miklos Vajna <vmiklos@frugalware.org> writes:

> I see your point and i played with it a bit, no success so far. If it
> becomes a new paragraph, the linkgit: is not processed. maybe it's an
> asciidoc bug?

You probably meant to do this, then.


 Documentation/git-pull.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 4cc633a..179bdfc 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -39,11 +39,11 @@ include::merge-strategies.txt[]
 	there is a remote ref for the upstream branch, and this branch
 	was rebased since last fetched, the rebase uses that information
 	to avoid rebasing non-local changes.
-
-	*NOTE:* This is a potentially _dangerous_ mode of operation.
-	It rewrites history, which does not bode well when you
-	published that history already.  Do *not* use this option
-	unless you have read linkgit:git-rebase[1] carefully.
++
+*NOTE:* This is a potentially _dangerous_ mode of operation.
+It rewrites history, which does not bode well when you
+published that history already.  Do *not* use this option
+unless you have read linkgit:git-rebase[1] carefully.
 
 \--no-rebase::
 	Override earlier \--rebase.
