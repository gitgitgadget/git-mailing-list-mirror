From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Clarify which paths git-clean will affect
Date: Wed, 06 May 2009 10:57:54 -0700
Message-ID: <7vljpauna5.fsf@alter.siamese.dyndns.org>
References: <20090505091302.GB27900@frsk.net>
	<200905051426.18814.trast@student.ethz.ch>
	<7vk54v1py6.fsf@alter.siamese.dyndns.org>
	<200905061524.52186.trast@student.ethz.ch>
	<20090506163145.GF4452@frsk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Fredrik Skolmli <fredrik@frsk.net>
X-From: git-owner@vger.kernel.org Wed May 06 19:58:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1lO7-0005UO-1F
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 19:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543AbZEFR5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 13:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756027AbZEFR5z
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 13:57:55 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46053 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856AbZEFR5y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 13:57:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090506175754.EPDE20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 6 May 2009 13:57:54 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id oHxu1b00B4aMwMQ03HxuqT; Wed, 06 May 2009 13:57:54 -0400
X-Authority-Analysis: v=1.0 c=1 a=jW5P4C6t7I8A:10 a=-ca1oWsSjK8A:10
 a=EjjfHCv3AAAA:8 a=ybZZDoGAAAAA:8 a=8dF8dL1V9nH1AGxSgHAA:9
 a=VikH19sV6UTBtUPCw_YA:7 a=Z1e9gegn6zzFz5uqpprkZHdVdeAA:4 a=_QZ2ba7fPqkA:10
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <20090506163145.GF4452@frsk.net> (Fredrik Skolmli's message of "Wed\, 6 May 2009 18\:31\:45 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118361>

Fredrik Skolmli <fredrik@frsk.net> writes:

> On Wed, May 06, 2009 at 03:24:47PM +0200, Thomas Rast wrote:
>
>> Indeed, yours is better.
>
> And I agree, it does looks better. Junio, would you like me to produce a
> patch v2, or would you like do the honor? (After all, you came up with the
> final suggestion)

Ok, I'll queue this one.

-- >8 -- 
Date: Wed, 6 May 2009 10:48:26 -0700
Subject: [PATCH] git-clean doc: the command only affects paths under $(cwd)

Fredrik Skolmli and Thomas Rast noticed that it was left unstated that
"git clean" ran from a subdirectory will not affect anything outside it,
with or without path limiters.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-clean.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 43b2de7..be894af 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -13,8 +13,8 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-This allows cleaning the working tree by removing files that are not
-under version control.
+Cleans the working tree by recursively removing files that are not
+under version control, starting from the current directory.
 
 Normally, only files unknown to git are removed, but if the '-x'
 option is specified, ignored files are also removed. This can, for
