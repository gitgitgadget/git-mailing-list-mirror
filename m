From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 17:45:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704181657190.27922@iabervon.org>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> 
 <20070417104520.GB4946@moonlight.home>  <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
  <200704171818.28256.andyparkins@gmail.com>  <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl>  <Pine.LNX.4.64.0704181130150.12094@racer.site>
  <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <8b65902a0704181308i41c878ebi88c03a929769ba39@mail.gmail.com>
 <alpine.LFD.0.98.0704181312060.2828@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 23:45:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeHyD-0003Oj-GT
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 23:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898AbXDRVpj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 17:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753983AbXDRVpj
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 17:45:39 -0400
Received: from iabervon.org ([66.92.72.58]:4689 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753979AbXDRVpi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 17:45:38 -0400
Received: (qmail 30974 invoked by uid 1000); 18 Apr 2007 21:45:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Apr 2007 21:45:37 -0000
In-Reply-To: <alpine.LFD.0.98.0704181312060.2828@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44954>

On Wed, 18 Apr 2007, Linus Torvalds wrote:

> On Wed, 18 Apr 2007, Guilhem Bonnefille wrote:
> > 
> > Yes, but I think that, as Git has ton more capabilities, user has to
> > understand more things than with CVS.
> 
> I do agree.
> 
> The whole "branch" thing is something you can ignore in CVS, but it's 
> simply very hard to ignore in git, because even *if* you just follow 
> another repository, git kind of forces you to be aware of the difference 
> between "local branch" and "remote tracking branch".
> 
> I think that's fairly fundamental to being distributed, though. 

I actually disagree here. CVS users are obviously familiar with "how far 
have I updated from the server". With CVS the "local branch" and "remote 
tracking branch" are qualitatively different, and with git they're 
qualitatively the same, but the user doesn't have to care. Particularly 
with the new refs layout, it's pretty easy to ignore, as long as the 
upstream repository isn't using branches for anything this particular user 
cares about.

You can just tell people, "Before you merge upstream changes, you have to 
commit, so that if the merge gets screwed up you don't lose your work." 
And they say, "Oh. That's useful." And they don't need to know the 
technical reasons this is both possible and necessary.

(Of course, branches are really helpful once you have a need for them, but 
there's no reason to learn about them before that point.)

	-Daniel
*This .sig left intentionally blank*
