From: Bill Lear <rael@zopyra.com>
Subject: Re: Dangers of working on a tracking branch
Date: Thu, 15 Feb 2007 15:53:01 -0600
Message-ID: <17876.54845.708466.669437@lisa.zopyra.com>
References: <17876.51013.561979.431717@lisa.zopyra.com>
	<Pine.LNX.4.64.0702151557410.1757@xanadu.home>
	<17876.52962.662946.582507@lisa.zopyra.com>
	<17876.53654.426022.454712@lisa.zopyra.com>
	<20070215214352.GA2980@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 22:53:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHoXQ-00064D-1s
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 22:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbXBOVxH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 16:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbXBOVxH
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 16:53:07 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60482 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793AbXBOVxG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 16:53:06 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1FLr2M15638;
	Thu, 15 Feb 2007 15:53:02 -0600
In-Reply-To: <20070215214352.GA2980@coredump.intra.peff.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39853>

On Thursday, February 15, 2007 at 16:43:52 (-0500) Jeff King writes:
>On Thu, Feb 15, 2007 at 03:21:38PM -0600, Bill Lear wrote:
>
>> Ok, so I break the model, what is the harm in that?  Can I no longer
>> pull from or push to the remote branch?  Do I corrupt something
>> locally?  Does something else break?  I'm trying to formulate an
>> explanation to our users why the 1.5 way is superior and I can't just
>> say "if you do that you break the model".
>
>The commits you make will not actually go onto that tracking branch;
>they will be part of a "detached HEAD" (that is, your HEAD doesn't point
>to _any_ branch). Once you check out a different branch, you will
>potentially lose those commits (actually, they will still be available
>through your reflog, but you will have to know to look for them there).

Is this really the way 1.4.4.1 works?  I have (mistakenly) been
working on my tracking branch, committing to it, pushing it, pulling
in from elsewhere, shifting to new branches, etc., and I haven't lost
anything, and can't see what harm I've done...

>> BTW, again, why does git clone not have an option to just create all
>> of the "working versions" (better name needed) of tracking branches?
>
>I don't recall anybody asking for it, yet. I think the idea is that
>those branches would just be clutter. If you want to work on something,
>it's easy enough to just start a local version of the branch:
>
>  git checkout -b topic origin/topic

Sure, it is easy, but it's surprising to (our) users when they
do a clone and can't "jump right in", and have to spend 3 seconds
doing the above...


Bill
