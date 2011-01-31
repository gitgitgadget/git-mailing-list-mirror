From: Junio C Hamano <gitster@pobox.com>
Subject: A note from the maintainer
Date: Sun, 30 Jan 2011 21:51:37 -0800
Message-ID: <7v4o8paady.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 31 06:51:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjmg2-0005Z8-Rl
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 06:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415Ab1AaFvo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Jan 2011 00:51:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33120 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab1AaFvo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jan 2011 00:51:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A6D92123;
	Mon, 31 Jan 2011 00:52:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=ouxuo2w6qMim3KIHVoXB6vAG4
	mQ=; b=anrwQLq427VaaE56q0LGn1lUiQi3NpHE6n0AuhhlTCXn35sByZlk95xqg
	DI3OU4fcxDTrA1nlqSGMLtO77GyQ+VwcvAupyF7HICunfjnPZKq95M6sJSOW0CgP
	aikR+dOWLsjxNh/zO9yMApJsk4Z/EYb0PL4vDOfXPoQYhnH1h0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=SCjCTMooHQDefXMYZ27
	3fCZn3LIPU3DSz0UFZgHQYH+9jfmY3LYxyJiwrDumqhnPuH/qTL51wf/hqnwZFz4
	+I6AvwFwoo7D9bLxvwmTYMDSxMdKefs/ZHNVVK/og+ycYfulQ1D1FqcK5Sa43DHD
	hVd+xNvX4/M9c6bMOmJeG1gM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6786F2122;
	Mon, 31 Jan 2011 00:52:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 463D62121; Mon, 31 Jan 2011
 00:52:31 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4C42B5B8-2CFE-11E0-976E-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165719>

Welcome to git development community.

This message is written by the maintainer and talks about how Git
project is managed, and how you can work with it.

* IRC and Mailing list

Members of the development community can sometimes be found on #git
IRC channel on Freenode.  Its log is available at:

        http://colabti.org/irclogger/irclogger_log/git

The development is primarily done on the Git mailing list. If you have
patches, please send them to the list address (git@vger.kernel.org).
following Documentation/SubmittingPatches.  You don't have to be
subscribed to send messages there, and the convention is to Cc:
everybody involved, so you don't even have to say "Please Cc: me, I am
not subscribed".

If you sent a patch and you did not hear any response from anybody for
several days, it could be that your patch was totally uninteresting, bu=
t
it also is possible that it was simply lost in the noise.  Please do no=
t
hesitate to send a reminder message politely in such a case.  Messages
getting lost in the noise is a sign that people involved don't have eno=
ugh
mental/time bandwidth to process them right at the moment, and it often
helps to wait until the list traffic becomes calmer before sending such=
 a
reminder.

The list archive is available at a few public sites as well:

        http://news.gmane.org/gmane.comp.version-control.git/
        http://marc.theaimsgroup.com/?l=3Dgit
        http://www.spinics.net/lists/git/

and some people seem to prefer to read it over NNTP:

        nntp://news.gmane.org/gmane.comp.version-control.git

When you point at a message in a mailing list archive, using
gmane is often the easiest to follow by readers, like this:

        http://thread.gmane.org/gmane.comp.version-control.git/27/focus=
=3D217

as it also allows people who subscribe to the mailing list as
gmane newsgroup to "jump to" the article.

* Repositories, branches and documentation.

My public git.git repository is at:

        git://git.kernel.org/pub/scm/git/git.git/

Immediately after I publish to the primary repository at kernel.org, I
also push into an alternate here:

        git://repo.or.cz/alt-git.git/

Impatient people might have better luck with the latter one (there are =
a
few other mirrors I push into at sourceforge and github as well).

Their gitweb interfaces are found at:

        http://git.kernel.org/?p=3Dgit/git.git
        http://repo.or.cz/w/alt-git.git

There are three branches in git.git repository that are not about the
source tree of git: "todo", "html" and "man".  The first one was meant =
to
contain TODO list for me, but I am not good at maintaining such a list =
and
it is in an abandoned state.  The branch mostly is used to keep some
helper scripts I use to maintain git and the regular "What's cooking"
messages these days.

The "html" and "man" are autogenerated documentation from the tip of th=
e
"master" branch; the tip of "html" is extracted to be visible at
kernel.org at:

        http://www.kernel.org/pub/software/scm/git/docs/

The above URL is the top-level documentation page, and it has
links to documentation of older releases.

The script to maintain these two documentation branches are found in th=
e
"todo" branch as dodoc.sh, if you are interested.  It is a demonstratio=
n
of how to use a post-update hook to automate a task after pushing into =
a
repository.

There are four branches in git.git repository that track the source tre=
e
of git: "master", "maint", "next", and "pu".  I may add more maintenanc=
e
branches (e.g. "maint-1.6.3") if we have hugely backward incompatible
feature updates in the future to keep an older release alive; I may not=
,
but the distributed nature of git means any volunteer can run a
stable-tree like that herself.

The "master" branch is meant to contain what are very well tested and
ready to be used in a production setting.  There could occasionally be
minor breakages or brown paper bag bugs but they are not expected to be
anything major, and more importantly quickly and trivially fixable.  Ev=
ery
now and then, a "feature release" is cut from the tip of this branch an=
d
they typically are named with three dotted decimal digits.  The last su=
ch
release was 1.7.4 done on Jan 30, 2011.  You can expect that the tip of
the "master" branch is always more stable than any of the released
versions.

Whenever a feature release is made, "maint" branch is forked off from
"master" at that point.  Obvious, safe and urgent fixes after a feature
release are applied to this branch and maintenance releases are cut fro=
m
it.  The maintenance releases are named with four dotted decimal, named
after the feature release they are updates to; the last such release wa=
s
1.7.3.5.  New features never go to this branch.  This branch is also
merged into "master" to propagate the fixes forward.

