From: Junio C Hamano <gitster@pobox.com>
Subject: A note from the maintainer
Date: Fri, 12 Feb 2010 17:24:16 -0800
Message-ID: <7vk4ui6i7z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 02:24:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng6kI-0007iq-8v
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 02:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437Ab0BMBYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 20:24:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249Ab0BMBYW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 20:24:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B92E99D8A;
	Fri, 12 Feb 2010 20:24:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=j67d
	TRSQOyJaObJn4oon8VgeKTI=; b=f4F0kUByOQ2trZDCYPFGjMcYw7ugp6Sk+JaU
	wuiqYAsU5ZPjquUWoZPRSsVp5fVFd9U0IYHYoIixSBEmXVn/ZHLY0wi2Lkt7A7FC
	lT4agfbU7ZspJNjSrQyKbA8ef4c+kPBqYPxH1bw9IgmipFlvUuR7iv5j6/XO304a
	x5Bz+iU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Ew9
	JTSM2u601QPM/j5ZLTGYO9iebimQPbs0In71J/gatAkRumSv/Qi16NWjfhxDfR4r
	AsxNJ/Ar1MSMHGAVzpRBaTjH2xSiM4rveZIZB9J3vuSOclign3Zfpqp8YF0cQpC7
	M68/sjfnn3KW6YvhPg2vSBjVjxddjLV+/gHm263g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5696799D86;
	Fri, 12 Feb 2010 20:24:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2340D99D85; Fri, 12 Feb
 2010 20:24:17 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 82A3F2BE-183E-11DF-A223-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139768>

Welcome to git development community.

This message is written by the maintainer and talks about how Git
project is managed, and how you can work with it.

* IRC and Mailing list

Members of the development community can sometimes be found on #git
IRC channel on Freenode.  Its log is available at:

        http://colabti.org/irclogger/irclogger_log/git

The development is primarily done on the Git mailing list If you have
patches, please send them to the list address (git@vger.kernel.org).
following Documentation/SubmittingPatches.  You don't have to be
subscribed to send messages there, and the convention is to Cc:
everybody involved, so you don't even have to say "Please Cc: me, I am
not subscribed".

If you sent a patch and you did not hear any response from anybody for
several days, it could be that your patch was totally uninteresting, but
it also is possible that it was simply lost in the noise.  Please do not
hesitate to send a reminder message politely in such a case.  Messages
getting lost in the noise is a sign that people involved don't have enough
mental/time bandwidth to process them right at the moment, and it often
helps to wait until the list traffic becomes calmer before sending such a
reminder.

The list archive is available at a few public sites as well:

        http://news.gmane.org/gmane.comp.version-control.git/
        http://marc.theaimsgroup.com/?l=git
        http://www.spinics.net/lists/git/

and some people seem to prefer to read it over NNTP:

        nntp://news.gmane.org/gmane.comp.version-control.git

When you point at a message in a mailing list archive, using
gmane is often the easiest to follow by readers, like this:

        http://thread.gmane.org/gmane.comp.version-control.git/27/focus=217

as it also allows people who subscribe to the mailing list as
gmane newsgroup to "jump to" the article.

* Repositories, branches and documentation.

My public git.git repository is at:

        git://git.kernel.org/pub/scm/git/git.git/

Immediately after I publish to the primary repository at kernel.org, I
also push into an alternate here:

        git://repo.or.cz/alt-git.git/

Impatient people might have better luck with the latter one.

Their gitweb interfaces are found at:

        http://git.kernel.org/?p=git/git.git
        http://repo.or.cz/w/alt-git.git

There are three branches in git.git repository that are not about the
source tree of git: "todo", "html" and "man".  The first one was meant to
contain TODO list for me, but I am not good at maintaining such a list and
it is in an abandoned state.  The branch mostly is used to keep some
helper scripts I use to maintain git and the regular "What's cooking"
messages these days.

The "html" and "man" are autogenerated documentation from the tip of the
"master" branch; the tip of "html" is extracted to be visible at
kernel.org at:

        http://www.kernel.org/pub/software/scm/git/docs/

The above URL is the top-level documentation page, and it has
links to documentation of older releases.

The script to maintain these two documentation branches are found in the
"todo" branch as dodoc.sh, if you are interested.  It is a demonstration
of how to use a post-update hook to automate a task after pushing into a
repository.

There are four branches in git.git repository that track the source tree
of git: "master", "maint", "next", and "pu".  I may add more maintenance
branches (e.g. "maint-1.6.3") if we have hugely backward incompatible
feature updates in the future to keep an older release alive; I may not,
but the distributed nature of git means any volunteer can run a
stable-tree like that herself.

The "master" branch is meant to contain what are very well tested and
ready to be used in a production setting.  There could occasionally be
minor breakages or brown paper bag bugs but they are not expected to be
anything major, and more importantly quickly and trivially fixable.  Every
now and then, a "feature release" is cut from the tip of this branch and
they typically are named with three dotted decimal digits.  The last such
release was 1.7.0 done on Feb 12, 2010.  You can expect that the tip of
the "master" branch is always more stable than any of the released
versions.

