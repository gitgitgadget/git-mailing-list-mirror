From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git Community Book
Date: Tue, 29 Jul 2008 18:34:31 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0807291716460.19665@iabervon.org>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 00:36:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNxnW-0004XJ-1a
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 00:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760241AbYG2Wee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 18:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760227AbYG2Wed
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 18:34:33 -0400
Received: from iabervon.org ([66.92.72.58]:38354 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760208AbYG2Wec (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 18:34:32 -0400
Received: (qmail 25548 invoked by uid 1000); 29 Jul 2008 22:34:31 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Jul 2008 22:34:31 -0000
In-Reply-To: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90696>

On Tue, 29 Jul 2008, Scott Chacon wrote:

> So I wanted to develop a really nice, easy to follow book for Git
> newcomers to learn git quickly and easily.  One of the issues I
> remember having when learning Git is that there is a lot of great
> material in the User Guide, Tutorial, Tutorial 2, Everyday Git, etc -
> but they're all huge long documents that are sometimes difficult to
> come back to and remember where you were, and I didn't know which one
> to start with or where to find what I was looking for, etc.

It would be good to include stuff from 
http://eagain.net/articles/git-for-computer-scientists/

Maybe only in inspiration, since it doesn't have an obvious license and 
it's stylisticly more technical. But it would be nice to have diagrams of 
"this is what git thinks of as history", possibly even arranging them like 
gitk shows things (older downward, refs pointing in from the side).

In particular, I think it's really useful to show a commit graph with 
branching and merging, and introduce refs as movable pointers to commits 
in the graph, and local branches as refs that you move and tracking refs 
as refs that copy values in other repositories.

I think you can even gloss of details of blobs and trees because they 
pretty much work just like files and directories in a filesystem (except 
that they take up much less storage in large quantities than you'd think). 
The only potentially interesting things are (1) a blob names the inode, 
not the dentry, so it's the file contents, not the name, mode, etc; and 
(2) the permission bits are just 'x', we've got symlinks, there are no 
owner/group or other attributes and "see also Submodules".

But I think that the section:
  http://eagain.net/articles/git-for-computer-scientists/#history
should have an equivalent in any git documentation that can have diagrams, 
and introducing a history diagram style early means that you can do a 
bunch of simple pictures to explain operations like "git checkout -b foo" 
or "git reset --hard HEAD^^" or "git checkout origin/master".

	-Daniel
*This .sig left intentionally blank*
