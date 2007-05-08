From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] user-manual.txt: Some doc updates
Date: Tue, 8 May 2007 10:37:28 +0200
Message-ID: <8aa486160705080137r88698b0n58c46c35838bd3d6@mail.gmail.com>
References: <87hcrcjre3.fsf@gmail.com> <20070508032115.GC9471@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue May 08 10:38:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlLD9-0004hJ-Os
	for gcvg-git@gmane.org; Tue, 08 May 2007 10:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934704AbXEHIhe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 04:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934744AbXEHIhe
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 04:37:34 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:24174 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934739AbXEHIhb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2007 04:37:31 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1659207wxd
        for <git@vger.kernel.org>; Tue, 08 May 2007 01:37:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RXAtOEdLKlqn783i3BmtWiLZjW6j/ByiWDxcloFREvDHaQfA/PeC8aJ2ymZCSfdnOUwkos1jFDO4oXUkTDEich6m4evKaclvDK6aV9oLrtbDTwhi0doXGdJT8TVReu+YnSk8yIysDySvYBHzw49lrQJ+y90a/P7dVAG8HfECRo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dDQw3PoGWUBSX7o1a3cuap0HtVFNzApOR50HchZNS/KL5lw9xJVrEm+AuqNhq4h7dHC2eo7zxUdqwFi0FKWK4HLur3NjkavT6rqjSibuub36zSsIyL+yX+e/kGsV2JlpJtVWj95p0buJDxwt9MtY9S0DinPRszS59DEX9E3EHQM=
Received: by 10.78.138.6 with SMTP id l6mr2351027hud.1178613449060;
        Tue, 08 May 2007 01:37:29 -0700 (PDT)
Received: by 10.78.137.19 with HTTP; Tue, 8 May 2007 01:37:28 -0700 (PDT)
In-Reply-To: <20070508032115.GC9471@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46553>

On 5/8/07, J. Bruce Fields <bfields@fieldses.org> wrote:
> On Thu, Apr 19, 2007 at 05:49:40PM +0200, Santi B=E9jar wrote:
> >  git branch::
> > +     list all local branches
> > +git branch -r::
> > +     list all remote branches
> > +git branch -a::
> >       list all branches
>
> I think I dropped this just because "remote branches" haven't yet bee=
n
> introduced at this point in the manual.  (That's not till "Examining
> branches from a remote repository".)  Could be some sections should b=
e
> reordered--suggestions welcomed.

OK.

>
> > +-------------------------------------------------
> > +$ git diff HEAD
> > +-------------------------------------------------
> > +
> > +shows the difference between the working tree and HEAD.
> > +
>
> I took the mention of this later on, but didn't think it was necessar=
y
> to mention here too.

=46air enough.

>
> > @@ -1872,10 +1880,7 @@ As with git-fetch, you may also set up confi=
guration options to
> >  save typing; so, for example, after
> >
> >  -------------------------------------------------
> > -$ cat >.git/config <<EOF
> > -[remote "public-repo"]
> > -     url =3D ssh://yourserver.com/~you/proj.git
> > -EOF
> > +$ git config remote."public-repo".url ssh://yourserver.com/~you/pr=
oj.git
> >  -------------------------------------------------
>
> I think this was adequately discussed.
>

OK.

> > +You can also instantly browse your working repository in gitweb us=
ing:
> > +
> > +-------------------------------------------------
> > +$ git instaweb
> > +-------------------------------------------------
> > +
> > +See gitlink:git-instaweb[1] for details.
> > +
>
> That's nifty, but doesn't seem necessary at this point, and doesn't
> quite fit in the section (which is about public repositories).
>

I've put it here because then you can view the gitweb before public
consumption. Otherwise OK.

> Others look good, thanks.
>
> But if you want whole patches applied or rejected with explanation, I
> think you may have to be prepared to revise and resubmit when there a=
re
> objections to parts.

Yes and I have already prepared the remaining patch, but first I need
to know the objections.

Santi
