From: Josef Wolf <jw@raven.inka.de>
Subject: Re: git-svn and repository hierarchy?
Date: Sat, 28 Feb 2009 00:58:25 +0100
Message-ID: <20090227235824.GD14187@raven.wolf.lan>
References: <20090224223412.GA4573@raven.wolf.lan> <49A50EB2.80300@drmicha.warpmail.net> <20090225232442.GC4573@raven.wolf.lan> <eaa105840902251702l68bc35f3ia15b1c804a6825f3@mail.gmail.com> <20090227165812.GA14187@raven.wolf.lan> <eaa105840902271011u19375ba4j4a765ed2707ebb3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 01:01:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdCeQ-0004NA-Nx
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 01:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756315AbZB1AAV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 19:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756105AbZB1AAV
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 19:00:21 -0500
Received: from quechua.inka.de ([193.197.184.2]:49354 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756019AbZB1AAU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 19:00:20 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1LdCcr-0000dl-AS; Sat, 28 Feb 2009 01:00:17 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 109D82C916; Sat, 28 Feb 2009 00:58:25 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <eaa105840902271011u19375ba4j4a765ed2707ebb3b@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111726>

On Fri, Feb 27, 2009 at 01:11:36PM -0500, Peter Harris wrote:
> On Fri, Feb 27, 2009 at 11:58 AM, Josef Wolf wrote:
> > On Wed, Feb 25, 2009 at 08:02:45PM -0500, Peter Harris wrote:
> >
> >> No need to coordinate clones, aside from each clone
> >> needing to know how to work in a "commits will be rebased by upstr=
eam"
> >> type of environment (which isn't unique to git-svn).
> >
> > Hmm, what does that exactly mean? =A0Chances are that the reason fo=
r my
> > problem is that _I_ am the one who don't know that...
>=20
> See, for example,
> http://kerneltrap.org/mailarchive/git/2008/8/23/3056824 and
> surrounding thread.
>=20
> The consensus is "Pester upstream until they stop rebasing".
> Unfortunately, Subversion is an application, not a human, so your
> pleas will go unheard. :-) The rest of that thread contains hints for
> working with a rebasing upstream.

Thanks for the pointer, Peter!  That's a long thread with a lot of
dense information.  I'm going to read (and try to understand :),
but I guess it will take a couple of days...

> git-svn will actually never rebase anything once it is in Subversion.
> So, for example, when they say 'linux-next' in that thread, you could
> read "any branch that isn't in Subversion yet", since you know that
> branch will be rebased at least once.

At the time I read the tutorials/howtos/whatever, I thought I understan=
d
what "rebase" actually means.  But now I get pretty much confused, sinc=
e
there are "git rebase", "git pull --rebase" and "git svn rebase" involv=
ed,
and they all seem to do very different things.

> > jw@raven:/home/jw> git --version
> > git version 1.6.0.2
> > jw@raven:/home/jw>
>=20
> 2beec8973 is the commit in question. Unless I'm mistaken, it first
> appeared in 1.6.1.0, so you may want to upgrade each cloneN to at
> least 1.6.1.

OK.
