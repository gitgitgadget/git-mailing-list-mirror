From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Thu, 02 Aug 2007 17:05:36 -0700
Message-ID: <7vodhpscrz.fsf@assigned-by-dhcp.cox.net>
References: <11858118802945-git-send-email-prohaska@zib.de>
	<20070802181853.GB31885@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 02:05:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGkfl-0007BM-Fq
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 02:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758492AbXHCAFj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 20:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757920AbXHCAFi
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 20:05:38 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:60454 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756858AbXHCAFi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 20:05:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070803000537.XZLA7349.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 20:05:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XC5c1X00W1kojtg0000000; Thu, 02 Aug 2007 20:05:37 -0400
In-Reply-To: <20070802181853.GB31885@fieldses.org> (J. Bruce Fields's message
	of "Thu, 2 Aug 2007 14:18:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54652>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> I wonder whether we could get away with just the brief list of features
> ("lets you view changes in the index and the working file, lets you
> individually select diff hunks for inclusion in the index"), and leave
> the how-to stuff to online guit-gui help, if it's necessary?

Let's do that.

> Also, I like the verb "stage" as a way to explain the part of the index
> file in creating commits, but I've been consistently using the word
> "index" throughout the user manual, and I think that's consistent with
> the rest of the documentation--so don't avoid it here.

I tend to agree.  The verb "to stage" is really just a way to
say "the act of adding contents to the index" and explain what
it implies (i.e. "prepare it to be included in the next commit").
Saying "you can _think_ of the index as a staging area" is fine,
but the official name of that thing is "the index", and I do not
think avoiding that term adds clarity to the documentation.
