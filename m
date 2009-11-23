From: Adrian May <adrian.alexander.may@gmail.com>
Subject: Re: Android needs repo, Chrome needs gclient. Neither work. What does 
	that say about git?
Date: Mon, 23 Nov 2009 12:11:29 +0800
Message-ID: <65e170e70911222011l776a6aean7bd75f072a806616@mail.gmail.com>
References: <2d707e8c-2561-470c-beba-c81e16ac441c@k17g2000yqh.googlegroups.com>
	 <65e170e70911200251q2ec5ec87rc37577dddfd3317d@mail.gmail.com>
	 <alpine.DEB.1.00.0911201229080.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, chromium-discuss@googlegroups.com
X-From: git-owner@vger.kernel.org Mon Nov 23 05:18:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCQNU-0002Bj-8k
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 05:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756239AbZKWEQv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 23:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756233AbZKWEQu
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 23:16:50 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:63568 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202AbZKWEQt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Nov 2009 23:16:49 -0500
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Nov 2009 23:16:49 EST
Received: by iwn1 with SMTP id 1so363204iwn.33
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 20:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=6FhGQ/uYTGQsH94f0pGbYvhV3Q4PlqqAleoEOhOWjfo=;
        b=BAExU6Sof261wIC2K73oVH3xw6dkMubdy0pm14zTinrkpF7+c3f1VlU0Ls2A0xFLEE
         0z5BaIh3BMOJjSZ4kd+Drv952kDUQbtZ7i2KIt16mgn0FqMr9rh7/CR1A0Ol8Mrs4LAT
         436Xc1e8oKOk3InQAdUWWpxr1ccuura2ed9ck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=w3LZ6K+a2K0M5CYjP1Pnt27rSbCGjjla8eGf6cyu3A8SG4NglQi1KAjMWiH8c3PHsE
         o0vIG1Rboy7fYZvXjgtu6piOAlRL0T/NVJ3LzHbHw6dUIHMpg9n7YDFPFCS/3dKhdotw
         eByCTSd6YgIMm9fqoJyaMIOhD6DHGT2668XX4=
Received: by 10.231.26.131 with SMTP id e3mr1669596ibc.0.1258949489381; Sun, 
	22 Nov 2009 20:11:29 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0911201229080.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133479>

>> Git is just plain wrong, because you can't split or merge repositori=
es
>> or pull subtrees of them.
>
> You are plain wrong, because that is possible. =C2=A0Did you maybe fo=
rget to do
> your homework before coming here and shouting around as if you were r=
ight?

So it is. Fair enough, I stand corrected. That was my single biggest
gripe about git so it's nice to know it's there.

> To the contrary, these "bolt-on scripts" are superior to other soluti=
ons,
> because they give the savvy user freedom to do _anything_ a program c=
an
> do.
> Your complaing have the same sense as complaining that gcc does not
> include functionality of Makefile, because you just can't manage
> larger projects without it (or equivalent).

Well, these scripts, whatever git is written in and pretty much
everything else in sight is a Turing machine, so anything could, in
theory, do anything. But nevertheless, I think everybody agrees that
certain functions belong in certain places, even if they disagree
about where. I'd wager that 'make' belongs outside of gcc because it
also drives other compilers, things like yacc, post-build steps, etc.
OTOH I think producing browse info is a long-standing ommission from
gcc that should never have been done externally in things like ctags
and cscope, because the compiler has to do 90% of the work required
anyway and because it's the compiler's opinion that counts.

As for gclient and repo, without pretending to be an expert on what
they actually do, I'm getting a strong gut feeling that if what I'm
trying to do is pull or push code, then that's about as close as you
can get to a definition of source control's central purpose. In the
days of cvs or svn, I'd expect to use the source control for that. How
come git needs help? Basically, my point is that these scripts should
be the roadmap for git itself, because those are the functions people
had to add to their git-based set-up in the real world. Also because
the implementations would probably be simpler, more robust and more
general if they were in git.

> these "bolt-on scripts" give the savvy user freedom

Actually, I think their purpose is precisely the opposite: to regiment
the ordinary developer into following their process. So having that
code under the developer's control is a weakness.

As for pulling subtrees, I guess it's sensible for the code managers
to declare which subtrees are likely to work on their own by making
them repositories. I believe you can also link lots of repositories
together to make a huge combo-repository, so I don't understand why
android doesn't use that instead of having this script to iterate over
them all. Maybe they started before the split/merge thing got written
(it would have been risky to try and get it right first time if they
couldn't rearrange them later.)

>> It doesn't have the kind of triggers you
>> need to assert change control either, and these bolt-on scripts are
>> just making life messy.
>Can you elaborate?

Well, I believe that repo is largely about asserting their code
integration process. It knows who to send your changes to for review.
But now that I think about it, I guess git does that as a first
principle. If I push to your repo, you get to review it before it goes
in and in the meantime I shouldn't be surprised that our repos look
different. So what the hell do they write those scripts for? Does
anybody around here know if they actually need them or not?
Unfortunately their list doesn't seem to be taking my post.

> If you had problems pulling the code, there are two possible sources =
of
> problems: the program or a PEBCAK.

Well, the repo thing eventually got fixed: it was committing suicide
at the first sign of server load. I don't know what gclient's problem
is, but my personal opinion is that the *root* problem is the
existence of the scripts at all. In both cases, there's not much room
for pebcak in the instructions.

> You obviously do not understand Open Source.  If you have an itch, sc=
ratch
> it, or pay somebody to scratch it for you.

I know, but I'm actually supposed to be getting on with my real job
instead of sticking my nose into other peoples' problems like this. I
might also argue that making suggestions is some kind of contribution,
at least if the value of the suggestion outweighs the distraction of
everybody having to read it to find out whether it's any use or not,
which may or may not be the case here. Either way, I also have a
budget for distractions and it doesn't allow for getting my brain
around the git source code.

Adrian.
