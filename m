From: Junio C Hamano <junkio@cox.net>
Subject: Re: Making git disappear when talking about my code
Date: Wed, 25 Apr 2007 12:17:30 -0700
Message-ID: <7vfy6oxnzp.fsf@assigned-by-dhcp.cox.net>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	<200704171818.28256.andyparkins@gmail.com>
	<20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl>
	<Pine.LNX.4.64.0704181130150.12094@racer.site>
	<alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704191118050.8822@racer.site>
	<alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
	<4627ABBB.8060709@softax.com.pl>
	<alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org>
	<877is29b1l.wl%cworth@cworth.org>
	<7vps5ud91x.fsf@assigned-by-dhcp.cox.net>
	<87vefm7l6g.wl%cworth@cworth.org>
	<alpine.LFD.0.98.0704231609440.9964@woody.linux-foundation.org>
	<7v1wiabbfr.fsf@assigned-by-dhcp.cox.net>
	<87mz0w7g3j.wl%cworth@cworth.org> <87k5w07dft.wl%cworth@cworth.org>
	<alpine.LFD.0.98.0704250751330.9964@woody.linux-foundation.org>
	<87fy6o770w.wl%cworth@cworth.org>
	<alpine.LFD.0.98.0704251341280.12375@xanadu.home>
	<878xcg6zv0.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 21:17:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgmzl-00048J-Fg
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 21:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992977AbXDYTRe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 15:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992973AbXDYTRe
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 15:17:34 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:40266 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992971AbXDYTRc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 15:17:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070425191732.JGNS1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 25 Apr 2007 15:17:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id rXHX1W0011kojtg0000000; Wed, 25 Apr 2007 15:17:31 -0400
In-Reply-To: <878xcg6zv0.wl%cworth@cworth.org> (Carl Worth's message of "Wed,
	25 Apr 2007 12:03:15 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45546>

Carl Worth <cworth@cworth.org> writes:

> It's more that I want a single way to talk about some branch I've just
> published, (necessarily both a url and a branch), and I assume an
> audience with a wide range of git experience, (from none to lots).

Why would you want to add another syntax that can talk about
only one branch?  It shows that you care only about talking
about single branch, making things harder for other people who
might want to talk about two branches or more.

I would agree with you that if you are talking to total git
newbie, you cannot get away with message like [3] in your
original and you would need some instructions you added in your
example [2].  But I suspect that is true for any new system.  If
somebody has never seen cvs and your project is hosted at cvs,
and if you want to be really helpful, I think you have to tell
"cvs -d :pserver:... co cworth-project" somewhere in your
message.

But that does not have to be in the main part of the
announcement, like this (this is your [2]):

    I've just written some very fancy feature for our cool project
    which you can see in gitweb at <gitweburl>. To track this
    branch, do "git remote add cworth <url>; git checkout --track
    -b <branch> cworth/<branch>" if you already have some clone of
    our project. Otherwise do "git clone <url>; git checkout
    --track -b <branch>". Please try it out and give me feedback.

You can say instead:

    I've just written some very fancy feature for our cool project
    which is available in the <branch> branch at <url>. Please try
    it out and give me feedback. [*1*]

    [Footnote]

    *1* If you have never used git, here are the ways to get at
        the cool project ...

	 <<< instruction here >>>

	If you have been tracking the upstream of the cool
	project, alternatively you can do this to get to my
	fancy feature as a new branch in your repository ...

	 <<< instruction here >>>
