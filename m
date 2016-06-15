From: Junio C Hamano <gitster@pobox.com>
Subject: A note from the maintainer
Date: Fri, 06 Mar 2015 15:33:04 -0800
Message-ID: <xmqq8uf9wuss.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 00:50:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU20U-000574-5C
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 00:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbbCFXtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 18:49:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64190 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932231AbbCFXtm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 18:49:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C1C13FB61;
	Fri,  6 Mar 2015 18:49:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=A
	FRKdIYXZ1QwFt43esroadmD38k=; b=PjXG0QMgilmFcBhDdOOnoXPZsQL6yyFDS
	SnNbzZUaODV9O+UXx7gl6DQ9txG2DwVmmaFsvG7utlvNdaG7xL19W0ZCGhh3Xem9
	Chngt0YDVjj1b4caWDChZ1174gfPpBN5HtOR6ghDyoCQfeO1TpxPAVr3ceukDDCj
	qiSHcjTJFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=yTO
	gwdAzhhs3IKlu/IleiWZFWMGyShQrdvB10SVg51FrsfbLYKmZYXMmNYqL1ylZdJs
	3sBRelmilBZNo9ofrpYC7Lcu10sVDdUCzCM3zCVzA1CZTxIpIWQEBut7d3ssMD9J
	fFy0OmWGqhKVES99ctKZWP1aJHuPDyV9jDwWx6iA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 64EAD3FB60;
	Fri,  6 Mar 2015 18:49:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD7913FB5D;
	Fri,  6 Mar 2015 18:49:40 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 74C23470-C45B-11E4-AC17-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264976>

[note to regular readers; there are a few updated paragraphs,
regarding our association with SFC and also our security mailing
list.]

Welcome to the Git development community.

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
getting lost in the noise may be a sign that those who can evaluate
your patch don't have enough mental/time bandwidth to process them
right at the moment, and it often helps to wait until the list traffic
becomes calmer before sending such a reminder.

The list archive is available at a few public sites:

        http://news.gmane.org/gmane.comp.version-control.git/
        http://marc.theaimsgroup.com/?l=git
        http://www.spinics.net/lists/git/

For those who prefer to read it over NNTP:

        nntp://news.gmane.org/gmane.comp.version-control.git

When you point at a message in a mailing list archive, using
gmane is often the easiest to follow by readers, like this:

        http://thread.gmane.org/gmane.comp.version-control.git/27/focus=217

as it also allows people who subscribe to the mailing list as gmane
newsgroup to "jump to" the article.

Some members of the development community can sometimes be found on
the #git and #git-devel IRC channels on Freenode.  Their logs are
available at:

        http://colabti.org/irclogger/irclogger_log/git
        http://colabti.org/irclogger/irclogger_log/git-devel

