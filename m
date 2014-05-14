From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 01/17] contrib: remove outdated README
Date: Wed, 14 May 2014 18:28:18 -0500
Message-ID: <5373fc12bc5e4_7411589304eb@nysa.notmuch>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
 <1399662703-355-2-git-send-email-felipe.contreras@gmail.com>
 <xmqqbnv6yb9l.fsf@gitster.dls.corp.google.com>
 <536d4e7ba8ea_585ea5308a9@nysa.notmuch>
 <CACPiFCKoegOj+dxAw87UgrrwrvPSDoFzyxZV1bEPNseiK2M7vw@mail.gmail.com>
 <xmqqsiodo7o6.fsf@gitster.dls.corp.google.com>
 <53726a577d6aa_4aa4b312f862@nysa.notmuch>
 <xmqqegzxmlsr.fsf@gitster.dls.corp.google.com>
 <CACPiFCKpx9e-swWW4KEfY9YkG7s0uPTs_aftV-NbXGkvMqtf-A@mail.gmail.com>
 <53729ccf26bb0_34aa9e53047f@nysa.notmuch>
 <CAGK7Mr63X3+XXuRUEcBwwnwrOrbip8VUebtL-tM3R8PYBPEXuQ@mail.gmail.com>
 <5373c56c5c531_56d6e3b30449@nysa.notmuch>
 <xmqq38gcjcuw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 01:39:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkild-0003IE-ON
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 01:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbaENXjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 19:39:18 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:54536 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbaENXjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 19:39:16 -0400
Received: by mail-oa0-f42.google.com with SMTP id j17so349772oag.1
        for <git@vger.kernel.org>; Wed, 14 May 2014 16:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=IIN7eiYwkb/VVvrRhO+nhsz/asNBE9CWyu11T0guArc=;
        b=hf4Un2RRGOwXRAC/o0RlQrzBGs8Gjlw3XhCqCfQu8VsR2Aj8eba70ZQwhFgq9wxmlo
         cDZW0WYY3b2Z5+zCGPUhCJFZuyiUndM2xUT0EdInPV8XdH5il525eZ1Ij33pJiVwH/hl
         PcJVpJNRWeV/Eocd1Ef/52unYp+V8lYS57SkXN6d8ntKNlQTN7alkubw6zPeDFGBYIAd
         2CyFSvJkwv2TGzw9Pd/5o/rZjoQy9N0E2IVID4q/mBwiLdUp0+wH4icVjKjfYbaCz3Nj
         KEVS3QCVmaAYeVCu8tKWpOsOuC76mMjvpbC3OEUM11n7y1P8aFsCepMzqDeNQ9aif4T+
         VD/Q==
X-Received: by 10.182.58.83 with SMTP id o19mr6655977obq.26.1400110756096;
        Wed, 14 May 2014 16:39:16 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id fj9sm11055882oeb.6.2014.05.14.16.39.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 May 2014 16:39:15 -0700 (PDT)
In-Reply-To: <xmqq38gcjcuw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249048>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > Junio never explained his *TECHNICAL* reason, and Michael Haggerty
> > simply said "there are good technical arguments for and against
> > moving git-remote-hg out of contrib", that was all his explanation for
> > the *TECHNICAL* reason.

> I am not interested in distinction between technical and social that
> much.  The points that were raised in the thread started by John
> Keeping, and some of the points that came to my mind while on that
> thread, even though I may not have mentioned in *that* thread, that
> affected the way *I* thought about the issue are these (not
> exhaustive):

Let's be clear; the discussion in that thread was contrib vs. core. Most
of the points you mention below are not related to that.

== contrib vs. core ==

This is the only point relevant to contrib vs. core:

>  - We may be painted in a hard place if remote-hg or remote-bzr take
>    us to a position where the Git as a whole is blocked while it is
>    incompatible with the other side.

It will never happen. I already argued against it[1], multiple times.
Essentially making the tests optional removes any possibility of
blockage (pluse many more arguments).

This is the crux of the problem, because as far as I know, it's the only
suppsed argument against contrib vs. core. An argument very weak and
already refuted.

I repeatedly asked Junio to clarify his reasoning, because it can't
possibly be that this is the only reason, and that's the full rationale.

If this is it. Then it's very clear: core wins.

== bundle vs. unbundle ==

The rest of the arguments are *not* related to contrib vs. core. They
are a red herring, but I'll answer anyway.

>  - A remote-helper has to depend on both sides.  Keeping it in
>    either contrib/ or in core, as opposed to unbundling, may make
>    things easier for the remote-helper maintainer, because at least
>    it would allow the helper to advance with Git in lock-step (but I
>    never heard that you do not prefer unbundling for this reason).

I am the maintainer I told you that wasn't the way to go and I'm telling
you again.

>  - In a longer term, a properly maintained remote-helpers should
>    work with wide varieties of Git and the remote system versions
>    anyway, so unbundling would be logically the more "correct" thing
>    to do.

I already argued against this (and so did you[2]); the same argument
applies to git-p4, git-cvs, git-svn, git-archimport, etc.

We are not seeing efforts to unbundle those. Why? Because it would be
detrimental to our users, for many reasons, starting by the fact that
there's no good visibility of out-of-tree tools.

>  - Unbundling would make it less easier to use the remote-helpers
>    for people who are used to keep up with my tree and pick them up
>    from contrib/, but that is a tiny minority these days.  Most
>    people use what distros package, and the distros that already
>    package contrib/ remote-helpers will switch their upstream to
>    unbundled repositories in order not to regress their packages for
>    their users.

