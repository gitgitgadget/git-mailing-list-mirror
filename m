Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4086B1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeHMOUZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:20:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:34459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728461AbeHMOUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:20:25 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1W5x-1g8lIE2DyT-00tVII; Mon, 13
 Aug 2018 13:38:23 +0200
Date:   Mon, 13 Aug 2018 13:38:29 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/21] Add range-diff, a tbdiff lookalike
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808131337360.71@tvgsbejvaqbjf.bet>
References: <pull.1.v5.git.gitgitgadget@gmail.com> <pull.1.v6.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qUizvWxMQhTxa9W57lVToQ8WfJmOfa1vgphUtM5UNXvO+p6PWRC
 rMSce+sV3F6Dq5YJsZGtTDZ00DWQvwNoynSARqhCWNLsNtrNmIWuub83L9xD2AaLzAd0Yb7
 OWPmox0ngbmgvKDO0KhwFMVUOM6oQfubT6vghfNw9xqzLDEwmdDnDkw4udM5BbqiV1nd040
 ZuXSD3OhpU68A8IQbxArg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XHwjt0pLtko=:hL32B69gHqy8dl8UXmc4a+
 TALfEGPhD7rivl4QxJPe0EV3fEVmEL+/TD0MbtvpyGOAW6IW76MWa2vAbxKSA2Dk8Hs5NVaeg
 yfOXkp5nOIoD6b37c61/xMhpQXqtCI3aG5o6EYEgi7dDc5Bijfxp/cIgUuoJauAamBiXQVVTK
 bsKiVWOnYoQ2gJdo7RfzmUBB6vHFw9LsTpK01pqLWTKeV3OUOWnSEile36G6jEjOh8Qkts9Z2
 cZyyqCHlfIpXFVrLvoZQBNbnmWeW5lqNuS4vPI4k6TEBW5/5JF4IR9yUDrAJcNPpPS4vstkmG
 E7LzGY4x/++OaujvrRTFRWJCmJAn8KefuwJk3lLUdabT78MWkiY23Ing+tTiQOlwOzs2SRb4w
 rGoeqoFzlsn/hN30IR8gLoxL8bP0h/92hKFr+QH08WLhZJ/MOXHv4mDCs7lbEjuSOqDs2LjpF
 QxxFayQ82GMUY67nKBAV+UclXBctHOxym/aJqWw1YBZr3IMhTCmxJQWJ6NI1MQcBFUAlVU6V8
 io4V7VyxGBsIWNyW6+6YuUosjxZKVnXpdTfkXMMdDNHvyGg5lwzKKkm1aeuYDOF2ukG34iyje
 x41/kB0Sxuo4Rh6uYkcVhql3c/bkXVuPN5A3RO3Wh77/RQXm87r/5PhJEZNFyM1TdYloAC5bc
 H+Il7LeKwNSxcHql9QUGh+zVHUda1+zkpaSc1Sxee9UlmjvmEWtjzK8oMORT7ovru1MdDRqKi
 TXhCILLK0CUl85mEMEqJPp0AzvA31TLLUDBRmVGC+fQj6157WZsnZLty3W7AgXeakNaz9ihxE
 MF8XfST
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 13 Aug 2018, Johannes Schindelin via GitGitGadget wrote:

