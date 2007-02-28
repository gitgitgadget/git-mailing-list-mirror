From: Junio C Hamano <junkio@cox.net>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 16:31:47 -0800
Message-ID: <7vejob9l70.fsf@assigned-by-dhcp.cox.net>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
	<Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070227154241.GA8228@thunk.org>
	<Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070227223929.GA9027@thunk.org> <86vehnnpy2.fsf@blue.stonehenge.com>
	<7vfy8rb2do.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702271605290.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 01:31:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMCjX-0002PI-QH
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 01:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbXB1Abt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 19:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbXB1Abt
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 19:31:49 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:54502 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbXB1Abs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 19:31:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070228003147.RZTF2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 19:31:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UoXn1W00K1kojtg0000000; Tue, 27 Feb 2007 19:31:48 -0500
In-Reply-To: <Pine.LNX.4.64.0702271605290.12485@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 27 Feb 2007 16:22:52 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40862>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>> > OK, how is that different from git-diff ?
>> 
>> I do not think there is any difference.  "show" is about
>> multiple points, not ranges.  "diff" is about multiple
>> (typically two) points, and not ranges.
>
> Well, I do think Ted has a good point. Having negative refs makes no sense 
> for the "no-walk" case (aka "git show").
>
> ... Negative object refs really don't make any sense unless you walk 
> the object list (or you're "git diff" and know about ranges explicitly).

If you did not say "(or you're..." part, then I would agree
to this 100%.

On the other hand, as you earlier said:

    On Fri, 22 Dec 2006,...
    > 
    > I can understand the advantage of a shortcut like "git diff ..next",
    > ...

    I can't understand why people complain about this.

    YOU DON'T HAVE TO USE IT. 
    ...
    > But, really, I still don't understand exactly _what_ "diff a..b" even
    > means. Can you explain it to me?

    It means exactly the same as "diff a b".

    It's that simple.

which made me lol, I am very tempted to say:

	It means exactly the same as "show a b".

        It's that simple.

Back to serious my self, I am wondering if this is a sensible
thing to ask:

	$ git show master...maint

which your patch now forbids.
