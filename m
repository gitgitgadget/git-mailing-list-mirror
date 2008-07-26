From: Petr Baudis <pasky@suse.cz>
Subject: Re: Official Git Homepage change? Re: git-scm.com
Date: Sat, 26 Jul 2008 16:17:47 +0200
Message-ID: <20080726141747.GS10151@machine.or.cz>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com> <20080726015314.GU32184@machine.or.cz> <d411cc4a0807260007i26791084lce6b6a8d74b831cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 16:18:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMkbh-0002ax-V1
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 16:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbYGZORu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 10:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbYGZORu
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 10:17:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50715 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896AbYGZORt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 10:17:49 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4CDE93939B56; Sat, 26 Jul 2008 16:17:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <d411cc4a0807260007i26791084lce6b6a8d74b831cc@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90226>

  Hi,

On Sat, Jul 26, 2008 at 12:07:03AM -0700, Scott Chacon wrote:
> On Fri, Jul 25, 2008 at 6:53 PM, Petr Baudis <pasky@suse.cz> wrote:
> >  Plenty of minor fixes are available for pull at
> >
> >        git://github.com/pasky/learn-github.git
> >        (http://github.com/pasky/learn-github/tree/master)
> 
> I've pulled in all this stuff and it should be live now.

  thanks.

> >
> >  Other non-trivial nits:
> >
> >  * I'm feeling a bit uneasy about listing so many projects using Git;
> > I haven't heard about quite a few of these and I'm not sure on what
> > merit should we list projects. "Prototype" or "Liftweb" and probably
> > even "Rubinius", is that going to ring a bell for major part of visitors
> > so that they say "oh, even _those_ guys are using Git"?
> 
> Based on a conversation in the other thread, I think we should have a
> list that is suggested by the community and just have the 3 or 4 that
> are really famous (Git, Linux, RoR...) and have the rest randomly
> pulled from that list - changed every day or so.

  Maybe it is because of my general background, but I think X.org, WINE
and Fedora (probably in this order) really belong to the list as well.
If you say Prototype and MooTools are huge projects that are very
well-known in the web programmer community too, it makes sense to
include them as well; and that would be it. I might add

	<p align="right"><em>...and many more</em><p>

below the list.

  Having some of the list randomly generated is an interesting idea, but
it should be clearly visually separated from the static part, and it
would probably take a bit of work to tune this to show only interesting
projects ($size * sqrt(activity)$ or something).

> >  * Reusing captions from command manpages in the Documentation page
> > shows nicely how awful they sometimes are. :-) This is probably something
> > to fix upstream, though.
> 
> I saw you changed some of these, I can take another pass.  I'm not
> entirely sure how useful it is to have the commands on that page, to
> tell the truth.  This may go away as the documentation page evolves.

  I agree. I changed none though, I just reordered some of the commands.

> >  * Is "Git for the lazy" really unique in some regard to deserve to be
> > listed among the other resources? I think we should minimalize
> > redundancy at the documentation page, the amount of material is already
> > overwhelming and it should be obvious for the visitor which document to
> > choose based on his needs. I have similar doubts about the 37signals
> > resources.
> >
> >        In other words, "let's keep the resources orthogonal!"
> 
> I agree - I would like to pull a lot of the information in those links
> into one open-source book that is kept up by the community and hosted
> at this page.  The documentation page will change significantly as we
> try to simplify and maximize the usefulness of the page.

  But that's a long-term project, I'm talking about the usefulness of
some of the links right now.

> >  * There is no reference to the Wiki in the documentation, only to the
> > [GitDocumentation] page; I think there should be a reference to the
> > [GitFaq] page too - a lot of important points that are not obvious
> > to newcomers are covered there. I'm just not sure where exactly to put
> > the link.
> >
> >  * I would go as far as put the link to the Wiki itself to the
> > navigation bar, simply since it is such a crucial resource.
> 
> 
> Perhaps I should just do this - would that cover the previous one as well?

  It seems you did, which is great! I think there should be a direct FAQ
link as well, though.

> >  How does that compare with the Git user manual? Have you considered
> > collaborating on that one, or what are your reasons not to? Or are you
> > trying to do something different?
> 
> I would like to - I have personally found that invaluable in learning
> Git, but I would like it to be more digestible and I would like to add
> a lot of supporting media to it - screencasts and diagrams, to help
> people that are more visual learners. Loading up a document where the
> TOC is several pages long is intimidating and difficult to start and
> stop with.

  Making it more digestible is certainly a worthy goal. :-) I think both
screencasts and diagrams could be valuable for the user manual, but
the question is how to best integrate them into the manual and if it
makes sense to do this within the Git tree, or how to cross-merge.
However, at the documentation side I focus pretty much exclusively on
improving the reference documentation, so that's not for me to discuss.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
