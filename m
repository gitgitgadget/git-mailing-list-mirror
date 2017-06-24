Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C10B20401
	for <e@80x24.org>; Sat, 24 Jun 2017 23:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755198AbdFXX2J (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 19:28:09 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35693 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755006AbdFXX14 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 19:27:56 -0400
Received: by mail-pf0-f196.google.com with SMTP id s66so12869420pfs.2
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 16:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=e0yIHgGpu6aHLirt5D86sR2pH18TzFr/9z0JWDaQzHU=;
        b=IUN2uY2F+HeBIEsjZX+5z+ukRzCRAhJHntggElT0tljjID2s4uxEkMVciT2ppJGg9J
         a/CGIUJH4rvxdio4y4rCijJVKXxVZJ7Bd8L+neO+OJPdO7fWQ6Iq3CG6gtFxekZzko7A
         RtBfqbu5SCSXn73uwrjY2DlMOujttqzhQRzvmOxKAGzVh+HnmYkxcrV1dfc8Im+5UhNC
         /mcQVRaEdW3BvDVdqb5+hVSlJCUMApVGdkjVx+wCxjaD2oZHXxj5Eg/VzMMnNVukHXWh
         mdZMg5d6E9mbU0RXQRhORMKavugscRdDe6aM5Qo5k2c0Hy8lfp3ZlVGKUiveV+jNiWN4
         zfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=e0yIHgGpu6aHLirt5D86sR2pH18TzFr/9z0JWDaQzHU=;
        b=axYn68yZZvkWxzmIT70Ngo+rQDU1yR+2pFQQX4Hm/Q8Df4DwlKlHzKGbK583r2NXRp
         StiZosEk6sIee2jwhimydA+c9il3Pjoa4+F+hd7VHVwszNf51RYKda2vH9W/XBqNhGi/
         GESfLx3APIASI16/7ao+rleRekgEsZQV2L4NOZnlzAMEva3NvtaMA+FCOeRqinc8Il6Y
         iH4MLt2XDDjISjFMsjlQ+wyvAryMP0+CQhRrfGZY04cFWMOkrrBITRfvje1r48DGsFbm
         H7YwecrCkp9xAcYqgda4duYVUoJE2HBRmu5qE+41t0/4q4SaljIicxVKuy+xgaPrJuAE
         pKkQ==
X-Gm-Message-State: AKS2vOwhJYkvtDrZnTrvwvMN7rx/8UQwa3KSBRyfcJy3FNdgYGgHoABF
        3vrspp4C5hfRXLcMoFQ=
X-Received: by 10.99.127.73 with SMTP id p9mr14826103pgn.169.1498346874934;
        Sat, 24 Jun 2017 16:27:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:c3f:f54c:5646:5c2e])
        by smtp.gmail.com with ESMTPSA id q88sm12601353pfd.133.2017.06.24.16.27.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 24 Jun 2017 16:27:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: A note from the maintainer
Date:   Sat, 24 Jun 2017 16:24:31 -0700
Message-ID: <xmqqa84x7ypy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

        http://public-inbox.org/git/
        http://marc.info/?l=git
        http://www.spinics.net/lists/git/

For those who prefer to read it over NNTP:

        nntp://news.public-inbox.org/inbox.comp.version-control.git
	nntp://news.gmane.org/gmane.comp.version-control.git

are available.

When you point at a message in a mailing list archive, using its
message ID is often the most robust (if not very friendly) way to do
so, like this:

	http://public-inbox.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org

Often these web interfaces accept the message ID with enclosing <>
stripped (like the above example to point at one of the most important
message in the Git list).

Some members of the development community can sometimes be found on
the #git and #git-devel IRC channels on Freenode.  Their logs are
available at:

        http://colabti.org/irclogger/irclogger_log/git
        http://colabti.org/irclogger/irclogger_log/git-devel

