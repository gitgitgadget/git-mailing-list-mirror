Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9AA01F404
	for <e@80x24.org>; Sun, 16 Sep 2018 20:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeIQCOr convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 16 Sep 2018 22:14:47 -0400
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21778 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbeIQCOr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 22:14:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1537131029; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=PdSfNf9Eul/9nMCeJo8xTN0SZNroB9ke9+kXyjS+lgWFwjtzG8TgBmQXvsv3SsxLXvQz+kRK6XgNtj6IFDKMGoZw8i5GfZoneRFbBuxq5LZOK+MFYua84qe9+nORINZ+8fqxH1SMzA1fGL/0kVB3RLobSZOnYZAZIEsLGR0LwUA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1537131029; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=5LfM4E22QJs42eW7TzTybJfA6z5BvHr8ghNFiuw5i34=; 
        b=IuoNACYPEZFCMYGC4biP2ti4k8ijLxo0ZMhVZ3V/Yu+EY9B1/dLZlOQhcoXvJLjpqxm235mmR/O0LZ6+txb3cpXw/1v512OGLUqIjyJ+5qST9Lc8MWaWKoMxWnvvcul6b6kv77l3O9ufKmKZKUmdwUYQnOWMD3lh0RsoEjmq8OM=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=astrangergravity.com;
        spf=pass  smtp.mailfrom=john@astrangergravity.com;
        dmarc=pass header.from=<john@astrangergravity.com> header.from=<john@astrangergravity.com>
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46]) by mx.zohomail.com
        with SMTPS id 1537131027650471.0999853586777; Sun, 16 Sep 2018 13:50:27 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id x26-v6so11822611lfi.7
        for <git@vger.kernel.org>; Sun, 16 Sep 2018 13:50:26 -0700 (PDT)
X-Gm-Message-State: APzg51AG81+T0c9NSkOIerpW3CPTv6gNtArGjuwyo9Zc9M0p7VzGE7sE
        KbAoFPp7F6trSV8Zx9q9ZWyLL1hHR4RbFRV6VRg=
X-Google-Smtp-Source: ANB0VdYUzVCN6LMfLeqPADV6LdkaQ9Jx/U4hh9cQBS/3oMC5LH3gMsJZwOticnF8NKdIMdtUZZUYISbTnEL+E8EmENU=
X-Received: by 2002:a19:4b46:: with SMTP id y67-v6mr4112717lfa.118.1537131025674;
 Sun, 16 Sep 2018 13:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <20180914190025.GJ55140@syl> <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com>
 <20180915164052.GA88932@syl> <878t41lcfi.fsf@evledraar.gmail.com>
In-Reply-To: <878t41lcfi.fsf@evledraar.gmail.com>
From:   John Austin <john@astrangergravity.com>
Date:   Sun, 16 Sep 2018 13:49:58 -0700
X-Gmail-Original-Message-ID: <CA+AhR6dDEWSmQ8srbXmx2BYgDBdSRtz9U7czHwepioJAZt3Xkg@mail.gmail.com>
Message-ID: <CA+AhR6dDEWSmQ8srbXmx2BYgDBdSRtz9U7czHwepioJAZt3Xkg@mail.gmail.com>
Subject: Re: Git for games working group
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        pastelmobilesuit@github.com, id@joeyh.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for all the thoughts so far -- I'm going to try to collate some
of my responses to avoid this getting too lengthy.

## Regarding Merging / Diffing
A couple of folks have suggested that we could improve merging /
diffing of binary files in general. I think this is useful, but can
only ever result in minor improvements, for the following reasons:

1. Game developers use an incredible amount of proprietary file
formats: Maya, Houdini, Photoshop, Wwise, Unreal UAssets, etc. At the
end of the day, it's fairly unlikely that we can build visual merge
tools for these asset types without an enormous amount of corporate
support.

2. Merging doesn't have a meaning for many types of files. I think git
has trained us that everything is merge-able, but that's not always
the case. If you gave an audio designer two voice-over audio files and
asked them to merge them, they'd give you a pretty strange look. You
have to re-record it from scratch. Content files can be highly
intertwined and highly subjective: as a textual metaphor, every line
of content conflicts with every other line. Even if you had a perfect
merge tool, it just doesn't make much sense to try to merge changes,
unless it's an incredibly simple change.

