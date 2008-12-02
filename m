From: Jason Riedy <jason@acm.org>
Subject: Re: Managing websites with git
Date: Mon, 01 Dec 2008 19:46:35 -0500
Message-ID: <87k5ajflp0.fsf@sparse.dyndns.org>
References: <fe5a74300811300830x850d81csc5cf1f9b367bac11@mail.gmail.com>
	<20081130170722.GJ6572@eratosthenes.sbcglobal.net>
	<20081130172717.GA7047@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Bryson <david@statichacks.org>,
	Felix Andersen <felix@nibbo.se>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 02:28:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7K3R-0007DI-6I
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 02:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbYLBB0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 20:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbYLBB0l
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 20:26:41 -0500
Received: from b.mail.sonic.net ([64.142.19.5]:52190 "EHLO b.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbYLBB0k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 20:26:40 -0500
X-Greylist: delayed 1747 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Dec 2008 20:26:40 EST
Received: from nan.sparse.yi.org (misc-148-78-88-138.pool.starband.net [148.78.88.138])
	(authenticated bits=0)
	by b.mail.sonic.net (8.13.8.Beta0-Sonic/8.13.7) with ESMTP id mB20v6bD025462;
	Mon, 1 Dec 2008 16:57:12 -0800
In-Reply-To: <20081130172717.GA7047@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 30 Nov 2008 12:27:17 -0500")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102088>

And David Bryson writes:
> One really should not push to a non-bare repo.

WHAT?!?!?!

And Jeff King responds:
> It's in master and should be in 1.6.1, but it is a config option that
> defaults to "warn" for now, so as not to break existing setups.

WHAT?!?!?!

I do this all the time.  I clone from my main working directory
onto some cluster / MPP where the build system is all wonky.
Once I get everything building, I push back to a branch (often
new) in my main working directory.  Then I can merge the build
changes whenever I get a chance.

Pushing from these systems often is much, much easier than
pulling from the origin.  Sometimes you're working in temporary
space on a back-end node; you can connect out but you cannot
connect in.

I've gotten a few people interested in git for managing these
nearly one-off build problems.  git is the first system that has
"just worked" for them.  Their having to configure each repo
eliminates the "just works" factor.

It feels like newer gits make more and more decisions about what
I shouldn't do.

Jason
