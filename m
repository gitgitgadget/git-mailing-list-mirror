Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FC591F462
	for <e@80x24.org>; Fri, 31 May 2019 12:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfEaMmx (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 08:42:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:53665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfEaMmw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 08:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559306566;
        bh=3AqPf0egjNaNdNGxeN1WinlkMRiwGInPn39ei+t9wkQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=e0LjkMrBk5dkMZwzYF5clKn+L0Z5NwjZIK6kVsI/tf500bUgwoVc1gfv0BFKH0ODM
         eKmo2MLd2uQndydBOyha7fhSGNrLLZXco1ejZKOfLRj6htNPnfYWxQQCOHI4T26fkP
         bT7ipJyevVTuCpCmBglbk6oKQfg4Dzs5mLXJx+AE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhkiL-1gk8eN0nOT-00mssv; Fri, 31
 May 2019 14:42:46 +0200
Date:   Fri, 31 May 2019 14:42:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2019, #05; Thu, 30)
In-Reply-To: <xmqqwoi7ws9z.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905311346170.44@tvgsbejvaqbjf.bet>
References: <xmqqwoi7ws9z.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <nycvar.QRO.7.76.6.1905311414001.44@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:z3lloeW/qwApSedeo+FTEaYFS90mgIEP0m/2Rg6Q3KdpqaBmZLR
 6YJN6PBiZbewl3z6PAuCpUYbXWHO7MzN36sKtOC6K9YDnI/JHP6yK/rAs5YJYqGlWgTadTV
 HqAp7UL7pDRHv0h9BenFCRkaer1hNupTKL/msJMwOTUHBGxh/N0k5pKUVHaOuxdWe4nOp3t
 N59ufU7VfE9bSAlddVP6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NsTQmqkjlNQ=:AXzBG6CfNaXNMMaW3DkVHf
 nS+RE7p5MqEN693JPP94orB81s5ASGXHuAM+ngf3NvkwkN70IeeCyzB0x+XNbR67P0BILaH+p
 qxroTRN59HMwYkUR9MH/+yfErr+Dx9/PT2PqTJ7xm4nbHqVXt+P0HEcPuuFfjvNDAalIehZdh
 hzUMl1trO8DWErLwwOpUUBk9aDekyIlOiHkxplHXbNYAjxgmBP9k2O9Q7TVBNV1xpF2V8/C68
 4S3qRYjIjEqwsnQj9HEfc0I7rGuQadlpljnooVRGClOi7BTGIW9zdJ+kJUXS/3XDS9ftYpiQ3
 62O56cHwx86XXOHNEPaHYftt/HPXI5qo5SXfF02Cm6ETNX1hE2zdxDZJ+wLmyiDX9aCWxMeFG
 4jPW6MCTlUAdjsEXqTCorrUoDZapGXxZtrfs6tpa0SlsdQxkSSVUSqvNvYGG0Jfdj6nXtiYEa
 m7A9wfQSAfXrmPYhGnVYcbA0KvQSjZTUoHI/H3BthzkSnbSp++X5OBxgESaKlNMFsxEPTp1C9
 62DoV6FpR9Ot5f43X+W8j/dEmV/a7MwpJp7Owrtni8HgIIMtHLMDW7/WnFlHHarv0GqvKG/z1
 +Y5dzFWf+1f5djhCLlqOu1s7C+serJDb4e04T27zS0MYQ5seVwIbz3tX/VNpigHXs0qAHJjnn
 Xmr/6QbBU3711WSv47O7B0Lyv2qCXNb511qW4tuYHaD8iPZFyuda0KtsdkwgVx8z1PLFDM4JJ
 wZNenjPHmxegfNWUmu7aidtfRA20HJzAjkmoWGhimirDjaV1c4Lgi+tiYemiVJ/XFYOhde3SZ
 M43bcX8J45ufGpeovNdgpCah75G+qmOnsf7P8QnmtVIylalwdkrejaMGtMreAn8B9/lqytQz1
 EMKUzcSLfx5Z0g1pLaX0ime6iPz8IsTyB31yfF95TMfJ3GDDxV/AHNqGX4dltXqDeMlNV8dVM
 0JuNJm0cph4uRDOXrlGg3f/+T5t69u6M/wO1dtBeIaeKPfJxo2EaT
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 30 May 2019, Junio C Hamano wrote:

> * bb/unicode-12.1-reiwa (2019-05-29) 1 commit
>   (merged to 'next' on 2019-05-30 at 016465335c)
>  + unicode: update the width tables to Unicode 12.1
> <<
> * bb/unicode-12.1-reiwa (2019-05-29) 1 commit
>  - unicode: update the width tables to Unicode 12.1
> >>
>
>  Update to Unicode 12.1 width table.
>
>  Will cook in 'next'.

I would actually be in favor of merging this before v2.22.0. It's not like
this is a feature we need to perfect, we just integrate upstream changes.

> * ab/hash-object-doc (2019-05-28) 1 commit
>  - hash-object doc: stop mentioning git-cvsimport
>
>  Doc update.
>
>  Will merge to 'next'.

Similarly, I think it would not hurt to merge this before v2.22.0.

Granted, it does not fix a regression, but it's not like it will introduce
a regression, either.

> * cc/list-objects-filter-wo-sparse-path (2019-05-29) 1 commit
>   (merged to 'next' on 2019-05-30 at 5a294203ad)
>  + list-objects-filter: disable 'sparse:path' filters
>
>  Disable "--filter=3Dsparse:path=3D<path>" that would allow reading from
>  paths on the filesystem.
>
>  Will cook in 'next'.

Not sure whether we want to fast-track this into v2.22.0. There is a risk.

But then, the longer we ship with `--filter=3Dsparse:path` *enabled*, the
more we invite users to actually try and use it.

> * ds/object-info-for-prefetch-fix (2019-05-28) 1 commit
>   (merged to 'next' on 2019-05-29 at ee0055b276)
>  + sha1-file: split OBJECT_INFO_FOR_PREFETCH
>
>  Code cleanup and futureproof.
>
>  Will cook in 'next'.

As agreed previously, I'd be in favor of keeping this out of v2.22.0.

> * ds/topo-traversal-using-commit-graph (2019-05-28) 2 commits
>   (merged to 'next' on 2019-05-30 at 590527995e)
>  + revision: keep topo-walk free of unintersting commits
>  + revision: use generation for A..B --topo-order queries
>
>  Prepare use of reachability index in topological walker that works
>  on a range (A..B).
>
>  Will cook in 'next'.

Same here, this can cook a bit longer.

> * es/git-debugger-doc (2019-05-28) 1 commit
>   (merged to 'next' on 2019-05-29 at 449ba4ae6c)
>  + doc: hint about GIT_DEBUGGER in CodingGuidelines
>
>  Doc update.
>
>  Will cook in 'next'.

I actually do not see any benefit of this documentation change cooking.
The most likely people to "cook" this is new contributors, and they will
not see anything that is in `next` in my experience.

But it does not *need* to be in v2.22.0, either.

> * es/grep-require-name-when-needed (2019-05-28) 1 commit
>   (merged to 'next' on 2019-05-29 at e1ec57894a)
>  + grep: fail if call could output and name is null
>
>  More parameter validation.
>
>  Will cook in 'next'.

This is not a new regression, so by your standard it should not get into
v2.22.0 this late in the game (and I agree with this standard, as there is
a risk of regressions here).

> * ew/server-info-remove-crufts (2019-05-28) 1 commit
>   (merged to 'next' on 2019-05-29 at 655ba18f30)
>  + server-info: do not list unlinked packs
>
>  "git update-server-info" used to leave stale packfiles in its
>  output, which has been corrected.
>
>  Will cook in 'next'.

I do dream of the day when we can just get rid of the entire non-smart
HTTP stuff.

And I do dream of the day when we can switch `git daemon` to serve via
smart HTTP, i.e. run `http-backend` internally. And then we could get rid
of the git:// protocol, too.

But I digress.

If anyone wants to have my opinion on whether to merge this before
v2.22.0: I don't think so, it is not critical enough, in my mind.

> * jk/HEAD-symref-in-xfer-namespaces (2019-05-28) 1 commit
>   (merged to 'next' on 2019-05-29 at c2cfe38955)
>  + upload-pack: strip namespace from symref data
>
>  The server side support for "git fetch" used to show incorrect
>  value for the HEAD symbolic ref when the namespace feature is in
>  use, which has been corrected.
>
>  Will cook in 'next'.

This is an older regression, so it should probably be kept in `next` for
now.

> * jk/am-i-resolved-fix (2019-05-28) 4 commits
>   (merged to 'next' on 2019-05-29 at e711103b1a)
>  + am: fix --interactive HEAD tree resolution
>  + am: drop tty requirement for --interactive
>  + am: read interactive input from stdin
>  + am: simplify prompt response handling
>
>  "git am -i --resolved" segfaulted after trying to see a commit as
>  if it were a tree, which has been corrected.
>
>  Will cook in 'next'.

Likewise.

> * js/bisect-helper-check-get-oid-return-value (2019-05-28) 1 commit
>   (merged to 'next' on 2019-05-29 at 24125b3bc0)
>  + bisect--helper: verify HEAD could be parsed before continuing
>
>  Code cleanup.
>
>  Will cook in 'next'.

And here, too: it is safe to keep it in `next`.

> * js/bundle-verify-require-object-store (2019-05-28) 1 commit
>   (merged to 'next' on 2019-05-29 at 747fbbaf11)
>  + bundle verify: error out if called without an object database
>
>  "git bundle verify" needs to see if prerequisite objects exist in
>  the receiving repository, but the command did not check if we are
>  in a repository upfront, which has been corrected.
>
>  Will cook in 'next'.

Yes, this topic should actually cook for a while.

> * js/fsmonitor-unflake (2019-05-28) 2 commits
>   (merged to 'next' on 2019-05-30 at 1aa850bc59)
>  + mark_fsmonitor_valid(): mark the index as changed if needed
>  + fill_stat_cache_info(): prepare for an fsmonitor fix
>
>  The data collected by fsmonitor was not properly written back to
>  the on-disk index file, breaking t7519 tests occasionally, which
>  has been corrected.
>
>  Will cook in 'next'.

Makes sense.

> * mm/p4-unshelve-windows-fix (2019-05-28) 1 commit
>  - p4 unshelve: fix "Not a valid object name HEAD0" on Windows
>
>  The command line to invoke a "git cat-file" command from inside
>  "git p4" was not properly quoted to protect a caret and running a
>  broken command on Windows, which has been corrected.
>
>  Will merge to 'next'.

Same here, this is a super old regression, and it will not hurt to cook it
a bit longer.

> * pb/request-pull-verify-remote-ref (2019-05-28) 2 commits
>  - request-pull: warn if the remote object is not the same as the local =
one
>  - request-pull: quote regex metacharacters in local ref
>
>  "git request-pull" learned to warn when the ref we ask them to pull
>  from in the local repository and in the published repository are
>  different.
>
>  Will merge to 'next'.

Quite honestly, I don't care about `request-pull`, for what I know, this
is shipped in Git for the exclusive use of the Linux kernel project, which
is a bit funny.

In any case: very old bug, so its best home is `next` for now.

> * po/git-help-on-git-itself (2019-05-16) 2 commits
>  - Doc: git.txt: remove backticks from link and add git-scm.com/docs
>  - git.c: show usage for accessing the git(1) help page
>
>  "git help git" was hard to discover (well, at least for some
>  people).
>
>  Will merge to 'next'.

I guess it would not hurt anybody (and get a bit more exposure) if it was
merged before v2.22.0, but it does not fix a problem introduced in this
cycle, so...

> * sw/git-p4-unshelve-branched-files (2019-05-28) 1 commit
>   (merged to 'next' on 2019-05-30 at e1985f61fc)
>  + git-p4: allow unshelving of branched files
>
>  "git p4" update.
>
>  Will cook in 'next'.

Agree.

> * vv/merge-squash-with-explicit-commit (2019-05-28) 1 commit
>   (merged to 'next' on 2019-05-29 at 209baa3e55)
>  + merge: refuse --commit with --squash
>
>  "git merge --squash" is designed to update the working tree and the
>  index without creating the commit, and this cannot be countermanded
>  by adding the "--commit" option; the command now refuses to work
>  when both options are given.
>
>  Will cook in 'next'.

Makes sense to me.

> * xl/record-partial-clone-origin (2019-05-29) 1 commit
>  - clone: respect user supplied origin name when setting up partial clon=
e
>
>  When creating a partial clone, the object filtering criteria is
>  recorded for the origin of the clone, but this incorrectly used a
>  hardcoded name "origin" to name that remote; it has been corrected
>  to honor the "--origin <name>" option.
>
>  Will merge to 'next'.

I am of two minds here: as far as I can tell, this fixes a regression that
has been introduced in 548719fbdc4c (clone: partial clone, 2017-12-08), so
it is super old.

On the other hand, the partial clone is a young feature and *just* picking
up steam, so I'd wish we could have this patch in an official version
rather earlier than later.

But I can live with it living in `next` for now.

> * ab/fail-prereqs-in-test (2019-05-14) 1 commit
>   (merged to 'next' on 2019-05-16 at d1be55f485)
>  + tests: add a special setup where prerequisites fail
>
>  Developer support to emulate unsatisfied prerequisites in tests to
>  ensure that the remainer of the tests still succeeds when tests
>  with prerequisites are skipped.
>
>  Will cook in 'next'.

I am excited to see this in `master` soon after v2.22.0.

> * jk/help-unknown-ref-fix (2019-05-15) 2 commits
>   (merged to 'next' on 2019-05-19 at e3e01160f7)
>  + help_unknown_ref(): check for refname ambiguity
>  + help_unknown_ref(): duplicate collected refnames
>
>  Improve the code to show args with potential typo that cannot be
>  interpreted as a commit-ish.
>
>  Will cook in 'next'.

I agree.

> * js/rebase-cleanup (2019-05-15) 5 commits
>   (merged to 'next' on 2019-05-16 at ccfed8f263)
>  + rebase: fold git-rebase--common into the -p backend
>  + sequencer: the `am` and `rebase--interactive` scripts are gone
>  + .gitignore: there is no longer a built-in `git-rebase--interactive`
>  + t3400: stop referring to the scripted rebase
>  + Drop unused git-rebase--am.sh
>
>  Update supporting parts of "git rebase" to remove code that should
>  no longer be used.
>
>  Will cook in 'next'.

Absolutely, there is no need to force this into v2.22.0.

Having said that, I already integrated this into Git fo Windows
v2.22.0-rc2... So I guess users on Windows will tell us if that broke
anything ;-)

