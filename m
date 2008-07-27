From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-scm.com
Date: Sun, 27 Jul 2008 13:37:07 +0200
Message-ID: <20080727113707.GC32184@machine.or.cz>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com> <7v3alxr0fd.fsf@gitster.siamese.dyndns.org> <d411cc4a0807251759m1d83d7c4w4724806b19f7c02a@mail.gmail.com> <7vsktwfu5z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 13:38:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN4Zo-0004Fo-0G
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 13:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbYG0LhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 07:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbYG0LhM
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 07:37:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59079 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbYG0LhK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 07:37:10 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4A98B393B321; Sun, 27 Jul 2008 13:37:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vsktwfu5z.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90331>

On Sat, Jul 26, 2008 at 10:10:32AM -0700, Junio C Hamano wrote:
> "Scott Chacon" <schacon@gmail.com> writes:
> 
> > On Fri, Jul 25, 2008 at 4:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> ...
> >> I find a tabular list like this list easier to read if it were sorted like
> >> this:
> >>
> >>        A       D       G
> >>        B       E       H
> >>        C       F
> >> ...
> >
> > I fixed the things you mentioned here, except for the list ordering,
> > only because I kinda think you big contributors should be at the top
> > there,...
> 
> If you are going to list 30 or so top contributors in 8 rows times 4
> columns, because visually the columns are much more distinct than the
> rows, it makes the result look more sorted.  This is the same reasoning
> hwo "git help --all" was fixed with 112d0ba (Make "git help" sort git
> commands in columns, 2005-12-18).

Actually, this is strange for me: I would never think about reading git
help --all by rows, and I would never think about reading the authors
list by columns! It's difficult for me to point out why, possibly
because the authors list has less items per row and the items are longer
(and multi-word), but that's just a speculation. Maybe cultural
background (Japanese books are written in columns, right?) plays some
role too, I don't know.

> The purpose of the list would most likely not to find somebody with high
> activity to contact for help (you would use the top list that is sorted by
> the commit count for that kind of thing).  It would primarily be to give
> credit to everybody, and perhaps so that people on the contributor list
> can point at their own name and say "I helped them", or find somebody else
> they happen to know in the list.
> 
> When a contributor used to have 8 commits and then adds 2 commits, that
> would move the name in the list by a dozen places or so with the current
> set of contributors.  It would be much easier to locate one's own name
> among a huge list if the names are alphabetically sorted, not by commit
> count.  When more people start to contribute, your name does not move so
> drastically.  If you are Adam, you are likely to find yourself near the
> beginning of the list, if you are Scott, you are likely to find yourself
> near one fourth from the end of the list.

I don't think locating is any issue; the find function of browser is
very easy to use nowadays. I guess the purpose of the list would be
to show "I helped them this much" (i.e. "I'm high on the list"). I think
this would actually motivate contributors to move up in the ladder -
people are competitive; you might get wary about this kind of
motivation, but I believe that it is no bad thing, inherently. Heck, I
admit it does motivate even me a little, safely in the "Primary Authors"
section. :-) (These guys with their tools merged into git have unfair
advantage! You should add up also, uh, git-homepage, cogito and, um...
repo.git! *baby cry*</vanity>)

> And for the "giving credit" purpose, I do not think truncating the list at
> 5 commits or less threshold, as suggested earlier and already done, makes
> much sense, either.

The point here is that the list is awfully long and also can contain
a lot of duplicates or people with broken unicode, etc. - it gets hard
to maintain, and it makes the about page too long. I would be of course
fine with a tiny link at the bottom "(show all contributors)".

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
