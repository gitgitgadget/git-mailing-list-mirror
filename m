From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: LCA06 Cogito/GIT workshop - (Re: git-whatchanged: exit out early on errors)
Date: Sat, 28 Jan 2006 18:33:52 +1300
Message-ID: <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>, keithp@keithp.com
X-From: git-owner@vger.kernel.org Sat Jan 28 06:34:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2ij3-0001X2-8c
	for gcvg-git@gmane.org; Sat, 28 Jan 2006 06:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWA1Fd4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jan 2006 00:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWA1Fd4
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jan 2006 00:33:56 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:64198 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932522AbWA1Fd4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2006 00:33:56 -0500
Received: by wproxy.gmail.com with SMTP id 57so741275wri
        for <git@vger.kernel.org>; Fri, 27 Jan 2006 21:33:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pceo/VlYUl+PCj5NPozS3srJWPr4nS0s159ui5c7Bv/tzLcGj0DdY7FL0mEbBQHHJ3sPqengrGNAeKjgQPKRorfUhejT6dnYHVaT3p02vBrCuG04t2hXUEpF7IqjOBNwKRIBz/Jdkf92BmMgZoa14XjFSnzQ5P78t8rXddUZHCs=
Received: by 10.54.92.8 with SMTP id p8mr4857043wrb;
        Fri, 27 Jan 2006 21:33:53 -0800 (PST)
Received: by 10.54.70.12 with HTTP; Fri, 27 Jan 2006 21:33:52 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15192>

On 1/28/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > During the presentation someone mentioned errors when running
> > git-cvsimport which I'm keen on hearing more about.
>
> Martin, I talked to Keith, and apparently you fixed some cvsimport problem
> they had with Cairo during dinner last night? Was that something that
> could have affected other people, or was it very specific to whatever
> Cairo CVS insanity? I've not seen any messages from you on it..

I've got a few small improvements to cvsimport in my laptop that I'll
push out for Junio to merge as soon as I get back to the office. I've
run "99% successful" imports of cairo and of x.org (modular and
monolithic) with all their branches and tags. It isn't literally the
20 years of commits Jim talked initially about -- cvs holds just the
last ~5 years.

The repos *are* a bit broken -- files missing (not moved, but really
missing) so some of the fixes are to make it easier to discover where
it is dying and workaround it. There are a few more things that I need
to debug in cvsimport -- there's a small delta between what I should
have and what I do have. As soon as they are 100% right I'll put them
on http://locke.catalyst.net.nz/gitweb for the X.org team to have a
look at them -- and a cronjob to keep them up to date with official
CVS.

BTW, have you still got that patch to git-merge to seed the commit msg
with conflicted files? ;-)

cheers,


m