> * jt/partial-clone-missing-ref-delta-base (2019-05-15) 2 commits
>   (merged to 'next' on 2019-05-29 at 5d7573a151)
>  + index-pack: prefetch missing REF_DELTA bases
>  + t5616: refactor packfile replacement
>
>  "git fetch" into a lazy clone forgot to fetch base objects that are
>  necessary to complete delta in a thin packfile, which has been
>  corrected.
>
>  Will cook in 'next'.

As with all things partial clone, I am of my usual two minds: I consider
it an experimental feature, still, so I'd love to move faster on it than
on other features. On the other hand, every such change risks introducing
regressions late in the game.

> * bl/userdiff-octave (2019-05-29) 2 commits
>   (merged to 'next' on 2019-05-29 at 6ed07afc89)
>  + userdiff: fix grammar and style issues
>   (merged to 'next' on 2019-05-19 at 9ea1180d6c)
>  + userdiff: add Octave
>
>  The pattern "git diff/grep" use to extract funcname and words
>  boundary for Matlab has been extend to cover Octave, which is more
>  or less equivalent.
>
>  Will cook in 'next'.

With userdiffs, I am pretty convinced that the only way we can cook them
really effectively is in official versions. I don't think that I know of
any Octave user who builds Git themselves (and yes, I know a couple of
Octave users, came even close to work with the group who started it in
Madison WI).

