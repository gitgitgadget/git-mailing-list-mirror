From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 22:21:17 -0400
Message-ID: <9e4733910606091921o1d07826w8292dc22b1872345@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
	 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
	 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
	 <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
	 <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>
	 <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 04:21:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fot6H-0006Gf-Qm
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 04:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWFJCVT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 22:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWFJCVS
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 22:21:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:10869 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932328AbWFJCVS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 22:21:18 -0400
Received: by nz-out-0102.google.com with SMTP id m7so337407nzf
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 19:21:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a36gZ6En+bJeVbxv+obE504E/kWM5+AOU6UD+P3wMcxno/xA+10g1aS2i8SAGpiLA+BINj5KksfKsaGl8LHT1mpJRVRl0A3kZ2f70+HlLwSXLhcldJHupq82uGnEcYLhVKdZEBXsec0Nmzauyu4VLBdg8gpM+3nYVQtONTo4H7I=
Received: by 10.36.80.8 with SMTP id d8mr5114003nzb;
        Fri, 09 Jun 2006 19:21:17 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 9 Jun 2006 19:21:17 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21585>

On 6/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Fri, 9 Jun 2006, Jon Smirl wrote:
> > >
> > > Btw, does anybody know roughly how much data a initial "cvs co" takes on
> > > the mozilla repo? Git will obviously get the whole history, and that will
> > > inevitably be bigger than getting a single check-out, but it's not
> > > necessarily orders of magnitude bigger.
> >
> > 339MB for initial checkout
>
> And I think people run :pserver: with compression by default, so we're
> likely talking about half that in actual download overhead, no?
>
> So a git clone would be about (wild handwaving, don't look at all the
> assumptions) four times as expensive - assuming we only look at a poor DSL
> line as the expense - as an initial CVS co, but you'd get the _whole_
> history. Which may or may not make up for it. For some people it will, for
> others it won't.

Could you clone the repo and delete changesets earlier than 2004? Then
I would clone the small repo and work with it. Later I decide I want
full history, can I pull from a full repository at that point and get
updated? That would need a flag to trigger it since I don't want full
history to come over if I am just getting updates from someone else's
tree that has a full history.

>
> Of course, to make up for some of the initial costs, I suspect that some
> people who are used to "cvs update" taking 15 minutes to update two files,
> it would be a serious relief to see the git kind of "300 objects in five
> seconds" kinds of pulls.

No more cvs diff taking four minutes to finish. I have to do that
every time I want to generate a 10 line patch. Diffs can run locally.
No more cvs update to replace files I deleted because I messed up
edits in them. And I can have local branches, yeah!

What are we going to do about the BEOS developers on Mozilla? There
are a couple more obscure OSes.

> Although I guess that's one of the CVS things that SVN improved on. At
> least I'd hope so ;/
>
>                         Linus
>


-- 
Jon Smirl
jonsmirl@gmail.com
