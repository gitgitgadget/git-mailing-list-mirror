From: Junio C Hamano <gitster@pobox.com>
Subject: A note from the maintainer
Date: Mon, 05 Mar 2012 23:10:28 -0800
Message-ID: <7vr4x6urvf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 08:10:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4oXc-000448-QM
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 08:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756946Ab2CFHKc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 02:10:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60398 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205Ab2CFHKb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 02:10:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D82731C8;
	Tue,  6 Mar 2012 02:10:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=ERIS1se2Wx2PHga4iF+7QeixP
	pI=; b=g4lJBIc72d3GrAGpzRVHol7bfQY8jRXTh7WxlDVL2cujskSyl01jWvqIu
	SISfffKPkaQxQYqy6/I5FklHyZp5D+3n18GNh08MFYiYqwjIcB6tD9BK+0v6Kkqr
	QO4OuSBgCsTTb9pZkWmN50MAmJnIA8n5lt0atir1LmASel/K0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=IJQ1JePRcoLTPWcPP2R
	WeQaP+ysveIh2gxNhxg7ELPuoq9Cif1LyHBS/kM8HCMGh2Jnwx9wkLWoKYTcz0GO
	ZKLTAeBBG/7eE0yyjWoZ290XiC5yOogRMuPY7T1y/lNlE9dFKS6pr2TirxCs/gFn
	QWpX1A7/LjLtIBnDkvJ1ijDw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5513E31C7;
	Tue,  6 Mar 2012 02:10:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8985231C6; Tue,  6 Mar 2012
 02:10:29 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74B82238-675B-11E1-8030-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192305>

Welcome to git development community.

This message is written by the maintainer and talks about how Git
project is managed, and how you can work with it.

* Mailing list and the community

The development is primarily done on the Git mailing list. Help
requests, feature proposals, bug reports and patches should be sent to
the list address <git@vger.kernel.org>.  You don't have to be
subscribed to send messages.  The convention on the list is to keep
everybody involved on Cc:, so it is unnecessary to say "Please Cc: me,
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

The list archive is available at a few public sites:

        http://news.gmane.org/gmane.comp.version-control.git/
        http://marc.theaimsgroup.com/?l=3Dgit
        http://www.spinics.net/lists/git/

=46or those who prefer to read it over NNTP (including the maintainer):

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

When you think git does not behave as you expect, please do not stop
your bug report with just "git does not work".  "I used git in this
way, but it did not work" is not much better, neither is "I used git
in this way, and X happend, which is broken".  It often is that git is
correct to cause X happen in such a case, and it is your expectation
that is broken. People would not know what other result Y you expected
to see instead of X, if you left it unsaid.

Please remember to always state

 - what you wanted to achieve;

 - what you did (the version of git and the command sequence to reprodu=
ce
   the behavior);

 - what you saw happen (X above);

 - what you expected to see (Y above); and

 - how the last two are different.

See http://www.chiark.greenend.org.uk/~sgtatham/bugs.html for further
hints.

* Repositories, branches and documentation.

My public git.git repositories are at:

        git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://github.com/git/git/
	https://code.google.com/p/git-core/
	git://git.sourceforge.jp/gitroot/git-core/git.git/
	git://git-core.git.sourceforge.net/gitroot/git-core/git-core/

A few gitweb interfaces are found at:

        http://git.kernel.org/?p=3Dgit/git.git
        http://repo.or.cz/w/alt-git.git

Preformatted documentation from the tip of the "master" branch can be
found in:

        git://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
        git://repo.or.cz/git-{htmldocs,manpages}.git/
        https://code.google.com/p/git-{htmldocs,manpages}.git/
        https://github.com/gitster/git-{htmldocs,manpages}.git/

You can browse the HTML manual pages at:

	http://git-htmldocs.googlecode.com/git/git.html

There are four branches in git.git repository that track the source tre=
e
of git: "master", "maint", "next", and "pu".

The "master" branch is meant to contain what are very well tested and
ready to be used in a production setting.  Every now and then, a "featu=
re
release" is cut from the tip of this branch and they typically are name=
d
with three dotted decimal digits.  The last such release was 1.7.9 done=
 on
Jan 27, 2012. You can expect that the tip of the "master" branch is alw=
ays
more stable than any of the released versions.

Whenever a feature release is made, "maint" branch is forked off from
"master" at that point.  Obvious, safe and urgent fixes after a feature
release are applied to this branch and maintenance releases are cut fro=
m
it.  The maintenance releases are named with four dotted decimal, named
after the feature release they are updates to; the last such release wa=
s
1.7.9.3.  New features never go to this branch.  This branch is also
merged into "master" to propagate the fixes forward.

A new development does not usually happen on "master". When you send a
series of patches, after review on the mailing list, a separate topic
branch is forked from the tip of "master" and your patches are queued
there, and kept out of "master" while people test it out. The quality o=
f
topic branches are judged primarily by the mailing list discussions.

Topic branches that are in good shape are merged to the "next" branch. =
In
general, the "next" branch always contains the tip of "master".  It mig=
ht
not be quite rock-solid, but is expected to work more or less without m=
ajor
breakage. The "next" branch is where new and exciting things take place=
=2E A
topic that is in "next" is expected to be polished to perfection before=
 it
is merged to "master".

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

 - po/ comes from the localization coordinator, Jiang Xin:

	https://github.com/git-l10n/git-po/

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
   =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason and Thomas Rast for helping w=
ith general
   design and implementation issues and reviews on the mailing list.

 - Shawn and Nicolas Pitre for helping with packfile design and
   implementation issues.

 - Martin Langhoff, Frank Lichtenheld and =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason for
   cvsserver and cvsimport.

 - Paul Mackerras for gitk.

 - Eric Wong, David D. Kilzer and Sam Vilain for git-svn.

 - Simon Hausmann, Pete Wyckoff and Luke Diamond for git-p4.

 - Jakub Narebski, John Hawley, Petr Baudis, Luben Tuikov, Giuseppe
   Bilotta for maintaining and enhancing gitweb.

 - =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason for kicking off the i18n effo=
rt, and Jiang
   Xin for volunteering to be the l10n coordinator.

 - J. Bruce Fields, Jonathan Nieder, Michael J Gruber and Thomas Rast f=
or
   documentation (and countless others for proofreading and fixing).

 - Alexandre Julliard for Emacs integration.

 - David Aguilar and Charles Bailey for taking good care of git-mergeto=
ol
   (and Theodore Ts'o for creating it in the first place) and git-difft=
ool.

 - Johannes Schindelin, Johannes Sixt, Erik Faye-Lund, Pat Thoyts and o=
thers
   for their effort to move things forward on the Windows front.

 - People on non-Linux platforms for keeping their eyes on portability;
   especially, Randal Schwartz, Theodore Ts'o, Jason Riedy, Thomas Glan=
zmann,
   Brandon Casey, Jeff King, Alex Riesen and countless others.
