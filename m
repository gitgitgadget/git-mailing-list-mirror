From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 02:12:43 -0700 (PDT)
Message-ID: <m3fwm7aox1.fsf@localhost.localdomain>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
	<20110714183710.GA26820@sigill.intra.peff.net>
	<CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
	<20110714190844.GA26918@sigill.intra.peff.net>
	<CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
	<20110714200144.GE26918@sigill.intra.peff.net>
	<69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
	<20110714203141.GA28548@sigill.intra.peff.net>
	<CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 11:12:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QheS6-0003eO-Fs
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 11:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965278Ab1GOJMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 05:12:48 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:46925 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964982Ab1GOJMq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 05:12:46 -0400
Received: by fxd18 with SMTP id 18so2539977fxd.11
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 02:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=B9/OB/7cslVOnGjYLouDAdvMIT9bcCoyWRGc9rn07vA=;
        b=rVOIqtUo6y8fjiaTJbUPe7TE37MaXpO2OgOHqQcF3xaH+0y96dhRfdO+o75bCInmWw
         U0vC/+QLxQa/ICHV7++domPsC+D6hzjj9otUleoMIN0CF2ypMYGA2e8YJRhKciqtrMFZ
         fE48zLWvUtjGU6rqTwT6WIUMhyHoJStiRzIUc=
Received: by 10.223.83.132 with SMTP id f4mr136744fal.25.1310721165392;
        Fri, 15 Jul 2011 02:12:45 -0700 (PDT)
Received: from localhost.localdomain (abva152.neoplus.adsl.tpnet.pl [83.8.198.152])
        by mx.google.com with ESMTPS id a18sm663615faa.6.2011.07.15.02.12.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jul 2011 02:12:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6F9CGgf013590;
	Fri, 15 Jul 2011 11:12:22 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6F9Bt73013585;
	Fri, 15 Jul 2011 11:11:55 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177193>

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Thu, Jul 14, 2011 at 1:31 PM, Jeff King <peff@peff.net> wrote:
> >
> > However, I'm not 100% convinced leaving generation numbers out was a
> > mistake. The git philosophy seems always to have been to keep the
> > minimal required information in the DAG.
> 
> Yes.
> 
> And until I saw the patches trying to add generation numbers, I didn't
> really try to push adding generation numbers to commits (although it
> actually came up as early as July 2005, so the "let's use generation
> numbers in commits" thing is *really* old).
> 
> In other words, I do agree that we should strive for minimal required
> information.
> 
> But dammit, if you start using generation numbers, then they *are*
> required information. The fact that you then hide them in some
> unarchitected random file doesn't change anything! It just makes it
> ugly and random, for chrissake!
> 
> I really don't understand your logic that says that the cache is
> somehow cleaner. It's a random hack! It's saying "we don't have it in
> the main data structure, so let's add it to some other one instead,
> and now we have a consistency and cache generation problem instead".

You store redundant information, one that is used to speed up
calculations, in a cache.
 
[...]
> > Generation numbers are _completely_ redundant with the actual structure
> > of history represented by the parent pointers.

What is more important the perceived structure of history can change
by three mechanisms:

 * grafts
 * replace objects
 * shallow clone

I can understand that you don't want to worry about grafts - they are
a terrible hack.  We can simply turn off using generation numbers
stored in commit if they are present.

The problem with shallow clones is only at beginning, when some of
commits in shallow repository does not have generation numbers.  You
cannot simply calculate generation number for a new commit in such
case.

But what about REPLACE OBJECTS?  If one for example use "git replace"
on root commit to join contemporary repository with historical
repository... this is not addressed in your emails.


And let's not forget the fact that we need cache for old commits which
don't have yet generation number in a commit.


BTW. you are not fair comparing size of code.  

First, some of Peff code is about _using_ generation numbers, which
will be needed regardless of whether generation numbers are stored in
cache or packfile index, or whether they are embedded in commit
objects.

Second, with generation number commit header you need to write fsck
code, and have to consider size of this yet-to-be-written code.

[...]
> > I liken it somewhat to the "don't store renames" debate.
> 
> That's total and utter bullshit.

I think Peff meant here that if you make mistakes in calculating
rename info or generation number, and have incorrect information
stored in commit object, you are f**ked.
 
> Storing renames is *wrong*. I've explained a million times why it's
> wrong. Doing it is a disaster. I know. I've used systems that did it.
> It's crap. It's fundamentally information that is actively misleading
> and WRONG. It's not even that you can do rename detection at run-time,
> it's that you *HAVE* to do rename detection at run-time, because doing
> it at commit time is simply utterly and fundamentally *wrong*.
> 
> Just look at "git blame -C" to remind yourself why rename information is wrong.

Also doing full code movement and copying detection (that is what "git
blame -C" does) rather than simplistic whole-file rename detection is
pretty much impossible at commit time.

Nb. most SCMs that use path-id based rename tracking require that user
explicitly marks renames using "scm move" or "scm rename" (well,
Mercurial has a tool for rename detection before commit, "hg
addremove").  But asking user to mark code movements is simply
infeasible.
 
> But even more importantly, look at git merges. Look at how git has
> gotten merging right since pretty much day #1, and has absolutely no
> issues with files that got generated two different ways. Look at every
> SCM that tries to do rename detection, and look at how THEY CANNOT DO
> MERGES RIGHT.
> 
> It's that simple. Rename detection is not about avoiding "redundant
> data". It's about doing the right thing.

Well, rename tracking supporters say that heuristic rename detection
can be wrong.


By the way, what happened to "wholesame directory rename detection"
patches?  Without them in the situation where one side renamed
directory, and other created new file in said directory git on merge
creates file in re-created old name of directory...

-- 
Jakub Narebski
Poland
