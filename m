From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 07 May 2014 20:09:52 -0500
Message-ID: <536ad9601b73b_3caaa612ecdc@nysa.notmuch>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
 <536a83097302f_76ff7a52ec6c@nysa.notmuch>
 <xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
 <536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
 <xmqqoaz95ees.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	=?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>,
	Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 03:20:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiD0w-0002w2-L3
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 03:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbaEHBUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 21:20:43 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:65110 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbaEHBUm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 21:20:42 -0400
Received: by mail-ob0-f170.google.com with SMTP id uy5so2216321obc.15
        for <git@vger.kernel.org>; Wed, 07 May 2014 18:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ZsHeMNgtqlZdegG7fsewsurAkro1IX0dfX7Odzf+WOM=;
        b=oDsewXq15KdEFnrrs6KyTgUIkN8lKMDkgDSM/uIbEKOfAU/dprs905YFqjdDJCOQae
         tYQgNqMMncCxxr3tnr685HyDIX6nk1BgwzsxoaREiT9P4GkmMNLoyRmH3Cn83YiA3gMb
         UtKKnQwUi9jILzuo87E12CvbwMtQRnuBnccJNcri3wQI/AUWEmYXjOksB4Wic+st6Ltt
         kt2+ApA3FLPyKiK6cT/Ly6vxKedwVgK9vhLRfkCoSFQIe7luMLVjQtRJcxk1CE7Ft7kc
         7f/KCws5qbeOpsCa+uNhQB/qpJEKKDBCm1UXgzAkHtK5XXoTIVRGRf1V1KaYd7o1mBM2
         AISw==
X-Received: by 10.182.66.170 with SMTP id g10mr360059obt.49.1399512041963;
        Wed, 07 May 2014 18:20:41 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id y10sm37966428obk.4.2014.05.07.18.20.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 May 2014 18:20:40 -0700 (PDT)
In-Reply-To: <xmqqoaz95ees.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248396>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > And you are still conveniently avoiding the question:
> >
> > Based on what reasoning?
> 
> Go re-read what was already said in the thread.

I already read it, and I already responded.

> I still think remote-hg and remote-bzr can and will flourish on their
> own merit,

Oh, you *think*. Well, what if you are wrong?

Or is that never a possibility? You are always right. Right?

> Having said that, I've been thinking (not because of this thread,
> but because I like imerge better and better these days) that there
> should be a much better way to have a list of recommended third-party
> plug-ins that enrich the Git ecosystem.

If and when such a mechanism exists, sure, it makes sense to move
functionality like git-p4 and git-remote-hg out of the core and contrib
areas.

But in the meantime what is ready for the core should be in the core.

> > Normally I would explain the details of why this is the case, and send
> > the crash regresion fix for v2.0 with a clear explanation,...
> 
> Without such an explanation in the log message, how would you expect
> anybody to guess correctly?

I don't. I told you it wasn't a mistake. If that's not enough for you,
that's *your* problem.

*If* git-remote-hg was to be part of the core, then sure, I would care
that you didn't understand why the patch is correct, and I would resend
immediately what a clear explanation.

But since it's only part of the contrib area which has such abundant
crap without documentation or tests. I do not care.

> Seriously, if you do not care about my first reaction, why do you
> even want to live in my tree?

As I already explained; I don't care about your reaction *because* you
don't want these tools to live in your tree.

> > The fact that I'm the maintainer and I say it'ss good should be good
> > enough, and if the current version in "master" renders unusable the
> > existing Mercurial clones, hey, it's only in contrib, right?
> 
> One potential merit I would see for keeping them in my tree is that
> your change will see second opinions from others involved in the
> project (including me), without giving a total rein based on the
> sub-maintainership alone.  All the changes from sub-area maintainers
> are vetted by at least two sets of eyeballs that way.
> 
> But after having to deal with you and seeing that you do not take
> constructive criticism well,

Oh, please. Up to the point where you decided unilaterally to move them
out of the core (they are alread in), all the constructive criticism to
git-remote-hg has been addressed properly.

I have spent an absurdely large amount of time working on git-remote-hg,
and the transport-helper to make sure everything works right. I even started
git-remote-bzr just to prove that the Python git_remote_helpers
framework was not needed, and eventually I made it work better than any
of the alternatives. I had to fight tooth-and-nail to prove that the
msysgit guys were wrong and my patch to handle UNINTERESTING refs
properly was right. Not to mention all the tests, the compatibility with
hg-git, and with gittifyhg, just to prove that my approach was superior
than the alternatives.

I addressed every issue reported constructively, every bug report was
fixed, every patch reviewed and usually improved by me. I made sure
users of older versions wouldn't be affected negatively when the marks
file was upgraded, and I even setup automatic tests for different
versions Bazaar and Mercurial that run every time I push to my
repository.

It is *way* beyond the quality of any other tool in 'contrib/' and even
some tools in the core, like 'git-request-pull' (which has known bugs),
and probably even 'git-pt'.

Even you agreed it would be beneficial to move them out of contrib; it
would benefit *everyone*. And there was no reason not to.

And then some random guy comes with a few bad arguments, and you change
your mind.

That's f*cking double standards. Pure and simple.

If git-remote-hg belongs out-of-tree, so does git-svn and git-p4. If
git-remote-hg belongs in the contrib area, so does git-svn, and git-p4.

After all this insane amout of work you are acting as if git-remote-hg
wasn't ready to move to the core, because I didn't explain *one* commit
properly to you (which happened after this bullshit).

If these helpers are not going to move forward why would I care? Give me
why one good reason why I should give a flying f*ck about the state of
remote-helpers in *your* tree after this (and BTW as things stand now,
it's not good).

It was *your* users who urged me to send my patches upstream.

> I doubt such a possibile merit will ever materialize in the area where
> you alone work on.

And there it is. Ad hominem rationale.

> Letting you do whatever you want in your own tree may benefit the
> users of remote-hg/remote-bzr better as the (bitter) second best
> option.

If and when there is a mechanism promoting out-of-tree tools, that
might be the case.

In the meantime virtually every tool that is worth using lives in
git.git and is distributed by default. Everything else is sub-par in the
minds of Git users.

One tool being dropped from the tree while other tools remain there is
not going to send a positive message to its users.

If you are so confident git-remote-hg would "flourish" out-of-tree, drop
git-p4 and git-svn, see what is the reaction.

-- 
Felipe Contreras
