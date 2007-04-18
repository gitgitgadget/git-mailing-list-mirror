From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 18:15:22 -0700
Message-ID: <7vejmilbyt.fsf@assigned-by-dhcp.cox.net>
References: <200704171041.46176.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org>
	<46250175.4020300@dawes.za.net>
	<Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org>
	<20070417235649.GE31488@curie-int.orbis-terrarum.net>
	<7vps62lfbw.fsf@assigned-by-dhcp.cox.net>
	<20070418010637.GF31488@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Rogan Dawes <lists@dawes.za.net>,
	Andy Parkins <andyparkins@gmail.com>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 03:15:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdylq-0003Z7-Oi
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 03:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbXDRBPY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 21:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753423AbXDRBPY
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 21:15:24 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:36618 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbXDRBPY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 21:15:24 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418011524.OKFF1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Apr 2007 21:15:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id oRFM1W00e1kojtg0000000; Tue, 17 Apr 2007 21:15:23 -0400
In-Reply-To: <20070418010637.GF31488@curie-int.orbis-terrarum.net> (Robin
	H. Johnson's message of "Tue, 17 Apr 2007 18:06:37 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44848>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> Glancing at the Gentoo bugs I've dealt with over the last 2 months as a
> quick survey, there are a few levels: 
> A - Able to submit a good diff
> B - Able to do a good implementation
> C - Able to come up with a good idea for improvement
>
> B are in short supply, and even of those, the number that can do A are
> smaller :-(. Category C is vastly bigger than B, and those that don't
> make B throw up a lot of chaff of bad implementations.
>
> Being able to extract the good ideas is what's important.

True, to a certain degree.  Maybe you and your fellow Gentoo
people are very much more accomodating, but my fear is that a
maintainer that goes length to sift through chaff himself
quickly runs out of time, becomes exhausted, and ends up being
careless.

Maybe I am spoiled by having only the best people around me, and
on git list.

But we are straying to a tangent.

I do not have much against an optional "only blob id" expansion
myself, as I do not see any more downside than CRLF expansion in
it.  But I suspect that once people see the $id$ expanded to
blob, they would not stop, because simply they do not understand
why blob-id and CRLF are much less evil than other things.
