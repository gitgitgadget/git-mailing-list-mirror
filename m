Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7993D20281
	for <e@80x24.org>; Fri, 29 Sep 2017 15:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbdI2PcT (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 11:32:19 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:57116 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbdI2PcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 11:32:16 -0400
Received: by mail-pg0-f51.google.com with SMTP id 7so937184pgd.13
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IYAghjLISdY/Yohmo6TKsjBiro+syYDo7SJY+fsWVI8=;
        b=DFTvyXtNX5xnHtwEhvLL0tpjw9tlZjs7n3QEc2a1L9jead2EGY9K0i3uEc9nLZDpIQ
         OsUYtS8wiHnJBIhsF5uXu2j2az9uYNnj7f2AwYdyNHNGqBtig1IRsWRmqebRncB5FWah
         Qz8VsJ2c2n/X3KVBhjXRm4AWDuqoalc4p/Ry2it2Ga54UUNMEBRDksNjTcFf5rK/1b/c
         E2lG+hXa18Qi/+gN7O9gdW0sNk+O58akSaDETHWwDnOWSNK8MPmIAWGVz/OPnRS6+qOF
         B8Dm3d+FodJw3rrMl3wy4Eb0UmaoZetIiCqgu99Y8InMGyUeAIRgFSlDPeHO716zKibt
         aHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IYAghjLISdY/Yohmo6TKsjBiro+syYDo7SJY+fsWVI8=;
        b=Mk5PnADlLvVtvMjAgK5q1F3sk7gKY7HfWkvBmn/Pa6F8Nrnqbq+2Uv8JXhnalQtezo
         VB3uXhX+OiqudQyQQZjVkphP1PFc4MguTbY/1hPvwvllSrp2HlqOrx9jy4aV1/JmA3NA
         flkLcuf02AsYJucgqzyyCy0NyW8EyYChU86gt+wjfQDUJSpYVQAcUqT9bTlQkDCmUcHc
         vxJQgUdEtg/aBkTWmmO2/VEWl3fu4M/R8MZTuEJBR3Ft8zuEF7ylgMhCmv+RrCqWvObY
         4ieIpXLWAvn9woQ4Om1jstcWDC0qLr5o3BJt2PbV3cPks/gqmi+JbFlF7YpR/ehk1mh8
         w5EQ==
X-Gm-Message-State: AHPjjUj7GJEWa982oePW7ZQmvArBoVjs7ejBUR+O8i6RdYpvCsOinDiu
        8QVP0n540DJTCIphaOgIHvWBGPXiOd6UFrOeNKTgwvIr
X-Google-Smtp-Source: AOwi7QBGfYUd7l4T5Nu+9yR5QrAn4G23aCqvO4Hj/Yt5vPiFUuR2sXFXbqfeCq6APEbOm4FIgYdXqzb3wwhdNgrOmRE=
X-Received: by 10.84.199.170 with SMTP id r39mr7381532pld.375.1506699135785;
 Fri, 29 Sep 2017 08:32:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.137.131 with HTTP; Fri, 29 Sep 2017 08:31:55 -0700 (PDT)
From:   Jonas Fonseca <jonas.fonseca@gmail.com>
Date:   Fri, 29 Sep 2017 11:31:55 -0400
Message-ID: <CAFuPQ1LQceLPhqKaFW+5EAXSbqEM0Ww3ZhSH3xQ6HK0GMt-2bw@mail.gmail.com>
Subject: [ANNOUNCE] tig-2.3.0
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Really excited to release version 2.3.0 of Tig which brings several
improvements to the rendering performance, new features like search/prompt
history persistence, and important fixes to the graph rendering and emoji
display. I'd like thank all contributors and Roland Walker and Sven Wegener in
particular for all the great patches.

What is Tig?
------------
Tig is an ncurses-based text-mode interface for git. It functions mainly
as a Git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various Git
commands.

 - Homepage: https://jonas.github.io/tig/
 - Manual: https://jonas.github.io/tig/doc/manual.html
 - Tarballs: https://github.com/jonas/tig/releases
 - Gitter: https://gitter.im/jonas/tig
 - Q&A: http://stackoverflow.com/questions/tagged/tig

Release notes
-------------
Incompatibilities:

 - The `width` setting on the `status`, `text` and `commit-title` columns was
   never applied and has been removed. (GH #617)

Improvements:

 - Improve load performance by throttling screen updates. (GH #622, #629)
 - Speed up graph rendering. (GH #638)
 - Enable scroll optimizations for Terminal.app and iTerm2. (GH #637)
 - Improve the test suite portability to not depend on GNU sed. (GH #609, #614)
 - Make build reproducible. (https://reproducible-builds.org/) (GH #613)
 - Enable binding to more symbolic keys and keys with control modifier:
   `F13`-`F19`, `ShiftLeft`, `ShiftRight`, `ShiftDel`, `ShiftHome`, `ShiftEnd`,
   `ShiftTab`, `Ctrl-C`, `Ctrl-V`, `Ctrl-S`, and `Ctrl-@`. (GH #314, #619, #642)
 - Persist readline history to `~/.tig_history` or `$XDG_DATA_HOME/tig/history`.
   Use `history-size` to control the number of entries to save. (GH #620, #713,
   #714, #718)
 - Preload last search from persistent history. (GH #630)
 - Add `view-close-no-quit` action, unbound by default. (GH #607)
 - Add `mouse-wheel-cursor` option (off by default) when set to true causes
   wheel actions to prefer moving the cursor instead of scrolling. (GH #608)
 - Add `truncation-delimiter` option, set to `~` by default. (GH #646)
 - Add `-q` parameter to `source` for "source-if-present". (GH #612)
 - Add `:echo` prompt command to display text in the status bar. (GH #626, #636)
 - Make `diff-highlight` colors configurable. (GH #625, #633)
 - Let Ctrl-C exit Y/N dialog, menu prompts and the file finder. (GH #632, #648)
 - Hide cursor unless at textual prompt. (GH #643)
 - Expand tilde ('~') in `:script` paths. (GH #674)
 - Show single-line output of external command in status bar. (GH #200, #557,
   #678)
 - Disable the graph when `--no-merges` is passed. (GH #687)
 - Print backtraces on segfault in debug mode.
 - Ignore script lines starting with `#` (comment). (GH #705)
 - Complete `repo:*` variables when readline is enabled. (GH #702)
 - Incorporate XTerm's `wcwidth.c` to find Unicode widths. (GH #691)

Bug fixes:

 - Fix graph display issues. (GH #419, #638)
 - Fix and improve rendering of Unicode characters. (GH #330, #621, #644, #682)
 - Handle hyphenated directory names when listing content. (GH #602)
 - Do not jump to next match when cancelling the search prompt. (GH #627)
 - Fix clearing of the status line after `Ctrl-C`. (GH #623, #649)
 - Fix handling of width on line-number and trimmed width of 1. (GH #617)
 - Set cursor position when not updating prompt contents. (GH #647)
 - Erase status line at exit time for users without altscreen-capable terminals.
   (GH #589)
 - Fix unexpected keys when restoring from suspend (`Ctrl-Z`). (GH #232)
 - contrib/vim.tigrc: Also bind G in the main as a workaround for limitations of
   the `none` action. (GH #594, #599)
 - Only override `blame-options` when commands are given and fix parsing of
   `-C`. (GH #597)
 - Fix diff name discovery to better handle prefixes.
 - Interpret button5 as wheel-down. (GH #321, #606)
 - Fix `back` / `parent` in tree view. (GH #641)
 - Fix memory corruption in `concat_argv` and file finder. (GH #634, #655)
 - Fix reading from stdin for `tig show`.
 - Document problem of outdated system-wide `tigrc` files in Homebrew. (GH #598)
 - Repaint the display when toggling `line-graphics`. (GH #527)
 - Fix custom date formatting support longer strings. (GH #522)
 - Don't segfault on ":exec" irregular args. (GH #686)
 - Fix segfault when calling htab_empty. (GH #663, #745)

Change summary
--------------
The diffstat and log summary for changes made in this release.

 .bookignore                                   |  16 +
 .gitignore                                    |   1 +
 .travis.yml                                   |   1 +
 INSTALL.adoc                                  |  26 +-
 Makefile                                      |  42 +-
 NEWS.adoc                                     |  69 +-
 README.adoc                                   |   2 +-
 book.md                                       |   2 +
 compat/compat.h                               |  15 +
 compat/hashtab.h                              |   4 +-
 compat/wcwidth.c                              | 709 ++++++++++++++++++
 compat/wcwidth.h                              |  47 ++
 compat/wordexp.c                              |  60 ++
 config.make.in                                |   1 +
 configure.ac                                  |   3 +-
 contrib/config.make                           |   3 +
 contrib/config.make-CYGWIN_NT-6.1             |   2 +-
 contrib/config.make-Darwin                    |   1 +
 contrib/tig-completion.bash                   |   6 +-
 contrib/vim.tigrc                             |   4 +-
 doc/manual.adoc                               |  37 +-
 doc/tig.1.adoc                                |  24 +-
 doc/tigrc.5.adoc                              | 120 ++-
 include/tig/display.h                         |   8 +-
 include/tig/io.h                              |   8 +-
 include/tig/keys.h                            |   9 +
 include/tig/line.h                            |  36 +-
 include/tig/options.h                         |   8 +-
 include/tig/prompt.h                          |   1 +
 include/tig/request.h                         |   5 +-
 include/tig/tig.h                             |   6 +
 include/tig/util.h                            |   2 +
 src/argv.c                                    |  12 +-
 src/blame.c                                   |  28 +-
 src/blob.c                                    |   2 +-
 src/diff.c                                    |  27 +-
 src/display.c                                 | 195 ++++-
 src/draw.c                                    |  17 +-
 src/graph-v2.c                                | 193 ++++-
 src/grep.c                                    |   4 +-
 src/io.c                                      |  50 +-
 src/keys.c                                    |  24 +-
 src/line.c                                    |  15 +-
 src/main.c                                    |   2 +-
 src/options.c                                 |  46 +-
 src/prompt.c                                  | 188 ++++-
 src/refdb.c                                   |   3 +
 src/search.c                                  |   4 +-
 src/status.c                                  |   4 +-
 src/string.c                                  |  45 +-
 src/tig.c                                     |  71 +-
 src/tree.c                                    |   4 +-
 src/ui.c                                      |  10 +-
 src/util.c                                    |   2 +-
 src/view.c                                    |  39 +-
 test/README.adoc                              |  10 +
 test/diff/diff-context-test                   |   4 +-
 test/diff/diff-highlight-color-test           |   2 +-
 test/diff/diff-stat-split-test                |  51 ++
 test/diff/diff-stat-test                      | 106 ++-
 test/diff/diff-stdin-test                     |  84 +++
 test/graph/00-simple-test                     |  10 -
 test/graph/06-extra-bars-test                 |  14 +-
 test/graph/10-shorter-merge-than-branch-test  |   2 +-
 test/graph/11-new-branch-in-middle-test       |   6 +-
 test/graph/15-many-merges-test                |  31 +-
 test/graph/17-more-merges-test                |   4 +-
 test/graph/18-tig-test                        |  12 -
 test/graph/20-tig-all-long-test               |   4 +-
 test/graph/gh-490-heap-buffer-overflow-test   |   4 +-
 .../graph/regression/horizontal-artifact-test |  41 +
 .../regression/horizontal-bar-wrong-2-test    |  41 +
 test/help/all-keybindings-test                |   1 +
 test/help/all-keybindings-test.expected       | 238 +++---
 test/help/default-test                        |  10 +-
 test/help/user-command-test                   |  10 +-
 test/main/all-arg-test                        |   2 +-
 test/main/branch-var-test                     |   6 +-
 test/main/commit-title-overflow-test          |   4 +-
 test/main/date-test                           |  34 +
 test/main/emoji-test                          |  74 ++
 test/main/filter-args-test                    |  10 +-
 test/main/graph-argument-test                 |   4 +-
 test/main/jump-ends-test                      |  54 ++
 test/main/no-matching-commmits-test           |   2 +-
 test/main/no-merges-test                      |  33 +
 test/main/refresh-periodic-test               |   2 +-
 test/main/refresh-test                        |   2 +-
 test/main/show-changes-after-rename-test      |   4 +-
 test/main/view-split-test                     |   6 +-
 test/prompt/exec-test                         |  42 ++
 test/refs/branch-var-test                     |   7 +-
 test/refs/replace-test                        |  12 +-
 test/refs/start-on-line-test                  |   2 +-
 test/regressions/github-390-test              |   2 +-
 test/script/comment-test                      |  23 +
 test/script/default-test                      |  21 +-
 test/stage/gh-410-test                        |   4 +-
 test/stage/split-chunk-test                   |   2 +-
 test/stash/start-on-line-test                 |   2 +-
 test/status/file-name-test                    |   6 +-
 test/status/on-branch-test                    |  18 +-
 test/status/on-branch-tracking-info-test      |  20 +-
 test/status/refresh-test                      |   2 +-
 test/status/repo-var-test                     |  17 +-
 test/tigrc/builtin-save-test                  |  16 +
 test/tigrc/command-value-long-test            |  58 ++
 test/tigrc/contrib-tigrc-test                 |   4 +-
 test/tigrc/parse-test                         |  15 +-
 test/tigrc/save-option-test                   |   9 +-
 test/tigrc/source-test                        | 116 +++
 test/tigrc/tigrc-manpage-examples-test        |  14 +-
 test/tigrc/truncation-test                    | 213 ++++++
 test/tigrc/width-test                         | 504 +++++++++++++
 test/tigrc/xdg-config-home-test               |   6 +-
 test/tools/libgit.sh                          |  18 +-
 test/tools/libtest.sh                         | 392 ++++++----
 test/tools/setup-conflict.sh                  |   4 +-
 test/tools/show-results.sh                    |  23 +-
 test/tools/valgrind-Darwin.supp               |   9 +
 test/tree/chdir-test                          | 197 +++++
 test/tree/file-name-test                      | 111 +++
 tigrc                                         |  36 +-
 tools/aspell.dict                             |  24 +-
 tools/ax_lib_readline.m4                      |  12 +-
 acinclude.m4 => tools/iconv.m4                |   0
 tools/make-builtin-config.sh                  |   2 +-
 tools/release.sh                              |   2 +-
 128 files changed, 4356 insertions(+), 794 deletions(-)

     1 Andreas Stieger
     1 Dan Wendorf
     1 Edgar Hipp
     1 Greg Hewgill
    35 Jonas Fonseca
     2 Marc Aldorasi
     1 Ramsay Jones
   112 Roland Walker
    11 Sven Wegener
     1 kiryph

-- 
Jonas Fonseca
