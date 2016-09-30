Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02954207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 22:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933973AbcI3WZN (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 18:25:13 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37108 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932687AbcI3WZK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 18:25:10 -0400
Received: by mail-wm0-f48.google.com with SMTP id b80so68018500wme.0
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 15:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=vRXSudmPmVHFpkOWSiSf/tYN/BPOJmQ6gtFOwqRTvH4=;
        b=qIMuii6ZrdCO9bD+62LBhZ6XCpvVuKEgwN/pwwvqB2SSsJ1Q3nnB0F3aQMz6DQ7DWn
         B+MlbacVk+aHhT8lDwnVB5kMXl8H2juD88KvVSQTt60lBcpsqOCMsue/187FT0HA6/xZ
         SBGVjkuMPyAofaAvwny+Wtuds8bTF+AHBlUS5q1CnzoY9OsSmVh78CmvN9sp6LA9I7lD
         3zXAfalM5vLjehFe2mRPfhKF4oXcutfH3X4LXGUcYvP+b0ZVjhOAHiBEhM807SeB7G2C
         BmcD7+M+/qxaZcN858kGcKzY6MYFdNOgwOEIkp3TU9skrKroOT3+2Fukie/tzOO1rQZz
         3dKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=vRXSudmPmVHFpkOWSiSf/tYN/BPOJmQ6gtFOwqRTvH4=;
        b=ZQkFM9fGA1pO0OUnjcDwBCx1vbv+gzx4qBacyOr4N4VjHxilX2Iz2/XFDYkVpNKLnO
         gpHOAxzPnX1ZdY6h5PkBm/HWC0SvfOlENJB41c9jF/K4vRseG2hqkd8ieBKZ8YjnE1Bz
         Hwz9iwBqLIwBV8+IKz78cbM/H74MQT1VXBDo5heF2RXo/n2pzlBp8mW5w7wEsg8ke6j2
         NVO2QNVEo7xAha3jHSb3hxkHGtkGXiaOyXO8czdZp0wrrUykhqIMJavk3Fblbo7x6+sN
         5SKzN8lOgtARblCgidlQDZwCW4QtwGJPdk6RO1sSIxYgWp6Yc+1M3Y3jFvgemtCc5nBm
         kMUQ==
X-Gm-Message-State: AA6/9RlwLakI8FIZv81B+hm4G4Vawnqd3Ljm9ZpJWcz57vEpzqvmI9qJxDrWFyG5Ko9a/w==
X-Received: by 10.28.45.214 with SMTP id t205mr5554912wmt.107.1475274308403;
        Fri, 30 Sep 2016 15:25:08 -0700 (PDT)
Received: from [192.168.1.26] (afo182.neoplus.adsl.tpnet.pl. [83.25.144.182])
        by smtp.googlemail.com with ESMTPSA id lf9sm8126944wjb.22.2016.09.30.15.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2016 15:25:07 -0700 (PDT)
Subject: Re: "Purposes, Concepts,Misfits, and a Redesign of Git" (a research
 paper)
To:     Konstantin Khomoutov <kostix+git@007spb.ru>, git@vger.kernel.org
References: <20160930191413.002049b94b3908b15881b77f@domain007.com>
Cc:     Santiago Perez De Rosso <sperezde@csail.mit.edu>,
        Daniel Jackson <dnj@csail.mit.edu>,
        Greg Wilson <gvwilson@third-bit.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@mat.umk.pl>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <481910fd-5a5f-ffc6-b98c-61d48b4a2e49@gmail.com>
Date:   Sat, 1 Oct 2016 00:24:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160930191413.002049b94b3908b15881b77f@domain007.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 30.09.2016 o 18:14, Konstantin Khomoutov pisze:

> The "It Will Never Work in Theory" blog has just posted a summary of a
> study which tried to identify shortcomings in the design of Git.
> 
> In the hope it might be interesting, I post this summary here.
> URL: http://neverworkintheory.org/2016/09/30/rethinking-git.html

I will comment on the article itself, not just on the summary.

| 2.2 Git
[...]
| But tracked files cannot be ignored; to ignore a tracked file
| one has to mark it as “assume unchanged.” This “assume
| unchanged” file will not be recognized by add; to make it
| tracked again this marking has to be removed.

WRONG!  Git has tracked files, untracked unignored files, and
untracked ignored files (mostly considered unimportant).

The "assume unchanged" bit is _performance_ optimization. It is not,
and cannot be a 'ignore tracked files' bit - here lies lost work!!!
You can use (imperfectly) "prefer worktree" bit hack instead.

You can say, if 'ignoring change to tracked files' is motivation,
or purpose, it lacks direct concept.

[...]
| As a result, when a user switches branches, files may be
| unexpectedly overwritten. 

This is possible _only_ if there are uncommitted changes. If they
are there, and they do not conflict with switching a branch, they
are "floated" to a newly checked out branch.

| Git fails with an error if there are any conflicting changes,
| effectively preventing the user from switching in this case.
| To mitigate this problem, Git provides a way to save versions
| of files to another storage area, called the “stash,” using
| a special command issued prior to the branch switch.

Or you can try to merge uncommitted changes with changes between
two branches: current and switched to.

Or you can forcibly discard your changes.

Or (with modern Git), you can put each branch in a separate
working area (with "git worktree"), though the article may predate
this feature.

[...]
| *Syncing with Other Repositories* Crucial to the understanding
| of how syncing with other repositories work is the notion
| of a “remote branch.” This is a branch (pointer to a commit)
| that (asynchronously) reflects the state of a branch in another
| repository. It is updated whenever there is some network
| communication (e.g., a push or fetch).

It is called "remote-tracking branch", rather than "remote branch".
At least in Git documentation. This branch is in local repository,
not in remote one. The remote-tracking branch for example
`origin/master` follows (tracks) branch `master` in remote
repository `origin`.

| The notion of a “remote branch” must not be confused
| with that of an “upstream branch.” An upstream branch is
| just a convenience for users: after the user assigns it to some
| branch, commands like pull and push default to use that
| branch for fetching and pushing changes if no branch is given
| as input.

Actually "upstream branch" (and related "upstream repository")
are a concept, not only a convenience. They denote a branch
(usually in remote repository) which is intended to ultimately
include changes in given branch. Note that "upstream branch"
can be set separately for any given local branch.

One thing that can enormously help recovering from errors, and
is not covered in the list of concepts is REFLOG.


[...]
| 3. Operational Misfits
[...]
| *Saving Changes* Suppose you are in the middle of a long
| task and want to save your changes, so that they can be later
| retrieved in case of failure. How would you do that?

You would use `git stash` or `git stash --include-untracked`!
In more complicated situations (during long-running operation
like resolving merge conflicts, interactive rebase, or finding
bugs with bisect) with modern Git you can create a new separate
working area with `git worktree`.

This also applies to the "*Switching branches*" problem (which
is more involved, as `git stash` would often not work, and if
it does it is harder to restore state - note however that stash
description includes the branch it was on).

So I would say that *Saving Changes* is solved with stash,
while *Switching Branches* remains a misfit.

| *Detached Head* Suppose you are working on some branch
| and realize that the last few commits you did are wrong, so
| you decide to go back to an old commit to start over again.
| You checkout that old commit and keep working creating
| commits. You might be surprised to discover that these new
| commits you’ve been working on belong to no branch at all.
| To avoid losing them you need to create a new branch or reset
| an existing one to point to the last commit.

It would be hard to be surprised unless one is in habit of
disregarding multi-line warning from Git... ;-)

