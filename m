From: Paul Mackerras <paulus@samba.org>
Subject: Re: Gitk feature - show nearby tags
Date: Sat, 3 Jun 2006 22:23:37 +1000
Message-ID: <17537.32585.260926.48759@cargo.ozlabs.ibm.com>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	<7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sat Jun 03 14:24:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmVAh-00037r-Vy
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 14:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWFCMXu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 08:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbWFCMXt
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 08:23:49 -0400
Received: from ozlabs.org ([203.10.76.45]:39858 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932622AbWFCMXt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 08:23:49 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 5FB0267A60; Sat,  3 Jun 2006 22:23:48 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21194>

Junio C Hamano writes:

> Another thing that would equally be useful is to show which
> branch a particular commit is on, so for example I can pick one
> commit while doing "gitk next" to view the next branch and see
> which topic it belongs to, and "gitk this-topic" to see which
> commits on that topic, if any, are not yet in the "next" branch.

That wouldn't be hard to do, it's just a matter of finding which heads
are descendents of the selected commit.  I think that with heads, you
would want to see all the descendent heads, rather than just the
nearest ones (those that aren't descendents of another descendent
head) as I do with tags.  What do you think?  If one head is a
descendent of another, and both are descendents of the selected
commit, should I show both?

> BTW, what's the maintenance/rewind policy on the "new" branch of
> gitk.git?  If you are never going to rewind it, I could pull it
> in "next" (and keep pulling your "master" in my "master") for
> wider exposure if you like.

I intend to pull "new" into "master" shortly, assuming I don't get any
bug reports for the "new" branch. :)

If you pull my "new" into your "next", and you then pull your "next"
into your "master", and I pull my "new" into my "master", and you pull
my "master" into your "master", won't we end up with duplicate merges?

Paul.
