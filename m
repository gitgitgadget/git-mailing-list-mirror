From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: merge-recursive: do not rudely die on binary merge
Date: Tue, 14 Aug 2007 21:16:29 -0400
Message-ID: <20070815011629.GA11266@pe.Belkin>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net> <20070814231422.GA10662@pe.Belkin> <7vlkcdacbi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 03:16:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL7VC-0007jQ-26
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 03:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707AbXHOBQb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 21:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754975AbXHOBQb
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 21:16:31 -0400
Received: from eastrmmtao104.cox.net ([68.230.240.46]:47839 "EHLO
	eastrmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbXHOBQb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 21:16:31 -0400
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070815011631.GCLD16925.eastrmmtao104.cox.net@eastrmimpo02.cox.net>;
          Tue, 14 Aug 2007 21:16:31 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo02.cox.net with bizsmtp
	id c1GV1X00Y0epFYL0000000; Tue, 14 Aug 2007 21:16:29 -0400
Received: from chris by localhost with local (Exim 4.66)
	(envelope-from <c.shoemaker@cox.net>)
	id 1IL7Ur-0002vn-Vf; Tue, 14 Aug 2007 21:16:29 -0400
Content-Disposition: inline
In-Reply-To: <7vlkcdacbi.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55869>

On Tue, Aug 14, 2007 at 05:09:05PM -0700, Junio C Hamano wrote:
> Chris Shoemaker <c.shoemaker@cox.net> writes:
> 
> >> This changes merge-recursive to still warn but do the "binary"
> >> merge for such a path; leave the "our" version in the working
> >> tree, but still keep the path unmerged so that the user can sort
> >> it out.
> >
> > Very nice.
> 
> Forgot to ask.  I did this because you had trouble on #git
> yesterday and then at around the same time today somebody else
> had the same issue.  Did this patch solve your problem?  I do
> not think this has big risk of regression, but if it does not
> help anything there is no reason to put it in 1.5.3, so I am
> asking for a success report.

Yes, with this patch, the merge completes, and leaves the index and
working tree in a sane state.  Thanks again.

-chris
