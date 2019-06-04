Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEF151F462
	for <e@80x24.org>; Tue,  4 Jun 2019 01:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfFDBck (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 21:32:40 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:36616 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfFDBck (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 21:32:40 -0400
Received: by mail-qk1-f175.google.com with SMTP id g18so1798924qkl.3
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 18:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=EoEfHprU8T6lTwI7tDTjh/OkRBmvM/3Bhz2GBzekyYI=;
        b=hyPYxl/+ybnqT+rMmuymC6ZVHDnQkoWaivxdBy6eYjyDg91FNlsWPJvh5PBgYSSjOa
         3sKz8tysIU2tAJRt6mFVeK8KElH/rL7A/3cyN7lnd3UgTFuUqxUwbwP0DHM96aCoueLh
         J60LtFkE//9W1J/KX4GqJkH55ID9CfXq0YAnetwWmkwB7YpKAWUzF32zuriRaZxpVIfy
         IvifL0wDHtZlPavi/HThCVEofd40yvGLY22otgy+JOmv0J5KjKcmBL+x5NObUXphm1Yi
         KkDfNZqYZyrnuSCmnJ2Ci2FvWvDQbeA0Rt1+N/zv0BF2JewOUaUglheUBvx5R1eoWL/Y
         3RYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=EoEfHprU8T6lTwI7tDTjh/OkRBmvM/3Bhz2GBzekyYI=;
        b=bWyIlnMLGKlHmq69QXSTJA6m+5tB7to1buPtf+oFRzBd6quQIj7A4EMpuNAzt+wInF
         ijCQac1KesZ///DwILLkIgWZTFPEchcNarW6+dQEk2wZcygbs9QqVv1nAea8JAxrLnfT
         /vmJq9/fHBiZQK7aEYSA3msb+COxU5RmGq7hGrfG7PI8Iro03S0OFCrPjObujDSUbXVV
         qW4Coi1LPrzGAfuhnY2myjfeTg7y5oeBkGfkRjAQI1INCeb/Dyu+TXQv9iCduS0123RC
         kIsbOtv0tFT8NXQMbrY9yA18hnGENf8Fp5AAKWgL+gisRCLM1Zo+9Ma6RRmG02em9WXQ
         FD+g==
X-Gm-Message-State: APjAAAXss82NCbyS9LZZcJeOoX9idV7JIygtOVABVDnoJLKYTHXwr5Y2
        ks9CY8Kq0EURlDjWMXhCtU9sF4NH2GNJPY4YUgvs3A==
X-Google-Smtp-Source: APXvYqwJUWedScn8H8M0fcZOC86IEVV0Pr/wY5w+h44uBF3UAxmc4uB/kAkgthDkE9fGjq3IW/K1WSOEvQTNQP79PdQ=
X-Received: by 2002:a05:620a:13d4:: with SMTP id g20mr23992114qkl.307.1559611955768;
 Mon, 03 Jun 2019 18:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqlfyito3a.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlfyito3a.fsf@gitster-ct.c.googlers.com>
Reply-To: ben.humphreys@atlassian.com
From:   Ben Humphreys <behumphreys@atlassian.com>
Date:   Tue, 4 Jun 2019 11:32:24 +1000
Message-ID: <CAFkS+y+dS51+nHTDy+A0HrXZpfsEE1UYPN-Xk0257o36ScUOHg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.22.0-rc3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I=E2=80=99m one of the Bitbucket Server developers and I just wanted to let
you know of one of our test cases that is now failing on the 2.22.0
release candidates (tested rc2 and rc3). I=E2=80=99m still looking into it,
but figure the release is probably imminent so worth reporting sooner
than later.

The problem seems to be related to some recent changes in
merge-recursive.c. I=E2=80=99ve made available our test dataset and the
following steps will reproduce the problem:

$ git --version
git version 2.22.0.rc3

$ git clone https://bitbucket.org/ben_humphreys/merge-dataset.git
$ cd merge-dataset
$ git checkout branch_that_has_rename_add_triggering_content_conflict_trgt
$ git merge origin/branch_that_has_rename_add_triggering_content_conflict_s=
rc
Assertion failed: (a->path && b->path), function merge_3way, file
merge-recursive.c, line 1044.
Abort trap: 6

The assertion is failing because b->path is null:

(lldb) print a->path
(char *const) $2 =3D 0x00007f8e177025f8 "count.txt"
(lldb) print b->path
(char *const) $3 =3D 0x0000000000000000 <no value available>

On Git 2.21.0 the merge succeeds (with conflicts as expected):

$ git merge origin/branch_that_has_rename_add_triggering_content_conflict_s=
rc
CONFLICT (rename/add): Rename numbers.txt->count.txt in
origin/branch_that_has_rename_add_triggering_content_conflict_src.
Added count.txt in HEAD
Auto-merging version of count.txt from numbers.txt
Auto-merging count.txt
Automatic merge failed; fix conflicts and then commit the result.

I=E2=80=99ll let you know if I get any further investigating this.

Best Regards,
Ben Humphreys


On Tue, Jun 4, 2019 at 6:23 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> A release candidate Git v2.22.0-rc3 is now available for testing
> at the usual places.  It is comprised of 718 non-merge commits
> since v2.21.0, contributed by 67 people, 17 of which are new faces.
>
> Hopefully, this will be the last -rc during this cycle.
>
> The tarballs are found at:
>
>     https://www.kernel.org/pub/software/scm/git/testing/
>
> The following public repositories all have a copy of the
> 'v2.22.0-rc3' tag and the 'master' branch that the tag points at:
>
>   url =3D https://kernel.googlesource.com/pub/scm/git/git
>   url =3D git://repo.or.cz/alt-git.git
>   url =3D https://github.com/gitster/git
>
> New contributors whose contributions weren't in v2.21.0 are as follows.
> Welcome to the Git development community!
>
>   Alexander Blesius, Baruch Siach, Boxuan Li, Chris Mayo,
>   Chris. Webster, Cl=C3=A9ment Chigot, Corentin BOMPARD, Damien Robert,
>   Dustin Spicuzza, Emily Shaffer, Michal Suchanek, Rohit Ashiwal,
>   Sun Chao, Tanushree Tumane, Vadim Kochan, William Hubbs, and
>   Yash Bhatambare.
>
> Returning contributors who helped this release are as follows.
> Thanks for your continued support.
>
>   =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Alban Gruin, Alexander Shopov, =
Anders
>   Waldenborg, Andreas Heiduk, Andrei Rybak, Beat Bolli, Ben Peart,
>   Brandon Richardson, brian m. carlson, Carlo Marcelo Arenas
>   Bel=C3=B3n, Christian Couder, Daniels Umanovskis, David Aguilar,
>   David Kastrup, Denton Liu, Derrick Stolee, Elijah Newren, Eric
>   Sunshine, Eric Wong, =C4=B0smail D=C3=B6nmez, Jean-No=C3=ABl Avila, Jef=
f
>   Hostetler, Jeff King, Jiang Xin, Joel Teichroeb, Joey Hess,
>   Johannes Schindelin, Jonathan Tan, Jordi Mas, Josh Steadmon,
>   Junio C Hamano, Kyle Meyer, Martin =C3=85gren, Matthew Kraai, Mike
>   Hommey, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy, Paul-Sebastian Ungur=
eanu,
>   Philip Oakley, Phillip Wood, Ramsay Jones, Ren=C3=A9 Scharfe,
>   Robert P. J. Day, Sven Strickroth, SZEDER G=C3=A1bor, Taylor Blau,
>   Thomas Gummerer, Todd Zullinger, Torsten B=C3=B6gershausen, and
>   Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n.
>
> ----------------------------------------------------------------
>
> Git 2.22 Release Notes (draft)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> Updates since v2.21
> -------------------
>
> Backward compatibility note
>
>  * The filter specification "--filter=3Dsparse:path=3D<path>" used to
>    create a lazy/partial clone has been removed.  Using a blob that is
>    part of the project as sparse specification is still supported with
>    the "--filter=3Dsparse:oid=3D<blob>" option.
>
> UI, Workflows & Features
>
>  * "git checkout --no-overlay" can be used to trigger a new mode of
>    checking out paths out of the tree-ish, that allows paths that
>    match the pathspec that are in the current index and working tree
>    and are not in the tree-ish.
>
>  * The %(trailers) formatter in "git log --format=3D..."  now allows to
>    optionally pick trailers selectively by keyword, show only values,
>    etc.
>
>  * Four new configuration variables {author,committer}.{name,email}
>    have been introduced to override user.{name,email} in more specific
>    cases.
>
>  * Command-line completion (in contrib/) learned to tab-complete the
>    "git submodule absorbgitdirs" subcommand.
>
>  * "git branch" learned a new subcommand "--show-current".
>
>  * Output from "diff --cc" did not show the original paths when the
>    merge involved renames.  A new option adds the paths in the
>    original trees to the output.
>
>  * The command line completion (in contrib/) has been taught to
>    complete more subcommand parameters.
>
>  * The final report from "git bisect" used to show the suspected
>    culprit using a raw "diff-tree", with which there is no output for
>    a merge commit.  This has been updated to use a more modern and
>    human readable output that still is concise enough.
>
>  * "git rebase --rebase-merges" replaces its old "--preserve-merges"
>    option; the latter is now marked as deprecated.
>
>  * Error message given while cloning with --recurse-submodules has
>    been updated.
>
>  * The completion helper code now pays attention to repository-local
>    configuration (when available), which allows --list-cmds to honour
>    a repository specific setting of completion.commands, for example.
>
>  * "git mergetool" learned to offer Sublime Merge (smerge) as one of
>    its backends.
>
>  * A new hook "post-index-change" is called when the on-disk index
>    file changes, which can help e.g. a virtualized working tree
>    implementation.
>
>  * "git difftool" can now run outside a repository.
>
>  * "git checkout -m <other>" was about carrying the differences
>    between HEAD and the working-tree files forward while checking out
>    another branch, and ignored the differences between HEAD and the
>    index.  The command has been taught to abort when the index and the
>    HEAD are different.
>
>  * A progress indicator has been added to the "index-pack" step, which
>    often makes users wait for completion during "git clone".
>
>  * "git submodule" learns "set-branch" subcommand that allows the
>    submodule.*.branch settings to be modified.
>
>  * "git merge-recursive" backend recently learned a new heuristics to
>    infer file movement based on how other files in the same directory
>    moved.  As this is inherently less robust heuristics than the one
>    based on the content similarity of the file itself (rather than
>    based on what its neighbours are doing), it sometimes gives an
>    outcome unexpected by the end users.  This has been toned down to
>    leave the renamed paths in higher/conflicted stages in the index so
>    that the user can examine and confirm the result.
>
>  * "git tag" learned to give an advice suggesting it might be a
>    mistake when creating an annotated or signed tag that points at
>    another tag.
>
>  * The "git pack-objects" command learned to report the number of
>    objects it packed via the trace2 mechanism.
>
>  * The list of conflicted paths shown in the editor while concluding a
>    conflicted merge was shown above the scissors line when the
>    clean-up mode is set to "scissors", even though it was commented
>    out just like the list of updated paths and other information to
>    help the user explain the merge better.
>
>  * The trace2 tracing facility learned to auto-generate a filename
>    when told to log to a directory.
>
>  * "git clone" learned a new --server-option option when talking over
>    the protocol version 2.
>
>  * The connectivity bitmaps are created by default in bare
>    repositories now; also the pathname hash-cache is created by
>    default to avoid making crappy deltas when repacking.
>
>  * "git branch new A...B" and "git checkout -b new A...B" have been
>    taught that in their contexts, the notation A...B means "the merge
>    base between these two commits", just like "git checkout A...B"
>    detaches HEAD at that commit.
>
>  * Update "git difftool" and "git mergetool" so that the combinations
>    of {diff,merge}.{tool,guitool} configuration variables serve as
>    fallback settings of each other in a sensible order.
>
>  * The "--dir-diff" mode of "git difftool" is not useful in "--no-index"
>    mode; they are now explicitly marked as mutually incompatible.
>
>
> Performance, Internal Implementation, Development Support etc.
>
>  * The diff machinery, one of the oldest parts of the system, which
>    long predates the parse-options API, uses fairly long and complex
>    handcrafted option parser.  This is being rewritten to use the
>    parse-options API.
>
>  * The implementation of pack-redundant has been updated for
>    performance in a repository with many packfiles.
>
>  * A more structured way to obtain execution trace has been added.
>
>  * "git prune" has been taught to take advantage of reachability
>    bitmap when able.
>
>  * The command line parser of "git commit-tree" has been rewritten to
>    use the parse-options API.
>
>  * Suggest GitGitGadget instead of submitGit as a way to submit
>    patches based on GitHub PR to us.
>
>  * The test framework has been updated to help developers by making it
>    easier to run most of the tests under different versions of
>    over-the-wire protocols.
>
>  * Dev support update to make it easier to compare two formatted
>    results from our documentation.
>
>  * The scripted "git rebase" implementation has been retired.
>
>  * "git multi-pack-index verify" did not scale well with the number of
>    packfiles, which is being improved.
>
>  * "git stash" has been rewritten in C.
>
>  * The "check-docs" Makefile target to support developers has been
>    updated.
>
>  * The tests have been updated not to rely on the abbreviated option
>    names the parse-options API offers, to protect us from an
>    abbreviated form of an option that used to be unique within the
>    command getting non-unique when a new option that share the same
>    prefix is added.
>
>  * The scripted version of "git rebase -i" wrote and rewrote the todo
>    list many times during a single step of its operation, and the
>    recent C-rewrite made a faithful conversion of the logic to C.  The
>    implementation has been updated to carry necessary information
>    around in-core to avoid rewriting the same file over and over
>    unnecessarily.
>
>  * Test framework update to more robustly clean up leftover files and
>    processes after tests are done.
>
>  * Conversion from unsigned char[20] to struct object_id continues.
>
>  * While running "git diff" in a lazy clone, we can upfront know which
>    missing blobs we will need, instead of waiting for the on-demand
>    machinery to discover them one by one.  The code learned to aim to
>    achieve better performance by batching the request for these
>    promised blobs.
>
>  * During an initial "git clone --depth=3D..." partial clone, it is
>    pointless to spend cycles for a large portion of the connectivity
>    check that enumerates and skips promisor objects (which by
>    definition is all objects fetched from the other side).  This has
>    been optimized out.
>
>  * Mechanically and systematically drop "extern" from function
>    declaration.
>
>  * The script to aggregate perf result unconditionally depended on
>    libjson-perl even though it did not have to, which has been
>    corrected.
>
>  * The internal implementation of "git rebase -i" has been updated to
>    avoid forking a separate "rebase--interactive" process.
>
>  * Allow DEP and ASLR for Windows build to for security hardening.
>
>  * Performance test framework has been broken and measured the version
>    of Git that happens to be on $PATH, not the specified one to
>    measure, for a while, which has been corrected.
>
>  * Optionally "make coccicheck" can feed multiple source files to
>    spatch, gaining performance while spending more memory.
>
>  * Attempt to use an abbreviated option in "git clone --recurs" is
>    responded by a request to disambiguate between --recursive and
>    --recurse-submodules, which is bad because these two are synonyms.
>    The parse-options API has been extended to define such synonyms
>    more easily and not produce an unnecessary failure.
>
>  * A pair of private functions in http.c that had names similar to
>    fread/fwrite did not return the number of elements, which was found
>    to be confusing.
>
>  * Update collision-detecting SHA-1 code to build properly on HP-UX.
>
>
> Fixes since v2.21
> -----------------
>
>  * "git prune-packed" did not notice and complain against excess
>    arguments given from the command line, which now it does.
>    (merge 9b0bd87ed2 rj/prune-packed-excess-args later to maint).
>
>  * Split-index fix.
>    (merge 6e37c8ed3c nd/split-index-null-base-fix later to maint).
>
>  * "git diff --no-index" may still want to access Git goodies like
>    --ext-diff and --textconv, but so far these have been ignored,
>    which has been corrected.
>    (merge 287ab28bfa jk/diff-no-index-initialize later to maint).
>
>  * Unify RPC code for smart http in protocol v0/v1 and v2, which fixes
>    a bug in the latter (lack of authentication retry) and generally
>    improves the code base.
>    (merge a97d00799a jt/http-auth-proto-v2-fix later to maint).
>
>  * The include file compat/bswap.h has been updated so that it is safe
>    to (accidentally) include it more than once.
>    (merge 33aa579a55 jk/guard-bswap-header later to maint).
>
>  * The set of header files used by "make hdr-check" unconditionally
>    included sha256/gcrypt.h, even when it is not used, causing the
>    make target to fail.  We now skip it when GCRYPT_SHA256 is not in
>    use.
>    (merge f23aa18e7f rj/hdr-check-gcrypt-fix later to maint).
>
>  * The Makefile uses 'find' utility to enumerate all the *.h header
>    files, which is expensive on platforms with slow filesystems; it
>    now optionally uses "ls-files" if working within a repository,
>    which is a trick similar to how all sources are enumerated to run
>    ETAGS on.
>    (merge 92b88eba9f js/find-lib-h-with-ls-files-when-possible later to m=
aint).
>
>  * "git rebase" that was reimplemented in C did not set ORIG_HEAD
>    correctly, which has been corrected.
>    (merge cbd29ead92 js/rebase-orig-head-fix later to maint).
>
>  * Dev support.
>    (merge f545737144 js/stress-test-ui-tweak later to maint).
>
>  * CFLAGS now can be tweaked when invoking Make while using
>    DEVELOPER=3DYesPlease; this did not work well before.
>    (merge 6d5d4b4e93 ab/makefile-help-devs-more later to maint).
>
>  * "git fsck --connectivity-only" omits computation necessary to sift
>    the objects that are not reachable from any of the refs into
>    unreachable and dangling.  This is now enabled when dangling
>    objects are requested (which is done by default, but can be
>    overridden with the "--no-dangling" option).
>    (merge 8d8c2a5aef jk/fsck-doc later to maint).
>
>  * On platforms where "git fetch" is killed with SIGPIPE (e.g. OSX),
>    the upload-pack that runs on the other end that hangs up after
>    detecting an error could cause "git fetch" to die with a signal,
>    which led to a flaky test.  "git fetch" now ignores SIGPIPE during
>    the network portion of its operation (this is not a problem as we
>    check the return status from our write(2)s).
>    (merge 143588949c jk/no-sigpipe-during-network-transport later to main=
t).
>
>  * A recent update broke "is this object available to us?" check for
>    well-known objects like an empty tree (which should yield "yes",
>    even when there is no on-disk object for an empty tree), which has
>    been corrected.
>    (merge f06ab027ef jk/virtual-objects-do-exist later to maint).
>
>  * The setup code has been cleaned up to avoid leaks around the
>    repository_format structure.
>    (merge e8805af1c3 ma/clear-repository-format later to maint).
>
>  * "git config --type=3Dcolor ..." is meant to replace "git config --get-=
color"
>    but there is a slight difference that wasn't documented, which is
>    now fixed.
>    (merge cd8e7593b9 jk/config-type-color-ends-with-lf later to maint).
>
>  * When the "clean" filter can reduce the size of a huge file in the
>    working tree down to a small "token" (a la Git LFS), there is no
>    point in allocating a huge scratch area upfront, but the buffer is
>    sized based on the original file size.  The convert mechanism now
>    allocates very minimum and reallocates as it receives the output
>    from the clean filter process.
>    (merge 02156ab031 jh/resize-convert-scratch-buffer later to maint).
>
>  * "git rebase" uses the refs/rewritten/ hierarchy to store its
>    intermediate states, which inherently makes the hierarchy per
>    worktree, but it didn't quite work well.
>    (merge b9317d55a3 nd/rewritten-ref-is-per-worktree later to maint).
>
>  * "git log -L<from>,<to>:<path>" with "-s" did not suppress the patch
>    output as it should.  This has been corrected.
>    (merge 05314efaea jk/line-log-with-patch later to maint).
>
>  * "git worktree add" used to do a "find an available name with stat
>    and then mkdir", which is race-prone.  This has been fixed by using
>    mkdir and reacting to EEXIST in a loop.
>    (merge 7af01f2367 ms/worktree-add-atomic-mkdir later to maint).
>
>  * Build update for SHA-1 with collision detection.
>    (merge 07a20f569b jk/sha1dc later to maint).
>
>  * Build procedure has been fixed around use of asciidoctor instead of
>    asciidoc.
>    (merge 185f9a0ea0 ma/asciidoctor-fixes later to maint).
>
>  * remote-http transport did not anonymize URLs reported in its error
>    messages at places.
>    (merge c1284b21f2 js/anonymize-remote-curl-diag later to maint).
>
>  * Error messages given from the http transport have been updated so
>    that they can be localized.
>    (merge ed8b4132c8 js/remote-curl-i18n later to maint).
>
>  * "git init" forgot to read platform-specific repository
>    configuration, which made Windows port to ignore settings of
>    core.hidedotfiles, for example.
>
>  * A corner-case object name ambiguity while the sequencer machinery
>    is working (e.g. "rebase -i -x") has been fixed.
>
>  * "git format-patch" did not diagnose an error while opening the
>    output file for the cover-letter, which has been corrected.
>    (merge 2fe95f494c jc/format-patch-error-check later to maint).
>
>  * "git checkout -f <branch>" while the index has an unmerged path
>    incorrectly left some paths in an unmerged state, which has been
>    corrected.
>
>  * A corner case bug in the refs API has been corrected.
>    (merge d3322eb28b jk/refs-double-abort later to maint).
>
>  * Unicode update.
>    (merge 584b62c37b bb/unicode-12 later to maint).
>
>  * dumb-http walker has been updated to share more error recovery
>    strategy with the normal codepath.
>
>  * A buglet in configuration parser has been fixed.
>    (merge 19e7fdaa58 nd/include-if-wildmatch later to maint).
>
>  * The documentation for "git read-tree --reset -u" has been updated.
>    (merge b5a0bd694c nd/read-tree-reset-doc later to maint).
>
>  * Code clean-up around a much-less-important-than-it-used-to-be
>    update_server_info() function.
>    (merge b3223761c8 jk/server-info-rabbit-hole later to maint).
>
>  * The message given when "git commit -a <paths>" errors out has been
>    updated.
>    (merge 5a1dbd48bc nd/commit-a-with-paths-msg-update later to maint).
>
>  * "git cherry-pick --options A..B", after giving control back to the
>    user to ask help resolving a conflicted step, did not honor the
>    options it originally received, which has been corrected.
>
>  * Various glitches in "git gc" around reflog handling have been fixed.
>
>  * The code to read from commit-graph file has been cleanup with more
>    careful error checking before using data read from it.
>
>  * Performance fix around "git fetch" that grabs many refs.
>    (merge b764300912 jt/fetch-pack-wanted-refs-optim later to maint).
>
>  * Protocol v2 support in "git fetch-pack" of shallow clones has been
>    corrected.
>
>  * Performance fix around "git blame", especially in a linear history
>    (which is the norm we should optimize for).
>    (merge f892014943 dk/blame-keep-origin-blob later to maint).
>
>  * Performance fix for "rev-list --parents -- pathspec".
>    (merge 8320b1dbe7 jk/revision-rewritten-parents-in-prio-queue later to=
 maint).
>
>  * Updating the display with progress message has been cleaned up to
>    deal better with overlong messages.
>    (merge 545dc345eb sg/overlong-progress-fix later to maint).
>
>  * "git blame -- path" in a non-bare repository starts blaming from
>    the working tree, and the same command in a bare repository errors
>    out because there is no working tree by definition.  The command
>    has been taught to instead start blaming from the commit at HEAD,
>    which is more useful.
>    (merge a544fb08f8 sg/blame-in-bare-start-at-head later to maint).
>
>  * An underallocation in the code to read the untracked cache
>    extension has been corrected.
>    (merge 3a7b45a623 js/untracked-cache-allocfix later to maint).
>
>  * The code is updated to check the result of memory allocation before
>    it is used in more places, by using xmalloc and/or xcalloc calls.
>    (merge 999b951b28 jk/xmalloc later to maint).
>
>  * The GETTEXT_POISON test option has been quite broken ever since it
>    was made runtime-tunable, which has been fixed.
>    (merge f88b9cb603 jc/gettext-test-fix later to maint).
>
>  * Test fix on APFS that is incapable of store paths in Latin-1.
>    (merge 3889149619 js/iso8895-test-on-apfs later to maint).
>
>  * "git submodule foreach <command> --quiet" did not pass the option
>    down correctly, which has been corrected.
>    (merge a282f5a906 nd/submodule-foreach-quiet later to maint).
>
>  * "git send-email" has been taught to use quoted-printable when the
>    payload contains carriage-return.  The use of the mechanism is in
>    line with the design originally added the codepath that chooses QP
>    when the payload has overly long lines.
>    (merge 74d76a1701 bc/send-email-qp-cr later to maint).
>
>  * The recently added feature to add addresses that are on
>    anything-by: trailers in 'git send-email' was found to be way too
>    eager and considered nonsense strings as if they can be legitimate
>    beginning of *-by: trailer.  This has been tightened.
>
>  * Builds with gettext broke on recent macOS w/ Homebrew, which
>    seems to have stopped including from /usr/local/include; this
>    has been corrected.
>    (merge 92a1377a2a js/macos-gettext-build later to maint).
>
>  * Running "git add" on a repository created inside the current
>    repository is an explicit indication that the user wants to add it
>    as a submodule, but when the HEAD of the inner repository is on an
>    unborn branch, it cannot be added as a submodule.  Worse, the files
>    in its working tree can be added as if they are a part of the outer
>    repository, which is not what the user wants.  These problems are
>    being addressed.
>    (merge f937bc2f86 km/empty-repo-is-still-a-repo later to maint).
>
>  * "git cherry-pick" run with the "-x" or the "--signoff" option used
>    to (and more importantly, ought to) clean up the commit log message
>    with the --cleanup=3Dspace option by default, but this has been
>    broken since late 2017.  This has been fixed.
>
>  * When given a tag that points at a commit-ish, "git replace --graft"
>    failed to peel the tag before writing a replace ref, which did not
>    make sense because the old graft mechanism the feature wants to
>    mimic only allowed to replace one commit object with another.
>    This has been fixed.
>    (merge ee521ec4cb cc/replace-graft-peel-tags later to maint).
>
>  * Code tightening against a "wrong" object appearing where an object
>    of a different type is expected, instead of blindly assuming that
>    the connection between objects are correctly made.
>    (merge 97dd512af7 tb/unexpected later to maint).
>
>  * An earlier update for MinGW and Cygwin accidentally broke MSVC build,
>    which has been fixed.
>    (merge 22c3634c0f ss/msvc-path-utils-fix later to maint).
>
>  * %(push:track) token used in the --format option to "git
>    for-each-ref" and friends was not showing the right branch, which
>    has been fixed.
>    (merge c646d0934e dr/ref-filter-push-track-fix later to maint).
>
>  * "make check-docs", "git help -a", etc. did not account for cases
>    where a particular build may deliberately omit some subcommands,
>    which has been corrected.
>
>  * The logic to tell if a Git repository has a working tree protects
>    "git branch -D" from removing the branch that is currently checked
>    out by mistake.  The implementation of this logic was broken for
>    repositories with unusual name, which unfortunately is the norm for
>    submodules these days.  This has been fixed.
>    (merge f3534c98e4 jt/submodule-repo-is-with-worktree later to maint).
>
>  * AIX shared the same build issues with other BSDs around fileno(fp),
>    which has been corrected.
>    (merge ee662bf5c6 cc/aix-has-fileno-as-a-macro later to maint).
>
>  * The autoconf generated configure script failed to use the right
>    gettext() implementations from -libintl by ignoring useless stub
>    implementations shipped in some C library, which has been
>    corrected.
>    (merge b71e56a683 vk/autoconf-gettext later to maint).
>
>  * Fix index-pack perf test so that the repeated invocations always
>    run in an empty repository, which emulates the initial clone
>    situation better.
>    (merge 775c71e16d jk/p5302-avoid-collision-check-cost later to maint).
>
>  * A "ls-files" that emulates "find" to enumerate files in the working
>    tree resulted in duplicated Makefile rules that caused the build to
>    issue an unnecessary warning during a trial build after merge
>    conflicts are resolved in working tree *.h files but before the
>    resolved results are added to the index.  This has been corrected.
>
>  * "git cherry-pick" (and "revert" that shares the same runtime engine)
>    that deals with multiple commits got confused when the final step
>    gets stopped with a conflict and the user concluded the sequence
>    with "git commit".  Attempt to fix it by cleaning up the state
>    files used by these commands in such a situation.
>    (merge 4a72486de9 pw/clean-sequencer-state-upon-final-commit later to =
maint).
>
>  * On a filesystem like HFS+, the names of the refs stored as filesystem
>    entities may become different from what the end-user expects, just
>    like files in the working tree get "renamed".  Work around the
>    mismatch by paying attention to the core.precomposeUnicode
>    configuration.
>    (merge 8e712ef6fc en/unicode-in-refnames later to maint).
>
>  * The code to generate the multi-pack idx file was not prepared to
>    see too many packfiles and ran out of open file descriptor, which
>    has been corrected.
>
>  * To run tests for Git SVN, our scripts for CI used to install the
>    git-svn package (in the hope that it would bring in the right
>    dependencies).  This has been updated to install the more direct
>    dependency, namely, libsvn-perl.
>    (merge db864306cf sg/ci-libsvn-perl later to maint).
>
>  * "git cvsexportcommit" running on msys did not expect cvsnt showed
>    "cvs status" output with CRLF line endings.
>
>  * The fsmonitor interface got out of sync after the in-core index
>    file gets discarded, which has been corrected.
>    (merge 398a3b0899 js/fsmonitor-refresh-after-discarding-index later to=
 maint).
>
>  * "git status" did not know that the "label" instruction in the
>    todo-list "rebase -i -r" uses should not be shown as a hex object
>    name.
>
>  * A prerequisite check in the test suite to see if a working jgit is
>    available was made more robust.
>    (merge abd0f28983 tz/test-lib-check-working-jgit later to maint).
>
>  * The codepath to parse :<path> that obtains the object name for an
>    indexed object has been made more robust.
>
>  * Code cleanup, docfix, build fix, etc.
>    (merge 11f470aee7 jc/test-yes-doc later to maint).
>    (merge 90503a240b js/doc-symref-in-proto-v1 later to maint).
>    (merge 5c326d1252 jk/unused-params later to maint).
>    (merge 68cabbfda3 dl/doc-submodule-wo-subcommand later to maint).
>    (merge 9903623761 ab/receive-pack-use-after-free-fix later to maint).
>    (merge 1ede45e44b en/merge-options-doc later to maint).
>    (merge 3e14dd2c8e rd/doc-hook-used-in-sample later to maint).
>    (merge c271dc28fd nd/no-more-check-racy later to maint).
>    (merge e6e15194a8 yb/utf-16le-bom-spellfix later to maint).
>    (merge bb101aaf0c rd/attr.c-comment-typofix later to maint).
>    (merge 716a5af812 rd/gc-prune-doc-fix later to maint).
>    (merge 50b206371d js/untravis-windows later to maint).
>    (merge dbf47215e3 js/rebase-recreate-merge later to maint).
>    (merge 56cb2d30f8 dl/reset-doc-no-wrt-abbrev later to maint).
>    (merge 64eca306a2 ja/dir-rename-doc-markup-fix later to maint).
>    (merge af91b0230c dl/ignore-docs later to maint).
>    (merge 59a06e947b ra/t3600-test-path-funcs later to maint).
>    (merge e041d0781b ar/t4150-remove-cruft later to maint).
>    (merge 8d75a1d183 ma/asciidoctor-fixes-more later to maint).
>    (merge 74cc547b0f mh/pack-protocol-doc-fix later to maint).
>    (merge ed31851fa6 ab/doc-misc-typofixes later to maint).
>    (merge a7256debd4 nd/checkout-m-doc-update later to maint).
>    (merge 3a9e1ad78d jt/t5551-protocol-v2-does-not-have-half-auth later t=
o maint).
>    (merge 0b918b75af sg/t5318-cleanup later to maint).
>    (merge 68ed71b53c cb/doco-mono later to maint).
>    (merge a34dca2451 nd/interpret-trailers-docfix later to maint).
>    (merge cf7b857a77 en/fast-import-parsing-fix later to maint).
>    (merge fe61ccbc35 po/rerere-doc-fmt later to maint).
>    (merge ffea0248bf po/describe-not-necessarily-7 later to maint).
>    (merge 7cb7283adb tg/ls-files-debug-format-fix later to maint).
>    (merge f64a21bd82 tz/doc-apostrophe-no-longer-needed later to maint).
>    (merge dbe7b41019 js/t3301-unbreak-notes-test later to maint).
>    (merge d8083e4180 km/t3000-retitle later to maint).
>    (merge 9e4cbccbd7 tz/git-svn-doc-markup-fix later to maint).
>    (merge da9ca955a7 jk/ls-files-doc-markup-fix later to maint).
>    (merge 6804ba3a58 cw/diff-highlight later to maint).
>    (merge 1a8787144d nd/submodule-helper-incomplete-line-fix later to mai=
nt).
>    (merge d9ef573837 jk/apache-lsan later to maint).
>    (merge c871fbee2b js/t6500-use-windows-pid-on-mingw later to maint).
>    (merge ce4c7bfc90 bl/t4253-exit-code-from-format-patch later to maint)=
.
>    (merge 397a46db78 js/t5580-unc-alternate-test later to maint).
>    (merge d4907720a2 cm/notes-comment-fix later to maint).
>    (merge 9dde06de13 cb/http-push-null-in-message-fix later to maint).
>    (merge 4c785c0edc js/rebase-config-bitfix later to maint).
>    (merge 8e9fe16c87 es/doc-gitsubmodules-markup later to maint).
>
> ----------------------------------------------------------------
>
> Changes since v2.21.0 are as follows:
>
> Alban Gruin (18):
>       sequencer: changes in parse_insn_buffer()
>       sequencer: make the todo_list structure public
>       sequencer: remove the 'arg' field from todo_item
>       sequencer: refactor transform_todos() to work on a todo_list
>       sequencer: introduce todo_list_write_to_file()
>       sequencer: refactor check_todo_list() to work on a todo_list
>       sequencer: refactor sequencer_add_exec_commands() to work on a todo=
_list
>       sequencer: refactor rearrange_squash() to work on a todo_list
>       sequencer: make sequencer_make_script() write its script to a strbu=
f
>       sequencer: change complete_action() to use the refactored functions
>       rebase--interactive: move sequencer_add_exec_commands()
>       rebase--interactive: move rearrange_squash_in_todo_file()
>       sequencer: refactor skip_unnecessary_picks() to work on a todo_list
>       rebase-interactive: use todo_list_write_to_file() in edit_todo_list=
()
>       rebase-interactive: append_todo_help() changes
>       rebase-interactive: rewrite edit_todo_list() to handle the initial =
edit
>       sequencer: use edit_todo_list() in complete_action()
>       rebase--interactive: move transform_todo_file()
>
> Alexander Blesius (1):
>       doc: fix typos in man pages
>
> Alexander Shopov (1):
>       gitk: Update Bulgarian translation (317t)
>
> Anders Waldenborg (7):
>       doc: group pretty-format.txt placeholders descriptions
>       pretty: allow %(trailers) options with explicit value
>       pretty: single return path in %(trailers) handling
>       pretty: allow showing specific trailers
>       pretty: add support for "valueonly" option in %(trailers)
>       strbuf: separate callback for strbuf_expand:ing literals
>       pretty: add support for separator option in %(trailers)
>
> Andreas Heiduk (1):
>       revisions.txt: remove ambibuity between <rev>:<path> and :<path>
>
> Andrei Rybak (1):
>       t4150: remove unused variable
>
> Baruch Siach (1):
>       send-email: don't cc *-by lines with '-' prefix
>
> Beat Bolli (1):
>       unicode: update the width tables to Unicode 12
>
> Ben Peart (1):
>       read-cache: add post-index-change hook
>
> Boxuan Li (1):
>       t4253-am-keep-cr-dos: avoid using pipes
>
> Brandon Richardson (1):
>       commit-tree: utilize parse-options api
>
> Carlo Marcelo Arenas Bel=C3=B3n (1):
>       http-push: prevent format overflow warning with gcc >=3D 9
>
> Chris Mayo (1):
>       notes: correct documentation of format_display_notes()
>
> Chris. Webster (1):
>       diff-highlight: use correct /dev/null for UNIX and Windows
>
> Christian Couder (5):
>       t6050: use test_line_count instead of wc -l
>       t6050: redirect expected error output to a file
>       replace: peel tag when passing a tag as parent to --graft
>       replace: peel tag when passing a tag first to --graft
>       list-objects-filter: disable 'sparse:path' filters
>
> Cl=C3=A9ment Chigot (2):
>       Makefile: use fileno macro work around on AIX
>       git-compat-util: work around for access(X_OK) under root
>
> Corentin BOMPARD (2):
>       doc/CodingGuidelines: URLs and paths as monospace
>       doc: format pathnames and URLs as monospace.
>
> Damien Robert (1):
>       ref-filter: use correct branch for %(push:track)
>
> Daniels Umanovskis (1):
>       branch: introduce --show-current display option
>
> David Aguilar (2):
>       mergetools: add support for smerge (Sublime Merge)
>       contrib/completion: add smerge to the mergetool completion candidat=
es
>
> David Kastrup (1):
>       blame.c: don't drop origin blobs as eagerly
>
> Denton Liu (38):
>       completion: complete git submodule absorbgitdirs
>       git-submodule.txt: "--branch <branch>" option defaults to 'master'
>       submodule--helper: teach config subcommand --unset
>       submodule: document default behavior
>       git-reset.txt: clarify documentation
>       git-clean.txt: clarify ignore pattern files
>       docs: move core.excludesFile from git-add to gitignore
>       contrib/subtree: ensure only one rev is provided
>       midx.c: convert FLEX_ALLOC_MEM to FLEX_ALLOC_STR
>       cocci: FLEX_ALLOC_MEM to FLEX_ALLOC_STR
>       tag: fix formatting
>       submodule: teach set-branch subcommand
>       tag: advise on nested tags
>       t7600: clean up style
>       t3507: clean up style
>       t7604: clean up style
>       t7502: clean up style
>       commit: extract cleanup_mode functions to sequencer
>       parse-options.h: extract common --cleanup option
>       merge: cleanup messages like commit
>       merge: add scissors line on merge conflict
>       cherry-pick/revert: add scissors line on merge conflict
>       t7610: unsuppress output
>       t7610: add mergetool --gui tests
>       *.[ch]: remove extern from function declarations using spatch
>       *.[ch]: remove extern from function declarations using sed
>       *.[ch]: manually align parameter lists
>       t2018: cleanup in current test
>       branch: make create_branch accept a merge base rev
>       revisions.txt: change "rev" to "<rev>"
>       revisions.txt: mark optional rev arguments with []
>       revisions.txt: mention <rev>~ form
>       tag: fix typo in nested tagging hint
>       mergetool: use get_merge_tool function
>       mergetool--lib: create gui_mode function
>       mergetool: fallback to tool when guitool unavailable
>       difftool: make --gui, --tool and --extcmd mutually exclusive
>       difftool: fallback on merge.guitool
>
> Derrick Stolee (4):
>       trace2:data: pack-objects: add trace2 regions
>       midx: pass a repository pointer
>       midx: add packs to packed_git linked list
>       trace2: add variable description to git.txt
>
> Dustin Spicuzza (1):
>       cvsexportcommit: force crlf translation
>
> Elijah Newren (23):
>       log,diff-tree: add --combined-all-paths option
>       merge-options.txt: correct wording of --no-commit option
>       t9300: demonstrate bug with get-mark and empty orphan commits
>       git-fast-import.txt: fix wording about where ls command can appear
>       fast-import: check most prominent commands first
>       fast-import: only allow cat-blob requests where it makes sense
>       fast-import: fix erroneous handling of get-mark with empty orphan c=
ommits
>       Use 'unsigned short' for mode, like diff_filespec does
>       merge-recursive: rename merge_options argument from 'o' to 'opt'
>       merge-recursive: rename diff_filespec 'one' to 'o'
>       merge-recursive: rename locals 'o' and 'a' to 'obuf' and 'abuf'
>       merge-recursive: use 'ci' for rename_conflict_info variable name
>       merge-recursive: move some struct declarations together
>       merge-recursive: shrink rename_conflict_info
>       merge-recursive: remove ren[12]_other fields from rename_conflict_i=
nfo
>       merge-recursive: track branch where rename occurred in rename struc=
t
>       merge-recursive: cleanup handle_rename_* function signatures
>       merge-recursive: switch from (oid,mode) pairs to a diff_filespec
>       t6043: fix copied test description to match its purpose
>       merge-recursive: track information associated with directory rename=
s
>       merge-recursive: give callers of handle_content_merge() access to c=
ontents
>       merge-recursive: switch directory rename detection default
>       Honor core.precomposeUnicode in more places
>
> Emily Shaffer (1):
>       gitsubmodules: align html and nroff lists
>
> Eric Sunshine (1):
>       check-non-portable-shell: support Perl versions older than 5.10
>
> Eric Wong (1):
>       repack: enable bitmaps by default on bare repos
>
> Jean-No=C3=ABl Avila (3):
>       l10n: fr.po remove obsolete entries
>       Doc: fix misleading asciidoc formating
>       diff: fix mistake in translatable strings
>
> Jeff Hostetler (30):
>       trace2: Documentation/technical/api-trace2.txt
>       trace2: create new combined trace facility
>       trace2: collect Windows-specific process information
>       trace2:data: add trace2 regions to wt-status
>       trace2:data: add editor/pager child classification
>       trace2:data: add trace2 sub-process classification
>       trace2:data: add trace2 transport child classification
>       trace2:data: add subverb to checkout command
>       trace2:data: add subverb to reset command
>       trace2:data: add trace2 hook classification
>       trace2:data: add subverb for rebase
>       trace2:data: add trace2 instrumentation to index read/write
>       trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
>       trace2: add for_each macros to clang-format
>       progress: add sparse mode to force 100% complete message
>       trace2:data: add trace2 data to midx
>       midx: add progress indicators in multi-pack-index verify
>       midx: during verify group objects by packfile to speed verification
>       config: initialize opts structure in repo_read_config()
>       trace2: refactor setting process starting time
>       trace2: add absolute elapsed time to start event
>       trace2: find exec-dir before trace2 initialization
>       config: add read_very_early_config()
>       trace2: use system/global config for default trace2 settings
>       trace2: report peak memory usage of the process
>       trace2: clarify UTC datetime formatting
>       trace2: make SIDs more unique
>       trace2: update docs to describe system/global config settings
>       trace2: fixup access problem on /etc/gitconfig in read_very_early_c=
onfig
>       trace2: fix tracing when NO_PTHREADS is defined
>
> Jeff King (92):
>       prune: lazily perform reachability traversal
>       prune: use bitmaps for reachability traversal
>       prune: check SEEN flag for reachability
>       t5304: rename "sha1" variables to "oid"
>       diff: drop options parameter from diffcore_fix_diff_index()
>       diff: drop unused color reset parameters
>       diff: drop unused emit data parameter from sane_truncate_line()
>       diff: drop complete_rewrite parameter from run_external_diff()
>       merge-recursive: drop several unused parameters
>       pack-objects: drop unused parameter from oe_map_new_pack()
>       files-backend: drop refs parameter from split_symref_update()
>       ref-filter: drop unused buf/sz pairs
>       ref-filter: drop unused "obj" parameters
>       ref-filter: drop unused "sz" parameters
>       diff: reuse diff setup for --no-index case
>       bisect: use string arguments to feed internal diff-tree
>       bisect: fix internal diff-tree config loading
>       bisect: make diff-tree output prettier
>       fetch: avoid calling write_or_die()
>       fetch: ignore SIGPIPE during network operation
>       rev-list: allow cached objects in existence check
>       doc/fsck: clarify --connectivity-only behavior
>       fsck: always compute USED flags for unreachable objects
>       compat/bswap: add include header guards
>       config: document --type=3Dcolor output is a complete line
>       line-log: suppress diff output with "-s"
>       line-log: detect unsupported formats
>       point pull requesters to GitGitGadget
>       Makefile: fix unaligned loads in sha1dc with UBSan
>       t5310: correctly remove bitmaps for jgit test
>       pack-objects: default to writing bitmap hash-cache
>       perf-lib.sh: rely on test-lib.sh for --tee handling
>       revision: drop some unused "revs" parameters
>       log: drop unused rev_info from early output
>       log: drop unused "len" from show_tagger()
>       update-index: drop unused prefix_length parameter from do_reupdate(=
)
>       test-date: drop unused "now" parameter from parse_dates()
>       unpack-trees: drop name_entry from traverse_by_cache_tree()
>       unpack-trees: drop unused error_type parameters
>       report_path_error(): drop unused prefix parameter
>       fetch_pack(): drop unused parameters
>       parse-options: drop unused ctx parameter from show_gitcomp()
>       pretty: drop unused "type" parameter in needs_rfc2047_encoding()
>       pretty: drop unused strbuf from parse_padding_placeholder()
>       git: read local config in --list-cmds
>       completion: fix multiple command removals
>       parse_opt_ref_sorting: always use with NONEG flag
>       refs/files-backend: handle packed transaction prepare failure
>       refs/files-backend: don't look at an aborted transaction
>       http: factor out curl result code normalization
>       http: normalize curl results for dumb loose and alternates fetches
>       http: use normalize_curl_result() instead of manual conversion
>       revision: use a prio_queue to hold rewritten parents
>       get_commit_tree(): return NULL for broken tree
>       rev-list: let traversal die when --missing is not in use
>       rev-list: detect broken root trees
>       test-prio-queue: use xmalloc
>       xdiff: use git-compat-util
>       xdiff: use xmalloc/xrealloc
>       progress: use xmalloc/xcalloc
>       t5516: drop ok=3Dsigpipe from unreachable-want tests
>       t5530: check protocol response for "not our ref"
>       upload-pack: send ERR packet for non-tip objects
>       pkt-line: prepare buffer before handling ERR packets
>       fetch: use free_refs()
>       remote.c: make singular free_ref() public
>       fetch: do not consider peeled tags as advertised tips
>       packfile.h: drop extern from function declarations
>       pack-revindex: open index if necessary
>       t5319: fix bogus cat-file argument
>       t5319: drop useless --buffer from cat-file
>       midx: check both pack and index names for containment
>       packfile: fix pack basename computation
>       http: simplify parsing of remote objects/info/packs
>       server-info: fix blind pointer arithmetic
>       server-info: simplify cleanup in parse_pack_def()
>       server-info: use strbuf to read old info/packs file
>       server-info: drop nr_alloc struct member
>       server-info: drop objdirlen pointer arithmetic
>       update_info_refs(): drop unused force parameter
>       t5304: add a test for pruning with bitmaps
>       untracked-cache: be defensive about missing NULs in index
>       untracked-cache: simplify parsing by dropping "next"
>       untracked-cache: simplify parsing by dropping "len"
>       p5302: create the repo in each index-pack test
>       doc/ls-files: put nested list for "-t" option into block
>       t/perf: depend on perl JSON only when using --codespeed
>       t/perf: add perf script for partial clones
>       coccicheck: optionally batch spatch invocations
>       t/lib-httpd: pass LSAN_OPTIONS through apache
>       coccicheck: make batch size of 0 mean "unlimited"
>       get_oid: handle NULL repo->index
>
> Jiang Xin (5):
>       t5323: test cases for git-pack-redundant
>       pack-redundant: delay creation of unique_objects
>       pack-redundant: rename pack_list.all_objects
>       pack-redundant: consistent sort method
>       i18n: fix typos found during l10n for git 2.22.0
>
> Joel Teichroeb (5):
>       stash: improve option parsing test coverage
>       stash: convert apply to builtin
>       stash: convert drop and clear to builtin
>       stash: convert branch to builtin
>       stash: convert pop to builtin
>
> Joey Hess (1):
>       convert: avoid malloc of original file size
>
> Johannes Schindelin (67):
>       ident: add the ability to provide a "fallback identity"
>       travis: remove the hack to build the Windows job on Azure Pipelines
>       tests: let --stress-limit=3D<N> imply --stress
>       tests: introduce --stress-jobs=3D<N>
>       built-in rebase: no need to check out `onto` twice
>       built-in rebase: use the correct reflog when switching branches
>       built-in rebase: demonstrate that ORIG_HEAD is not set correctly
>       built-in rebase: set ORIG_HEAD just once, before the rebase
>       Makefile: use `git ls-files` to list header files, if possible
>       curl: anonymize URLs in error messages and warnings
>       remote-curl: mark all error messages for translation
>       stash: add back the original, scripted `git stash`
>       stash: optionally use the scripted version again
>       tests: add a special setup where stash.useBuiltin is off
>       legacy stash: fix "rudimentary backport of -q"
>       built-in stash: handle :(glob) pathspecs again
>       mingw: drop MakeMaker reference
>       mingw: allow building with an MSYS2 runtime v3.x
>       rebase: deprecate --preserve-merges
>       mingw: respect core.hidedotfiles =3D false in git-init again
>       test-lib: introduce 'test_atexit'
>       git-daemon: use 'test_atexit` to stop 'git-daemon'
>       git p4 test: use 'test_atexit' to kill p4d and the watchdog process
>       rebase -i: demonstrate obscure loose object cache bug
>       sequencer: improve error message when an OID could not be parsed
>       sequencer: move stale comment into correct location
>       get_oid(): when an object was not found, try harder
>       difftool: remove obsolete (and misleading) comment
>       parse-options: make OPT_ARGUMENT() more useful
>       difftool: allow running outside Git worktrees with --no-index
>       docs: move gitremote-helpers into section 7
>       docs: do not document the `git remote-testgit` command
>       check-docs: really look at the documented commands again
>       check-docs: do not expect guide pages to correspond to commands
>       check-docs: fix for setups where executables have an extension
>       tests (rebase): spell out the `--keep-empty` option
>       tests (rebase): spell out the `--force-rebase` option
>       t7810: do not abbreviate `--no-exclude-standard` nor `--invert-matc=
h`
>       t5531: avoid using an abbreviated option
>       tests (push): do not abbreviate the `--follow-tags` option
>       tests (status): spell out the `--find-renames` option in full
>       tests (pack-objects): use the full, unabbreviated `--revs` option
>       t3301: fix false negative
>       untracked cache: fix off-by-one
>       tests: disallow the use of abbreviated options (by default)
>       t9822: skip tests if file names cannot be ISO-8859-1 encoded
>       macOS: make sure that gettext is found
>       remote-testgit: move it into the support directory for t5801
>       Makefile: drop the NO_INSTALL variable
>       help -a: do not list commands that are excluded from the build
>       check-docs: allow command-list.txt to contain excluded commands
>       docs: exclude documentation for commands that have been excluded
>       check-docs: do not bother checking for legacy scripts' documentatio=
n
>       test-tool: handle the `-C <directory>` option just like `git`
>       Turn `git serve` into a test helper
>       t5580: verify that alternates can be UNC paths
>       fsmonitor: demonstrate that it is not refreshed after discard_index=
()
>       fsmonitor: force a refresh after the index was discarded
>       t6500(mingw): use the Windows PID of the shell
>       difftool --no-index: error out on --dir-diff (and don't crash)
>       status: fix display of rebase -ir's `label` command
>       parse-options: adjust `parse_opt_unknown_cb()`s declared return typ=
e
>       stash: document stash.useBuiltin
>       rebase: replace incorrect logical negation by correct bitwise one
>       tests: mark a couple more test cases as requiring `rebase -p`
>       docs: say that `--rebase=3Dpreserve` is deprecated
>       rebase docs: recommend `-r` over `-p`
>
> Jonathan Tan (25):
>       remote-curl: reduce scope of rpc_state.argv
>       remote-curl: reduce scope of rpc_state.stdin_preamble
>       remote-curl: reduce scope of rpc_state.result
>       remote-curl: refactor reading into rpc_state's buf
>       remote-curl: use post_rpc() for protocol v2 also
>       tests: define GIT_TEST_PROTOCOL_VERSION
>       t5601: check ssh command only with protocol v0
>       tests: always test fetch of unreachable with v0
>       t5503: fix overspecification of trace expectation
>       t5512: compensate for v0 only sending HEAD symrefs
>       t5700: only run with protocol version 1
>       tests: fix protocol version for overspecifications
>       t5552: compensate for v2 filtering ref adv.
>       submodule: explain first attempt failure clearly
>       t5551: mark half-auth no-op fetch test as v0-only
>       fetch-pack: call prepare_shallow_info only if v0
>       fetch-pack: respect --no-update-shallow in v2
>       sha1-file: support OBJECT_INFO_FOR_PREFETCH
>       fetch-pack: binary search when storing wanted-refs
>       diff: batch fetching of missing blobs
>       pack-objects: write objects packed to trace2
>       transport: die if server options are unsupported
>       clone: send server options when using protocol v2
>       worktree: update is_bare heuristics
>       fetch-pack: send server options after command
>
> Jordi Mas (1):
>       l10n: Fixes to Catalan translation
>
> Josh Steadmon (5):
>       protocol-capabilities.txt: document symref
>       trace2: write to directory targets
>       clone: do faster object check for partial clones
>       trace2: fix incorrect function pointer check
>       commit-graph: fix memory leak
>
> Junio C Hamano (18):
>       test: caution on our version of 'yes'
>       builtin/log: downcase the beginning of error messages
>       format-patch: notice failure to open cover letter for writing
>       Start 2.22 cycle
>       The second batch
>       The third batch
>       The fourth batch
>       gettext tests: export the restored GIT_TEST_GETTEXT_POISON
>       The fifth batch
>       The sixth batch
>       Makefile: dedup list of files obtained from ls-files
>       The seventh batch
>       The eighth batch
>       Git 2.22-rc0
>       pkt-line: drop 'const'-ness of a param to set_packet_header()
>       Git 2.22-rc1
>       Git 2.22-rc2
>       Git 2.22-rc3
>
> Kyle Meyer (5):
>       rebase docs: fix "gitlink" typo
>       submodule: refuse to add repository with no commits
>       dir: do not traverse repositories with no commits
>       add: error appropriately on repository with no commits
>       t3000 (ls-files -o): widen description to reflect current tests
>
> Martin =C3=85gren (14):
>       setup: free old value before setting `work_tree`
>       setup: fix memory leaks with `struct repository_format`
>       config/diff.txt: drop spurious backtick
>       config/fsck.txt: avoid starting line with dash
>       git.txt: remove empty line before list continuation
>       git-svn.txt: drop escaping '\' that ends up being rendered
>       Documentation: turn middle-of-line tabs into spaces
>       Documentation/Makefile: add missing xsl dependencies for manpages
>       Documentation/Makefile: add missing dependency on asciidoctor-exten=
sions
>       asciidoctor-extensions: fix spurious space after linkgit
>       Doc: auto-detect changed build flags
>       doc-diff: let `render_tree()` take an explicit directory name
>       doc-diff: support diffing from/to AsciiDoc(tor)
>       doc-diff: add `--cut-header-footer`
>
> Matthew Kraai (1):
>       t3903: add test for --intent-to-add file
>
> Michal Suchanek (1):
>       worktree: fix worktree add race
>
> Mike Hommey (2):
>       fix pack protocol example client/server communication
>       Make fread/fwrite-like functions in http.c more like fread/fwrite.
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (129):
>       parse-options.h: remove extern on function prototypes
>       parse-options: add one-shot mode
>       parse-options: disable option abbreviation with PARSE_OPT_KEEP_UNKN=
OWN
>       parse-options: add OPT_BITOP()
>       parse-options: stop abusing 'callback' for lowlevel callbacks
>       parse-options: avoid magic return codes
>       parse-options: allow ll_callback with OPTION_CALLBACK
>       diff.h: keep forward struct declarations sorted
>       diff.h: avoid bit fields in struct diff_flags
>       diff.c: prepare to use parse_options() for parsing
>       diff.c: convert -u|-p|--patch
>       diff.c: convert -U|--unified
>       diff.c: convert -W|--[no-]function-context
>       diff.c: convert --raw
>       read-cache.c: fix writing "link" index ext with null base oid
>       completion: add more parameter value completion
>       diff-parseopt: convert --patch-with-raw
>       diff-parseopt: convert --numstat and --shortstat
>       diff-parseopt: convert --dirstat and friends
>       diff-parseopt: convert --check
>       diff-parseopt: convert --summary
>       diff-parseopt: convert --patch-with-stat
>       diff-parseopt: convert --name-only
>       diff-parseopt: convert --name-status
>       diff-parseopt: convert -s|--no-patch
>       diff-parseopt: convert --stat*
>       diff-parseopt: convert --[no-]compact-summary
>       diff-parseopt: convert --output-*
>       diff-parseopt: convert -B|--break-rewrites
>       diff-parseopt: convert -M|--find-renames
>       diff-parseopt: convert -D|--irreversible-delete
>       diff-parseopt: convert -C|--find-copies
>       diff-parseopt: convert --find-copies-harder
>       diff-parseopt: convert --no-renames|--[no--rename-empty
>       diff-parseopt: convert --relative
>       diff-parseopt: convert --[no-]minimal
>       diff-parseopt: convert --ignore-some-changes
>       Delete check-racy.c
>       diff-parseopt: convert --[no-]indent-heuristic
>       diff-parseopt: convert --patience
>       diff-parseopt: convert --histogram
>       diff-parseopt: convert --diff-algorithm
>       diff-parseopt: convert --anchored
>       diff-parseopt: convert --binary
>       diff-parseopt: convert --full-index
>       diff-parseopt: convert -a|--text
>       diff-parseopt: convert -R
>       diff-parseopt: convert --[no-]follow
>       diff-parseopt: convert --[no-]color
>       diff-parseopt: convert --word-diff
>       diff-parseopt: convert --word-diff-regex
>       diff-parseopt: convert --color-words
>       diff-parseopt: convert --exit-code
>       diff-parseopt: convert --quiet
>       diff-parseopt: convert --ext-diff
>       diff-parseopt: convert --textconv
>       diff-parseopt: convert --ignore-submodules
>       diff-parseopt: convert --submodule
>       files-backend.c: factor out per-worktree code in loose_fill_ref_dir=
()
>       files-backend.c: reduce duplication in add_per_worktree_entries_to_=
dir()
>       Make sure refs/rewritten/ is per-worktree
>       unpack-trees: fix oneway_merge accidentally carry over stage index
>       checkout.txt: note about losing staged changes with --merge
>       commit: improve error message in "-a <paths>" case
>       unpack-trees: keep gently check inside add_rejected_path
>       unpack-trees: rename "gently" flag to "quiet"
>       read-tree: add --quiet
>       checkout: prevent losing staged changes with --merge
>       diff-parseopt: convert --ws-error-highlight
>       diff-parseopt: convert --ita-[in]visible-in-index
>       diff-parseopt: convert -z
>       diff-parseopt: convert -l
>       diff-parseopt: convert -S|-G
>       diff-parseopt: convert --pickaxe-all|--pickaxe-regex
>       diff-parseopt: convert -O
>       diff-parseopt: convert --find-object
>       diff-parseopt: convert --diff-filter
>       diff-parseopt: convert --[no-]abbrev
>       diff-parseopt: convert --[src|dst]-prefix
>       diff-parseopt: convert --line-prefix
>       diff-parseopt: convert --no-prefix
>       diff-parseopt: convert --inter-hunk-context
>       diff-parseopt: convert --[no-]color-moved
>       diff-parseopt: convert --color-moved-ws
>       diff.c: allow --no-color-moved-ws
>       range-diff: use parse_options() instead of diff_opt_parse()
>       diff --no-index: use parse_options() instead of diff_opt_parse()
>       am: avoid diff_opt_parse()
>       config: correct '**' matching in includeIf patterns
>       interpret-trailers.txt: start the desc line with a capital letter
>       read-tree.txt: clarify --reset and worktree changes
>       packfile.c: add repo_approximate_object_count()
>       refs.c: add refs_ref_exists()
>       refs.c: add refs_shorten_unambiguous_ref()
>       refs.c: remove the_repo from substitute_branch_name()
>       refs.c: remove the_repo from expand_ref()
>       refs.c: add repo_dwim_ref()
>       refs.c: add repo_dwim_log()
>       refs.c: remove the_repo from read_ref_at()
>       submodule foreach: fix "<command> --quiet" not being respected
>       commit.cocci: refactor code, avoid double rewrite
>       commit.c: add repo_get_commit_tree()
>       sha1-name.c: remove the_repo from sort_ambiguous()
>       sha1-name.c: remove the_repo from find_abbrev_len_packed()
>       sha1-name.c: add repo_find_unique_abbrev_r()
>       sha1-name.c: store and use repo in struct disambiguate_state
>       sha1-name.c: add repo_for_each_abbrev()
>       sha1-name.c: remove the_repo from get_short_oid()
>       sha1-name.c: remove the_repo from interpret_nth_prior_checkout()
>       sha1-name.c: remove the_repo from interpret_branch_mark()
>       sha1-name.c: add repo_interpret_branch_name()
>       sha1-name.c: remove the_repo from get_oid_oneline()
>       sha1-name.c: remove the_repo from get_describe_name()
>       sha1-name.c: remove the_repo from get_oid_basic()
>       sha1-name.c: remove the_repo from get_oid_1()
>       sha1-name.c: remove the_repo from handle_one_ref()
>       sha1-name.c: remove the_repo from diagnose_invalid_index_path()
>       sha1-name.c: remove the_repo from resolve_relative_path()
>       sha1-name.c: remove the_repo from get_oid_with_context_1()
>       sha1-name.c: add repo_get_oid()
>       submodule-config.c: use repo_get_oid for reading .gitmodules
>       sha1-name.c: remove the_repo from maybe_die_on_misspelt_object_name
>       sha1-name.c: remove the_repo from other get_oid_*
>       sha1-name.c: remove the_repo from get_oid_mb()
>       parse-options: don't emit "ambiguous option" for aliases
>       submodule--helper: add a missing \n
>       diff-parseopt: correct variable types that are used by parseopt
>       diff-parseopt: restore -U (no argument) behavior
>       parse-options: check empty value in OPT_INTEGER and OPT_ABBREV
>
> Paul-Sebastian Ungureanu (17):
>       sha1-name.c: add `get_oidf()` which acts like `get_oid()`
>       strbuf.c: add `strbuf_join_argv()`
>       strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
>       t3903: modernize style
>       stash: rename test cases to be more descriptive
>       stash: add tests for `git stash show` config
>       stash: mention options in `show` synopsis
>       stash: convert list to builtin
>       stash: convert show to builtin
>       stash: convert store to builtin
>       stash: convert create to builtin
>       stash: convert push to builtin
>       stash: make push -q quiet
>       stash: convert save to builtin
>       stash: optimize `get_untracked_files()` and `check_changes()`
>       stash: replace all `write-tree` child processes with API calls
>       stash: convert `stash--helper.c` into `stash.c`
>
> Philip Oakley (2):
>       rerere doc: quote `rerere.enabled`
>       describe doc: remove '7-char' abbreviation reference
>
> Phillip Wood (21):
>       am/cherry-pick/rebase/revert: document --rerere-autoupdate
>       merge: tweak --rerere-autoupdate documentation
>       sequencer: break some long lines
>       cherry-pick: demonstrate option amnesia
>       cherry-pick --continue: remember options
>       commit/reset: try to clean up sequencer state
>       fix cherry-pick/revert status after commit
>       sequencer: fix cleanup with --signoff and -x
>       sequencer.c: save and restore cleanup mode
>       sequencer: always discard index after checkout
>       rebase: don't translate trace strings
>       rebase: rename write_basic_state()
>       rebase: use OPT_RERERE_AUTOUPDATE()
>       rebase -i: combine rebase--interactive.c with rebase.c
>       rebase -i: remove duplication
>       rebase -i: use struct commit when parsing options
>       rebase -i: use struct object_id for squash_onto
>       rebase -i: use struct rebase_options to parse args
>       rebase -i: use struct rebase_options in do_interactive_rebase()
>       rebase: use a common action enum
>       rebase -i: run without forking rebase--interactive
>
> Ramsay Jones (2):
>       prune-packed: check for too many arguments
>       Makefile: fix 'hdr-check' when GCRYPT not installed
>
> Ren=C3=A9 Scharfe (1):
>       get-tar-commit-id: parse comment record
>
> Robert P. J. Day (3):
>       mention use of "hooks.allownonascii" in "man githooks"
>       docs/git-gc: fix typo "--prune=3Dall" to "--prune=3Dnow"
>       attr.c: ".gitattribute" -> ".gitattributes" (comments)
>
> Rohit Ashiwal (3):
>       test functions: add function `test_file_not_empty`
>       t3600: modernize style
>       t3600: use helpers to replace test -d/f/e/s <path>
>
> SZEDER G=C3=A1bor (27):
>       test-lib: fix interrupt handling with 'dash' and '--verbose-log -x'
>       t/lib-git-daemon: make sure to kill the 'git-daemon' process
>       tests: use 'test_atexit' to stop httpd
>       t0301-credential-cache: use 'test_atexit' to stop the credentials h=
elper
>       git p4 test: clean up the p4d cleanup functions
>       git p4 test: simplify timeout handling
>       git p4 test: disable '-x' tracing in the p4d watchdog loop
>       t9811-git-p4-label-import: fix pipeline negation
>       t5318-commit-graph: remove unused variable
>       Documentation/git-diff-tree.txt: fix formatting
>       Documentation/technical/api-config.txt: fix formatting
>       Documentation/technical/protocol-v2.txt: fix formatting
>       ci: install Asciidoctor in 'ci/install-dependencies.sh'
>       index-pack: show progress while checking objects
>       ci: stick with Asciidoctor v1.5.8 for now
>       ci: fix AsciiDoc/Asciidoctor stderr check in the documentation buil=
d job
>       progress: make display_progress() return void
>       progress: assemble percentage and counters in a strbuf before print=
ing
>       blame: default to HEAD in a bare repo when no start commit is given
>       builtin rebase: use FREE_AND_NULL
>       builtin rebase: use oideq()
>       progress: clear previous progress update dynamically
>       progress: break too long progress bar lines
>       ci: install 'libsvn-perl' instead of 'git-svn'
>       trace2: rename environment variables to GIT_TRACE2*
>       trace2: document the supported values of GIT_TRACE2* env variables
>       progress: avoid empty line when breaking the progress line
>
> Sun Chao (2):
>       pack-redundant: delete redundant code
>       pack-redundant: new algorithm to find min packs
>
> Sven Strickroth (1):
>       MSVC: include compat/win32/path-utils.h for MSVC, too, for real_pat=
h()
>
> Tanushree Tumane (1):
>       mingw: remove obsolete IPv6-related code
>
> Taylor Blau (4):
>       t: move 'hex2oct' into test-lib-functions.sh
>       t: introduce tests for unexpected object types
>       list-objects.c: handle unexpected non-blob entries
>       list-objects.c: handle unexpected non-tree entries
>
> Thomas Gummerer (15):
>       move worktree tests to t24*
>       entry: factor out unlink_entry function
>       entry: support CE_WT_REMOVE flag in checkout_entry
>       read-cache: add invalidate parameter to remove_marked_cache_entries
>       checkout: clarify comment
>       checkout: factor out mark_cache_entry_for_checkout function
>       checkout: introduce --{,no-}overlay option
>       checkout: introduce checkout.overlayMode config
>       revert "checkout: introduce checkout.overlayMode config"
>       ident: don't require calling prepare_fallback_ident first
>       stash: drop unused parameter
>       stash: pass pathspec as pointer
>       glossary: add definition for overlay
>       stash: setup default diff output format if necessary
>       ls-files: use correct format string
>
> Todd Zullinger (9):
>       t4038-diff-combined: quote paths with whitespace
>       t9902: test multiple removals via completion.commands
>       completion: use __git when calling --list-cmds
>       Documentation/rev-list-options: wrap --date=3D<format> block with "=
--"
>       Documentation/git-status: fix titles in porcelain v2 section
>       Documentation/git-svn: improve asciidoctor compatibility
>       Documentation/git-show-branch: avoid literal {apostrophe}
>       test-lib: try harder to ensure a working jgit
>       RelNotes: minor typo fixes in 2.22.0 draft
>
> Torsten B=C3=B6gershausen (1):
>       trace2: NULL is not allowed for va_list
>
> Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
>       l10n: Updated Vietnamese translation for v2.21 rd2
>
> Vadim Kochan (1):
>       autoconf: #include <libintl.h> when checking for gettext()
>
> William Hubbs (1):
>       config: allow giving separate author and committer idents
>
> Yash Bhatambare (1):
>       gitattributes.txt: fix typo
>
> brian m. carlson (35):
>       t/lib-submodule-update: use appropriate length constant
>       khash: move oid hash table definition
>       pack-bitmap: make bitmap header handling hash agnostic
>       pack-bitmap: convert struct stored_bitmap to object_id
>       pack-bitmap: replace sha1_to_hex
>       pack-bitmap: switch hard-coded constants to the_hash_algo
>       pack-bitmap: switch hash tables to use struct object_id
>       submodule: avoid hard-coded constants
>       notes-merge: switch to use the_hash_algo
>       notes: make hash size independent
>       notes: replace sha1_to_hex
>       object-store: rename and expand packed_git's sha1 member
>       builtin/name-rev: make hash-size independent
>       fast-import: make hash-size independent
>       fast-import: replace sha1_to_hex
>       builtin/am: make hash size independent
>       builtin/pull: make hash-size independent
>       http-push: convert to use the_hash_algo
>       http-backend: allow 64-character hex names
>       http-push: remove remaining uses of sha1_to_hex
>       http-walker: replace sha1_to_hex
>       http: replace hard-coded constant with the_hash_algo
>       http: compute hash of downloaded objects using the_hash_algo
>       http: replace sha1_to_hex
>       remote-curl: make hash size independent
>       hash: add a function to lookup hash algorithm by length
>       builtin/get-tar-commit-id: make hash size independent
>       archive: convert struct archiver_args to object_id
>       refspec: make hash size independent
>       builtin/difftool: use parse_oid_hex
>       dir: make untracked cache extension hash size independent
>       read-cache: read data in a hash-independent way
>       Git.pm: make hash size independent
>       gitweb: make hash size independent
>       send-email: default to quoted-printable when CR is present
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (44):
>       receive-pack: fix use-after-free bug
>       commit-graph tests: split up corrupt_graph_and_verify()
>       commit-graph tests: test a graph that's too small
>       Makefile: remove an out-of-date comment
>       Makefile: move "strip" assignment down from flags
>       Makefile: add/remove comments at top and tweak whitespace
>       Makefile: Move *_LIBS assignment into its own section
>       Makefile: move the setting of *FLAGS closer to "include"
>       Makefile: allow for combining DEVELOPER=3D1 and CFLAGS=3D"..."
>       gc: remove redundant check for gc_auto_threshold
>       gc: convert to using the_hash_algo
>       gc: refactor a "call me once" pattern
>       reflog tests: make use of "test_config" idiom
>       reflog tests: test for the "points nowhere" warning
>       rebase: remove the rebase.useBuiltin setting
>       gc docs: modernize the advice for manually running "gc"
>       gc docs: stop noting "repack" flags
>       gc docs: clean grammar for "gc.bigPackThreshold"
>       commit-graph: fix segfault on e.g. "git status"
>       commit-graph: don't early exit(1) on e.g. "git status"
>       commit-graph: don't pass filename to load_commit_graph_one_fd_st()
>       commit-graph verify: detect inability to read the graph
>       commit-graph write: don't die if the existing graph is corrupt
>       commit-graph: improve & i18n error messages
>       reflog tests: assert lack of early exit with expiry=3D"never"
>       gc: handle & check gc.reflogExpire config
>       test-lib: whitelist GIT_TR2_* in the environment
>       gc docs: include the "gc.*" section from "config" in "gc"
>       gc docs: re-flow the "gc.*" section in "config"
>       gc docs: fix formatting for "gc.writeCommitGraph"
>       gc docs: note how --aggressive impacts --window & --depth
>       gc docs: downplay the usefulness of --aggressive
>       gc docs: note "gc --aggressive" in "fast-import"
>       gc docs: clarify that "gc" doesn't throw away referenced objects
>       gc docs: remove incorrect reference to gc.auto=3D0
>       perf README: correct docs for 3c8f12c96c regression
>       perf aggregate: remove GIT_TEST_INSTALLED from --codespeed
>       perf-lib.sh: make "./run <revisions>" use the correct gits
>       perf-lib.sh: remove GIT_TEST_INSTALLED from perf-lib.sh
>       perf tests: add "bindir" prefix to git tree test results
>       perf-lib.sh: forbid the use of GIT_TEST_INSTALLED
>       trace2: fix up a missing "leave" entry point
>       trace2: fix up a missing "leave" entry point
>       sha1dc: update from upstream
>
> =C4=B0smail D=C3=B6nmez (2):
>       mingw: do not let ld strip relocations
>       mingw: enable DEP and ASLR
>
