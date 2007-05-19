From: Junio C Hamano <junkio@cox.net>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Sat, 19 May 2007 12:56:49 -0700
Message-ID: <7vejlcwpry.fsf@assigned-by-dhcp.cox.net>
References: <200705170539.11402.andyparkins@gmail.com>
	<200705180141.06862.Josef.Weidendorfer@gmx.de>
	<200705180857.18182.andyparkins@gmail.com>
	<200705181043.09203.Josef.Weidendorfer@gmx.de>
	<7vejle6p96.fsf@assigned-by-dhcp.cox.net>
	<20070519181228.GP4708@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>,
	Steven Grimm <koreth@midwinter.com>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Sat May 19 21:56:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpV2v-0007Sz-Qt
	for gcvg-git@gmane.org; Sat, 19 May 2007 21:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760329AbXEST4w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 15:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761551AbXEST4w
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 15:56:52 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:64806 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760329AbXEST4v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 15:56:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519195650.TZJP6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 15:56:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 17wp1X0081kojtg0000000; Sat, 19 May 2007 15:56:50 -0400
In-Reply-To: <20070519181228.GP4708@mellanox.co.il> (Michael S. Tsirkin's
	message of "Sat, 19 May 2007 21:12:28 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47766>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

>> Fetching from a new URL (not just "different from what is
>> defined in .gitmodules") is a major deal from security point of
>> view (you should not fetch from stranger you do not trust).
>
> I'm sorry, I'm confused. I thought the "URL" in .gitmodules
> is just a unique project key/name? So how come you are now
> speaking about fetching from it?

Sorry for confusing you.  The point was by default that we
should not blindly follow URL given from upstream -- the
statement you quoted is one justification why my strawman uses
the URL in .gitmodules as a mere hint and look-up key.

Having said that, I'd ask not to take minor details in the
strawman too literally and seriously.  I am 100% sure that we
would be in a serious trouble if what we end up doing matches
literally what my handwaving strawman suggested.  The strawman
was thrown out to the open primarily so that (smarter and more
beautiful) people who thought the issues longer and harder to
express their opinions easier by having something to compare
their unique ideas against, nothing more.

I am slightly more than 50% sure that we would not want to tie
subproject fetch/clone into superproject fetch/clone, and _if_
we would tie it to anything, it would be to the checkout, but
that is only my gut feeling.  Maybe we end up not tying
subproject fetch/clone to anything that happens in the
superproject; we may even do it in a completely different way
than the strawman said it _might_ work.  That's perfectly fine.

The expectation from me sending out that handwaving strawman was
to help encouraging others to present their ideas, with
justifications.  And having something to compare against, even
if it is just a handwaving strawman, is often much easier when
presenting your ideas and showing which part of your design is
important.  You can say something like "the strawman fails in
this scenario, which is important in real life for such and such
reasons, and my design handles it this way" -- and everybody
can discuss if it is an important design consideration, and what
the best design to solve that problem if it is.

So don't take that strawman, especially the details in it, too
seriously, but take it as what it was: a firestarter.
