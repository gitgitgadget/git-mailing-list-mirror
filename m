From: Theodore Tso <tytso@mit.edu>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 09:57:15 -0500
Message-ID: <20090219145715.GC14810@mini-me.lan>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com> <A3E3A7A0-F03F-4C8B-B3F8-756B0E89798C@wincent.com> <43d8ce650902190155m4de23643r8a9d3c35686ea4e9@mail.gmail.com> <2A7CAA9F-DB42-4782-BF61-41E8DA577DF2@wincent.com> <20090219101154.GB16119@coredump.intra.peff.net> <6887C6DB-E9C8-4DC8-BD1E-C20E92271FA5@wincent.com> <20090219102053.GA17417@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 19 16:46:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaB6O-0001qL-Ay
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 16:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbZBSPor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 10:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752894AbZBSPor
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 10:44:47 -0500
Received: from THUNK.ORG ([69.25.196.29]:53502 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752102AbZBSPoq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 10:44:46 -0500
Received: from tytso authenticated as tytso by thunker.thunk.org with local   (Exim 4.50 #1 (Debian))
	id 1LaB4r-0002CF-UP; Thu, 19 Feb 2009 10:44:42 -0500
Content-Disposition: inline
In-Reply-To: <20090219102053.GA17417@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110710>

On Thu, Feb 19, 2009 at 05:20:53AM -0500, Jeff King wrote:
> > Yes, I do the same. But notice that you did "git rebase -i -- 
> > >>>origin<<<---". Seems to me you are definitely _thinking_ in terms of 
> > your topic _branch_ and not in terms of "the last few commits".
> 
> Perhaps. I think of it as "the set of commits not yet published"
> (since I publish only by sending patches to Junio, and he is my origin)
> and nothing to do with the topic branch itself.

Indeed, I bet most people who use this workflow think of git rebase -i
origin or "git rebase -i HEAD^^^^" (where I normally figure out how
many commits I need to go back and type the right number of carets) as
a magic command that does what we want, without necessarily thinking
about why it works the way that it does.

I can guarantee that most of the time I don't think "hmm, so I'm going
to be rebasing my topic branch onto origin so I can make some
changes."  Nope, it's, "I'm going to futz with the commits to get them
just right".

   	     	 	    	     - Ted
