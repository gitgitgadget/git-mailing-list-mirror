From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Question on GIT usage.
Date: Mon, 31 Oct 2005 18:56:43 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0510311847570.25300@iabervon.org>
References: <4362C700.6020901@candelatech.com> <Pine.LNX.4.64.0510311749080.25300@iabervon.org>
 <Pine.LNX.4.64.0510311520190.27915@g5.osdl.org> <Pine.LNX.4.64.0510311821410.25300@iabervon.org>
 <Pine.LNX.4.64.0510311540300.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ben Greear <greearb@candelatech.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 00:58:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWjWW-00033o-BD
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 00:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbVJaX5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 18:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbVJaX5F
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 18:57:05 -0500
Received: from iabervon.org ([66.92.72.58]:53265 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964899AbVJaX5E (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 18:57:04 -0500
Received: (qmail 23539 invoked by uid 1000); 31 Oct 2005 18:56:43 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Oct 2005 18:56:43 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510311540300.27915@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10903>

On Mon, 31 Oct 2005, Linus Torvalds wrote:

> On Mon, 31 Oct 2005, Daniel Barkalow wrote:
> > 
> > Oh, that reminds me: is there a simple way to merge a branch with another 
> > local branch or remote branch that's already up-to-date? E.g., I've 
> > already fetched the latest git from kernel.org, built it, and installed 
> > it. Now I want to merge my development branch with that. Last time I was 
> > looking, I had to write the message for the merge myself, unlike "pull", 
> > which takes care of that.
> 
> Umm.. Why don't you just use "pull"?
> 
> I _think_ you should be able to just do
> 
> 	git pull <repodir> <branchname>
> 
> where <repodir> can even be just "." for the very same repository.
> 
> I've not tested it, but dammit, it should work. If it doesn't, it's a bug.

That does follow logically, but it really ought to be an example in the 
documentation, because "fetch what you have from yourself and merge it" 
isn't the first thing that comes to mind for me. :)

I'll make sure that works and comes out nicely, and then send in a 
Documentation patch.

	-Daniel
*This .sig left intentionally blank*
