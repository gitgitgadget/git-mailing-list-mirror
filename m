From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: --full-tree
Date: Fri, 27 Nov 2009 16:05:30 -0500
Message-ID: <20091127210530.GC26921@coredump.intra.peff.net>
References: <20091125214949.GA31473@coredump.intra.peff.net>
 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
 <20091125222037.GA2861@coredump.intra.peff.net>
 <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
 <20091127062013.GA20844@coredump.intra.peff.net>
 <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302>
 <20091127095914.GA4865@sigill.intra.peff.net>
 <alpine.DEB.1.00.0911271144230.4521@intel-tinevez-2-302>
 <20091127180235.GA26633@coredump.intra.peff.net>
 <alpine.DEB.1.00.0911272102430.4521@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Pickens <jepicken@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 27 22:05:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE80V-0005Sz-At
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 22:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbZK0VFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 16:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbZK0VFX
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 16:05:23 -0500
Received: from peff.net ([208.65.91.99]:53500 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696AbZK0VFX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 16:05:23 -0500
Received: (qmail 29575 invoked by uid 107); 27 Nov 2009 21:09:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 27 Nov 2009 16:09:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Nov 2009 16:05:30 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0911272102430.4521@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133938>

On Fri, Nov 27, 2009 at 09:07:51PM +0100, Johannes Schindelin wrote:

> > Yes, as a matter of fact, I do work on 10 different computers. I'm sorry 
> > that you find managing your configuration so challenging. But if you 
> > don't use the configuration variable, then your own personal setup is 
> > totally irrelevant.
> 
> As I just demonstrated, this is a false statement.

I must have missed where you demonstrated it.

> > If your argument is that this lack of consistency will irritate users,
> > you need to show that:
> > 
> >   1. There are users who switch between a large number of setups, but
> >      will not apply config consistently.
> 
> This is a strawman, and you should be ashamed to put it here.  Just 

How is this a strawman? A strawman would be me overstating an
exaggerated position by you and then arguing against it. All I have
claimed is that it is not sufficient for _you_ to be personally annoyed
by this existence of this option. You need to argue that there is a
significant group of people in the same situation who will be ignored.

Or have I mis-spoken in summarizing your claim that a "lack of
consistency will irritate users". Is that not your point?

> Just think about it.  If you plan to change the side cars are supposed to 
> drive on, it is not enough to have a nice cozy committee deciding on it in 
> some little room somewhere in Wyoming.  Especially not if they decide that 
> you can drive on the other side if you put a sticker "I am a right-wing 
> driver" on your car.

When the number of "git grep" crash fatalities rises above zero, maybe
this line of reasoning will be relevant.

I am talking about making software configurable so that people, in their
own private setups, can make the software work as they see fit. Yes, it
is possible for that setup to be visible to other people in some
situations. But I am arguing that we need to weigh the (in my opinion
substantial) inconvenience to users in their everyday work compared to
the inconvenience of one user sitting at another user's terminal (or
cutting and pasting commands, or running a script).

> > And the GitTogether had a "users complain about git, and we try to
> > listen" session.
> 
> Oh, that makes me so happy.  <sarcasm>Soooo happy</sarcasm>.  So it was an 
> ivory tower meeting, once again?

I don't know what to say. You complain and complain about how git is not
being responsive to users. Shawn organizes a session where people at
Google who are using git every day can try to make their complaints in
an organized forum where a bunch of developers will listen and talk
about ways we can address those complaints. And now you are mad about
that?

If you think we need a git conference where lots of users show up, I
think that's a great idea. But until you provide some suggestions about
how to organize such a thing, I don't see how you are helping anything.

-Peff