So I'd be fine with this still making it into v2.22.0.

> * ew/update-server-info (2019-05-15) 1 commit
>   (merged to 'next' on 2019-05-19 at bf4f2871ab)
>  + update-server-info: avoid needless overwrites
>
>  "git update-server-info" learned not to rewrite the file with the
>  same contents.
>
>  Will cook in 'next'.

Yep. Same rationale as with the other `update-server-info` topic.

> * nd/corrupt-worktrees (2019-05-15) 1 commit
>   (merged to 'next' on 2019-05-16 at d92c25f800)
>  + worktree add: be tolerant of corrupt worktrees
>
>  "git worktree add" used to fail when another worktree connected to
>  the same repository was corrupt, which has been corrected.
>
>  Will cook in 'next'.

While not an old regression, it was not introduced in *this* cycle. So I'm
fine with keeping it out of v2.22.0.

> * mh/import-transport-fd-fix (2019-05-16) 2 commits
>   (merged to 'next' on 2019-05-19 at 5e86f92f7a)
>  + Use xmmap_gently instead of xmmap in use_pack
>  + dup() the input fd for fast-import used for remote helpers
>
>  The ownership rule for the file descriptor to fast-import remote
>  backend was mixed up, leading to unrelated file descriptor getting
>  closed, which has been fixed.
>
>  Will cook in 'next'.