Whenever a feature release is made, "maint" branch is forked off from
"master" at that point.  Obvious, safe and urgent fixes after a feature
release are applied to this branch and maintenance releases are cut from
it.  The maintenance releases are named with four dotted decimal, named
after the feature release they are updates to; the last such release was
1.6.6.2.  New features never go to this branch.  This branch is also
merged into "master" to propagate the fixes forward.

A trivial and safe enhancement goes directly on top of "master".  A new
development, either initiated by myself or more often by somebody who
found his or her own itch to scratch, does not usually happen on "master",
however.  Instead, a separate topic branch is forked from the tip of
"master", and it first is tested in isolation; I may make minimum fixups
at this point.  Usually there are a handful such topic branches that are
running ahead of "master" in git.git repository.  I do not publish the tip
of these branches in my public repository, however, partly to keep the
number of branches that downstream developers need to worry about low, and
primarily because I am lazy.

The quality of topic branches are judged primarily by the mailing list
discussions.  Some of them start out as "good idea but obviously is broken
in some areas (e.g. breaks the existing testsuite)" and then with some
more work (either by the original contributor's effort or help from other
people on the list) becomes "more or less done and can now be tested by
wider audience".  Luckily, most of them start out in the latter, better
shape.

The "next" branch is to merge and test topic branches in the latter
category.  In general, the branch always contains the tip of "master".  It
might not be quite rock-solid production ready, but is expected to work
more or less without major breakage.  I usually use "next" version of git
for my own work, so it cannot be _that_ broken to prevent me from
integrating and pushing the changes out.  The "next" branch is where new
and exciting things take place.

The two branches "master" and "maint" are never rewound, and "next"
usually will not be either (this automatically means the topics that have
been merged into "next" are usually not rebased, and you can find the tip
of topic branches you are interested in from the output of "git log
next"). You should be able to safely build on top of them.

After a feature release is made from "master", however, "next" will be
rebuilt from the tip of "master" using the surviving topics.  The commit
that replaces the tip of the "next" will usually have the identical tree,
but it will have different ancestry from the tip of "master".

The "pu" (proposed updates) branch bundles all the remainder of topic
branches.  The "pu" branch, and topic branches that are only in "pu", are
subject to rebasing in general.  By the above definition of how "next"
works, you can tell that this branch will contain quite experimental and
obviously broken stuff.

When a topic that was in "pu" proves to be in testable shape, it graduates
to "next".  I do this with:

        git checkout next
        git merge that-topic-branch

Sometimes, an idea that looked promising turns out to be not so good and
the topic can be dropped from "pu" in such a case.

A topic that is in "next" is expected to be polished to perfection before
it is merged to "master" (that's why "master" can be expected to stay more
stable than any released version).  Similarly to the above, I do it with
this:

        git checkout master
        git merge that-topic-branch
        git branch -d that-topic-branch

Note that being in "next" is not a guarantee to appear in the next release
(being in "master" is such a guarantee, unless it is later found seriously
broken and reverted), nor even in any future release.  There even were
cases that topics needed reverting a few commits in them before graduating
to "master", or a topic that already was in "next" were entirely reverted
from "next" because fatal flaws were found in them later.


* Other people's trees, trusted lieutenants and credits.

Documentation/SubmittingPatches outlines to whom your proposed changes
should be sent.  As described in contrib/README, I would delegate fixes
and enhancements in contrib/ area to the primary contributors of them.

Although the following are included in git.git repository, they have their
own authoritative repository and maintainers:

 - git-gui/ comes from Shawn Pearce's git-gui project:

        git://repo.or.cz/git-gui.git

 - gitk-git/ comes from Paul Mackerras's gitk project:

        git://git.kernel.org/pub/scm/gitk/gitk.git

I would like to thank everybody who helped to raise git into the current
shape.  Especially I would like to thank the git list regulars whose help
I have relied on and expect to continue relying on heavily:

 - Linus on general design issues.

 - Linus, Shawn Pearce, Johannes Schindelin, Nicolas Pitre, Ren$BC)(B
   Scharfe, Jeff King and Johannes Sixt on general implementation
   issues.

 - Shawn and Nicolas Pitre on pack issues.

 - Martin Langhoff and Frank Lichtenheld on cvsserver and cvsimport.

 - Paul Mackerras on gitk.

 - Eric Wong on git-svn.

 - Simon Hausmann on git-p4.

 - Jakub Narebski, Petr Baudis, Luben Tuikov, Giuseppe Bilotta on
   gitweb.

 - J. Bruce Fields on documentation (and countless others for
   proofreading and fixing).

 - Alexandre Julliard on Emacs integration.

 - Charles Bailey for taking good care of git-mergetool (and Theodore
   Ts'o for creating it in the first place).

 - David Aguilar for git-difftool.

 - Johannes Schindelin, Johannes Sixt and others for their effort to
   move things forward on the Windows front.

 - People on non-Linux platforms for keeping their eyes on
   portability; especially, Randal Schwartz, Theodore Ts'o, Jason
   Riedy, Thomas Glanzmann, Brandon Casey, Jeff King, Alex Riesen and
   countless others.

* This document

The latest copy of this document is found in git.git repository,
on 'todo' branch, as MaintNotes.
