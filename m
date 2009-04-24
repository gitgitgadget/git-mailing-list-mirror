From: Jeff King <peff@peff.net>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 11:04:42 -0400
Message-ID: <20090424150442.GA11245@coredump.intra.peff.net>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org> <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com> <20090423201636.GD3056@coredump.intra.peff.net> <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com> <20090424141139.GC10761@coredump.intra.peff.net> <b4087cc50904240730n42e605e1od37d88d43e00f142@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 17:07:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxMz0-0002V0-RW
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 17:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbZDXPEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 11:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbZDXPEu
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 11:04:50 -0400
Received: from peff.net ([208.65.91.99]:44951 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbZDXPEt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 11:04:49 -0400
Received: (qmail 29062 invoked by uid 107); 24 Apr 2009 15:04:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 11:04:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 11:04:42 -0400
Content-Disposition: inline
In-Reply-To: <b4087cc50904240730n42e605e1od37d88d43e00f142@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117448>

On Fri, Apr 24, 2009 at 09:30:20AM -0500, Michael Witten wrote:

> On Fri, Apr 24, 2009 at 09:11, Jeff King <peff@peff.net> wrote:
> > I think I wasn't clear in my original message. I didn't mean teaching
> > low-level stuff like plumbing or file layouts. By "bottom-up" I really
> > meant teaching concepts (like objects, their types, and references),
> > from which user operations and workflows can be explained (or often
> > deduced by the user). Whereas a top-down approach would _start_ with
> > workflows and say "To accomplish X, do Y".
> 
> I knew you would make exactly this rebuttle ;-D
> 
> However, notice that you can't reasonably be expected to understand
> "accomplish X" without having concepts like objects and references.

Heh. I don't think you also predicted the paragraph that I ended up
deleting, which made it more clear that I was not trying to rebut, but
rather agree.

Like you, I think that not teaching concepts first leads to confusion
later.  Version control (or at least git) is just complex enough that
you are much better off understanding what is happening than simply
following a recipe. So when your recipe doesn't go as planned, or you
don't know which recipe to use, or you need some variant of a recipe,
you have some basis for understanding what to do.

But users in the past have really seemed to want to start with recipes,
so that they can be productive as soon as possible (and I think some
people have said that the top-down ordering just makes more sense to
them, so it may just be a matter of learning style). And I think the
user manual is somewhat of a response to that request, since the
command manpages are very bottom-up (but are also quite confusing, just
because of their size, and because concept information is scattered
throughout).

So I am advocating for more bottom-up documentation (which I think you
are), but I don't necessarily think it should _replace_ the top-down
documentation (which I'm not sure is your position or not).

> The reason most people get by is that git's operation can be
> compatible with a number of other theories people might have already
> picked up from using computers. The trouble starts when their existing
> theories don't mesh well with the underlying git theory, leading the
> user to develop the equivalent of epicycles in order to explain to
> himself whats going on.

Epicycles? I thought commit orbits were defined by the ether through
they flowed.

-Peff
