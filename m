Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 305D61F404
	for <e@80x24.org>; Sun, 16 Sep 2018 14:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeIPUSb (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 16:18:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33995 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeIPUSa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 16:18:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id u1-v6so10901121eds.1
        for <git@vger.kernel.org>; Sun, 16 Sep 2018 07:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=dGuE4Jt0JHnBSJbNugaTm/RbTZXzMu44I7V2msQ1zpk=;
        b=lTgbUknmjk5LYgmgh8+V5+VrNx/lgjsuQ6itJmca6yfQL+7hpNKSbpxClQ2IzNvvdJ
         PxkCWn0h720/WtGrFovdJqr+Gd5k2sNgZUk3fkib5seNao3BOxMfiutySbXHe9Gwn7mR
         ryh0wStHCScdnaEnTClSdYKs1J5irH13TQAPhrFuLc+tNZ4j84iwVM8pIZ3GQyINQK5U
         g5fPs13d4WGBTbUM/OIyy8ac7vZL0u3/VdB1q6zkBKRNcdPNQvDs/8vKcc22+m8PSgy9
         mTaUsBFsNMdG+rgQrTmn/AUGvQ7Q+LFVFr4qZbzmiBAM59r+z1Zj5BCMfxg/+pDeb3NY
         f0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=dGuE4Jt0JHnBSJbNugaTm/RbTZXzMu44I7V2msQ1zpk=;
        b=RMd31SwojUXy4opxPf5c9cSiBy4knxlkqLMkVIOQfzM1ZH6l0lXQJkYMoQGRXXsUB3
         zQejyaz7opcm6wEJxfLYJZlcUZ19EaWJ3p5UfkX+TBnsnpE0EbFFMh+kTj9PbiH6r35i
         HsZBnXKHNSMtlNiwQn30En9mLIgR1ithCxQeUAYoR0+dHC519K1ifqlDLmZBys5Y2Qrw
         /U+QnjSi3UcuWx0BVbHF50dDQwxYQoFXiXF4SYvSErxBn5Vz08rZ3dR2hr2fz/A7690k
         +0PkESROUmDGp5nUM+U0l6KCSQvikpmmPPzXOHyLzyRpmSgi7sBvOl4ArW2iLfb8DO9/
         K7PQ==
X-Gm-Message-State: APzg51CuWJxarh+L05f/0Gn5OdKWTK8MVwGvSBhI3zzgQKOcLmKv9JF0
        9ZYcc7aWHgJGNJoEgNwJGdA=
X-Google-Smtp-Source: ANB0VdYV8JCmzo43cYSvqxSleUM8uXJZaXznYjj5h0yOxZbV4NUu9EeXxXw7SHhSJh8r5NB+a2XYIQ==
X-Received: by 2002:a50:b37a:: with SMTP id r55-v6mr37040141edd.145.1537109715764;
        Sun, 16 Sep 2018 07:55:15 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id f7-v6sm9253002edd.6.2018.09.16.07.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Sep 2018 07:55:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Austin <john@astrangergravity.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net, larsxschneider@gmail.com,
        pastelmobilesuit@github.com, Joey Hess <id@joeyh.name>
Subject: Re: Git for games working group
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
        <20180914190025.GJ55140@syl>
        <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com>
        <20180915164052.GA88932@syl>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180915164052.GA88932@syl>
Date:   Sun, 16 Sep 2018 16:55:13 +0200
Message-ID: <878t41lcfi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 15 2018, Taylor Blau wrote:

> On Fri, Sep 14, 2018 at 02:09:12PM -0700, John Austin wrote:
>> I've been working myself on strategies for handling binary conflicts,
>> and particularly how to do it in a git-friendly way (ie. avoiding as
>> much centralization as possible and playing into the commit/branching
>> model of git).
>
> Git LFS handles conflict resolution and merging over binary files with
> two primary mechanisms: (1) file locking, and (2) use of a merge-tool.
>
>   1. is the most "non-Git-friendly" solution, since it requires the use
>      of a centralized Git LFS server (to be run alongside your remote
>      repository) and that every clone phones home to make sure that they
>      are OK to acquire a lock.
>
>      The workflow that we expect is that users will run 'git lfs lock
>      /path/to/file' any time they want to make a change to an
>      unmeregeable file, and that this call first checks to make sure
>      that they are the only person who would hold the lock.
>
>      We also periodically "sync" the state of locks locally with those
>      on the remote, namely during the post-merge, post-commit, and
>      post-checkout hook(s).
>
>      Users are expected to perform the 'git lfs unlock /path/to/file'
>      anytime they "merge" their changes back into master, but the
>      thought is that servers could be taught to automatically do this
>      upon the remote detecting the merge.
>
>   2. is a more it-friendly approach, i.e., that the 'git mergetool'
>      builtin does work with files tracked under Git LFS, i.e., that both
>      sides of the merge are filtered so that the mergetool can resolve
>      the changes in the large files instead of the textual pointers.
>
>
>> I've got to a loose design that I like, but it'd be good to get some
>> feedback, as well as hearing what other game devs would want in a
>> binary conflict system.
>
> Please do share, and I would be happy to provide feedback (and make
> proposals to integrate favorable parts of your ideas into Git LFS).

All of this is obviously correct as far as git-lfs goes. Just to use
this as a jump-off comment on the topic of file locking and to frame
this discussion more generally.

It's true that a tool like git-lfs "requires the use of a centralized
[...] server" for file locking, but it's not the case that a feature
like file locking requires a centralized authority.

In particular, git-lfs unlike git-annex (which preceded it) does the
opposite of (to quote John upthread) "avoid[...] as much centralization
as possible", it *is* explicitly a centralized large file solution, not
a distributed one, as opposed to git-annex.

That's not a critique of git-lfs or the centralized method, or a
recommendation for decentralization in this context, but we already have
a similar distributed solution in the form of git-annex, it's just a hop
skip and a jump away from changing "who has the file" to "who has the
lock".

So how does that work? In the centralized case like
git-lfs/cvs/p4/whatever you have some "lock/unlock" command, and it
locks a file on a central server, locking is usually a a [locked?, who]
state of "is it locked" and "who locked it?". Usually this is also
followed-up on the client-side by checking those files out without the
"w" flag.

In the hypothetical git-annex-like case (simplifying a bit for the
purposes this explanation), for every FILE in your tree you have a
corresponding FILE.lock file, but it's not a boolean, but a log of who's
asked for locks, i.e. lines of:

    <repository UUID> <ts> <state> <who (email?)> <explanation?>

E.g.:

    $ cat Makefile.lock
    my-random-per-repo-id 2018-09-15 1 avarab@gmail.com "refactoring all Makefiles"
    my-random-per-repo-id 2018-09-16 0 avarab@gmail.com "done!"

This log is append-only, when clients encounter conflicts there's a
merge driver to ensure that all updates are kept.

You can then enact a policy saying you care or don't care about updates
from certain sources, or ignore locks older than so-and-so.

None of this is stuff I'd really recommend. It's just instructive to
point out that if someone wants a distributed locking solution for git,
it pretty much already exists, you can even (ab)use git-annex for it
today with a tiny hack on top.

I.e. each time you want to lock a file called Makefile just:

    echo We created a lock for this >Makefile.lock &&
    git annex add Makefile.lock &&
    git annex sync

And to release the lock:

    git annex rm Makefile.lock &&
    git annex sync

Then you and others using this just mentally pretend (or setup aliases)
that the following mapping exists:

    git annex get <file> && git annex sync ==> git lockit <file>
    git annex rm <file>  && git annex sync ==> git unlockit <file>

And that stuff like "git annex whereis" (designed to list "who has the
files") means "git annex who-has-locks".

Then you'd change the post-{checkout,merge} hooks to list the locks
"tracked annex files", chmod -w appropriately, and voila, a distributed
locking solution for git built on top of an existing tool you can
implement in a couple of hours.

Now, if I were in a game studio like this would I do any of this? Nope,
I think even if you go for locks something like the centralized git-lfs
approach is simpler and probably more appropriate (you presumably want
to be centralized anyway).

But to be honest I don't really get the need for this given something
like the use-case noted upthread:

    > John Austin <john@astrangergravity.com> wrote:
    > An essential example would be a team of 5 audio designers working
    > together on the SFX for a game. If one designer wants to add a layer
    > of ambience to 40% of the .wav files, they have to coordinate with
    > everyone else on the project manually.

If you have 5 people working on a project together, isn't it more
straightforward to post in IRC/E-Mail:

    Hey @all, don't change *.wav files for the next couple of days,
    major refactoring.

That's what we do all the time over in the non-game-non-binary-assets SW
development world, and I daresay that even if you have textual
conflicts, they're sometimes just as hard to solve.

I.e. you can have two people unaware of each other on a team starting to
in parallel refactor the same set of code in two completely different
ways, needing a lot of manual merging / throwing out of most of one
implementation. The way that's usually dealt with is something like the
above example post to a ML.

But maybe I'm just not imagining the use-cases.
