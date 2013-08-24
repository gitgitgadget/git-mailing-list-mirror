From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/13] Modernize user-manual
Date: Sat, 24 Aug 2013 20:31:32 +0100
Organization: OPDS
Message-ID: <1E7ACF7D33524F728C058D4F850613D1@PhilipOakley>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <gitster@pobox.com>, <wking@tremily.us>
To: "Thomas Ackermann" <th.acker@arcor.de>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 24 21:31:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDJYf-0006iX-Ot
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 21:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447Ab3HXTba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 15:31:30 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:43582 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755432Ab3HXTb3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Aug 2013 15:31:29 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah8NAOMIGVJOl3GZ/2dsb2JhbABagweJa7cjBAQBgRoXdGgBAYEfAQEUAQQBAQQBCAEBLh4BASELAgMFAgEDDgcMJRQBBBoGBxcGARIIAgECAwGFOAcBghENAwkKrFoFiXKNf4FGgTODI30DiHmGEZpFgTqBZTuBLQ
X-IPAS-Result: Ah8NAOMIGVJOl3GZ/2dsb2JhbABagweJa7cjBAQBgRoXdGgBAYEfAQEUAQQBAQQBCAEBLh4BASELAgMFAgEDDgcMJRQBBBoGBxcGARIIAgECAwGFOAcBghENAwkKrFoFiXKNf4FGgTODI30DiHmGEZpFgTqBZTuBLQ
X-IronPort-AV: E=Sophos;i="4.89,947,1367967600"; 
   d="scan'208";a="439285359"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip02ir2.opaltelecom.net with SMTP; 24 Aug 2013 20:31:26 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232887>

From: "Thomas Ackermann" <th.acker@arcor.de>
> Hi,
>
> command output has changed for some commands in the last years,
> so reflect this also in the user-manual. While doing so, fix some
> minor
> spelling, formatting and wording issues.
>
> Further, some references and recommendations which nowadays might
> only confuse and not help new Git users where removed. Also some
> explanations where rephrased to IMHO make them easier to understand
> for new users.

Since 1.8.3 we have had the ability to list the main Git Guides using
the 'git help -g' option, unfortunately the User Manual is not in a man
format, so it isn't listed within the help option.

Is it worth adjusting the User Manual formatting such that it could be
displayed as a man page? (which would also require a file name change
from user-manual.txt to git-user-manual.txt). Or create a new man page
helper `git-user-manual.txt` that would provide a follow-me link to the
current user manual?

Back at $gmane/216146 Junio noted that the git(1) man page does contain
onward links to the user manual, but I believe that users should be able
to get to it directly from a git command such as 'git help user-manual'.
Easy access makes it more likely to be read, in the same way that man 
pages are checked.

Philip

>
> The last patch removes a lengthy paragraph which states that "git
> prune"
> (and "git fsck") should only be used in a quiescent repository.  The
> man-page for "git prune" tells nothing about this. So either the
> removal should be OK or we have to duplicate the warning paragraph
> in the man-page of "git prune"?
>
> [PATCH 01/13] Call it "Git User Manual" and remove reference to very
> old Git version
> [PATCH 02/13] Use current "detached HEAD" message
> [PATCH 03/13] Use current output for "git repack"
> [PATCH 04/13] Use "git merge" instead of "git pull ."
> [PATCH 05/13] Fix some typos
> [PATCH 06/13] Simplify "How to make a commit"
> [PATCH 07/13] Improve description in "How to merge"
> [PATCH 08/13] Improve section "Manipulating branches"
> [PATCH 09/13] Improve section "Merge multiple trees"
> [PATCH 10/13] Remove unnecessary historical note from "Object storage
> format"
> [PATCH 11/13] Remove obscure reference from "Examples"
> [PATCH 12/13] Remove irrelevant reference from "Tying it all together"
> [PATCH 13/13] "git prune" is safe now
>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
>
>
> ---
> Thomas
