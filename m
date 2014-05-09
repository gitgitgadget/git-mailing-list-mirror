From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 07/25] contrib: remove 'git-jump'
Date: Fri, 9 May 2014 11:20:05 -0400
Message-ID: <20140509152005.GB18197@sigill.intra.peff.net>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-8-git-send-email-felipe.contreras@gmail.com>
 <20140509020350.GD9787@sigill.intra.peff.net>
 <536c399454062_741a161d31099@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 17:20:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wimav-0003Tk-Lk
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 17:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756816AbaEIPUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 11:20:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:48294 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756785AbaEIPUH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 11:20:07 -0400
Received: (qmail 26282 invoked by uid 102); 9 May 2014 15:20:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 May 2014 10:20:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 May 2014 11:20:05 -0400
Content-Disposition: inline
In-Reply-To: <536c399454062_741a161d31099@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248570>

On Thu, May 08, 2014 at 09:12:36PM -0500, Felipe Contreras wrote:

> Jeff King wrote:
> > On Thu, May 08, 2014 at 07:58:18PM -0500, Felipe Contreras wrote:
> > 
> > > No activity, no tests.
> > 
> > Like diff-highlight, I don't think "no activity" is a useful indicator.
> > I use this daily, and several people have commented off-list to me that
> > they use it, too.
> 
> Add tests then.

I don't really feel like spending time on it right now. There are better
uses of my time.

I thought on this for a while before responding. Am I simply being lazy
and a bad programmer not to write tests? Am I propagating a double
standard where I do not have to write tests?

Here's the conclusion I came to. Sure, some tests are better than no
tests. But the code works, empirically; I use it every day. It is not
changing, so the chances of regression are low. I can spend an hour
writing tests that demonstrate what I already know. I can even spend
several hours trying to come up with torture cases that might
demonstrate a potential failure that nobody in the real world
experiences. But why?

Because YOU, who have no interest whatsoever in either this script or
diff-highlight, have decided to demand that I write them, or spend time
spinning the code into its own repository. Sorry, but I have more useful
things to do than appease you.

I have no problem with cleaning up cruft in contrib that is broken and
nobody uses; it is a potential hazard and time-waster for people who
look in that directory. But when people say "no, this is maintained, I
use it, and it works", I really don't see the point in you arguing with
them. Nobody benefits.

> It this is never meant to move to the core, then it should go
> out-of-tree anyway.

"should" in your opinion. I know, I know, you will quote contrib/README
at me.  If Junio wants to enforce "contrib is only for things which are
meant to graduate" in his tree, then I will abide by that and maintain
these scripts out-of-tree. But I would rather see an actual decision
from the maintainer on that, and not an 8-year-old README which clearly
has not been followed in the intervening years.

And speaking of wasted time, I do not plan on responding further to you
in this thread. I am telling you ahead of time that this is the case,
because elsewhere[1] I saw you complaining that Junio did not respond to
your emails, which you seemed to think was because he cannot admit that
he was wrong. So I want to say up front that I am going to avoid
interacting with you further because it generally seems fruitless,
consumes a large amount of time, and causes me a great deal of stress.

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/248441
