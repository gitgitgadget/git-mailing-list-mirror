From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: handle multiple Cc addresses when reading
	mbox message
Date: Fri, 13 Feb 2009 22:37:49 -0500
Message-ID: <20090214033749.GA24545@coredump.intra.peff.net>
References: <1234566313-36478-1-git-send-email-jaysoffian@gmail.com> <20090214003113.GB7769@coredump.intra.peff.net> <76718490902131642y62b81bfat129cfbeda7957ff8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 04:39:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYBN9-000551-VV
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 04:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbZBNDhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 22:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbZBNDhw
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 22:37:52 -0500
Received: from peff.net ([208.65.91.99]:37954 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889AbZBNDhw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 22:37:52 -0500
Received: (qmail 28311 invoked by uid 107); 14 Feb 2009 03:38:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 13 Feb 2009 22:38:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Feb 2009 22:37:49 -0500
Content-Disposition: inline
In-Reply-To: <76718490902131642y62b81bfat129cfbeda7957ff8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109813>

On Fri, Feb 13, 2009 at 07:42:16PM -0500, Jay Soffian wrote:

> On Fri, Feb 13, 2009 at 7:31 PM, Jeff King <peff@peff.net> wrote:
> > I don't know what the right solution is. I am certainly not volunteering
> > to rewrite; I am very happy just using my actual MUA to send patches. :)
> 
> It is quite ugly, and I have thought about rewriting it.
> 
> But to be quite honest, I have become very discouraged over the last
> two weeks about submitting patches. What seems at first to be a simple
> change has required multiple revisions over frankly what feels to me
> like nit-picking.

I hope it wasn't my message in this thread that sent you over the edge.
I really did mean the "this isn't a comment on your patch" but was just
musing out loud over what the right direction for send-email is in
general.

> Me: Notice wart
> Me: Cut wart off (i.e. submit patch)
> Reviewer: Sorry, you didn't cut that wart off to my standards, unless
> you can do it better, I'd rather have the wart.
> 
> I dunno, maybe I'm too sensitive and don't have the fortitude for
> contributing to git.
> 
> Or maybe I'm just venting on a Friday.

I hope just venting. I think the warts you've been cutting off have been
improving git.

One of the things I have seen happening with your patches is something
like:

  Jay: Here's a patch.
  Reviewer: Good, but it should also do X to be complete.
              or
            Good, but there is one corner case where the correct
            behavior is unclear [queue endless discussion, production of
            several versions of the patch doing different behavior, or
            realization that some of the behavior would be an order of
            magnitude more work to implement]

Those sorts of reviews are good for helping git in the long run, and I
think reviewers are often thinking in terms of git's overall
progression. But I think it is also OK sometimes as a patch submitter to
say "This series scratches my itch, and I am done for now." And maybe
somebody else picks it up and builds on it. Or maybe you do, but weeks
or months later. Or maybe nobody does, because it turns out that nobody
really cares about that corner case in practice.

Which is really just "perfect is the enemy of the good" in another form,
and recognizing that git's development is incremental.

And all of that isn't to say there aren't plenty of patches that should
be rejected for incompleteness or lack of handling corner cases. Many
times an incomplete solution is worse than no solution at all. So there
is some judgement required about whether the changes are a net positive
and a net negative.

But I think it is up to the submitter to decide how far he wants to take
a given topic (and at what rate), and to say "OK, I'll go implement
that", "This behavior doesn't go all the way, but we're better off than
before", or even to just take a week off and come back to it later.

So if you're feeling burned out on submitting patches, maybe that helps.

Of course, there are also just plain nitpicks. We try to keep them to a
minimum, but they do creep in. :)

-Peff
