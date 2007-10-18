From: Jeff King <peff@peff.net>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 23:23:07 -0400
Message-ID: <20071018032307.GA7313@coredump.intra.peff.net>
References: <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org> <20071017015109.303760cc@localhost.localdomain> <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org> <20071018003256.GA5062@coredump.intra.peff.net> <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org> <20071018024553.GA5186@coredump.intra.peff.net> <alpine.LFD.0.999.0710171955580.26902@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Lu <git@vicaya.com>, Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 05:23:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiLyk-0005fb-AO
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 05:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760590AbXJRDXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 23:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760869AbXJRDXK
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 23:23:10 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4067 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755720AbXJRDXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 23:23:09 -0400
Received: (qmail 31945 invoked by uid 111); 18 Oct 2007 03:23:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 17 Oct 2007 23:23:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2007 23:23:07 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710171955580.26902@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61457>

On Wed, Oct 17, 2007 at 08:13:23PM -0700, Linus Torvalds wrote:

> Yes. 
> 
> You're missing the fact that some people have problems with editors.
> 
> So they add a line, and they add *that* line with the wrong kind of 
> indentation. And it shows up among the other lines like this (here the 
> whole patch is indented):

Oh. I thought you meant "if you have an all-spaces policy, your diffs
will not look good." But what you meant was "when people screw up your
policy by mixing tabs and spaces, your diffs will not look good." And
that applies equally, whether they are screwing up your all-tabs or
all-spaces setup (and I remain convinced that no matter what your
policy, people _will_ screw it up).

Thanks for the clarification.

> It's very seldom the case that you grow some problem space and performance 
> stays the same.

Yes. I wondered whether the increased size would really matter here, or
if it would get lost in the noise of program startup and other
activities. But in this case, it really does matter.

> > Gah, I can't believe I've not only been sucked into a tab vs spaces
> > discussion, but now I've actually wasted time doing a performance
> > comparison on it.
> Well, performance analysis isn't exactly a "waste". That "git grep" was 

No, it's not a waste. In the grand scheme of things, I don't actually
care that much about the result, but hey, I think I may be the only
person out of this gigantic thread to actually provide _numbers_. :)

> Yeah, I don't think it's wonderful, but it might even be a good thing as a 
> "hey, at least you are aware of the notion of GC now" kind of introduction 
> to people (who then hopefully realize that they don't actually want 
> automatic GC, but rather do it once a week or something).

It would have been nicer if it said something like "Your repository
looks crufty. Running git-gc --auto..." using whatever terms users would
be comfortable with. Instead, it just started with "Counting objects"
and a long wait. I happen to know what that means, but I'm not sure how
a git newbie would react (though it looked _much_ nicer because of
Nico's recent terser progress patches).

-Peff