That is not true. Distributions mostly put everything in contrib/ into
/usr/share/git without much care about what does what. If something is
missing the users might notice, but the packages wouldn't. It would
require different packagers that care to create the new packages, if it
happens at all. The new packages might be created in a ppa, or some
other third-party place not very visible.

If proper packages manage to end up in the main distribution
repositories, it will take a long time, and in the meantime users will
be left with a bad taste in their mouth.

It will take even more time if these tools remain in contrib/ because
nobody will notice anything, until bugs start to pile up.

>  - On the other hand, unbundling will make it easier for the the
>    end-users (both the ones who are fed distro packaged versions and
>    the ones who build from the source _and_ who overcome the "less
>    easier because now they have to pull from not just me but from
>    the unbundled places" inconvenience) to keep up with the
>    leading/bleeding edge, because the remote-helpers do not have to
>    freeze at the same time other parts of Git are frozen before the
>    release, and users and distros can pick improved remote-helpers
>    up and even "mix and match", when they have some other reason
>    that prevents them from updating Git itself.

Users don't care much about being on the bleeding edge. They care that
their tools keep working and in the same way. For that it's more
important that the maintainers have as many eyes as possible no the
patches. And sending the patches on git@vger.kernel.org has certain
helped in that regard. You want to take that away from them.

Additionally, they care that the tools are easy to set up. Being able to
clone Mercurial repositories from an out-of-the-box version of Git is
much more important to them than being "on the bleeding edge".

Plus this also applies got git-p4, git-cvs, git-svn, etc. It's not a
good argument for them, and it's not a good argument for
git-remote-hg/bzr either.

>  - Unbundling would also involve the risk of making them obscure,
>    and the original reason why we added contrib/ area to host
>    "having something is often better than having nothing" tools,
>    even if some of them were of lessor quality, was exactly that.
>    While building the momentum and the Git community, it was
>    necessary to have a nursery.  That reasoning no longer applies
>    these days, and we have seen examples of third-party independent
>    products that can improve the users' Git life flourishing.

This is not true. The reasoning behind the contrib/ nursery was
*entirely* so that they could move into the core, just like you said
they would since day one [3]. If they are not going to be part of the
core, all the time in contrib was wasted.

If they had been an out-of-tree project, interest would slowly build up
to the point where separate packages get created and slowly build
popularity.

Instead what we would have is a big breakage in user expectations,
followed by uncertain period of time where the tools are not packaged.
And git-remote-hg/bzr would have to compete with other tools who have
had longer time in the free-market, and thus have more publicity in the
form of blog posts, etc. There's already multiple git-remote-hg and
git-remote-bzr, and it would be hard to explain which is which and why
you would want to use these particular ones. The only salient point
would be that they were once part of the git.git repository, but that
begs the question; why did they got dropped. And the fact that you
haven't been able to provide a good explanation doesn't help.

If on the other hand they become part of the core as was the intention
since day one, none of this would happen, and *everybody* would be happy.

>    "We have less need for a nursery" is not a reason to kick bundled
>    things out that want to be bundled, but it tells us that we no
>    longer have to be afraid of unbundled things dying in obscurity,
>    if there are other reasons that tell us unbundling is better.

Do we no longer have to be afraid of that? WHY? All the responses from
the contrib cleanup patches seem to suggest that pretty much *everyone*
is afraid the contrib tools would die in obscurity if unbundled.

> I may be missing some others, and I would be lying if I did not at
> all think of the "net liability" issue Michael brought up, but the
> above that does not include anything you labelled as "social
> manners" was more or less enough to convince me to say
> 
>     ... and I am inclined to be persuaded that the users of
>     remote-hg/bzr may better off if they are unbundled from my tree.
> 
> in
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/247660/focus=248242

This is a huge distraction and a red herring. The issue discussed never
was bundle vs. unbundle, it was contrib vs. core. After answering the
original issue we could discuss contrib vs. unbundle, or core vs.
unbundle. But you tainted the discussion by deciding on the case bundle
vs. unbundle before it was even discussed, and with no explanation.

The jury is still out in the case core vs. unbundle, and if the best
arguments in favor of unbundle are the ones you just brought up, then
the case is pretty one-sided.

Either way the case is closed, because the judge already passed
veredict, even before there was a chance to bring any arguments.

== Conclusion ==

Do not be fooled. There was only one argument that blocked the
graduation to the core, it was a bad one, and it was refuted pretty
decisevely; remote-hg/bzr should move to the core.

If and when foreign scm tools such as git-p4, git-cvs, git-svn and
git-remote-hg/bzr should move out of the core and be unbundled is a
separate matter that hasn't been discussed yet. When such discussion
happens it should take more than the weak arguments Junio has put forth
in order to determine their faith. And when doing so there should be
measures in place to make sure the transition is as smooth as possible,
like a page that lists these tools, and documentation about the best
practices that these out-of-tree tools should follow (I already argued
for that).

The facts remain clear: Junio made a hasty decision with regards to
git-remote-hg/bzr, which he would *never* do with other tools in exactly
the same position: git-p4, git-svn, etc.

[1] http://article.gmane.org/gmane.comp.version-control.git/248685
[2] http://article.gmane.org/gmane.comp.version-control.git/248156
[3] http://article.gmane.org/gmane.comp.version-control.git/220277

-- 
Felipe Contreras
