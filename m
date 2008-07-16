From: Theodore Tso <tytso@mit.edu>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 16:13:33 -0400
Message-ID: <20080716201333.GI2167@mit.edu>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com> <alpine.DEB.1.00.0807161902400.8986@racer> <32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 22:14:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDOW-0001sD-3t
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbYGPUNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbYGPUNh
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:13:37 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:39006 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752116AbYGPUNg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:13:36 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KJDNW-0004yt-9R; Wed, 16 Jul 2008 16:13:34 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KJDNV-0003pj-Ki; Wed, 16 Jul 2008 16:13:33 -0400
Content-Disposition: inline
In-Reply-To: <32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88741>

On Wed, Jul 16, 2008 at 02:35:16PM -0400, Avery Pennarun wrote:
> In svn, a branch is a revision-controlled directory.  In git, a branch
> is a "ref".  What's a ref?  Well, it's a name for a commit.  What's a
> commit?  Well, it's a blob.  What's a blob?  Err, that's complicated.
> What happens when I delete a branch?  Well, it's still in the reflog.
> What's the reflog?  Well, it's the local revision history of each
> branch.  Local?  Why not shared?  In svn, the revision history of each
> branch is shared, but in git, you don't need to, because...
> 
> Even git branches are surprisingly concept heavy, unless your users
> ask a lot fewer questions than mine.  The really critical question is
> why it's so easy to delete a branch in git, and that leads rapidly
> into the commit-tree stuff, which is always a spiral into plumbing as
> you try to explain the tree of commits.

I don't think you need to go into the plumbing to explain the commit
tree.  What I normally do is tell people that branches point at
commits, and that commits are identified by commit ID's, which can be
full SHA-1 hashes, or which can be abbreviated for convenience's sake.
It's not strictly necessary to tell them about the commit-tree
plumbing command; just that each commit creates a snapshot, and that
commits can have one or more parents, plus the commit mesage, plus the
snapshot.

I do absolutely agree with Johannes' assertion that you don't have to
explain commit-tree, git-rev-list, and all the rest.  The only reason
why users will need to see git-rev-list is because git-log references
it so prominently, and some of the more powerful git-log options are
only documented in git-rev-list.

							- Ted
