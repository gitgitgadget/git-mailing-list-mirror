From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation: Add a usage case of git-reset with
 path
Date: Sat, 16 Feb 2008 10:40:20 -0800
Message-ID: <7vabm0agob.fsf@gitster.siamese.dyndns.org>
References: <1203180526-12020-1-git-send-email-pdebie@ai.rug.nl>
 <1203180526-12020-2-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sat Feb 16 19:41:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQRyh-0005nl-CE
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 19:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756474AbYBPSlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 13:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754686AbYBPSlA
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 13:41:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756137AbYBPSk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 13:40:58 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3479141F5;
	Sat, 16 Feb 2008 13:40:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 6427E41F4; Sat, 16 Feb 2008 13:40:53 -0500 (EST)
In-Reply-To: <1203180526-12020-2-git-send-email-pdebie@ai.rug.nl> (Pieter de
 Bie's message of "Sat, 16 Feb 2008 17:48:46 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74058>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> @@ -176,6 +176,23 @@ $ git reset                                       <3>
>      committed as 'snapshot WIP'.  This updates the index to show your
>      WIP files as uncommitted.
>  
> +Reset a single file in the index::

Yeah, an example and description for this relatively new feature
has been lacking.  Very mucuh appreciated.

By the way, I noticed a leftover from our ancient past.

-- >8 --
[PATCH] Documentation/git-reset:

Since 3368d11 (Remove unnecessary git-rm --cached reference from
status output), the status output marks the "Added but not yet
committed" section as "Changes to be committed".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-reset.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index a4e0a77..b6bcf4d 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -37,7 +37,7 @@ OPTIONS
 --soft::
 	Does not touch the index file nor the working tree at all, but
 	requires them to be in a good order. This leaves all your changed
-	files "Added but not yet committed", as linkgit:git-status[1] would
+	files "Changes to be committed", as linkgit:git-status[1] would
 	put it.
 
 --hard::
-- 
1.5.4.1.1350.g2b9ee