There is a volunteer-run newsletter to serve our community ("Git Rev
News" http://git.github.io/rev_news/rev_news.html).

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
our security mailing list <git-security@googlegroups.com>.  This is
a closed list that is limited to people who need to know early about
vulnerabilities, including:

  - people triaging and fixing reported vulnerabilities
  - people operating major git hosting sites with many users
  - people packaging and distributing git to large numbers of people

where these issues are discussed without risk of the information
leaking out before we're ready to make public announcements.


* Repositories and documentation.

My public git.git repositories are at:

  git://git.kernel.org/pub/scm/git/git.git/
  https://kernel.googlesource.com/pub/scm/git/git
  git://repo.or.cz/alt-git.git/
  https://github.com/git/git/
  git://git.sourceforge.jp/gitroot/git-core/git.git/
  git://git-core.git.sourceforge.net/gitroot/git-core/git-core/

This one shows not just the main integration branches, but also
individual topics broken out:

  git://github.com/gitster/git/

A few web interfaces are found at:

  http://git.kernel.org/cgit/git/git.git
  https://kernel.googlesource.com/pub/scm/git/git
  http://repo.or.cz/w/alt-git.git

Preformatted documentation from the tip of the "master" branch can be
found in:

  git://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
  git://repo.or.cz/git-{htmldocs,manpages}.git/
  https://github.com/gitster/git-{htmldocs,manpages}.git/

The manual pages formatted in HTML for the tip of 'master' can be
viewed online at:

  https://git.github.io/htmldocs/git.html


* How various branches are used.

There are four branches in git.git repository that track the source tree
of git: "master", "maint", "next", and "pu".

The "master" branch is meant to contain what are very well tested and
ready to be used in a production setting.  Every now and then, a
"feature release" is cut from the tip of this branch.  They used to be
named with three dotted decimal digits (e.g. "1.8.5"), but recently we
switched the versioning scheme and "feature releases" are named with
three-dotted decimal digits that ends with ".0" (e.g. "1.9.0").

The last such release was 2.12 done on Feb 24th, 2017. You can expect
that the tip of the "master" branch is always more stable than any of
the released versions.

Whenever a feature release is made, "maint" branch is forked off from
"master" at that point.  Obvious and safe fixes after a feature
release are applied to this branch and maintenance releases are cut
from it.  Usually the fixes are merged to the "master" branch first,
several days before merged to the "maint" branch, to reduce the chance
of last-minute issues.  The maintenance releases used to be named with
four dotted decimal, named after the feature release they are updates
to (e.g. "1.8.5.1" was the first maintenance release for "1.8.5"
feature release).  These days, maintenance releases are named by
incrementing the last digit of three-dotted decimal name (e.g. "2.12.1"
was the first maintenance release for the "2.12" series).

New features never go to the 'maint' branch.  This branch is also
merged into "master" to propagate the fixes forward as needed.

A new development does not usually happen on "master". When you send a
series of patches, after review on the mailing list, a separate topic
branch is forked from the tip of "master" (or somewhere older, especially
when the topic is about fixing an earlier bug) and your patches are queued
there, and kept out of "master" while people test it out. The quality of
topic branches are judged primarily by the mailing list discussions.

Topic branches that are in good shape are merged to the "next" branch. In
general, the "next" branch always contains the tip of "master".  It might
not be quite rock-solid, but is expected to work more or less without major
breakage. The "next" branch is where new and exciting things take place. A
topic that is in "next" is expected to be polished to perfection before it
is merged to "master".  Please help this process by building & using the
"next" branch for your daily work, and reporting any new bugs you find to
the mailing list, before the breakage is merged down to the "master".

The "pu" (proposed updates) branch bundles all the remaining topic
branches the maintainer happens to have seen.  There is no guarantee that
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
The output of the above "git log" talks about a "jch" branch, which is an
early part of the "pu" branch; that branch contains all topics that
are in "next" and a bit more (but not all of "pu") and is used by the
maintainer for his daily work.

The two branches "master" and "maint" are never rewound, and "next"
usually will not be either.  After a feature release is made from
"master", however, "next" will be rebuilt from the tip of "master"
using the topics that didn't make the cut in the feature release.

A natural consequence of how "next" and "pu" bundles topics together
is that until a topic is merged to "next", updates to it is expected
by replacing the patch(es) in the topic with an improved version,
and once a topic is merged to "next", updates to it needs to come as
incremental patches, pointing out what was wrong in the previous
patches and how the problem was corrected.

Note that being in "next" is not a guarantee to appear in the next
release, nor even in any future release.  There were cases that topics
needed reverting a few commits in them before graduating to "master",
or a topic that already was in "next" was reverted from "next" because
fatal flaws were found in it after it was merged to "next".


* Other people's trees.

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

When sending proposed updates and fixes to these parts of the system,
please base your patches on these trees, not git.git (the former two
even have different directory structures).
