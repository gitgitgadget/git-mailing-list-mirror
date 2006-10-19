From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 13:14:09 -0400
Message-ID: <20061019171409.GA31671@fieldses.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org> <453792A8.1010700@utoronto.ca> <8764eg2qaa.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 19:15:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GabUB-0000qe-Qt
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 19:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946253AbWJSRO1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 13:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946256AbWJSRO0
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 13:14:26 -0400
Received: from mail.fieldses.org ([66.93.2.214]:43659 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1946253AbWJSROZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 13:14:25 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1GabT7-0001Uc-Kt; Thu, 19 Oct 2006 13:14:09 -0400
To: Carl Worth <cworth@cworth.org>
Content-Disposition: inline
In-Reply-To: <8764eg2qaa.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29375>

On Thu, Oct 19, 2006 at 10:01:33AM -0700, Carl Worth wrote:
> On Thu, 19 Oct 2006 10:58:48 -0400, Aaron Bentley wrote:
> > On the other hand, I think your revision identifiers are not as
> > permanent as you think.
> >
> > In the first place, it seems fairly common in the Git community to
> > rebase.  This process throws away old revisions and creates new
> > revisions that are morally equivalent[1].
> 
> Yes, rebasing does "destroy history" in one sense, (in actual fact, it
> creates new commits and leaves the old ones around, which may or may
> not have references to them anymore).

Note that the id's are still permanent in this case; they will never
(module some assumptions about the crypto) be reused.  So a given id
points at one and only one object, for all time; it's just that we may
forget what that one object is....

> > In the second place, one must consider the "nuclear launch codes"
> > scenario.
> 
> Sure. And git does provide tools that can do this.

So in this case you can certainly lose the launch codes.  But you have
forever granted everyone a way to determine whether a given guess at the
launch codes is correct.  (Again, assuming some stuff about SHA1).

--b.
