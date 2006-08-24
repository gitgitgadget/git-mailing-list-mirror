From: Junio C Hamano <junkio@cox.net>
Subject: Re: git cherry-pick feature request
Date: Thu, 24 Aug 2006 00:29:26 -0700
Message-ID: <7vmz9ubnhl.fsf@assigned-by-dhcp.cox.net>
References: <17643.62896.396783.890223@cargo.ozlabs.ibm.com>
	<7vfyfnixv5.fsf@assigned-by-dhcp.cox.net>
	<17644.21269.128308.313284@cargo.ozlabs.ibm.com>
	<20060823143551.GA4592@sigio.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 09:29:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GG9eg-0007Gs-KL
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 09:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWHXH32 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 03:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWHXH32
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 03:29:28 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:24714 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750703AbWHXH31 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 03:29:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060824072926.LQA21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 Aug 2006 03:29:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id DjVS1V0024Noztg0000000
	Thu, 24 Aug 2006 03:29:26 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060823143551.GA4592@sigio.intra.peff.net> (Jeff King's message
	of "Wed, 23 Aug 2006 10:35:51 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25942>

Jeff King <peff@peff.net> writes:

> On Wed, Aug 23, 2006 at 11:07:33PM +1000, Paul Mackerras wrote:
>
>> While I'm asking for features, another one that would be really useful
>> for another tool I'm writing is a 3-way diff for a file between the
>> working directory, the index, and the current head commit, something
>> like what git diff-tree -c does for merges.  That is, it would have
>
> Theoretically I'm working on this, but I haven't really had time to get
> started on it yet this week. If you have patience, I'll get to it. If
> not, then somebody else is welcome to take a crack at it.

It is not entirely related, but I've restarted looking into a
parallel tree walker again and will push something in "pu"
tonight.

It will probably be quite a while until it becomes useful,
though.  I suspect your approach of internally running
run_diff_files() and run_diff_index() and consolidating the
result, while it might feel hackish, would be easier at least in
the short term.
