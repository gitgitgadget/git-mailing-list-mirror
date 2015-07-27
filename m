From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Mon, 27 Jul 2015 00:55:33 -0400
Message-ID: <20150727045533.GB27465@peff.net>
References: <20150723012343.GA21000@peff.net>
 <xmqqpp3io5km.fsf@gitster.dls.corp.google.com>
 <20150724072325.GC2111@peff.net>
 <xmqq8ua5oapm.fsf@gitster.dls.corp.google.com>
 <20150725020526.GA8948@peff.net>
 <xmqqh9osjfsu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Josh Bleecher Snyder <josharian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 06:55:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJaRw-0006Em-H8
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 06:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbbG0Ezg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 00:55:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:35077 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750757AbbG0Ezf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 00:55:35 -0400
Received: (qmail 11488 invoked by uid 102); 27 Jul 2015 04:55:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Jul 2015 23:55:35 -0500
Received: (qmail 3679 invoked by uid 107); 27 Jul 2015 04:55:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jul 2015 00:55:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jul 2015 00:55:33 -0400
Content-Disposition: inline
In-Reply-To: <xmqqh9osjfsu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274649>

On Sat, Jul 25, 2015 at 10:41:21AM -0700, Junio C Hamano wrote:

> > I'm still on the fence to have the config kick in only for HEAD.
> 
> Hmm, I cannot tell offhand if the confusion factor is worth it (I
> didn't say "I don't think it is worth it").
> [...]

I've snipped most of your response because it all seemed pretty
reasonable to me.

At this point I think I am of the opinion that the decision to use
--first-parent is sufficiently nuanced that it the config option is not
really a "drop-in" solution for people, even if their projects follow
the matching workflow. Like you, I am not really _against_ it, but since
nobody in this thread is saying "yes, I would turn that on", that may be
a sign. The patch is out there on the list, and I'd encourage people who
think it might be useful to apply the patch and report back in a few
weeks or months if they find it useful.

We _could_ merge the patch to make that experimentation easier for
users. The downside is we will be stuck supporting the log.firstParent
option forever, but I don't think it is actively _wrong_ to have. Just
possibly useless.

And poor Josh, who so nicely came to the Git table at OSCON and talked
to me about his project's workflow, has now had to put up with a slew of
emails and no applied patch. :)

But maybe this discussion is of some use; it has not been fruitless, as
I think the best answer so far is "encourage awareness and appropriate
use of --first-parent".

> I admit I may be minority, but two common things I do everyday are
> "log --first-parent v2.5.0-rc0.." and "log --first-parent master..pu";
> I could certainly use a short-hand there.
> 
> I already have alias for it, so this is not to help me personally,
> but "log -FO" to trigger first-parent one-line would make the alias
> unnecessary.

I do not have an alias, but I spell it "--fir<TAB>". :)

-Peff
