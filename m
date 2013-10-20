From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: GSoC 2014: Summary so far, discussion starter: how to improve?
Date: Sun, 20 Oct 2013 12:00:01 +0200
Message-ID: <87bo2kdzz2.fsf@gmail.com>
References: <8761stx04i.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Straub <bs@github.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Christian Couder <christian.couder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Edward Thomson <ethomson@microsoft.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Martin Woodward <martin.woodward@microsoft.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Michael Schubert <schu@schu.io>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Philip Kelley <phkelley@hotmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Russell Belfer <rb@github.com>,
	Scott Chacon <schacon@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Vicent =?ut
To: Thomas Rast <tr@thomasrast.ch>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 20 12:00:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXpo8-00023l-DG
	for gcvg-git-2@plane.gmane.org; Sun, 20 Oct 2013 12:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160Ab3JTKAO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Oct 2013 06:00:14 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62713 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab3JTKAM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Oct 2013 06:00:12 -0400
Received: by mail-ie0-f174.google.com with SMTP id qd12so9467541ieb.5
        for <git@vger.kernel.org>; Sun, 20 Oct 2013 03:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        bh=cdlsDYkSIzDupPb9oNUDcU1JoLwNt+Cl8CNA84T19Us=;
        b=tdY6s+KgZHuVOKHbMr+cVRIACwhaBjN9JqOaKuV1JHfG9eYeLA64KkN0T25EwP66sZ
         0V1sMpVpq2uRCYVjgjpcEnYstRIZ6w2b4ciE0abcrreakjq0eb8k0dlASUtXrkcf9oYs
         NqMl4TMK9v3sT8O9rtQo6FTxqaYPmxsIqvsoqbKgqN7z93pTR/fcBML5DuxJwz5/1ZuU
         T1/38xQiea0hmTBUsV/LhsHNlccXJn2yYHMa8Vbm3rNxRXwJS9OIUxAVoPbixreCgkV0
         82gC3YGGoPHe55fx2W+s8ppxC1P+xA9gQcKW0MjK/mD5dTCUW8eUXjYn06FrQU4oPC3p
         FZ7Q==
X-Received: by 10.50.115.5 with SMTP id jk5mr5470647igb.47.1382263211522;
        Sun, 20 Oct 2013 03:00:11 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPSA id w4sm23683084igb.5.2013.10.20.03.00.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2013 03:00:10 -0700 (PDT)
In-Reply-To: <8761stx04i.fsf@linux-k42r.v.cablecom.net>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236417>


As participant in GSoC 2012 I'll mostly respond to this from a student
point of view.

Generally I had a great learning experience with my project.  It was a
great introduction into how the Git project and open source projects in
general work and certainly lowered the barrier to start contributing to
Git.  I was and still am grateful for this experience.

Even though my contributions after the GSoC were very small, I wouldn't
have contributed those patches if I hadn't participated in GSoC before.
That probably doesn't (yet) make up for the work invested in me, but I
certainly hope it will down the line.

Thomas Rast <tr@thomasrast.ch> writes:

> [Unfortunately libgit2 no longer has a mailing list.  I put an arbitr=
ary
> group of libgit2 contributors in the Cc list.]
>
>
> Previous Episodes
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Git participated in Google Summer of Code (GSoC) 2007-2012, but did n=
ot
> participate in 2013 based on discussion in February [1].  At Git-Merg=
e
> in Berlin there was a discussion round [2] that this post attempts to
> summarize as a basis for further discussion and (hopefully)
> participation in GSoC'14.
>
> Much sooner than in previous years, Google has already confirmed that
> GSoC'14 will in fact happen [3].
>
> Note that while mistakes herein are mine, many ideas and opinions
> aren't.  This really tries to be a summary.  Please flame >/dev/null,
> not me.
>
>
> GSoC 2007-2012
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Data presented in [2] shows that roughly half of the projects resulte=
d
> in merged code, and roughly half of the students remained with the Gi=
t
> community significantly after the end of GSoC.  (The sets aren't
> exactly the same.)
>
> A feeling expressed in [1], [2] and elsewhere is that this is not
> enough value for money and effort.  We should therefore discuss how t=
o
> improve.
>
> Note that everyone seems to agree that libgit2 had a much better run
> in GSoC than core git.  There seems to be less agreement on what
> exactly they do differently, though.
>
> Theories
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> These are the hypotheses that I have heard (mostly in [1] and [2]) as
> to what is bad about Git's prior GSoC participations.
>
> * Aiming far too high, focusing on cool/shiny projects with a large
>   impact.  This also affects the students, who tend to cluster around
>   the largest, shiniest project suggestions.