A trivial and safe enhancement goes directly on top of "master".  A new
development, either initiated by myself or more often by somebody who
found his or her own itch to scratch, does not usually happen on "maste=
r",
however.  Instead, a separate topic branch is forked from the tip of
"master", and it first is tested in isolation; I may make minimum fixup=
s
at this point.  Usually there are a handful such topic branches that ar=
e
running ahead of "master" in git.git repository.  I do not publish the =
tip
of these branches in my public repository, however, partly to keep the
number of branches that downstream developers need to worry about low, =
and
primarily because I am lazy.

The quality of topic branches are judged primarily by the mailing list
discussions.  Some of them start out as "good idea but obviously is bro=
ken
in some areas (e.g. breaks the existing testsuite)" and then with some
more work (either by the original contributor's effort or help from oth=
er
people on the list) becomes "more or less done and can now be tested by
wider audience".  Luckily, most of them start out in the latter, better
shape.

The "next" branch is to merge and test topic branches in the latter
category.  In general, the branch always contains the tip of "master". =
 It
might not be quite rock-solid production ready, but is expected to work
more or less without major breakage.  I usually use "next" version of g=
it
for my own work, so it cannot be _that_ broken to prevent me from
integrating and pushing the changes out.  The "next" branch is where ne=
w
and exciting things take place.

The two branches "master" and "maint" are never rewound, and "next"
usually will not be either (this automatically means the topics that ha=
ve
been merged into "next" are usually not rebased, and you can find the t=
ip
of topic branches you are interested in from the output of "git log
next"). You should be able to safely build on top of them.

After a feature release is made from "master", however, "next" will be
rebuilt from the tip of "master" using the surviving topics.  The commi=
t
that replaces the tip of the "next" will usually have the identical tre=
e,
but it will have different ancestry from the tip of "master".

The "pu" (proposed updates) branch bundles all the remainder of topic
branches.  The "pu" branch, and topic branches that are only in "pu", a=
re
subject to rebasing in general.  By the above definition of how "next"
works, you can tell that this branch will contain quite experimental an=
d
obviously broken stuff.

When a topic that was in "pu" proves to be in testable shape, it gradua=
tes
to "next".  I do this with:

        git checkout next
        git merge that-topic-branch

Sometimes, an idea that looked promising turns out to be not so good an=
d
the topic can be dropped from "pu" in such a case.

A topic that is in "next" is expected to be polished to perfection befo=
re
it is merged to "master" (that's why "master" can be expected to stay m=
ore
stable than any released version).  Similarly to the above, I do it wit=
h
this:

        git checkout master
        git merge that-topic-branch
        git branch -d that-topic-branch

Note that being in "next" is not a guarantee to appear in the next rele=
ase
(being in "master" is such a guarantee, unless it is later found seriou=
sly
broken and reverted), nor even in any future release.  There even were
cases that topics needed reverting a few commits in them before graduat=
ing
to "master", or a topic that already was in "next" were entirely revert=
ed
from "next" because fatal flaws were found in them later.


* Other people's trees, trusted lieutenants and credits.

Documentation/SubmittingPatches outlines to whom your proposed changes
should be sent.  As described in contrib/README, I would delegate fixes
and enhancements in contrib/ area to the primary contributors of them.

Although the following are included in git.git repository, they have th=
eir
own authoritative repository and maintainers:

 - git-gui/ comes from git-gui project, maintained by Pat Thoyts:

        git://repo.or.cz/git-gui.git

 - gitk-git/ comes from Paul Mackerras's gitk project:

        git://git.kernel.org/pub/scm/gitk/gitk.git

I would like to thank everybody who helped to raise git into the curren=
t
shape.  Especially I would like to thank the git list regulars whose he=
lp
I have relied on and expect to continue relying on heavily:

 - Linus on general design issues.

 - Linus, Shawn Pearce, Johannes Schindelin, Nicolas Pitre, Ren=C3=A9
   Scharfe, Jeff King, Jonathan Nieder, Johan Herland, Johannes Sixt,
   Sverre Rabbelier and Thomas Rast on general implementation issues
   and reviews on the mailing list.

 - Shawn and Nicolas Pitre on pack issues.

 - Martin Langhoff, Frank Lichtenheld and =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason on
   cvsserver and cvsimport.

 - Paul Mackerras on gitk.

 - Eric Wong, David D. Kilzer and Sam Vilain on git-svn.

 - Simon Hausmann and Pete Wyckoff on git-p4.

 - Jakub Narebski, John Hawley, Petr Baudis, Luben Tuikov, Giuseppe Bil=
otta on
   gitweb.

 - J. Bruce Fields, Jonathan Nieder, Michael J Gruber and Thomas Rast o=
n
   documentation (and countless others for proofreading and fixing).

 - Alexandre Julliard on Emacs integration.

 - David Aguilar and Charles Bailey for taking good care of git-mergeto=
ol
   (and Theodore Ts'o for creating it in the first place) and git-difft=
ool.

 - Johannes Schindelin, Johannes Sixt, Erik Faye-Lund and others for th=
eir
   effort to move things forward on the Windows front.

 - People on non-Linux platforms for keeping their eyes on portability;
   especially, Randal Schwartz, Theodore Ts'o, Jason Riedy, Thomas Glan=
zmann,
   Brandon Casey, Jeff King, Alex Riesen and countless others.

* This document

The latest copy of this document is found in git.git repository,
on 'todo' branch, as MaintNotes.
