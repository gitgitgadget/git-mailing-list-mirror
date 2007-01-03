From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] Documentation/tutorial: misc updates
Date: Wed, 3 Jan 2007 08:09:02 -0600
Message-ID: <8aa486160701030609g22eadf0brf8743dad5701f315@mail.gmail.com>
References: <sbejar@gmail.com> <87fyastgoo.fsf@gmail.com>
	 <200701031350.l03Doulu015800@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 03 15:09:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H26nk-0005Xm-Dt
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 15:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbXACOJF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 3 Jan 2007 09:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbXACOJF
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 09:09:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:42117 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbXACOJE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jan 2007 09:09:04 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5178533uga
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 06:09:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gs0HofDw2wOvQihtgHoSW/C7mGezAbLgVRW840Xapj1jEfAvThfNtfv9qRuneu9AfRfn8nwcgDZ5DIREPe/ov9Hv4O4At9gYExUgh7wt6SQjGbVaymW27DMjYTEXdg6n2lwxhPSGYRhC4F7YCn+tqohQsuRWY66cwgjGJxE32/c=
Received: by 10.78.203.13 with SMTP id a13mr2217660hug.1167833342844;
        Wed, 03 Jan 2007 06:09:02 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Wed, 3 Jan 2007 06:09:02 -0800 (PST)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
In-Reply-To: <200701031350.l03Doulu015800@laptop13.inf.utfsm.cl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35870>

On 1/3/07, Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:
> Santi B=E9jar <sbejar@gmail.com> wrote:
> > Three changes:
> > 1) Teach how to delete a branch with "git branch -d name".
> > 2) The first commit does not have a parent.
> > 3) Teach "git show" instead of "git cat-file -p".
> > ---
> >  Documentation/tutorial.txt |   17 +++++++++++++----
> >  1 files changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.tx=
t
> > index d043e84..f0a5526 100644
> > --- a/Documentation/tutorial.txt
> > +++ b/Documentation/tutorial.txt
> > @@ -222,6 +222,15 @@ $ gitk
> >
> >  will show a nice graphical representation of the resulting history=
=2E
> >
> > +At this point you could delete the experimental branch with
> > +
> > +------------------------------------------------
> > +$ git branch -d experimental
> > +------------------------------------------------
> > +
> > +This command ensures that the changes in the experimental branch a=
re
> > +already in the current branch.
> > +
>
> Huh? This deletes the branch, it doesn't ensure changes have been sav=
ed.

It deletes the branch only if the current branch is fast-forwarding it.

Could be rephrase as:

This command only delete the experimental branch if it is already
merge in the current branch.

>
> >  If you develop on a branch crazy-idea, then regret it, you can alw=
ays
> >  delete the branch with
> >
> > @@ -391,8 +400,8 @@ $ git show HEAD           # the tip of the curr=
ent branch
> >  $ git show experimental      # the tip of the "experimental" branc=
h
> >  -------------------------------------
> >
> > -Every commit has at least one "parent" commit, which points to the
> > -previous state of the project:
> > +Every commit has at least one "parent" commit (except the first),
> > +which points to the previous state of the project:
>
> And how can it have more than one parent? If you mention it, better c=
ome
> clean about merges (can be explained in detail later).

I have not mentined it, I've just added the exception that the
firt/root commits have zero parents.

>
> >  -------------------------------------
> >  $ git show HEAD^  # to see the parent of HEAD
>
> And if there are several parents?

Already explained before.

>
> > @@ -510,10 +519,10 @@ of the file:
> >  $ git diff v2.5:Makefile HEAD:Makefile.in
> >  -------------------------------------
>
> HEAD:Makefile.in doesn't need HEAD.

Not needed if the Makefile.in in the working directory is equal to the
file in HEAD.
But better explain new things.

Santi
