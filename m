Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E6A20248
	for <e@80x24.org>; Tue, 26 Feb 2019 17:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfBZRPq (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 12:15:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37956 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfBZRPq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 12:15:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id v26so3004123wmh.3
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 09:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=FKpuqcwwM56ios6RvMgjIDZ4lPaOAxE1++3CZ80iKy8=;
        b=kvK3c9Ldxe27Cj/uJQDQESffk35WnZBBg6x7giRR4tZrAweOdvuDEBCo3NQr6WArFl
         sRksCimgBMG9VAGtpV03q3xDjvX89/+SOkVsojBVWi1P3VSefP5Dw4LpXd9sOQ9+nq3+
         6tYU9J1IzrdSmJrVGHuw/TEeQ57IfIegTsFLAnjC4a6EVIBTbanRjSV5ZOzlRuxvvPZp
         vSSrffABZsjKClccyBpYbr8jJB7L7k8N58i1Qm+0uHDa5PqBD8o6OQxsaT02f+0H90tl
         9LWa3HIOtZDWkn2y1YeG233E5s2XUW8IY/Y5Izd+3I3NtWwiyGFCCf5dFW1TGA9FTRp1
         6JHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=FKpuqcwwM56ios6RvMgjIDZ4lPaOAxE1++3CZ80iKy8=;
        b=N4tzLCGpveDV/0tzgMd87dz1JSNns0dCD3eXmupZhxPVTMXCcKRYcTLD+7ajroxsdg
         88ysYDy/t4WjkejiNRTZwZlI5CjzbR5WOeipjkmk/tceB5kXvq8giqryiR36xM8zxz38
         RuBk03V1ikobCH4DmCLsbxGf+UIc0IxLp2FHmuZNOCHAYowPmGkXP9iOSNeF0imH+hQ1
         TJeKXG6WfmQAQtSmoxh4g5SDmiIIVOG4pIlTKBxjRleyuQgnInm9uQWQPVl8fSV1M5IA
         5fH3aTg97hI1hVixXSohKeV2RAI/bkPiuIR3c1wDY1oaCfx+hU9O9wgirJGGX9h4xlvf
         Gl6Q==
X-Gm-Message-State: AHQUAuY+JHWWqGvyQCnFnbiibsH7o3O7sbWb3aHI59uARfbe4LASIlIe
        ALZVDKxa/a92ioXyW1lQeDlRVb3a
X-Google-Smtp-Source: AHgI3IZAGMZBo2nlfLt1SDILd7Etc1Tsc6/XtPIDVwUiPQBmYPutKOyDu9J727/gWg1vFLW7r4hzRw==
X-Received: by 2002:a1c:9acd:: with SMTP id c196mr3507413wme.145.1551201342958;
        Tue, 26 Feb 2019 09:15:42 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m4sm10832wml.2.2019.02.26.09.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 09:15:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: A note from the maintainer
Date:   Wed, 27 Feb 2019 02:15:40 +0900
Message-ID: <xmqqwolmcvyb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[jc: as I said earlier, I'll be offline for a week, but remembered
that I haven't sent this out for a while---I tried to make a habit
of sending this message out after every feature release, and we had
one recently, so it is a good time to send one from the airport
lounge before I fly out.]

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

As an anti-spam measure, the mailing list software rejects messages
that are not text/plain and drops them on the floor.  If you are a
GMail user, you'd want to make sure "Plain text mode" is checked.

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

My public git.git repositories are (mirrored) at:

  git://git.kernel.org/pub/scm/git/git.git/
  https://kernel.googlesource.com/pub/scm/git/git
  git://repo.or.cz/alt-git.git/
  https://github.com/git/git/
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

The last such release was 2.15 done on Oct 30th, 2017.  You can expect
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

New features never go to the 'maint' branch.  It is merged into "master"
primarily to propagate the description in the release notes forward.

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
