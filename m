From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Git Community Book
Date: Wed, 30 Jul 2008 17:39:18 -0400
Message-ID: <20080730213918.GD19117@fieldses.org>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com> <20080729170955.GK32184@machine.or.cz> <d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 23:40:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOJPE-0000UZ-Dm
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 23:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbYG3VjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 17:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753401AbYG3VjW
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 17:39:22 -0400
Received: from mail.fieldses.org ([66.93.2.214]:52506 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808AbYG3VjV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 17:39:21 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1KOJOA-0005LG-Fo; Wed, 30 Jul 2008 17:39:18 -0400
Content-Disposition: inline
In-Reply-To: <d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90860>

> > So my confusion still is - where does this stand wrt. the user manual?
> > Why didn't you just start with the manual and work on that? I thought
> > you were planning to do that, but apparently we misunderstood each other
> > in the last mails.
> >
On Tue, Jul 29, 2008 at 11:30:55AM -0700, Scott Chacon wrote:
> 
> I was originally planning on doing that, but the problem is the
> graphics, diagrams and screencasts.  Unless I am mistaken, there is
> not a single outside media reference in any of these guides - the
> diagrams that are there are all ascii drawings.  I'm assuming there is
> a reason for that. If I wanted to add images and screencast embeds
> into the guide, how would that work?
> 

Yeah, some possible obstacles:

	- Size: People probably won't want large binary blobs added to
	  the git repository.
	- Editability: We want to be able to keep the materials up to
	  date and accurate.
	- Source readability: the current documentation can all be read
	  in place without doing a build.
	- Build requirements: I seem to recall complaints about the
	  toolchain required to build the existing documentation.

At least for simple diagrams it might be possible to solve most of those
problems with an appropriate diagram-description-language that could be
compiled into image files.  Screencasts are probably totally out,
though.

In cases where you do find you're working with the same material, any
improvements you could contribute back to the in-tree documentation
would of course be appreciated.

> Well, that's what the point of this is - to ask everyone to help me
> review it, and possibly help me add to it.  The user manual is great,
> but even I don't reference it very often because I find it difficult
> to find content in it I need quickly.

If you had notes on any particular examples (I looked for X in place Y,
then place Z, and finally found it where I least expected it in place
Q...), they'd be appreciated.

> The specific order I choose is very different from the User Guide and
> is likely to bother a number of people, which you mentioned (and I'm
> sure Dscho will _hate_) because I introduce the object model at the
> beginning.  (I'm still working on that section, trying to simplify it
> and add in some other diagrams and a short screencast I have that I
> think will be helpful)  This is because I have had a lot of positive
> feedback that primary frustration from people comes from them thinking
> of Git as a super-better Subversion.
>
> I would venture to say that
> _most_ of the users coming to Git now are currently fluent in
> Subversion.  Even if they are from Perforce or CVS (the other two ones
> I will occasionally run into), their mental model of what an SCM does
> is the same - delta storage.  I've found that by ridding them of that
> notion off the bat, they have _far_ fewer problems and frustrations
> with Git than when I just try to show them the first 10 commands in
> sort of a cookbook style.  It's not a complicated model, it doesn't
> take long to teach, and in _my personal_ experience (which is not to
> say it's necessarily correct), it helps people the most in picking it
> up and really loving the tool.

I've considered doing the same for the user manual, actually, for some
of the same reasons--my main concern would be that it be done very
quickly, so as not to make people feel like it was a big obstacle on
their way to actually doing what they need to do.

So, anyway, that's to say that suggestions for reorganization of the
in-tree documentation (as opposed to just smaller-scale fixes) would
also be welcomed....

--b.

> 
> The book is built so that it is just as easy to start in the 'Basic
> Usage' section and go back later, but if you're going to sit down and
> just start reading, I think it would be better to explain why Git is
> different at a fundamental level right off the bat.
> 
> Scott
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