## Regarding File Locking:
File locking works well enough in Perforce, but there are a couple of
issues I've found using file locking in LFS or in Gitolite (hadn't
seen this before, thanks!).

1. File Locking is an 'active' system. File Locking adds extra
operations that must be taken, both before writing to a file and then
after finishing your changes. Artists either must drop down to a
terminal (unlikely), or we must integrate our file-locking system with
existing artist tools (a large amount of work). Either way it adds a
lot of extra grunt-work. Imagine having to manually mark which files
you modify rather than just using git status. One of git's biggest
benefit is removing this type of manual labor.

2. File Locking doesn't extend well across branches. Acquiring a lock
usually blocks modifications to this file across all branches. This
cuts off basic branching models and features (like having release
branches) that are large part of why git is so successful.

3. It's not entirely sound. Developer A can modify 'binary.bin', and
push the changes to master. Developer B, who is behind master by a
couple of days, can then unknowingly acquire the lock and make further
changes ignoring A's new commit. When B attempts to push, they will
get conflicts. If you look closely, this is a symptom of issue 2:
locking doesn't understand branches.

## "Implicit" Locking

Instead, I think it's better to think about how we can use the
structure of the git graph to solve the issue. Imagine the following
pre-commit hook for a developer attempting to commit 'binary.bin':

If there exists any commit binary.bin on a different branch that is
not integrated into this branch,  block the commit.

In this case, making a commit with a file blocks others from touching
it, until they pull in that commit. To make the parallel, making a
commit acquires a 'lock' on the file, but there's no release. The only
requirement is that you always modify the latest version of the file.

This has issues of its own, and it's a simplification of the system I
have in mind. It means Developer A needs to have information about the
commit graph local to Developer B's machine (but notably not the
files). However I think it is a better starting place for thinking
about these sorts of systems. The locks fall implicitly from the
commit graph structure, so it plays well with all of your normal git
commands. You can branch, cherry-pick, rebase, etc without any extra
support or aliases. I'll write up something a bit more detailed in a
bit.

