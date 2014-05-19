From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Sun, 18 May 2014 20:19:58 -0500
Message-ID: <53795c3e58f73_10da88d30829@nysa.notmuch>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
 <537693aee4fdd_3e4812032fcc@nysa.notmuch>
 <xmqq7g5i4r48.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 03:31:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmCQ2-0000u5-3H
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 03:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbaESBbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 21:31:05 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33820 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbaESBbE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 21:31:04 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so5414241obc.13
        for <git@vger.kernel.org>; Sun, 18 May 2014 18:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=qrv2f8Dyo9ECZHTN5CpqoZw2ItVemyA3JAMlu+CnwKo=;
        b=EV773I3fhL52z/On9AxP2R/AF6o9E0Mq9dqHHf7KDgLv3Q7GJgUO2M6ib2Kp9DGryd
         V6kYkAlOnjZg83jM2mOO6w5zuHP7REvdCAfagxBKGIwDvtFuc/pz9DJ/h/kQE4iPCTGv
         /plddsNUDFs4tRgaWpW49atORUl5kUZUNTmQYF1Ceytg/zy/6+WGRw6eFoaQDgVFvffQ
         BlD3GwYRioQseiedWPvq4H3CYpXU0KfgfrtpkI2mEFmQKDW7WuxF/4frxhk2GertnsEQ
         OGL5gdP64HCkxh8xv56FHMYKURBihZvD2D/U3EaUD9hYin8BuSUwbSVGMfWPUb9i+NMq
         f0Zw==
X-Received: by 10.182.33.6 with SMTP id n6mr32429903obi.48.1400463063556;
        Sun, 18 May 2014 18:31:03 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id w3sm5628976obp.16.2014.05.18.18.31.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 May 2014 18:31:02 -0700 (PDT)
In-Reply-To: <xmqq7g5i4r48.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249557>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> > But that being said, this is Felipe's code. While we have a legal right
> >> > to distribute it in v2.0, if he would really prefer it out for v2.0, I
> >> > would respect that.
> >> 
> >> I am fine with that.
> >
> > Are you? Because in two of the three options you list below you wouldn't
> > be doing that.
> 
> "that" does not refer to "remove them at v2.0 (unconditional)".  It
> refers to "If Felipe really wants for the removal for v2.0, I would
> respect that".  And I saw you said you did not want to disrupt v2.0.
> 
> If the options I listed all meant removal at v2.0, then I would
> understand your complaints, but that is not the case, so I am not
> sure what to make of that.

It is a weird choice of semantics then. You said you would "respect" my
wish, but your proposals did not "follow" my wish.

> > The fact of the matter is that users cannot depend on packages any more.
> > Maybe they'll be packaged, maybe not. If they are it will take a long
> > time before they do. In the meantime they'll have to manually install
> > them all all out-of-tree tools.
> 
> I have always thought that distro packagers are the biggest ally us
> project leaders have.  They locate useful pieces of software,
> massage them into a shape that fit their distro well and deliver
> what we write to their audience.  Packaging stuff that are useful to
> their end-users is what they do best, and not leaving useful stuff
> unpackaged is in their best interest.

Yet I bet a lot of open-source software is not actually packaged. That's
the reason there's Python's pip, and Ruby gems.

*If* your software is popular enough, then yes, packagers are your
biggest allys, but if not, they aren't.

> Your statement makes it sound like they are incompetent lazy fools
> who do not know what is useful for their users.

This sentence proves you have no idea how packaging is done.

There is no comittee that hunts down packages that are "useful for their
users" and assigns available packagers to those projects. Exactly the
same way you don't assign Git developers tasks based on what is "useful
for our users".

Each packager decides what project they package, just like every Git
developer decides on what feature they work on.

An obscure package might be packaged because a prominent Debian package
maintainer likes it, and a much more useful and popular project might
not be packaged simply because no package maintainer is interested in
it.

Exactly the same happens in Git; people work on relatively obsucre
features such as ref transactions, because they are interested in them,
and features much more "useful for our" users get ignored, because
there's nobody (of relevance) championing them.

When a popular project that is "useful for the users" is neglected for
too long, what usually happens is that an outsider steps up and does the
packaging, which then goes through a review process, and that outsider
might become an official maintainer, and maybe start to package other
things too. That's how packagers join the project.

But nothing gets done if no ousider steps up.

Excatly the same happens in Git; when a feature has been neglected for
too long, an outsider comes and tries to implement it, go through a
review process, and eventually start fixing other things too.

So no, there's no comittee that decides what should be packaged, just
like there's no committe that decides what Git features should be
developed.

It's incredibly alarming that you would think packagers in open source
distributions would work any other way.

And it's incredibly funny that you would label people working on such
model as "incompetent lazy fools" for "not knowing what is useful for
their users", when it is *EXACTLY* the same thing you do in Git; you do
not know what is useful for our users; you don't actually care; you just
work on whatever you like to work on.

It's even worst than that, because if somebody steps up to package a
popular project, the package goes in, but when somebody steps up to
implement a feature that improves our user-interface in Git; they get
their knees shot.

> I find it disturbing to see such a distrust.  Or am I being too
> naive to have too much faith in packaging folks?

There is so much wrong with your mode of thinking and the blindness that
you don't see what you yourself do that I don't even know where to
begin.

Yes you are too naive, on many levels.

> I checked the list of packages that depend on "git" on one of my
> boxes (it is a bit old Ubuntu).  I of course expected that many of
> them are what comes from our tree split into their own "niche tool"
> packages (e.g. git-svn, git-gui, gitweb...), but I was pleasantly
> surprised to see many that I haven't even aware of being packaged.
> Of course, "tig" is among the packages that depend on us which I am
> happy to see.
> 
> There are things of somewhat questionable value I saw in the list,
> of course.  It is already 2014, and I feel fairly safe to feel that
> I can say without offending too many people that I doubt "git-arch"
> would be on such a list of packages distros offer to their users, if
> it were written as a third-party plug-in today.
> 
> It is an (odd) example of a package that is still there mostly by
> inertia at this point, and that inertia comes from many things.  It
> is in our tree outside contrib/, it was found useful once in the
> past and was packaged, the packager already has infrastructure to
> cut a separate package out of our tree, and it is more trouble to
> retire it and risk breaking minority users than just keep shipping
> it.
> 
> But hg is not in a situation similar to tla, is it?  I simply cannot
> imagine "there is no history worthwhile to salvage out of Mercurial
> repositories" coming anytime in the near future.
> 
> After looking at the reverse-depends list of packages, my faith is
> strengthened in that the Git ecosystem is truly maturing and useful
> third-party plug-ins will be picked up by distro packagers.

Where is git-imerge packaged?

Do you want to bet? Nah, you don't *ever* want to accept you were wrong,
even you clearly where.

> Am I delusional?

Yes you are.

This is what's going to happen: there won't be an official git-hg
package for *years*, if there is ever one. That is my prediction based
on all the available evidence, I am willing to stand by it and accept I
was wrong if it proves otherwise.

Are you willing to stand by your own decisions?

-- 
Felipe Contreras
