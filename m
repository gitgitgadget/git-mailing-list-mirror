From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 02:58:49 -0400
Message-ID: <20061010065849.GA2413@coredump.intra.peff.net>
References: <20061010054643.GA565@coredump.intra.peff.net> <20061010064117.86409.qmail@web31813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 08:59:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXBZs-00016g-95
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 08:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWJJG6w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 02:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWJJG6w
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 02:58:52 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:44758 "HELO
	peff.net") by vger.kernel.org with SMTP id S965050AbWJJG6v (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 02:58:51 -0400
Received: (qmail 23402 invoked from network); 10 Oct 2006 02:58:49 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 10 Oct 2006 02:58:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Oct 2006 02:58:49 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20061010064117.86409.qmail@web31813.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28612>

On Mon, Oct 09, 2006 at 11:41:17PM -0700, Luben Tuikov wrote:

> Then let's universally underline absolutely _every_ link in gitweb
> which is clickable, regardless of where it appears, the font, typeset
> and size.

Instead, let's make a strawman argument!

Though I agree that it would be nicer for ALL links in gitweb to be
consistent, I think there is an argument to be made about look. However,
the specific example I mentioned is a single list in which some elements
are underlined and blue (which has been the classic user interface hint
for a link for a decade), and some aren't. Do you see why I think that
might be inconsistent?

> Unless you have "a priori" knowlege of "underline means clickable" there

Which was my argument in the first place (note that I was talking about
people with a high degree of computer exposure).

> is no chance of thinking that "not-underlined means not-clickable".

There is clearly a non-zero chance. Here's a relatively ridiculous
argument.

Look at the 'summary' page for a project. For each commit, there are
blue and underlined 'commitdiff', 'text', and 'snapshot' links.  The
date, author, and message text have no such decoration. I click on the
underlined things and see that they are all links. I click on date and
author and see they are not links. The pattern of underlining links has
held for five out of six elements. Do you think it's unreasonable to
guess that the sixth element is not a link based on that pattern?


Look, I agree that not underlining everything might make the page look
nicer. And if we want to balance consistency against aesthetics, that's
fine. But please don't argue that there isn't an inconsistency.

-Peff
