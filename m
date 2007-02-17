From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-name-rev: accept list of refs from user
Date: Sat, 17 Feb 2007 15:30:02 -0800
Message-ID: <7vr6soqs5h.fsf@assigned-by-dhcp.cox.net>
References: <7vmz3ctzer.fsf@assigned-by-dhcp.cox.net>
	<20070217231327.GA5382@coredump.intra.peff.net>
	<20070217231943.GA30839@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 00:30:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIZ0K-0006jT-SI
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 00:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992874AbXBQXaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 18:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992868AbXBQXaF
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 18:30:05 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:64331 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992875AbXBQXaD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 18:30:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217233003.FJAC22948.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 18:30:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QnW21W00S1kojtg0000000; Sat, 17 Feb 2007 18:30:03 -0500
In-Reply-To: <20070217231943.GA30839@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 17 Feb 2007 18:19:43 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40024>

Jeff King <peff@peff.net> writes:

> On Sat, Feb 17, 2007 at 06:13:28PM -0500, Jeff King wrote:
>
>>   git show-ref | grep /v1 | git name-rev --refs-from=- $commit
>
> BTW, I think this should be in addition to, not instead of, Johannes'
> patch. I think for the simple filtering case, his syntax is much quicker
> and more natural.
>
> Of course, there will be plenty of conflicts merging them. :) I can do
> the merge and resubmit after you publish Johannes' patch; just let me
> know.

I was hoping that everybody would be happy once Johannes's patch
is extended to grok more than one --refs=<pattern> options.
