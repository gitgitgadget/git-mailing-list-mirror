From: Petr Baudis <pasky@suse.cz>
Subject: Re: suggestions for gitweb
Date: Mon, 14 May 2007 03:08:31 +0200
Message-ID: <20070514010831.GH4489@pasky.or.cz>
References: <20070512205529.GS14859@MichaelsNB> <7v8xbtwtsy.fsf@assigned-by-dhcp.cox.net> <20070513000151.GT14859@MichaelsNB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Michael Niedermayer <michaelni@gmx.at>
X-From: git-owner@vger.kernel.org Mon May 14 03:08:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnP3G-0005y2-DO
	for gcvg-git@gmane.org; Mon, 14 May 2007 03:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761701AbXENBIf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 21:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761704AbXENBIe
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 21:08:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53338 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761687AbXENBIe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 21:08:34 -0400
Received: (qmail 21974 invoked by uid 2001); 14 May 2007 03:08:31 +0200
Content-Disposition: inline
In-Reply-To: <20070513000151.GT14859@MichaelsNB>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47212>

  Hi,

On Sun, May 13, 2007 at 02:01:52AM CEST, Michael Niedermayer wrote:
> On Sat, May 12, 2007 at 03:39:25PM -0700, Junio C Hamano wrote:
> > Michael Niedermayer <michaelni@gmx.at> writes:
> > 
> > > * gitweb uses many terms which are new to a non git user, and while
> > >   devlopers who work on ffmpeg will very likely very quickly have
> > >   figured out the meaning of all of them. i think simple users who just
> > >   want to browse the ffmpeg code will have their problems, so i belive 
> > >   a small help text linked to from all pages which contains a short
> > >   definition of all the git(web) specific terms would be very helpfull
> > >   something like
> > >     blob        - file      at a specific revission/date
> > >     tree        - directory at a specific revission/date
> > >     (short) log - project wide commit log
> > >     history     - short log equivalent for a file or directory
> > 
> > Coming fron non-CVS camp, I think changing this to non-git terms
> > is very harmful than educating users who are migrating from
> > other systems.
> 
> you must missunderstand me :(
> i want to educate them, but i cannot as iam not speaking about ffmpeg
> developers/contributors but rather random people who are curious and 
> want to take a look at the ffmpeg source
> 
> for them a simple help link similar to "ViewVC Help" which viewvc has
> on the bottom right of its pages would be great IMHO
> also the text above is a pure random suggestion by a svn user and was
> not intended to redefine any git terms

  I seriously doubt the usefulness of this. Meaning of all the links except
maybe blob seems immediately obvious for me, even if I try to imagine
that I know nothing about Git; maybe I'm wrong here, I might try to do
an experiment. :-)

  But, even if that's the case, when a new user meets gitweb and looks
at the 'history' link, what do you think she will do? Start hunting the
page for some link to a glossary? I yet have to see a user like that :-)
- I will bet that she just clicks at the link and figures out what it is
about based on what happenned.

> > > * The blame page shows the SHA1 for each hunk and IMHO thats the last thing
> > >   i would want to see first, id be much more interrested in by whom and
> > >   when a given change was done, iam wondering in which case the SHA1 would
> > >   be usefull? copy-paste onto your command line git tools but then why
> > >   use gitweb at all, 'git blame' would make more sense IMHO and a simple
> > >   click would reveal the sha1 with more info anyway ...
> > 
> > They serve no purpose other than showing something to click on,
> > and allow you to hover over (some people argued in the past
> > that they recognize certain commit object names, but honestly I
> > would not believe them).  However, I do not think there are much
> > better alternatives.  Try coming up with a different "label"
> > string that is of uniform length across commits, and does not
> > chew up too much screen real estate.
> 
> trivial
> the first N chars of the username + YYMMDD
> 
> so for example:
> michaeln070612
> 
> or with space:
> michaeln 070612

This idea occurred to me, but so if a file is born from 20 commits in a
single day, you have no distinction between them. And if you throw time
in the mix too, it already becomes way too long; I'd argue that even
username-date already feels too long.

> [...]
> > > * on the history page there are "blob", "commitdiff" and "diff to current"
> > >   the obvious missing one is "diff to previous" which would be the diff to
> > >   the previous blob of this file
> > 
> > Isn't that commitdiff, or commitdiff on that page does not limit
> > the diff to the blob?
> 
> commitdiff doesnt limit it to the blob ...

I don't know if it's better to limit commitdiff or not; a compromise
approach would be not to limit it but to jump to the fragment concerning
the given blob.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
