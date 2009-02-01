From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Sun, 1 Feb 2009 23:59:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902012349360.3586@pacific.mpi-cbg.de>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>  <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>  <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>  <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
 <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com> <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de> <20090131095622.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 00:00:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTlJ9-00055B-8e
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 00:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbZBAW7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 17:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752609AbZBAW7a
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 17:59:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:47887 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752264AbZBAW73 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 17:59:29 -0500
Received: (qmail invoked by alias); 01 Feb 2009 22:59:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 01 Feb 2009 23:59:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/I6PoMumDI1H206EcgUULXPYiiTbL/9yUdXtHQg8
	b6DWl8CjHK7Itm
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090131095622.6117@nanako3.lavabit.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108023>

Hi,

On Sat, 31 Jan 2009, Nanako Shiraishi wrote:

> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> 
> > You cannot just cater for one workflow and fsck the other workflows 
> > over.
> >
> > You'll have to devise a method that helps the workflow you are 
> > interested in, but leaves the others alone.
> 
> I think you'd want to repeat that to yourself when you propose to switch 
> the default for denyCurrentcurrentBranch config to "true" too hastily 
> the next time?

Nanako, what exactly do you think I did before writing these lines:

    Granted, we wanted to have a longer grace period for old-timers, but
    let's face it:
    [... a discussion on the pros and cons ...]

?  Do you think I did that just on a whim, or do you rather assume that I 
thought long and hard about it?

> I don't think your patch matches the tradition of how defaults are 
> changed in git project. You don't introduce a large change just after 
> the maintainer hints about going into a freeze for 1.X.Y release when Y 
> isn't zero.

Indeed.  That is why I wrote "Granted, we wanted to have a longer grace 
period"!

> I assume that everybody, including the maintainer who is too heavyweight

I saw Junio.  He is in no way heavyweight.  He is actually rather skinny.

> and has too much inertia to accept too sudden a change of the course,
> wants to eventually make the default to deny pushing to the current
> branch. But I think such a change should come at 1.7.0 release at the
> earliest, and a constructive thing to do is to put in a patch to 1.6.2
> that helps the users with the eventual transition.

So what do you want to achieve?  Annoy me?  Annoy Git newbies?  Annoy Git 
oldtimers?

Eventually, it will boil down to

- who
- when

to annoy.

And I have a strong suspicion that it does not help the reputation of Git 
at all, if we annoy

- new Git users
- for a long time

Rather, I'd like to annoy only

- a few oldtimers who should know better by now
- just once, when they upgrade to a new minor release and see that they 
  forgot to mark their repository as "bare".

If you would think about it as long and hard as I did, you would see that 
we have to annoy

- a few oldtimers
- at some stage

anyway, but in the meantime, we could avoid to annoy

- a lot of new Git users
- for a long time

at the cost of annoying

- a few oldtimers
- now, instead of later

which cost will come to

- us
- anyway

Frankly, I am surprised that people do not agree with me on this point.

> What do people think?

Seriously, when it comes to the Git users I interact with, they think 
"what the bl**dy fsck did the Git people smoke when they made it _so_ hard 
on new Git users, I am certainly not the only person bitten by 
this."

I know, because they let me in on their thoughts, but are too shy to 
mention them here on the Git list.

And as everybody knows, I am a nice guy, and I listen.

Ciao,
Dscho