Git is a member project of software freedom conservancy, a non-profit
organization (https://sfconservancy.org/).  To reach a committee of
liaisons to the conservancy, contact them at <git@sfconservancy.org>.


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

 - what you did (the version of git and the command sequence to reproduce
   the behavior);

 - what you saw happen (X above);

 - what you expected to see (Y above); and

 - how the last two are different.

See http://www.chiark.greenend.org.uk/~sgtatham/bugs.html for further
hints.

If you think you found a security-sensitive issue and want to disclose
it to us without announcing it to wider public, please contact us at
our security mailing list <git-security@googlegroups.com>.


* Repositories, branches and documentation.

My public git.git repositories are at:

        git://git.kernel.org/pub/scm/git/git.git/
	https://kernel.googlesource.com/pub/scm/git/git
	git://repo.or.cz/alt-git.git/
	https://github.com/git/git/
	https://code.google.com/p/git-core/
	git://git.sourceforge.jp/gitroot/git-core/git.git/
	git://git-core.git.sourceforge.net/gitroot/git-core/git-core/

A few web interfaces are found at:

        http://git.kernel.org/?p=git/git.git
	https://kernel.googlesource.com/pub/scm/git/git
        http://repo.or.cz/w/alt-git.git

Preformatted documentation from the tip of the "master" branch can be
found in:

        git://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
        git://repo.or.cz/git-{htmldocs,manpages}.git/
        https://code.google.com/p/git-{htmldocs,manpages}.git/
        https://github.com/gitster/git-{htmldocs,manpages}.git/

You can browse the HTML manual pages at:

	http://git-htmldocs.googlecode.com/git/git.html

There are four branches in git.git repository that track the source tree
of git: "master", "maint", "next", and "pu".

The "master" branch is meant to contain what are very well tested and
ready to be used in a production setting.  Every now and then, a
"feature release" is cut from the tip of this branch.  They used to be
named with three dotted decimal digits (e.g. "1.8.5"), but recently we
switched the versioning scheme and "feature releases" are named with
three-dotted decimal digits that ends with ".0" (e.g. "1.9.0").

The last such release was 2.3.0 done on Feb 5th, 2015. You can expect
that the tip of the "master" branch is always more stable than any of
the released versions.

Whenever a feature release is made, "maint" branch is forked off from
"master" at that point.  Obvious, safe and urgent fixes after a
feature release are applied to this branch and maintenance releases
are cut from it.  The maintenance releases used to be named with four
dotted decimal, named after the feature release they are updates to
(e.g. "1.8.5.1" was the first maintenance release for "1.8.5" feature
release).  These days, maintenance releases are named by incrementing
the last digit of three-dotted decimal name (e.g. "2.3.2" is the
second maintenance relaese for "2.3" series).

New features never go to the 'maint' branch.  This branch is also
merged into "master" to propagate the fixes forward as needed.

A new development does not usually happen on "master". When you send a
series of patches, after review on the mailing list, a separate topic
branch is forked from the tip of "master" and your patches are queued
there, and kept out of "master" while people test it out. The quality of
topic branches are judged primarily by the mailing list discussions.

Topic branches that are in good shape are merged to the "next" branch. In
general, the "next" branch always contains the tip of "master".  It might
not be quite rock-solid, but is expected to work more or less without major
breakage. The "next" branch is where new and exciting things take place. A
topic that is in "next" is expected to be polished to perfection before it
is merged to "master".

The "pu" (proposed updates) branch bundles all the remaining topic
branches the maintainer happens to have.  There is no guarantee that
the maintainer has enough bandwidth to pick up any and all topics that
are remotely promising from the list traffic, so please do not read
too much into a topic being on (or not on) the "pu" branch.  This
branch is mainly to remind the maintainer that the topics in them may
turn out to be interesting when they are polished, nothing more.  The
topics on this branch aren't usually complete, well tested, or well
documented and they often need further work.  When a topic that was
in "pu" proves to be in a testable shape, it is merged to "next".

You can run "git log --first-parent master..pu" to see what topics are
currently in flight.  Sometimes, an idea that looked promising turns out
to be not so good and the topic can be dropped from "pu" in such a case.

The two branches "master" and "maint" are never rewound, and "next"
usually will not be either.  After a feature release is made from
"master", however, "next" will be rebuilt from the tip of "master"
using the topics that didn't make the cut in the feature release.

Note that being in "next" is not a guarantee to appear in the next
release, nor even in any future release.  There were cases that topics
needed reverting a few commits in them before graduating to "master",
or a topic that already was in "next" was reverted from "next" because
fatal flaws were found in it after it was merged to "next".


* Other people's trees, trusted lieutenants and credits.

Documentation/SubmittingPatches outlines to whom your proposed changes
should be sent.  As described in contrib/README, I would delegate fixes
and enhancements in contrib/ area to the primary contributors of them.

Although the following are included in git.git repository, they have their
own authoritative repository and maintainers:

 - git-gui/ comes from git-gui project, maintained by Pat Thoyts:

        git://repo.or.cz/git-gui.git

 - gitk-git/ comes from Paul Mackerras's gitk project:

        git://ozlabs.org/~paulus/gitk

 - po/ comes from the localization coordinator, Jiang Xin:

	https://github.com/git-l10n/git-po/