I think it might be more of an UX problem, namely that the
`git checkout` command does too many things, which include
checking out revision (detaching HEAD, or landing on unnamed
branch, unless we create a new branch at the same time with
the '-b <newbranch>' option), and checking out a branch,
that is switching to other branch.

| *File Rename* Suppose you rename a file and make some
| changes to it. If you changed a significant portion of the file,
| then, as far as Git is concerned, you didn’t rename the file,
| but it is instead as if you deleted the old file and created a new
| one (which means that the file history is now lost). To work
| around this, you have to be diligent about creating a commit
| with the rename only, and only then creating a new commit
| with the modifications. This, however, likely creates a bogus
| commit that doesn’t correspond to a logical group of changes.

First, I think it might be inherent problem. The version control
system may implement *rename tracking* (store information about
renames), or *rename detection*. The latter is what Git does,
and it is what allows to do for example detecting copying and
movement of contents across files and within the same file
for `git blame` (and `git gui blame`) - which is impossible with
only rename tracking.

Nb. that handling file renames and other source reorganization
is important thing that modern version control systems should
be able to handle.

Second, the need for handling renames can be found in two
different operations. One is following history of a single
file across renames, or seeing a rename when looking at changes
in a single revision. The other is merging two lines of
development where one did a rename. The trick of splitting
large rename+change into pure rename and change without rename
can help only the former... the less important one. Merging
in Git is done using [recursive] 3-way merge strategy, which
takes into account only the endpoint state, and not history
between them - so if it was rename then change doesn't matter.

Third, (which is a bit of victim^W user blaming), large changes
are process smell. The cases when change accompanying rename
is so large that it screws heuristic based rename detection
legitimately are (or are supposed to be) rare. And for the
legitimate cases, that is end-of-line changes, there are
solutions to help (-w for diff, -Xrenormalize for merge).

| *File Tracking* Suppose you create a new file and then you
| add the file to start tracking changes to it. You keep working
| on the file making new modifications and then you make
| a vanilla commit. You might be surprised to find out that
| what actually got committed is the old version of the file
| (representing its state the last time the file was staged), and
| not the most recent one.

Unless one uses `git commit -a`, like most people (I think)
in most cases do.

Hopefully `git add -N`, aka. "intent to add", would help here...
when people switch to it to adding new files, and when the
feature gets improved (as it is now) to make it better and
easier to use (e.g. so "git diff" shows new i-t-a files).