This was mostly why my project wasn't merged, imo.  More complicated
projects generally sound more interesting (to me at least), so I
directly went for one of the more complicated ones.  There were a few
warnings that this might be too complicated along the application
process, but without real previous knowledge of the code base I
overestimated myself and underestimated the project and chose to ignore
all of that.

As some of you may know I'm still working on the project, but my time i=
s
limited so it will take a while for it to bring it to inclusion shape,
if it every will be merged.

> * Diminishing returns: Git is too mature, with little low-hanging
>   fruit left, making such projects harder
>
> * Projects are too political, progress depending on non-technical
>   arguments
>
> * Our mentors suck on various axes, notably not supporting students
>   enough in things that matter:
>   - smooth interaction with community

Especially at first I was reluctant to use the mailing list for
discussions and used the #git-devel irc channel a lot for that.  While =
I
felt these conversations were very fruitful, it would probably have bee=
n
good to send at least a summary email to the list after those
conversations.

>   - ensure fast iteration/short cycles

I think that was quite hard to do with my project, as it was impossible
to split up.  I think this would not only help community interaction,
but would be great for the student too, getting the satisfaction from
getting patches merged early.

>   - navigating the code base

This was the least of my problems, I got good pointers on where to star=
t
from Thomas and others on the irc channel, and help was always availabl=
e
to me, whenever I needed it.

> * Scope creep: projects tend to get blocked on some bigger
>   refactoring/restructuring task that was not in the original proposa=
l
>
>
> Ideas and Suggestions
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> These are mostly from [2].  There were some suggestions that we learn
> from Matthieu Moy's very successful student projects (eg. [4]).
>
> * View GSoC much more as a lot of work than free labor
>
> * Break projects into smaller, easier tasks
>   - They should individually be simple, quick things if the mentor di=
d
>     them.
>   - Should be parallelizable so students don't have to block on revie=
ws.
>
> * Mentoring improvements:
>   - Always have a co-mentor
>   - Focus on social aspects (who to Cc, etc.)
>   - Nominate separate "review mentors" to ensure fast review cycles
>
> * Define explicit criteria
>   - what we want to do
>   - how we judge code and social interactions
>   - when to fail the students
>
> * Have students review some patches
>
>
> Further steps
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> * Discuss :-)
>
>   And then apply this hard-won knowledge systematically.  In
>   particular I think it wouldn't hurt to keep the project proposals
>   out of this thread until we have agreed on goals/standards to
>   measure them against.
>
> * Does libgit2 want to remain under the Git umbrella, or participate
>   on its own?
>
> * Figure out the wiki situation.  In previous years the project
>   proposals and other important information were hosted at k.org [5] =
and
>   github wikis [6].  Other options were floated, such as an official
>   wiki hosted by github.  (This is somewhat of a contentious issue th=
at
>   spans beyond GSoC.)
>
> * Find an org admin and backup.  In previous years Shawn and Peff did
>   this.  Would you do it again?
>
> * Gather a list of potential mentors.
>
>
>
> [1]  http://thread.gmane.org/gmane.comp.version-control.git/216485
> [2]  http://www.youtube.com/watch?v=3DXP4CxUkBPSQ=E2=80=8E
> [3]  http://googleblog.blogspot.ch/2013/10/50-million-lines-of-code-a=
nd-counting.html
> [4]  http://thread.gmane.org/gmane.comp.version-control.git/221159
> [5]  https://git.wiki.kernel.org/index.php/SoC2011Projects
>      similarly for previous years
> [6]  https://github.com/peff/git/wiki/SoC-2012-Ideas
>      https://github.com/trast/git/wiki/SoC-2013-Ideas
>
> --
> Thomas Rast
> tr@thomasrast.ch