Makes sense, too. That's an old regression if I'm not mistaken.

> * ab/deprecate-R-for-dynpath (2019-05-19) 1 commit
>   (merged to 'next' on 2019-05-19 at 944976e981)
>  + Makefile: remove the NO_R_TO_GCC_LINKER flag
>
>  The way of specifying the path to find dynamic libraries at runtime
>  has been simplified.  The old default to pass -R/path/to/dir has been
>  replaced with the new default to pass -Wl,-rpath,/path/to/dir,
>  which is the more recent GCC uses.  Those who need to build with an
>  old GCC can still use "CC_LD_DYNPATH=3D-R"
>
>  Will cook in 'next'.

Yep.

> * ba/clone-remote-submodules (2019-05-28) 1 commit
>   (merged to 'next' on 2019-05-29 at 71972f94c2)
>  + clone: add `--remote-submodules` flag
>
>  "git clone --recurse-submodules" learned to set up the submodules
>  to ignore commit object names recorded in the superproject gitlink
>  and instead use the commits that happen to be at the tip of the
>  remote-tracking branches from the get-go, by passing the new
>  "--remote-submodules" option.
>
>  Will cook in 'next'.

Are we really sure that this is a good option name? With that description,
I would have expected `--recurse-submodules=3Dfollow-tips` or some such.

