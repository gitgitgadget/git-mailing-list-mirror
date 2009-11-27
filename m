From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: --full-tree
Date: Fri, 27 Nov 2009 13:02:35 -0500
Message-ID: <20091127180235.GA26633@coredump.intra.peff.net>
References: <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net>
 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
 <20091125222037.GA2861@coredump.intra.peff.net>
 <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
 <20091127062013.GA20844@coredump.intra.peff.net>
 <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302>
 <20091127095914.GA4865@sigill.intra.peff.net>
 <alpine.DEB.1.00.0911271144230.4521@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Pickens <jepicken@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 27 19:02:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE59T-0002ut-Bp
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 19:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbZK0SC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 13:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbZK0SC1
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 13:02:27 -0500
Received: from peff.net ([208.65.91.99]:42460 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbZK0SC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 13:02:27 -0500
Received: (qmail 28566 invoked by uid 107); 27 Nov 2009 18:06:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 27 Nov 2009 13:06:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Nov 2009 13:02:35 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0911271144230.4521@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133914>

On Fri, Nov 27, 2009 at 11:53:42AM +0100, Johannes Schindelin wrote:

> > If only somebody had written a "pager.status" configuration variable,
> > you could use that. Oh wait. I did. And it shipped in v1.6.0.
> 
> And it makes things inconsistent.  That is why I do not use it. 

Then you can not use this configuration variable, too. Has the existence
of pager.status, since you do not use it, been a problem for you so far?

> Do you work on 10 different computers?  I do.  And nothing is more
> unnerving than the same command producing something different on the
> different computers.

Yes, as a matter of fact, I do work on 10 different computers. I'm sorry
that you find managing your configuration so challenging. But if you
don't use the configuration variable, then your own personal setup is
totally irrelevant.

If your argument is that this lack of consistency will irritate users,
you need to show that:

  1. There are users who switch between a large number of setups, but
     will not apply config consistently.

  2. Some of these setups will be using the new config option.

If they are all controlled by a single user, how is that user any worse
off for the config option existing? They can choose not to use it if
the hassle is not worth it. I do not think the existence of an option is
giving too much rope to these users.

If you are talking about 10 machines, all controlled by different users,
whose terminals you have to sit down on to help them, then yes, it will
be inconvenient for you. But if users are setting up configuration for
these machines, shouldn't _their_ convenience in using configuration
trump _your_ convenience for occasionally sitting down and helping them?

> I, for one, do not like Git's reputation, but I am tired of trying to 
> fight for the users.  BTW quick question: how many Git _users_ were at the 
> GitTogether at MV?  0?

In my opinion, you are actively fighting _against_ a user in this case.

And the GitTogether had a "users complain about git, and we try to
listen" session. There were two google users in person, but we also went
through a list of pre-made questions from other googlers. This issue
wasn't discussed, though. Nor was the question of consistency between
configurations, to my recollection. I think Shawn may have taken notes,
and could be more specific.

> >   http://article.gmane.org/gmane.comp.version-control.git/133672
> 
> I only skimmed it, yes.  And I did not plan to participate in this thread.  
> But it seems that my views are not represented enough, even if gitzilla 
> chimed in with the very valid, under-acknowledged and over-ignored 
> message: consistency is good.  Corollary: inconsistency is bad.

That is an over-simplification. Inconsistency between setups is bad. But
so is inconsistency between git commands, and between git and other
commands. So is not supporting a user's workflow, or supporting it in a
way that is tedious and error-prone. You have to weigh the badness of
those things against each other in finding a solution.

But then, that was the point I already made in the article linked above.

-Peff
