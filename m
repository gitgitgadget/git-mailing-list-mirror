From: Junio C Hamano <gitster@pobox.com>
Subject: A note from the maintainer
Date: Tue, 04 Oct 2011 19:22:58 -0700
Message-ID: <7vr52s9ny5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 04:23:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBH8g-0002Wn-Ii
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 04:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934004Ab1JECXF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 22:23:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65045 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932820Ab1JECXC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 22:23:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 185496998;
	Tue,  4 Oct 2011 22:23:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=L55FxzXSVUTKmrr/kNRhPMywg
	9U=; b=MGNrhaUqgrcXGlKq95GxlKRPACAvdPSriSkcJyLuiwPyqOYpxllerwkq6
	iqnxE5Qp1WPccYB/JhbUq14wpSoX1K5+MNGh1GRp7MwsidpjiccBZ7JEaEvOZ+4H
	1F2HfwLT2TGj8K6ZkTCYxQAQ6aOqCqCASDHIUyrG9v3Jp2QMiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=PlL9pFVPKcxY3EkGkb/
	n+Pr3zBBIYulY/KuPB0tt3knnWfnF5jrpPtWTxvVi8i2kGKB3S7dt5Zo3mlX7oCF
	N9aXvqKPfhVX/baBv8HiwegNYvmq4Y42do/IULspuEQlru18qS/KVPntDEmG+ZKb
	hbMvLv3k1gBNX/cS8FJS7uDM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D64B6997;
	Tue,  4 Oct 2011 22:23:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07F3E6996; Tue,  4 Oct 2011
 22:22:59 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1FEFC02-EEF8-11E0-9DF1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182819>

Welcome to git development community.

This message is written by the maintainer and talks about how Git
project is managed, and how you can work with it.

* Mailing list and the community

The development is primarily done on the Git mailing list. Help
requests, feature proposals, bug reports and patches should be sent to
the list address <git@vger.kernel.org>.  You don't have to be
subscribed to send messages.  The convention on the list is to keep
everybody involved on Cc:, so it is unnecessary to ask "Please Cc: me,
I am not subscribed".

Before sending patches, please read Documentation/SubmittingPatches
and Documentation/CodingGuidelines to familiarize yourself with the
project convention.

If you sent a patch and you did not hear any response from anybody for
several days, it could be that your patch was totally uninteresting,
but it also is possible that it was simply lost in the noise.  Please
do not hesitate to send a reminder message in such a case.  Messages
getting lost in the noise is a sign that people involved don't have
enough mental/time bandwidth to process them right at the moment, and
it often helps to wait until the list traffic becomes calmer before
sending such a reminder.

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

as it also allows people who subscribe to the mailing list as gmane
newsgroup to "jump to" the article.

Some members of the development community can sometimes also be found
on the #git IRC channel on Freenode.  Its log is available at:

        http://colabti.org/irclogger/irclogger_log/git

* Reporting bugs

When you think git does not behave as you expect, please do not stop yo=
ur
bug report with just "git does not work".  "I tried to do X but it did =
not
work" is not much better, neither is "I tried to do X and git did Y, wh=
ich
is broken".  It often is that what you expect is _not_ what other peopl=
e
expect, and chances are that what you expect is very different from wha=
t
people who have worked on git have expected (otherwise, the behavior
would have been changed to match that expectation long time ago).

Please remember to always state

 - what you wanted to do;

 - what you did (the version of git and the command sequence to reprodu=
ce
   the behavior);

 - what you saw happen;

 - what you expected to see; and

 - how the last two are different.

See http://www.chiark.greenend.org.uk/~sgtatham/bugs.html for further
hints.

* Repositories, branches and documentation.

My public git.git repository is at:

        git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git
	https://github.com/git/git
	https://code.google.com/p/git-core/

Impatient people might have better luck with the latter two (there are =
a
few other mirrors I push into at sourceforge and github as well).

Their gitweb interfaces are found at:

        http://git.kernel.org/?p=3Dgit/git.git
        http://repo.or.cz/w/alt-git.git

There are three branches in git.git repository that are not about the
source tree of git: "html", "man", and "todo".

The "html" and "man" are preformatted documentation from the tip of
the "master" branch; the tip of "html" is visible at:

        http://www.kernel.org/pub/software/scm/git/docs/
	http://git-core.googlecode.com/git-history/html/git.html

The above URL is the top-level documentation page, and it may have
links to documentation of older releases.

The "todo" branch was originally meant to contain a TODO list for me,
but is mostly used to keep some helper scripts I use to maintain git.
=46or example, the script that was used to maintain the two documentati=
on
branches are found there as dodoc.sh, which may be a good demonstration
of how to use a post-update hook to automate a task after pushing into =
a
repository.

There are four branches in git.git repository that track the source tre=
e
of git: "master", "maint", "next", and "pu".

The "master" branch is meant to contain what are very well tested and
ready to be used in a production setting.  Every now and then, a "featu=
re
release" is cut from the tip of this branch and they typically are name=
d
with three dotted decimal digits.  The last such release was 1.7.7 done=
 on
Sept 30, 2011. You can expect that the tip of the "master" branch is al=
ways
more stable than any of the released versions.

Whenever a feature release is made, "maint" branch is forked off from
"master" at that point.  Obvious, safe and urgent fixes after a feature
release are applied to this branch and maintenance releases are cut fro=
m
it.  The maintenance releases are named with four dotted decimal, named
after the feature release they are updates to; the last such release wa=
s
1.7.6.4.  New features never go to this branch.  This branch is also
merged into "master" to propagate the fixes forward.

A new development does not usually happen on "master". When you send a
series of patches, after review on the mailing list, a separate topic
branch is forked from the tip of "master" and your patches are queued
there, and kept out of "master" while people test it out.  The quality =
of
topic branches are judged primarily by the mailing list discussions.

Topic branches that are in good shape are merged to the "next" branch. =
In
general, the "next" branch always contains the tip of "master".  It mig=
ht
not be quite rock-solid production ready, but is expected to work more =
or
less without major breakage. The "next" branch is where new and excitin=
g
things take place. A topic that is in "next" is expected to be polished=
 to
perfection before it is merged to "master" (that's why "master" can be
expected to stay more stable than any released version).

The "pu" (proposed updates) branch bundles all the remaining topic
branches. The topics on the branch are not complete, well tested, nor w=
ell
documented and need further work. When a topic that was in "pu" proves =
to
be in testable shape, it is merged to "next".

You can run "git log --first-parent master..pu" to see what topics are
currently in flight.  Sometimes, an idea that looked promising turns ou=
t
to be not so good and the topic can be dropped from "pu" in such a case=
=2E

The two branches "master" and "maint" are never rewound, and "next"
usually will not be either.  After a feature release is made from
"master", however, "next" will be rebuilt from the tip of "master"
using the topics that didn't make the cut in the feature release.

Note that being in "next" is not a guarantee to appear in the next
release, nor even in any future release.  There were cases that topics
needed reverting a few commits in them before graduating to "master",
or a topic that already was in "next" was reverted from "next" because
fatal flaws were found in it after it was merged.


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

 - Linus Torvalds, Shawn Pearce, Johannes Schindelin, Nicolas Pitre,
   Ren=C3=A9 Scharfe, Jeff King, Jonathan Nieder, Johan Herland, Johann=
es
   Sixt, Sverre Rabbelier, Michael J Gruber, Nguy=E1=BB=85n Th=C3=A1i N=
g=E1=BB=8Dc Duy,
   =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason and Thomas Rast on general de=
sign and
   implementation issues and reviews on the mailing list.

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