| *Untracking File* Suppose there’s a database configuration
| file committed in the repository and you now want to edit
| this file to do some local testing. This new version of the
| file should not be committed. You could always leave out
| the file from the commit every time, but this is laborious and
| error-prone. You might think that you could make it ignored
| by modifying the `.gitignore` file but this doesn’t work for
| committed files.

The name "Untracking File" is misleading. You untrack file
(that is remove it from future commits) with `git rm --cached`.
No problem here. The name is "Ignore changes to tracked files",
or "Stopping tracking changes to file".

If you think of ignored files as unimportant, not precious,
then mismatch between understanding and what Git does would
lessen.

| The way to ignore this file is to mark it as
| “assume unchanged,” but this marking will be cleared when
| you switch to another branch.

s/“assume unchanged,”/“skip worktree,” (see earlier comment).

Right. Also, currently you need to use low-level commands
(`git update-index`) to mark file in this way.

[...]
| 4. Purposes for Version Control
[...]
| *Collaboration* To this point, all the purposes might apply in
| the context of a single user. Collaboration needs arise when
| multiple users work together on a single code base.
| /* ..........................................................
| /* _Purpose 4. Synchronize changes of collaborators_

One very important purpose that must be fulfilled before even
trying to synchronize changes is *isolation of changes*. Each
developer needs its own working area, so his or her changes do
not interfere with work of other developers.

Though "Disconnected operations" a bit overlaps (and is partial
superset) of this purpose.

See also intro to "Version Control by Example", by Eric Sink
http://ericsink.com/vcbe/html/intro.html

[...]
| 5.1 Stashing: An Example
|
| We consider the motivating purpose of stashing not to be
| a subpurpose of any of the high-level purposes for version
| control (§4). This section elaborates on our rationale for this.
|
| Take (what seem to be) the motivating use cases for stashing
| [9, Chapter 7.3]: (1) to pull into a dirty working directory
| and (2) to deal with an interruption in your workflow

Actually (1) is not a separate use case, but a subset 
(specialization) of (2) - and interruption in your workflow,
where the interruption is pull.

Note that to synchronize with remote repository one should use
fetch, not pull.  The latter is more involved operation, and
should be considered interruption.  Also, rarer if using
feature branches workflow, and not working on long-lived
stabilization branches directly.

[...]
| The problem
| is the lack of connection between this purpose and the highlevel
| purposes for version control, which suggests that the
| introduction of stashing might be to patch flaws in the design
| of Git and not to satisfy a requirement of version control.

Or the problem might be that you are missing some (maybe minor)
requirement of version control system. Just saying...

| 6. Analysis
[...]
| *Divided Ignored and Assumed Unchanged*

This ignores the fact that (unstated) assumption is that ignored
files are considered not important (or at least less important;
Git cares less about changes in those files, and may in some
cases make you loose changes to them).

Ignore file != ignore changes, though it may look like it is.

[...]
| 7. Gitless
|
| 7.1 Overview
|
| Gitless has no staging area, and the only file classifications
| are “tracked,” “untracked,” “ignored,” and “in conflict.”

Without staging area, I wonder how you would be able to handle
well different types of integration conflicts, which are not
limited to CONFLICT(content).

You also loose the ability to select subset of *changes* to
be committed, not only files.  This is often very useful, see
http://tomayko.com/writings/the-thing-about-git
http://2ndscale.com/rtomayko/2008/the-thing-about-git

[...]
| A branch in Gitless is a completely independent line of
| development: each branch includes the working version of
| files [...]

If I understand your model correctly, you would get rid of
one problem / mismatch, but get into other. What would you
do if you started work on some branch, and then realized
that you should have been working on a new topic branch?
Or you realized that you are on wrong branch, and want to
move changes?

Ah, I haven't realized that it is described later (well,
at least the first case):

: In regard to branching, to address situations in which the
: user wants changes made in the current branch to be moved
: onto the destination branch (e.g., the user realizes that she
: has been working in the wrong branch), the Gitless branch
: command has a `move-over` flag


[...]
|  Also, there
| is no possible way of getting in a “detached head” state; at
| any time, the user is always working on some branch (the
| “current” branch). Head is a per-branch reference to the last
| commit of the branch.

How do you solve the problem of checking out the state of
the tag, that is the state of repository at given revision?

Also during some long lived multi-step operations, like bisect
or interactive rebase, you are not really on any branch,

| 7.2.1 Discussion
[...]
| There could be other use cases for the
| staging area that Gitless doesn’t handle well but we expect
| these to be fairly infrequent.

Like handling merge conflict...??? Infrequent doesn't mean
unimportant.


That's all my comments for now.


This is a very interesting research.  Those problems (misfits)
are legitimate concern.  Even if it would not result in changes
to how Git works, it should improve how we are talking about
version control, and how we design them (that includes GUIs
that work above version control systems).

Best regards,
-- 
Jakub Narębski