- JA
On Sun, Sep 16, 2018 at 7:55 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sat, Sep 15 2018, Taylor Blau wrote:
>
> > On Fri, Sep 14, 2018 at 02:09:12PM -0700, John Austin wrote:
> >> I've been working myself on strategies for handling binary conflicts,
> >> and particularly how to do it in a git-friendly way (ie. avoiding as
> >> much centralization as possible and playing into the commit/branching
> >> model of git).
> >
> > Git LFS handles conflict resolution and merging over binary files with
> > two primary mechanisms: (1) file locking, and (2) use of a merge-tool.
> >
> >   1. is the most "non-Git-friendly" solution, since it requires the use
> >      of a centralized Git LFS server (to be run alongside your remote
> >      repository) and that every clone phones home to make sure that they
> >      are OK to acquire a lock.
> >
> >      The workflow that we expect is that users will run 'git lfs lock
> >      /path/to/file' any time they want to make a change to an
> >      unmeregeable file, and that this call first checks to make sure
> >      that they are the only person who would hold the lock.
> >
> >      We also periodically "sync" the state of locks locally with those
> >      on the remote, namely during the post-merge, post-commit, and
> >      post-checkout hook(s).
> >
> >      Users are expected to perform the 'git lfs unlock /path/to/file'
> >      anytime they "merge" their changes back into master, but the
> >      thought is that servers could be taught to automatically do this
> >      upon the remote detecting the merge.
> >
> >   2. is a more it-friendly approach, i.e., that the 'git mergetool'
> >      builtin does work with files tracked under Git LFS, i.e., that both
> >      sides of the merge are filtered so that the mergetool can resolve
> >      the changes in the large files instead of the textual pointers.
> >
> >
> >> I've got to a loose design that I like, but it'd be good to get some
> >> feedback, as well as hearing what other game devs would want in a
> >> binary conflict system.
> >
> > Please do share, and I would be happy to provide feedback (and make
> > proposals to integrate favorable parts of your ideas into Git LFS).
>
> All of this is obviously correct as far as git-lfs goes. Just to use
> this as a jump-off comment on the topic of file locking and to frame
> this discussion more generally.
>
> It's true that a tool like git-lfs "requires the use of a centralized
> [...] server" for file locking, but it's not the case that a feature
> like file locking requires a centralized authority.
>
> In particular, git-lfs unlike git-annex (which preceded it) does the
> opposite of (to quote John upthread) "avoid[...] as much centralization
> as possible", it *is* explicitly a centralized large file solution, not
> a distributed one, as opposed to git-annex.
>
> That's not a critique of git-lfs or the centralized method, or a
> recommendation for decentralization in this context, but we already have
> a similar distributed solution in the form of git-annex, it's just a hop
> skip and a jump away from changing "who has the file" to "who has the
> lock".
>
> So how does that work? In the centralized case like
> git-lfs/cvs/p4/whatever you have some "lock/unlock" command, and it
> locks a file on a central server, locking is usually a a [locked?, who]
> state of "is it locked" and "who locked it?". Usually this is also
> followed-up on the client-side by checking those files out without the
> "w" flag.
>
> In the hypothetical git-annex-like case (simplifying a bit for the
> purposes this explanation), for every FILE in your tree you have a
> corresponding FILE.lock file, but it's not a boolean, but a log of who's
> asked for locks, i.e. lines of:
>
>     <repository UUID> <ts> <state> <who (email?)> <explanation?>
>
> E.g.:
>
>     $ cat Makefile.lock
>     my-random-per-repo-id 2018-09-15 1 avarab@gmail.com "refactoring all Makefiles"
>     my-random-per-repo-id 2018-09-16 0 avarab@gmail.com "done!"
>
> This log is append-only, when clients encounter conflicts there's a
> merge driver to ensure that all updates are kept.
>
> You can then enact a policy saying you care or don't care about updates
> from certain sources, or ignore locks older than so-and-so.
>
> None of this is stuff I'd really recommend. It's just instructive to
> point out that if someone wants a distributed locking solution for git,
> it pretty much already exists, you can even (ab)use git-annex for it
> today with a tiny hack on top.
>
> I.e. each time you want to lock a file called Makefile just:
>
>     echo We created a lock for this >Makefile.lock &&
>     git annex add Makefile.lock &&
>     git annex sync
>
> And to release the lock:
>
>     git annex rm Makefile.lock &&
>     git annex sync
>
> Then you and others using this just mentally pretend (or setup aliases)
> that the following mapping exists:
>
>     git annex get <file> && git annex sync ==> git lockit <file>
>     git annex rm <file>  && git annex sync ==> git unlockit <file>
>
> And that stuff like "git annex whereis" (designed to list "who has the
> files") means "git annex who-has-locks".
>
> Then you'd change the post-{checkout,merge} hooks to list the locks
> "tracked annex files", chmod -w appropriately, and voila, a distributed
> locking solution for git built on top of an existing tool you can
> implement in a couple of hours.
>
> Now, if I were in a game studio like this would I do any of this? Nope,
> I think even if you go for locks something like the centralized git-lfs
> approach is simpler and probably more appropriate (you presumably want
> to be centralized anyway).
>
> But to be honest I don't really get the need for this given something
> like the use-case noted upthread:
>
>     > John Austin <john@astrangergravity.com> wrote:
>     > An essential example would be a team of 5 audio designers working
>     > together on the SFX for a game. If one designer wants to add a layer
>     > of ambience to 40% of the .wav files, they have to coordinate with
>     > everyone else on the project manually.
>
> If you have 5 people working on a project together, isn't it more
> straightforward to post in IRC/E-Mail:
>
>     Hey @all, don't change *.wav files for the next couple of days,
>     major refactoring.
>
> That's what we do all the time over in the non-game-non-binary-assets SW
> development world, and I daresay that even if you have textual
> conflicts, they're sometimes just as hard to solve.
>
> I.e. you can have two people unaware of each other on a team starting to
> in parallel refactor the same set of code in two completely different
> ways, needing a lot of manual merging / throwing out of most of one
> implementation. The way that's usually dealt with is something like the
> above example post to a ML.
>
> But maybe I'm just not imagining the use-cases.
>