> The incredibly useful git-tbdiff [https://github.com/trast/tbdiff] tool to
> compare patch series (say, to see what changed between two iterations sent
> to the Git mailing list) is slightly less useful for this developer due to
> the fact that it requires the hungarian and numpy Python packages which are
> for some reason really hard to build in MSYS2. So hard that I even had to
> give up, because it was simply easier to re-implement the whole shebang as a
> builtin command.
> 
> The project at https://github.com/trast/tbdiff seems to be dormant, anyway.
> Funny (and true) story: I looked at the open Pull Requests to see how active
> that project is, only to find to my surprise that I had submitted one in
> August 2015, and that it was still unanswered let alone merged.
> 
> While at it, I forward-ported AEvar's patch to force --decorate=no because 
> git -p tbdiff would fail otherwise.
> 
> Side note: I work on implementing range-diff not only to make life easier
> for reviewers who have to suffer through v2, v3, ... of my patch series, but
> also to verify my changes before submitting a new iteration. And also, maybe
> even more importantly, I plan to use it to verify my merging-rebases of Git
> for Windows (for which I previously used to redirect the
> pre-rebase/post-rebase diffs vs upstream and then compare them using git
> diff --no-index). And of course any interested person can see what changes
> were necessary e.g. in the merging-rebase of Git for Windows onto v2.17.0 by
> running a command like:
> 
>         base=^{/Start.the.merging-rebase}
>         tag=v2.17.0.windows.1
>         pre=$tag$base^2
>         git range-diff $pre$base..$pre $tag$base..$tag
> 
> The command uses what it calls the "dual color mode" (can be disabled via 
> --no-dual-color) which helps identifying what actually changed: it prefixes
> lines with a - (and red background) that correspond to the first commit
> range, and with a + (and green background) that correspond to the second
> range. The rest of the lines will be colored according to the original
> diffs.

Changes since v5:

- Fixed the bug (introduced in v5) where a dashdash would not be handled
  appropriately.

> Changes since v4:
> 
>  * Fixed a typo in the commit message of "range-diff: add tests" that was
>    introduced in v4.
>  * White-space fixes.
>  * Fixed the length of the first header underline in the man page.
>  * Changed the preprocessor guard in linear-assignment.h to reflect the new
>    name (instead of the old name, which was hungarian.h).
>  * Likewise, changed the preprocessor guards in range-diff.h to hide the
>    history of the thrice-renamed command.
>  * Fixed indentation in the completion.
>  * Instead of trying to paper over white-space error handling that does not
>    apply to "diffs of diffs", dual color mode now simply disables all
>    white-space warnings.
>  * When showing the "single arg must be symmetric range" error message, git
>    range-diff now also shows the usage.
>  * Adjusted the commit message of "range-diff: adjust the output of the
>    commit pairs" to avoid the surprise of the reviewer when onelines are
>    printed all of a sudden, too.
>  * "range-diff: adjust the output of the commit pairs" is now using a
>    simpler way to print onelines.
>  * We are now sandwiching the diff_opt_parse() loop between two 
>    parse_options(), to make sure that we caught all options, and that the -- 
>    separator is handled.
>  * Adjusted the lookup_commit_reference() call to the newest master (it now
>    takes a the_repository parameter).
> 
> Changes since v3:
> 
>  * The cover letter was adjusted to reflect the new reality (the command is
>    called range-diff now, not branch-diff, and --dual-color is the default).
>  * The documentation was adjusted a bit more in the patch that makes 
>    --dual-color the default.
>  * Clarified the calculation of the cost matrix, as per Stefan Beller's
>    request.
>  * The man page now spells out that merge commits are ignored in the commit
>    ranges (not merges per se).
>  * The code in linear-assignment.c was adjusted to use the SWAP() macro.
>  * The commit message of the patch introducing the first rudimentary
>    implementation no longer talks about the "Hungarian" algorithm, but about
>    the "linear assignment algorithm" instead.
>  * A bogus indentation change was backed out from the patch introducing the
>    first rudimentary implementation.
>  * Instead of merely warning about missing .. in the 2-parameter invocation,
>    we now exit with the error message.
>  * The diff_opt_parse() function is allowed to return a value larger than 1,
>    indicating that more than just one command-line parameter was parsed. We
>    now advance by the indicated value instead of always advancing exactly 1
>    (which is still correct much of the time).
>  * A lengthy if...else if...else if...else was simplified (from a logical
>    point of view) by reordering it.
>  * The unnecessarily static variable dashes was turned into a local variable
>    of the caller.
>  * The commit message talking about the new man page still referred to git
>    branch --diff, which has been fixed.
>  * A forgotten t7910 reference was changed to t3206.
>  * An unbalanced double-tick was fixed in the man page.
>  * Fixed grammar both of the commit message and the description of the 
>    --no-dual-color option.
>  * To fix the build, a blank man page is now introduced together with the
>    new range-diff command, even if it is populated for real only at a later
>    patch (i.e. at the same time as before).
>  * The headaches Junio fears would be incurred by that simple workaround to
>    avoid bogus white-space error reporting are fended off: a more complex
>    patch is now in place that adds (and uses) a new white-space flag. Sadly,
>    as is all too common when Junio "encourages" me to replace a simple
>    workaround by something "proper", it caused all kinds of headaches to get
>    this right, so I am rather less certain that the "proper" fix will cause
>    us less headaches than the simple workaround would have done. But
>    whatever.
>  * The dual color mode now also dims the changes that are exclusively in the
>    first specified commit range, and uses bold face on the changes
>    exclusively in the second one. This matches the intuition when using 
>    range-diff to compare an older iteration of a patch series to a newer
>    one: the changes from the previous iteration that were replaced by new
>    ones "fade", while the changes that replace them are "shiny new".
> 
> Changes since v2:
> 
>  * Right-aligned the patch numbers in the commit pairs.
>  * Used ALLOC_ARRAY() in hungarian.c instead of xmalloc(sizeof()*size).
>  * Changed compute_assignment()s return type from int to void, as it always
>    succeeds.
>  * Changed the Hungarian Algorithm to use an integer cost matrix.
>  * Changed the --creation-weight option to --creation-factor where is an
>    integer.
>  * Retitled 1/19 and 2/19 to better conform with the current conventions, as
>    pointed out (and suggested) by Junio.
>  * Shut up Coverity, and at the same time avoided passing the unnecessary i 
>    and j parameters to output_pair_header().
>  * Removed support for the --no-patches option: we inherit diff_options'
>    support for -s already (and much more).
>  * Removed the ugly _INV enum values, and introduced a beautiful
>    GIT_COLOR_REVERSE instead. This way, whatever the user configured as
>    color.diff.new (or .old) will be used in reverse in the dual color mode.
>  * Instead of overriding the fragment header color, the dual color mode will
>    now reverse the "outer" fragment headers, too.
>  * Turned the stand-alone branch-diff command into the --diff option of git
>    branch. Adjusted pretty much all commit messages to account for this.
>    This change should no longer be visible: see below.
>  * Pretty much re-wrote the completion, to support the new --diff mode of
>    git-branch. See below: it was reverted for range-diff.
>  * Renamed t7910 to t3206, to be closer to the git-branch tests.
>  * Ensured that git_diff_ui_config() gets called, and therefore color.diff.*
>    respected.
>  * Avoided leaking four_spaces.
>  * Fixed a declaration in a for (;;) statement (which Junio had as a fixup!
>    that I almost missed).
>  * Renamed branch --diff, which had been renamed from branch-diff (which was
>    picked to avoid re-using tbdiff) to range-diff.
>  * Renamed hungarian.c and its header to linear-assignment.c
>  * Made --dual-color the default, and changed it to still auto-detect
>    whether color should be used rather than forcing it
> 
> Johannes Schindelin (20):
>   linear-assignment: a function to solve least-cost assignment problems
>   Introduce `range-diff` to compare iterations of a topic branch
>   range-diff: first rudimentary implementation
>   range-diff: improve the order of the shown commits
>   range-diff: also show the diff between patches
>   range-diff: right-trim commit messages
>   range-diff: indent the diffs just like tbdiff
>   range-diff: suppress the diff headers
>   range-diff: adjust the output of the commit pairs
>   range-diff: do not show "function names" in hunk headers
>   range-diff: use color for the commit pairs
>   color: add the meta color GIT_COLOR_REVERSE
>   diff: add an internal option to dual-color diffs of diffs
>   range-diff: offer to dual-color the diffs
>   range-diff --dual-color: skip white-space warnings
>   range-diff: populate the man page
>   completion: support `git range-diff`
>   range-diff: left-pad patch numbers
>   range-diff: make --dual-color the default mode
>   range-diff: use dim/bold cues to improve dual color mode
> 
> Thomas Rast (1):
>   range-diff: add tests
> 
>  .gitignore                             |   1 +
>  Documentation/config.txt               |   6 +-
>  Documentation/git-range-diff.txt       | 252 +++++++++++
>  Makefile                               |   3 +
>  builtin.h                              |   1 +
>  builtin/range-diff.c                   | 116 +++++
>  color.h                                |   7 +
>  command-list.txt                       |   1 +
>  contrib/completion/git-completion.bash |  14 +
>  diff.c                                 | 105 ++++-
>  diff.h                                 |  10 +-
>  git.c                                  |   1 +
>  linear-assignment.c                    | 201 ++++++++
>  linear-assignment.h                    |  22 +
>  range-diff.c                           | 435 ++++++++++++++++++
>  range-diff.h                           |   9 +
>  t/.gitattributes                       |   1 +
>  t/t3206-range-diff.sh                  | 145 ++++++
>  t/t3206/history.export                 | 604 +++++++++++++++++++++++++
>  19 files changed, 1915 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/git-range-diff.txt
>  create mode 100644 builtin/range-diff.c
>  create mode 100644 linear-assignment.c
>  create mode 100644 linear-assignment.h
>  create mode 100644 range-diff.c
>  create mode 100644 range-diff.h
>  create mode 100755 t/t3206-range-diff.sh
>  create mode 100644 t/t3206/history.export
> 
> 
> base-commit: 1d89318c48d233d52f1db230cf622935ac3c69fa
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-1%2Fdscho%2Fbranch-diff-v6
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1/dscho/branch-diff-v6
> Pull-Request: https://github.com/gitgitgadget/git/pull/1
> 
> Range-diff vs v5:
> 
>   1:  f168da3a3 =  1:  f168da3a3 linear-assignment: a function to solve least-cost assignment problems
>   2:  33758f361 =  2:  33758f361 Introduce `range-diff` to compare iterations of a topic branch
>   3:  08b8c3fc4 =  3:  08b8c3fc4 range-diff: first rudimentary implementation
>   4:  7b9091968 =  4:  7b9091968 range-diff: improve the order of the shown commits
>   5:  9e1e66007 !  5:  8515d2f75 range-diff: also show the diff between patches
>      @@ -80,6 +80,8 @@
>       +		else
>       +			i += c;
>       +	}
>      ++	while (i < argc)
>      ++		argv[j++] = argv[i++];
>       +	argc = j;
>       +	diff_setup_done(&diffopt);
>       +
>   6:  167ca02a3 =  6:  a10ca0163 range-diff: right-trim commit messages
>   7:  ca8de8c75 =  7:  f81cbef2c range-diff: indent the diffs just like tbdiff
>   8:  eb94d1982 =  8:  458090ffd range-diff: suppress the diff headers
>   9:  6330afad9 =  9:  d3be03a44 range-diff: adjust the output of the commit pairs
>  10:  c296675eb = 10:  94b44dfe6 range-diff: do not show "function names" in hunk headers
>  11:  85e0ab82f = 11:  1477c58e4 range-diff: add tests
>  12:  f48b62644 = 12:  32492c159 range-diff: use color for the commit pairs
>  13:  1ad74f939 = 13:  969a196f4 color: add the meta color GIT_COLOR_REVERSE
>  14:  39a0ecd28 = 14:  f1c86f606 diff: add an internal option to dual-color diffs of diffs
>  15:  c32a24f6a = 15:  3c7b9f339 range-diff: offer to dual-color the diffs
>  16:  05947781f = 16:  c56c51c8b range-diff --dual-color: skip white-space warnings
>  17:  3147c4440 = 17:  8c5543a06 range-diff: populate the man page
>  18:  b08e6d937 = 18:  16e3cf27b completion: support `git range-diff`
>  19:  19406283e = 19:  d9b09abcf range-diff: left-pad patch numbers
>  20:  6b3552386 = 20:  f6fd3955e range-diff: make --dual-color the default mode
>  21:  ccf8c1bb2 = 21:  699cd712e range-diff: use dim/bold cues to improve dual color mode
> 
> -- 
> gitgitgadget
> 
> 