In other words, I would have been in favor of keeping this in `pu` for a
little while longer. But it's already in `next`...

> * ds/close-object-store (2019-05-28) 3 commits
>  - packfile: rename close_all_packs to close_object_store
>  - packfile: close commit-graph in close_all_packs
>  - commit-graph: use raw_object_store when closing
>  (this branch uses ds/commit-graph-write-refactor.)
>
>  The commit-graph file is now part of the "files that the runtime
>  may keep open file descriptors on, all of which would need to be
>  closed when done with the object store", and the file descriptor to
>  an existing commit-graph file now is closed before "gc" finializes
>  a new instance to replace it.
>
>  Waiting on ds/commit-graph-write-refactor to stabilize.

FWIW I backported this to Git for Windows, as the underlying bug would
prevent an auto gc from working as intended (iff the commit graph feature
is turned on, of course).

> * ml/userdiff-rust (2019-05-30) 2 commits
>  - userdiff: two simplifications of patterns for rust
>   (merged to 'next' on 2019-05-19 at 1266fddce5)
>  + userdiff: add built-in pattern for rust
>
>  The pattern "git diff/grep" use to extract funcname and words
>  boundary for Rust has been added.
>
>  Will cook in 'next'.

The same comment as for Octave applies (modulo me knowing anybody on the
team who started the project).

