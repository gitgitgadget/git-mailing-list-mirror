From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-pull and tag objects
Date: Sun, 11 Feb 2007 11:21:25 -0800
Message-ID: <7vejowec0a.fsf@assigned-by-dhcp.cox.net>
References: <1170933407.15431.38.camel@okra.transitives.com>
	<81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
	<7v4ppurka1.fsf@assigned-by-dhcp.cox.net>
	<20070210142322.GB25607@thunk.org>
	<Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
	<7vy7n5gs0y.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702110948120.8424@woody.linux-foundation.org>
	<7vire8ec6w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Alex Riesen <raa.lkml@gmail.com>,
	Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 11 20:21:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGKGo-0006BR-A4
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 20:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbXBKTV1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 14:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbXBKTV1
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 14:21:27 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:36250 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074AbXBKTV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 14:21:26 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070211192126.WYTZ21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Feb 2007 14:21:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NKMR1W00W1kojtg0000000; Sun, 11 Feb 2007 14:21:26 -0500
In-Reply-To: <7vire8ec6w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 11 Feb 2007 11:17:27 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39303>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> So I think it's ok. 
>
> Well, what you are saying is that it used to be Ok in Jul 5 2005
> version but with tag following it is not Ok anymore, isn't it?

Oops. I misread my own code.

You are right.  We filter and refetch only the ones we do not
have, so we are Ok.

Sorry for the noise.
