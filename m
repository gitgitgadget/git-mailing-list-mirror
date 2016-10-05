Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEB31207EC
	for <e@80x24.org>; Wed,  5 Oct 2016 10:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754589AbcJEKOz (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 06:14:55 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35073 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753085AbcJEKOx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 06:14:53 -0400
Received: by mail-wm0-f49.google.com with SMTP id f193so219370501wmg.0
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=20fpXT8iK1ebhwFv9DgrtEBL6vtNw82rLbd11sgUgMM=;
        b=PmMfgq/q8zKUPqekxZXoLvYzzs9oxqLaS04Tms/JUmcd/NmZWFQkGiJ0ai8uTz2+ok
         58cK/Bb/T+TBAHO1Tvn7IWn5tr2kuyGKN5ryMmU6YwtvnC1ML9YKXqtjMHNS2u+27suX
         Q96ZHcbm4q3SBzBuDu5t9VMI2/4rXoiWCHzvh2mHJHtSUDb1o/PijqAIO4tju3b0tlcE
         KA93USZejgZ9svWrj1DfoWYXyYtXvQEViaOYEsVNnAmKKp2JzQqjZbIPWfk6yvECad+/
         LYThB06LRm82frOv9irCeJdfVBvJWQ1wljt46eFregrSkXzPMuZsH3pYbETt/0gQvLp6
         nKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=20fpXT8iK1ebhwFv9DgrtEBL6vtNw82rLbd11sgUgMM=;
        b=ak/b0kKRBpZhwRRWr8REzYca8+6STFHGs8AkJ3S83Wt0b8ReBiM2Dyv8ntUDNxKw0K
         O4Vj91SLFXKRrX2q8EkHn66duFQe0NJzmMVelF0/AXHG6kFUc9uBp+TOZOzm19VC+/Je
         ZntVRDtgb+RHayPX3puAB67Tn2P5JRTGcGJoAuWVwwEi9yOLueSegtfw27iZXdvReU9I
         4t01Sfr26lCLJKO2X12BU+BJU+QqSM3+vmXY+lDlT/Fcai5jkJYWFOattYsKyW1BXEsN
         HV6Vy9Gv7zBcBMWIlMHjYmftVaIZ4xXIlBG1QTg90Bez3vSkGpeubH/Dfq3qlQO9vWb7
         RHWg==
X-Gm-Message-State: AA6/9RmmZsTYmlvDvV6Et4PmVbhWYLhMlZO/OGCDmtFcXJU+7P3xlQU4oh0f2Hj8XyXg3sAfdMrC0vtAR8fXOw==
X-Received: by 10.28.212.129 with SMTP id l123mr2705190wmg.22.1475662490753;
 Wed, 05 Oct 2016 03:14:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.136.149 with HTTP; Wed, 5 Oct 2016 03:14:10 -0700 (PDT)
In-Reply-To: <CAKbZu+BUOAjixTmEC4octseyJbMnFuaCTtLT9hx3H10=AECeKw@mail.gmail.com>
References: <20160930191413.002049b94b3908b15881b77f@domain007.com>
 <481910fd-5a5f-ffc6-b98c-61d48b4a2e49@gmail.com> <CAKbZu+BUOAjixTmEC4octseyJbMnFuaCTtLT9hx3H10=AECeKw@mail.gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Wed, 5 Oct 2016 12:14:10 +0200
Message-ID: <CANQwDwcj15bk3uvjqnOwqqLFN_qOZCoWATssNBwD4kDTDfS6Hw@mail.gmail.com>
Subject: Re: "Purposes, Concepts,Misfits, and a Redesign of Git" (a research paper)
To:     Santiago Perez De Rosso <sperezde@csail.mit.edu>
Cc:     Konstantin Khomoutov <kostix+git@007spb.ru>,
        git <git@vger.kernel.org>, Daniel Jackson <dnj@mit.edu>,
        Greg Wilson <gvwilson@third-bit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[git@vger.kernel.org does not accept HTML emails]

I just hope that this email don't get mangled too much...

On 5 October 2016 at 04:55, Santiago Perez De Rosso
<sperezde@csail.mit.edu> wrote:
> On Fri, Sep 30, 2016 at 6:25 PM Jakub Nar=C4=99bski <jnareb@gmail.com> wr=
ote:
>> W dniu 30.09.2016 o 18:14, Konstantin Khomoutov pisze:
>>
>>> The "It Will Never Work in Theory" blog has just posted a summary of a
>>> study which tried to identify shortcomings in the design of Git.
>>>
>>> In the hope it might be interesting, I post this summary here.
>>> URL: http://neverworkintheory.org/2016/09/30/rethinking-git.html
>>
>> I will comment on the article itself, not just on the summary.
>>
>> | 2.2 Git
>> [...]
>> | But tracked files cannot be ignored; to ignore a tracked file
>> | one has to mark it as =E2=80=9Cassume unchanged.=E2=80=9D This =E2=80=
=9Cassume
>> | unchanged=E2=80=9D file will not be recognized by add; to make it
>> | tracked again this marking has to be removed.
>>
>> WRONG!  Git has tracked files, untracked unignored files, and
>> untracked ignored files (mostly considered unimportant).
>>
>> The "assume unchanged" bit is _performance_ optimization. It is not,
>> and cannot be a 'ignore tracked files' bit - here lies lost work!!!
>> You can use (imperfectly) "prefer worktree" bit hack instead.
>>
>> You can say, if 'ignoring change to tracked files' is motivation,
>> or purpose, it lacks direct concept.
>
>
> I don't see what's wrong with the paragraph you mention. I am aware of th=
e
> fact that assumed unchanged is intended to be used as a performance
> optimization but that doesn't seem to be the way it is used in practice.
> Users have appropriated the optimization and effectively turned into a
> concept that serves the purpose of preventing the commit of a file. For
> example:
>
> from http://gitready.com/intermediate/2009/02/18/temporarily-ignoring-fil=
es.html
>
>  So, to temporarily ignore changes in a certain file, run:
>  git update-index --assume-unchanged <file>
>  ...
>
> from http://stackoverflow.com/questions/17195861/undo-git-update-index-as=
sume-unchanged-file
>  The way you git ignore watching/tracking a particular dir/file.
>  you just run this:
>  git update-index --assume-unchanged <file>
> ...
>
>
> btw, this appropriation suggests that users want to be able to ignore
> tracked files and they do what they can with what they are given (which
> in this case means abusing the assumed unchanged bit).

Yes, this is true that users may want to be able to ignore changes to
tracked files (commit with dirty tree), but using `assume-unchanged` is
wrong and dangerous solution.  Unfortunately the advice to use it is
surprisingly pervasive.  I would thank you to not further this error.
(Well, `skip-worktree` is newer, that's why it is lesser known, perhaps)

To ignore tracked files you need to use `skip-worktree` bit.

You can find the difference between `assume-unchanged` and
`skip-worktree`, and when use which in:
http://stackoverflow.com/questions/13630849/git-difference-between-assume-u=
nchanged-and-skip-worktree
http://fallengamer.livejournal.com/93321.html
http://blog.stephan-partzsch.de/how-to-ignore-changes-in-tracked-files-with=
-git/

The difference is that skip-worktree will not overwrite a file that is
different from the version in the index, but assume-unchanged can.  This
means that the latter can OVERWRITE YOUR PRECIOUS CHANGES!

Some people started to recommend it
http://stackoverflow.com/questions/32251037/ignore-changes-to-a-tracked-fil=
e
http://www.virtuouscode.com/2011/05/20/keep-local-modifications-in-git-trac=
ked-files/


>> | The notion of a =E2=80=9Cremote branch=E2=80=9D must not be confused
>> | with that of an =E2=80=9Cupstream branch.=E2=80=9D An upstream branch =
is
>> | just a convenience for users: after the user assigns it to some
>> | branch, commands like pull and push default to use that
>> | branch for fetching and pushing changes if no branch is given
>> | as input.
>>
>> Actually "upstream branch" (and related "upstream repository")
>> are a concept, not only a convenience. They denote a branch
>> (usually in remote repository) which is intended to ultimately
>> include changes in given branch. Note that "upstream branch"
>> can be set separately for any given local branch.
>
>
> We never say upstream branch is not a concept. It even appears in the
> table.

Hmmm... I got onfused by words "is just a convenience", which for me
implies that it is not a concept.

>>
>>
>> One thing that can enormously help recovering from errors, and
>> is not covered in the list of concepts is REFLOG.
>
>
> Yes, the analysis is not exhaustive, there are other concepts missing
> too (e.g., "submodule")

I think reflog is something that every user should know about, and
useful for all.  Submodules and subtrees is something situational,
needed only for a subset of users.

On the other hand the concept of "submodules" is something that it is
under active development, and it is assumed to be immature.  So coming
up with a good (re)design for this feature, and/or good set of
concept, would be a very good thing.


Another thing that it is not present is the concept of "immutable
history", and how to deal with it (`git-notes`, `git-replace`), and
how it conflict with other concepts (interactive rebase and the
concept of "rewriting history").  But I agree with focusing on most
commonly known, used and encountered concepts and misfits.

>> [...]
>> | 3. Operational Misfits
>> [...]
>> | *Saving Changes* Suppose you are in the middle of a long
>> | task and want to save your changes, so that they can be later
>> | retrieved in case of failure. How would you do that?
>>
>> You would use `git stash` or `git stash --include-untracked`!
>> In more complicated situations (during long-running operation
>> like resolving merge conflicts, interactive rebase, or finding
>> bugs with bisect) with modern Git you can create a new separate
>> working area with `git worktree`.
>
> A general comment regarding misfits: misfits correspond to scenarios
> in which Git behaves in a way that is unpredictable or inconvenient.
> It doesn't mean that a task has to be impossible to do in order for
> something to be a misfit.

If there were one-command solution, and the problem was that users
don't know about it, I would say that it is not a misfit.  But,
admittedly, it is not the case here...

>> | *Detached Head* Suppose you are working on some branch
>> | and realize that the last few commits you did are wrong, so
>> | you decide to go back to an old commit to start over again.
>> | You checkout that old commit and keep working creating
>> | commits. You might be surprised to discover that these new
>> | commits you=E2=80=99ve been working on belong to no branch at all.
>> | To avoid losing them you need to create a new branch or reset
>> | an existing one to point to the last commit.
>>
>> It would be hard to be surprised unless one is in habit of
>> disregarding multi-line warning from Git... ;-)
>
> True if you are an expert user, but I can assure you novices will
> find that situation baffling, even with the multi-line warnings.

True, the "detached HEAD" case (aka "unnamed branch") can be puzzling
for Git users, and it has few uses (e.g. checking out the state of
tag temporarily, to test it).

I wonder if `git status` should be enhanced to tell user how to get
out of "detached HEAD" situation -- it has lots of advices in it.

>> [...]
>> | The problem
>> | is the lack of connection between this purpose and the highlevel
>> | purposes for version control, which suggests that the
>> | introduction of stashing might be to patch flaws in the design
>> | of Git and not to satisfy a requirement of version control.
>>
>> Or the problem might be that you are missing some (maybe minor)
>> requirement of version control system. Just saying...
>
> What would that purpose be? and why would you say that's a
> high-level purpose for version control and not one that's
> git-specific?

The stash (or rather its equivalent) is not something Git specific.
It is present also in other version control systems, among others:

* Mercurial: as 'shelve' extension (in core since 1.8)
* Bazaar: as 'bzr shelve' command
* Fossil: as 'fossil stash' command (with subcommands)
* Subversion: Shelve planned for 1.10 (2017?)

I would say that 'stash' could be considered about isolating work on
different features, different sub-branch sized parallel work.

But it might be that stash doesn't have connection with highlevel
purposes for version control, and that it is purely convenience
feature.  Just playing the role of Advocatus Diaboli (important in
scientific works, isn' it?)...

>> [...]
>> | 7. Gitless
>> |
>> | 7.1 Overview
>> |
>> | Gitless has no staging area, and the only file classifications
>> | are =E2=80=9Ctracked,=E2=80=9D =E2=80=9Cuntracked,=E2=80=9D =E2=80=9Ci=
gnored,=E2=80=9D and =E2=80=9Cin conflict.=E2=80=9D
>>
>> Without staging area, I wonder how you would be able to handle
>> well different types of integration conflicts, which are not
>> limited to CONFLICT(content).
>>
>> You also loose the ability to select subset of *changes* to
>> be committed, not only files.  This is often very useful, see
>> http://tomayko.com/writings/the-thing-about-git
>> http://2ndscale.com/rtomayko/2008/the-thing-about-git
>
> This is described later:

Right, my mistake, I have missed this.  I should have read article in
full, then respond, rather than reply as I go...

> Common use cases for the staging area in Git are to select files to commi=
t,
> split up a large change into multiple commits, and review the changes
> selected to be committed. We address the first by providing a more flexib=
le
> commit command that lets the user easily customize the set of files to
> commit (with only, include and exclude flags). For the second use case we
> have a partial flag in commit that allows the user to interactively selec=
t
> segments of files to commit (like Git=E2=80=99s commit --patch). Finally,=
 our diff
> command accepts the same only, include and exclude flags to customize the
> set of files to be diffed. There could be other use cases for the staging
> area that Gitless doesn=E2=80=99t handle well but we expect these to be f=
airly
> infrequent.

I wrote later that Git offers more flexibility with respect of
interactive edition of the staging area (additive, substractive, from
HEAD, from arbitrary commit) and checking the prepared state (add <->
diff <-> stash --keep-index + test + unstash)... but I think this is a
matter of implementing interface for those fetures to 'partial'
commit.  It might be less flexible, and less powerfull, but it would
be there.

> Note that Gitless is built on top of Git so we do have a staging area, th=
e
> difference is that unlike Git, in Gitless the index is hidden from the us=
er.

All right.

I have just an idea of using the index (or rather its extensions) to
implement sub-commit history (forgotten after committing), as a way to
resolve misfit about "commit" concept and (P1) vs (P2) purposes...

>> [...]
>> |  Also, there
>> | is no possible way of getting in a =E2=80=9Cdetached head=E2=80=9D sta=
te; at
>> | any time, the user is always working on some branch (the
>> | =E2=80=9Ccurrent=E2=80=9D branch). Head is a per-branch reference to t=
he last
>> | commit of the branch.
>>
>> How do you solve the problem of checking out the state of
>> the tag, that is the state of repository at given revision?
>
> You can't checkout a tag, you would have to create a new branch with
> its head equal to the tag, and switch to that branch.

For the purpose of testing a state at a tag (for example as a
prerequisite to bisection), it fills like unnecessarily complicated
solution, a new misfit.  But I guess that you consider "detached HEAD"
misfit to be more important to get rid of.

>> Also during some long lived multi-step operations, like bisect
>> or interactive rebase, you are not really on any branch,
>
> In Gitless we don't have bisect but for rebase (fuse in Gitless) we
> record the current branch.

No bisect?  This is very useful feature.  Though it might be done
without detached HEAD, but with specialized pseudo-branch 'bisect' (as
it was done in earlier versions of Git, or maybe even now).

Anyway, for [interactive] rebase / transplant / graft / fuse you need
to be able to abort an operation and return to the state before
staring rebase.  Though you can or do solve this by remembering
the starting position.

>> | 7.2.1 Discussion
>> [...]
>> | There could be other use cases for the
>> | staging area that Gitless doesn=E2=80=99t handle well but we expect
>> | these to be fairly infrequent.
>>
>> Like handling merge conflict...??? Infrequent doesn't mean
>> unimportant.
>
> I regard handling merge conflicts as very important. Why do you need
> an explicit staging area for this? Note that Gitless has a staging
> area, it's just hidden from the user. The `gl diff` or `gl status`
> command should be able to show the same conflict information.

Well, the staging area was created (also?) to handle merges.  Though
perhaps it doesn't need to be explicit to be useful...

Best regards,
--=20
Jakub Nar=C4=99bski
