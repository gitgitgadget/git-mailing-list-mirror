From: Theodore Tso <tytso@mit.edu>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 17:39:29 -0500
Message-ID: <20070227223929.GA9027@thunk.org>
References: <E1HM1XL-00071C-N5@candygram.thunk.org> <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070227154241.GA8228@thunk.org> <Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 23:39:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMAyx-00025v-Vm
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 23:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbXB0Wjh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 17:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbXB0Wjh
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 17:39:37 -0500
Received: from thunk.org ([69.25.196.29]:41003 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbXB0Wjh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 17:39:37 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HMB4M-0003al-8R; Tue, 27 Feb 2007 17:45:14 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HMAyn-0002vx-VC; Tue, 27 Feb 2007 17:39:29 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40831>

On Tue, Feb 27, 2007 at 08:55:41PM +0100, Johannes Schindelin wrote:
> Since you seem to be no old-timer who cannot remember how she learnt about 
> certain Git concepts: What documentation did you read, an in which order? 
> This might help us making the parts likely to be seen by new users 
> better...

I started using Everyday git, and the git(7) man page, and the
tutorials.  I tried using some of the git manpages, but many of them
were so inpenetrable that I would just skip over that bit and hope the
rest of the man page would make sense or would just try searching
somewhere for the information.  To be honest, some of the best
documentation was Linus's email messages on the git mailing list,
especially the ones about git philosophy and examples about how to do
things.

For example, the man page of git-rev-parse will give you a very dry
description of ".." and "...", but absolutely no examples of when you
would you might use one or the other.  The only place where I learned
about this was from some of Linus's e-mail messages, and even then I'm
still a little shaky on when you might use '...'.   

And I'm still not sure why

	git show v1.5.0..v1.5.0.1 

doesn't throw an error, and why it prints what it does...

> > As a suggestion, maybe we should be moving (or at least copying) things 
> > like the <object> identifier syntax from the git-rev-parse manpage 
> > (which is plumbing, right?) to the top-level git manpage?
> 
> My vote is for moving, and referencing (kind of mv && ln -s).
> 
> But that means that you have to explain in a really concise way that Git 
> repositories contain blob, tree, commit and tag objects. And what they 
> are.

Well, git(7) already has an extraordinary verbose description of glob,
tree, commit, and tag options, so if we move the object id syntax to
git(7) that wouldn't be a problem.  :-)

						- Ted
