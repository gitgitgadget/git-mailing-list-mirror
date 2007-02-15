From: Bill Lear <rael@zopyra.com>
Subject: Re: Dangers of working on a tracking branch
Date: Thu, 15 Feb 2007 16:04:38 -0600
Message-ID: <17876.55542.236594.121347@lisa.zopyra.com>
References: <17876.51013.561979.431717@lisa.zopyra.com>
	<Pine.LNX.4.64.0702151557410.1757@xanadu.home>
	<17876.52962.662946.582507@lisa.zopyra.com>
	<17876.53654.426022.454712@lisa.zopyra.com>
	<20070215214352.GA2980@coredump.intra.peff.net>
	<17876.54845.708466.669437@lisa.zopyra.com>
	<20070215215816.GA3757@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 23:04:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHoic-00033Z-3f
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 23:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932843AbXBOWEm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 17:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932845AbXBOWEm
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 17:04:42 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60524 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932843AbXBOWEl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 17:04:41 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1FM4cJ15822;
	Thu, 15 Feb 2007 16:04:38 -0600
In-Reply-To: <20070215215816.GA3757@coredump.intra.peff.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39855>

On Thursday, February 15, 2007 at 16:58:16 (-0500) Jeff King writes:
>On Thu, Feb 15, 2007 at 03:53:01PM -0600, Bill Lear wrote:
>
>> Is this really the way 1.4.4.1 works?  I have (mistakenly) been
>> working on my tracking branch, committing to it, pushing it, pulling
>> in from elsewhere, shifting to new branches, etc., and I haven't lost
>> anything, and can't see what harm I've done...
>
>Sorry, I thought you were talking about v1.5. v1.4.* does not have the
>detached HEAD feature, and the default layout is to keep tracking and
>local branches in the same namespace. This means that you can checkout
>and commit to a tracking branch just as a local branch, and all changes
>will be saved. It will only bite you later, when you try to fetch into
>that tracking branch and realize that the fetch is not a fast-forward
>(remember the troubles you were having with fetches and pushes last
>week? Those were caused by working on the tracking branches).

Ok, just wanted confirmation of my (in)sanity.

>> >  git checkout -b topic origin/topic
>> 
>> Sure, it is easy, but it's surprising to (our) users when they
>> do a clone and can't "jump right in", and have to spend 3 seconds
>> doing the above...
>
>Fair enough. It should be pretty simple to implement; why don't you try
>working up a patch? :)

Well, I seriously thought about it, but the git-clone code is pretty
dense.  It might be educational though, and since I'm the only one
who wants it ... might be worth a shot.

Thank you for your help.


Bill
