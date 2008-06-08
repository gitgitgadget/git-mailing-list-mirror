From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [PATCH] Port to 12 other Platforms.
Date: Sun, 8 Jun 2008 13:31:15 -0600
Message-ID: <Pine.LNX.4.64.0806081318520.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806080926240.18454@xenau.zenez.com>
 <m3prqsvsiq.fsf@localhost.localdomain> <Pine.LNX.4.64.0806080959390.18454@xenau.zenez.com>
 <7vhcc3kbdw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 21:32:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Qcy-0004ZW-04
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 21:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbYFHTbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 15:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbYFHTbQ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 15:31:16 -0400
Received: from zenez.com ([166.70.62.2]:11205 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752911AbYFHTbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 15:31:16 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 46223E5F50; Sun,  8 Jun 2008 13:31:15 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 2C853E5F1B;
	Sun,  8 Jun 2008 13:31:15 -0600 (MDT)
In-Reply-To: <7vhcc3kbdw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84311>

On Sun, 8 Jun 2008, Junio C Hamano wrote:
> Boyd Lynn Gerber <gerberb@zenez.com> writes:
> > On Sun, 8 Jun 2008, Jakub Narebski wrote:
> > This was from my own copy of the master archive.  It is my proposal.  I 
> > thought you had to get an OK from this list before you do a push to the 
> > main archive.  Am I missing something?  I am new to this list and the 
> > proper methods for submitting patches.  I thought I was following the 
> > guidelines from 
> >
> > http://repo.or.cz/w/git.git?a=blob_plain;f=Documentation/SubmittingPatches;hb=HEAD
> >
> > What am I missing?
> 
> It might appear that many people somehow hate your patch and ganging up 
> on it, and if so I apologize for them and I assure you that they do not 
> mean ill.

This list has been very good.  The problem comes from other lists and 
personal assualts on my domain.  
 
> There seem to be some confusion either in the SubmittingPatches document 
> or the way some suggestions have been given in the recent postings by 
> people, so let's clear it up first.

Yes, I was a bit confused but the docs/email/IRC.  I really apperciate the 
message below.  I really want to comply with the rules of this list and 
make sure my changes make it into the master/core source.

... 
>    * For an enhancement, describe in what situation the new feature is
>      useful, defend why that use case is worth supporting, state how
>      awkward (or perhaps impossible) to do the same thing is with the
>      current set of features, and discuss and defend why you chose this
>      specific approach to fix the awkwardness among other possibilities.
>      E.g. "This adds a new feature X that works like this.  When you have
>      Y and want to arrive at Z, with the current set of commands you would
>      need to do W, but...".
> 
>    The point is to help people, who later wonder why the change was made
>    and on what basis the author thought the change was necessary and/or
>    sufficient back then when the change was made, understand the context.
> 
>    This comes at the beginning of the e-mail message, and is concluded by
>    S-o-b line(s).

I agree.  I am not sure on some things but I will ask more later.

>  * Supporting material that makes it easy to understand the particular
>    iteration of the patch in the context of review discussion, things like
>    "Compared to the previous round, I changed this and that, thanks to
>    comments from X and Y."  Because only the final iteration will get
>    committed in the final history, it does not make sense to include such
>    information in the commit message.  This comes after the commit log
>    message, and a single three-dash line is used to separate this part
>    from the commit log message.
> 
>  * The change itself, aka "patch".  This comes at the end of the message.
...

>     __USLC__ indicates UNIX System Labs Corperation (USLC), or a Novell-derived
>     compiler and/or some SysV based OS's.
> 
>     __M_UNIX indicates XENIX/SCO UNIX/OpenServer 5.0.7 and prior releases
>     of the SCO OS's.  It is used just like Apple and BSD, both of these
>     shouldn't have _XOPEN_SOURCE defined.
> 
> These are valuable clues to anybody who is unfamiliar with (and/or do 
> not have an easy access to) these systems.  When people later want to 
> touch git-compat-util.h around the place where !defined(__USLC__) is 
> used, they would run "git blame" (or perhaps "git log -S__USLC__") to 
> find your commit that modified this line, and by looking at the commit 
> log message why you added these symbols on the #if line.  It would help 
> protect your changes from begin broken by them if you help them 
> understand why these are there, and the above two paragraphs should 
> definitely go to the commit log message.  They are not mere supporting 
> material for this review cycle alone.

I will have to find all this information.  It took me 2 months in my 
personal time to find and fix them.  I will have to get back on this 
below.
 
> "..., both of these shouldn't have" however could even be more helpful 
> if it was stated like "On these platforms, defining _XOPEN_SOURCE hides 
> definitions of X, Y and Z that we use, which is not what we want.", for 
> people who would want to know what specific breakage the change 
> addresses.
>
> It would change "Ok, somebody with SCO systems says this patch fixes 
> things for him" to "I see, if _XOPEN_SOURCE over there makes *that* 
> function unavailable, then we definitely shouldn't have _XOPEN_SOURCE 
> defined at this point of the header file".  IOW, it makes "Ok, I trust 
> the guy's judgement, even though the details are fuzzy to me" into "Ok, 
> I agree with his judgement".

Thanks, more later when time permits.

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
