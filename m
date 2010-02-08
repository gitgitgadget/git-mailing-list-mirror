From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: A Visual Git Reference
Date: Mon, 8 Feb 2010 16:57:12 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1002081513430.14365@iabervon.org>
References: <ca433831002081134m698f531bwa22f0474db0cdcb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 22:57:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nebba-0000ZZ-Kj
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 22:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267Ab0BHV5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 16:57:14 -0500
Received: from iabervon.org ([66.92.72.58]:60153 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124Ab0BHV5N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 16:57:13 -0500
Received: (qmail 6741 invoked by uid 1000); 8 Feb 2010 21:57:12 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Feb 2010 21:57:12 -0000
In-Reply-To: <ca433831002081134m698f531bwa22f0474db0cdcb@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139324>

On Mon, 8 Feb 2010, Mark Lodato wrote:

> All,
> 
> I put together a "Visual Git Reference" containing visualizations of
> the most common git commands, for people who prefer to see images over
> text.  It is designed as a reference, not a tutorial, so readers need
> to have some amount of experience before the page will become useful.
> 
> URL: http://marklodato.github.com/visual-git-guide/
> Git repo: http://github.com/marklodato/visual-git-guide/
> 
> If you have any feedback or suggestions, please let me know!

The "3-way merge" node should graphically distinguish the base from the 
two sides, rather than having all three just go in. The "3-way merge" 
operation is tricky to understand visually without some sort of "split and 
rejoin, with specific points" thing.

Also, it would probably be worth showing the use of the index in the 
process of a 3-way merge: all three versions go into the blue box, and a 
combination (with conflict markers) goes into the pink box; the user 
cleans up the pink box, and replaces the 3-part blue box content with the 
cleaned-up single result content; then the commit gives the diagram you 
have for "git merge other".

I think you should introduce the detached HEAD situation early; right 
after "git checkout HEAD~ files", it would be worth showing "git checkout 
HEAD~". It's pretty common for people in the "technical user" part of the 
kernel community to use git to browse history and test different commits, 
and never do a commit at all. This is a pretty common mode across many 
version control systems (e.g., "cvs checkout -D yesterday"), and nothing 
unexpected happens if you don't try to commit while doing it. In fact, you 
could show tracking down a bug introduced between maint and master by 
checking out c10b9 and then da985.

Then, later, you can bring up the fact that you can actually do commits in 
that situation, and show how that works. That part is the part that's 
novel and could potentially lead to people doing work and having it become 
unreachable. Also, after commiting with a detached HEAD, the normal next 
step is to create a new branch ("git checkout -b new-topic").

	-Daniel
*This .sig left intentionally blank*
