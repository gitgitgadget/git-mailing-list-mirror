Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FC44207F8
	for <e@80x24.org>; Sat,  6 May 2017 14:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbdEFOzR (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 10:55:17 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36094 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdEFOzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 10:55:16 -0400
Received: by mail-yw0-f179.google.com with SMTP id b68so14179232ywe.3
        for <git@vger.kernel.org>; Sat, 06 May 2017 07:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FGs5SizU0J4thlCOkEC9Lu94RLrt6WSJxHPVVO1J0wA=;
        b=IsacOG3SRj4t6slaWI8vmnjINRQAF03J0G751REoEIfom1lGMQd0U2fQrjbsRG+vlN
         IbnyJ2EfWTHRg7zm3O0LG74+PEV3RbhbLZBvojZ1o3m2y23183V7If3mMSkSlQode2VH
         6Osqg8ZsO8jzHqdvNiL8Ct9nex91OMn3/p44alE8XGM4S+70VgKRU6eT4hG2FG6djTOf
         X88JldW5cOp4n5qyA8lmdVuggT5pC5EwpxDcQlOz3BjJBS2Dsw4J1bHQlknJ1Cm6j5k9
         hRc+RmXhRM+XQiQYLmDhuyVAoibHwRTSPRJNGTgEK5ga02M99fsf8idIshpAONWNQ9bk
         08VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FGs5SizU0J4thlCOkEC9Lu94RLrt6WSJxHPVVO1J0wA=;
        b=b1tJKkQ3mGiOUcEsNngOBQOqWVwYngQn0WopA3CH0Av19R4A3HYE9Ujp1A2pb14hEW
         vi2FYkgydNNDV0TluyNYFGMxaOWJM/Eq+OhLtYxwTwpIx55yZ2bbv73jEPHtUQMo6/vp
         oF35DVYkaG7qEbxApsvN5JsYBEXdwK7jp62DNZRNA0Am/GdAEhpyJXgdc/J+XhptFK29
         unsnak1y28u8c8gsYGvHvGc0kmfrXqBh6oaxkCqdhnSZn7dFLPfj423BEfmFv3CAKfC1
         DAlikT+Wb7VECCHlpLDOHJP9gi7FpYDfI5VoHyA2Xr42TTPswPG8mBJHeQGQ02GJpWae
         vn+g==
X-Gm-Message-State: AN3rC/7RhU0iv5vaOtY6G5eVqr2zeeAbCKymjKYpzPbEau9iCm6gn4pd
        Ceb7HM9Fr5VmaU+/2yfPrx0PA90RcbQV3e4=
X-Received: by 10.13.204.78 with SMTP id o75mr12274691ywd.251.1494082515322;
 Sat, 06 May 2017 07:55:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.78.148 with HTTP; Sat, 6 May 2017 07:54:54 -0700 (PDT)
From:   Jonas Fonseca <jonas.fonseca@gmail.com>
Date:   Sat, 6 May 2017 10:54:54 -0400
Message-ID: <CAFuPQ1KSfKT+UKEdjcQ60sWL-yBGPWUZxhAAQ1AdrAr=VMdGfQ@mail.gmail.com>
Subject: [ANNOUNCE] tig-2.2.2
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

A new version of Tig has been release with several improvements and bug fix=
es.

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
Upgrade instructions:

 - The `status-untracked-dirs` option was renamed to
   `status-show-untracked-dirs` to match the new `status-show-untracked-fil=
es`
   option.

Improvements:

 - Use `diff-options` when preparing the diff in the stage view to make the=
 diff
   state configurable. (GH #545)
 - Add 'status-show-untracked-files' option mirroring Git's
   'status.showUntrackedFiles' to toggle display of untracked files.  in th=
e
   status view. On by default. (GH #562)
 - Update `ax_with_curses.m4` and use `pkg-config` to detect. (GH #546)
 - Add `tig-pick` script for using Tig as a commit picker. (GH #575, #580)
 - Add "smart case" option ('set ignore-case =3D smart-case') to ignore cas=
e when
   the search string is lower-case only. (GH #320, #579)

Bug fixes:

 - Fix author ident cache being keyed by email only. (GH #424, #526, #547)
 - Fix periodic refresh mode to properly detect ref changes. (GH #430, #591=
)
 - Add workaround for detecting failure to start the diff-highlight process=
.
 - Show diffs in the stash view when `set mailmap =3D true`. (GH #556)
 - Fix parsing of git-log revision arguments, such as `--exclude=3D...` in
   conjunction with `--all`. (GH #555)
 - Fix diff stat parsing for binary copies.
 - Fix crash when resizing terminal while search is in progress. (GH #515, =
#550)
 - Fix argument filtering to pass more arguments through to Git.
 - Check for termcap support in split tinfo libs. (GH #568, #585)

Change summary
--------------
The diffstat and log summary for changes made in this release.

 INSTALL.adoc                         |  10 +-
 Makefile                             |   2 +-
 NEWS.adoc                            |  44 ++++++++-
 README.adoc                          |   2 +-
 book.md                              |   2 +-
 config.make.in                       |   2 +-
 configure.ac                         |   2 +-
 contrib/tig-pick                     |  48 +++++++++
 doc/manual.adoc                      |   5 +-
 doc/screenshots.md                   |  11 ---
 doc/tig.1.adoc                       |   2 +-
 doc/tigrc.5.adoc                     |  15 ++-
 include/tig/argv.h                   |   1 +
 include/tig/diff.h                   |   4 +-
 include/tig/git.h                    |   4 +-
 include/tig/options.h                |   5 +-
 include/tig/types.h                  |  12 ++-
 include/tig/util.h                   |   1 +
 include/tig/view.h                   |   4 +-
 src/argv.c                           |   4 +-
 src/blame.c                          |  29 +++---
 src/blob.c                           |  16 ++-
 src/diff.c                           |  56 ++++++-----
 src/display.c                        |   8 +-
 src/draw.c                           |   2 +-
 src/grep.c                           |   4 +-
 src/help.c                           |   9 +-
 src/io.c                             |   8 +-
 src/log.c                            |   2 +-
 src/main.c                           |  16 +--
 src/options.c                        |  72 +++++++++-----
 src/pager.c                          |  10 +-
 src/parse.c                          |  14 ++-
 src/refs.c                           |  21 ++--
 src/search.c                         |  16 ++-
 src/stage.c                          |  44 ++++-----
 src/stash.c                          |   6 +-
 src/status.c                         |  40 +++++---
 src/tig.c                            |  30 +++---
 src/tree.c                           |  10 +-
 src/util.c                           |   6 +-
 src/view.c                           |  25 ++---
 src/watch.c                          |   2 +-
 test/diff/diff-highlight-test        |  38 ++++++-
 test/files/repo-authornamechange.tgz | Bin 0 -> 7557 bytes
 test/main/author-name-change-test    |  27 +++++
 test/main/filter-args-test           |  74 ++++++++++++++
 test/main/refresh-periodic-test      |  74 ++++++++++++++
 test/main/search-test                |  22 +++++
 test/status/untracked-files-test     |  27 +++++
 test/tigrc/compat-error-test         |   5 +-
 tigrc                                |   6 +-
 tools/aspell.dict                    |   9 +-
 tools/ax_lib_readline.m4             |  16 ++-
 tools/ax_require_defined.m4          |  37 +++++++
 tools/ax_with_curses.m4              | 142 +++++++++++++++++++--------
 56 files changed, 822 insertions(+), 281 deletions(-)

    22  Jonas Fonseca
     3  Mina Naguib
     1  Justin Lecher
     1  Konrad Gr=C3=A4fe
     1  Lukas Holecek
     1  Thomas Koutcher
     1  Benjamin Reitzammer
     1  Tim Harder
     1  Delyan Angelov

--=20
Jonas Fonseca
