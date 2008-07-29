From: Petr Baudis <pasky@suse.cz>
Subject: Re: Git Community Book
Date: Tue, 29 Jul 2008 19:09:55 +0200
Message-ID: <20080729170955.GK32184@machine.or.cz>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 19:11:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNsiy-0004Ky-3H
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 19:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbYG2RJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 13:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbYG2RJ6
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 13:09:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58933 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbYG2RJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 13:09:57 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4543C2C4C027; Tue, 29 Jul 2008 19:09:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90658>

On Tue, Jul 29, 2008 at 09:20:20AM -0700, Scott Chacon wrote:
> So, what I've started to do is pull material from all of them into a
> single book which will be available in online HTML (one page per
> chapter) and downloadable PDF form.  I'm trying to give it a very
> organized flow that will hopefully be a bit easier to follow and
> digest than the current formats, and including a number of diagrams,
> illustrations and screencasts to supplement the text.  Where possible,
> I am also trying to simplify the explanations a bit to be a tad more
> digestible for beginning users, at least in the first couple dozen
> chapters. I have put the current html output of this book here:
> 
> http://book.git-scm.com

I think what most of the people here would be also interested in is

	http://github.com/schacon/learn-github/wikis/how-to-contribute

There is no license in the source code - what are the copying terms?

It is maybe somewhat unfortunate that this is in a different format that
the standard git choice asciidoc, but the formats do look rather similar
so I assume it should not be hard to even convert from one to another if
needed.

Unfortunately, I probably won't have enough time to review the content
in details anytime soon, so I can only say that that the site looks
pretty. :-) I have skimmed through the Introduction part only, but
frankly, my feelings are somewhat mixed; I think the "direct dive-in"
you take in the Database and Index section is controversial at best, and
I personally much prefer the gentle approach of user manual, which does
not hurl details on git's objects model on the user right away. To me,
it would make sense to move this all somewhere between chapter four and
five. (Incidentally, only after writing this, I have looked at the
actual structure of the User Manual and I think it makes more sense than
your approach.)

So my confusion still is - where does this stand wrt. the user manual?
Why didn't you just start with the manual and work on that? I thought
you were planning to do that, but apparently we misunderstood each other
in the last mails.

Which goals are different between the Git Community Book and the User
Manual? It seems to me that the intent is the same in both cases, and if
the User Manual is not sufficiently digestible and easy to understand
for a newcomer, wouldn't it make more sense to make it so?

The thought of yet another Git resource _in addition_ to the existing
ones just makes me nervous. This isn't only about your time that I feel
is being spent unnecessarily ineffectively by not building upon the
existing text, but also about the _community_ resources - the user
manual has a great benefit that it was actually reviewed by the mailing
list so it will probably have quite smaller error rate than anything
you or me would write on our own, no matter how big Git expert you are.

I'm not saying you don't have good reasons to make the choice you did,
I just don't understand them yet - please help me here.

> So I wanted to develop a really nice, easy to follow book for Git
> newcomers to learn git quickly and easily.  One of the issues I
> remember having when learning Git is that there is a lot of great
> material in the User Guide, Tutorial, Tutorial 2, Everyday Git, etc -
> but they're all huge long documents that are sometimes difficult to
> come back to and remember where you were, and I didn't know which one
> to start with or where to find what I was looking for, etc.

So, one of your arguments is that the current material are huge long
documents that are difficult to come back to and remember where you
were. But if I'd split the User Manaul TOC to the same layout you use
for the Community Book, what is the difference here? It seems to me that
both would appear pretty much the same. Should I do a proof of concept?
;-)

> Also, for credit, I have generated an Authors page I will be linking
> to the site soon that lists everyone that contributed a patch to any
> of the Git User Guide, Git Tutorials, etc.  It is in the PDF right
> now, but not in the HTML version yet (and the PDF is not yet linked to
> the site).

So, right now you are basically taking existing material and rearranging
it? By what rules? What is the underlying idea of your approach, and why
is it better than the current structure of the user manual? Have you
considered how to perform this all so that you can easily get further
updates and corrections to the user manual?

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
