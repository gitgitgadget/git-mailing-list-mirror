From: Jeff King <peff@peff.net>
Subject: Re: git-gc doesn't clean up leftover objects after
	git-filter-branch unless you clone first
Date: Thu, 24 Apr 2008 12:14:07 -0400
Message-ID: <20080424161407.GA23737@sigill.intra.peff.net>
References: <32541b130804230841h32c07f3arc94cccfaf0b156a3@mail.gmail.com> <7vve28sdys.fsf@gitster.siamese.dyndns.org> <20080423221316.GE30057@sigill.intra.peff.net> <20080424012836.GA30812@sigill.intra.peff.net> <32541b130804240843k471ecfeteb1008c44a56808b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 18:15:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jp46G-0006cM-Fa
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 18:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756973AbYDXQOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 12:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754375AbYDXQOL
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 12:14:11 -0400
Received: from peff.net ([208.65.91.99]:2904 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753516AbYDXQOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 12:14:09 -0400
Received: (qmail 11641 invoked by uid 111); 24 Apr 2008 16:14:08 -0000
Received: from lawn-128-61-26-53.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.26.53)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 24 Apr 2008 12:14:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Apr 2008 12:14:07 -0400
Content-Disposition: inline
In-Reply-To: <32541b130804240843k471ecfeteb1008c44a56808b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80308>

On Thu, Apr 24, 2008 at 11:43:55AM -0400, Avery Pennarun wrote:

> >  +If you are expecting some objects to be collected and it isn't, check
> >  +all of those locations and decide whether it makes sense in your case to
> >  +remove those references.
> >  +
> 
> This information would have helped me quite a bit when I first
> encountered this problem.  It would be nice if it also showed up under
> git-prune (since git-gc doesn't delete anything itself, if I

Hmm, maybe it would make sense to put that note in git-prune, with a
note in git-gc to look at the prune page.

> understand correctly).  Also a link to some information about reflogs
> (even just to "see also" git-reflog) would help, since I didn't hear
> about reflogs at all until after I joined the mailing list.

$ grep -A6 See.Also Documentation/git-gc.txt
See Also
--------
linkgit:git-prune[1]
linkgit:git-reflog[1]
linkgit:git-repack[1]
linkgit:git-rerere[1]

But if the note were moved to git-prune, it would be natural to mention
git-reflog there. What do you think?

-Peff