> * pw/rebase-edit-message-for-replayed-merge (2019-05-19) 1 commit
>   (merged to 'next' on 2019-05-19 at dc3e30641c)
>  + rebase -r: always reword merge -c
>
>  A "merge -c" instruction during "git rebase --rebase-merges" should
>  give the user a chance to edit the log message, even when there is
>  otherwise no need to create a new merge and replace the existing
>  one (i.e. fast-forward instead), but did not.  Which has been
>  corrected.
>
>  Will cook in 'next'.

I backported this also, mainly for my own convenience :-)

It really is a pretty obvious bug fix, but the bug has been with us for
quite a while.

> * sb/format-patch-base-patch-id-fix (2019-05-08) 2 commits
>   (merged to 'next' on 2019-05-15 at 1ab7d2b71c)
>  + format-patch: make --base patch-id output stable
>  + format-patch: inform user that patch-id generation is unstable
>
>  The recently added "--base" option of "format-patch" computed the

Was it not included in v2.9.0? That's not recent. Or maybe my Git fu
deserts me?

$ git tag --contains fa2ab86d18f16ab5e6d2f2cd6e8cc00460bada17
...
v2.9.0
...

(I think that the feature was introduced in fa2ab86d18f1 (format-patch:
add '--base' option to record base tree info, 2016-04-26)).

>  patch-ids for prerequisite patches in an unstable way, which has
>  been updated to compute in a way that is compatible with "git
>  patch-id --stable".
>
>  Will cook in 'next'.

Yes, this can cook for a bit.

> * ab/send-email-transferencoding-fix (2019-05-29) 7 commits
>   (merged to 'next' on 2019-05-29 at c8a99d18c0)
>  + send-email: fix regression in sendemail.identity parsing
>  + send-email: document --no-[to|cc|bcc]
>  + send-email: fix broken transferEncoding tests
>  + send-email: remove cargo-culted multi-patch pattern in tests
>   (merged to 'next' on 2019-05-13 at 38c6a1e7e0)
>  + send-email: do defaults -> config -> getopt in that order
>  + send-email: rename the @bcclist variable for consistency
>  + send-email: move the read_config() function above getopts
>
>  Since "git send-email" learned to take 'auto' as the value for the
>  transfer-encoding, it by mistake stopped honoring the values given
>  to the configuration variables sendemail.transferencoding and/or
>  sendemail.<ident>.transferencoding.  This has been corrected to
>  (finally) redoing the order of setting the default, reading the
>  configuration and command line options.
>
>  Will cook in 'next'.

I guess many users of `git send-email` actually build their Git
themselves, so cooking it in `next` should give this patch series some
good exposure.

> * dl/format-patch-notes-config (2019-05-17) 2 commits
>   (merged to 'next' on 2019-05-19 at d3f6f1872b)
>  + format-patch: teach format.notes config option
>  + git-format-patch.txt: document --no-notes option
>
>  "git format-patch" learns a configuration to set the default for
>  its --notes=3D<ref> option.
>
>  Will cook in 'next'.

Sounds good to me.

> * jk/unused-params-final-batch (2019-05-13) 14 commits
>   (merged to 'next' on 2019-05-15 at ef7435264c)
>  + verify-commit: simplify parameters to run_gpg_verify()
>  + show-branch: drop unused parameter from show_independent()
>  + rev-list: drop unused void pointer from finish_commit()
>  + remove_all_fetch_refspecs(): drop unused "remote" parameter
>  + receive-pack: drop unused "commands" from prepare_shallow_update()
>  + pack-objects: drop unused rev_info parameters
>  + name-rev: drop unused parameters from is_better_name()
>  + mktree: drop unused length parameter
>  + wt-status: drop unused status parameter
>  + read-cache: drop unused parameter from threaded load
>  + clone: drop dest parameter from copy_alternates()
>  + submodule: drop unused prefix parameter from some functions
>  + builtin: consistently pass cmd_* prefix to parse_options
>  + cmd_{read,write}_tree: rename "unused" variable that is used
>
>  Remove many unused parameters throughout the codebase, with the
>  ultimate aim to allow us compile with -Wunused-parameter cleanly.
>
>  Will cook in 'next'.

What a heroic effort. I look forward to having this in `master` short
after v2.22.0.

> * nd/init-relative-template-fix (2019-05-13) 1 commit
>   (merged to 'next' on 2019-05-15 at 4d5b17f712)
>  + init: make --template path relative to $CWD
>
>  A relative pathname given to "git init --template=3D<path> <repo>"
>  ought to be relative to the directory "git init" gets invoked in,
>  but it instead was made relative to the repository, which has been
>  corrected.
>
>  Will cook in 'next'.

Yep, makes sense, if you ask me.

> * en/fast-export-encoding (2019-05-14) 5 commits
>   (merged to 'next' on 2019-05-16 at c88bd3edb5)
>  + fast-export: do automatic reencoding of commit messages only if reque=
sted
>  + fast-export: differentiate between explicitly UTF-8 and implicitly UT=
F-8
>  + fast-export: avoid stripping encoding header if we cannot reencode
>  + fast-import: support 'encoding' commit header
>  + t9350: fix encoding test to actually test reencoding
>
>  The "git fast-export/import" pair has been taught to handle commits
>  with log messages in encoding other than UTF-8 better.
>
>  Will cook in 'next'.

Yes, please ;-)

> * nd/merge-quit (2019-05-19) 2 commits
>   (merged to 'next' on 2019-05-19 at 9880e7ee4e)
>  + merge: add --quit
>  + merge: remove drop_save() in favor of remove_merge_branch_state()
>
>  "git merge" learned "--quit" option that cleans up the in-progress
>  merge while leaving the working tree and the index still in a mess.
>
>  Will cook in 'next'.

Also: yes, please!

> * es/first-contrib-tutorial (2019-05-29) 3 commits
>   (merged to 'next' on 2019-05-30 at 96317960ab)
>  + doc: add some nit fixes to MyFirstContribution
>   (merged to 'next' on 2019-05-19 at 9ddfae82bf)
>  + documentation: add anchors to MyFirstContribution
>  + documentation: add tutorial for first contribution
>
>  A new tutorial targetting specifically aspiring git-core
>  developers.
>
>  Will cook in 'next'.

As with the `GIT_DEBUGGER` topic, I am not so sure that it makes sense to
cook in `next`, as it will hardly get any exposure, if any at all.

> * nd/worktree-name-sanitization (2019-05-15) 1 commit
>   (merged to 'next' on 2019-05-16 at 9a2dd33122)
>  + worktree add: sanitize worktree names
>
>  In recent versions of Git, per-worktree refs are exposed in
>  refs/worktrees/<wtname>/ hierarchy, which means that worktree names
>  must be a valid refname component.  The code now sanitizes the names
>  given to worktrees, to make sure these refs are well-formed.
>
>  Will cook in 'next'.

I am in favor of cooking this a bit more, too.

Hopefully it is useful for you to hear my thoughts on those branches? If
not, please let me know, I do not want to impose my opinion on you.

Thanks,
Dscho

