Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 870451F454
	for <e@80x24.org>; Tue,  5 Nov 2019 17:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390345AbfKERHl (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 12:07:41 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:37093 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbfKERHk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 12:07:40 -0500
Received: by mail-wm1-f53.google.com with SMTP id q130so83416wme.2
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 09:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/Ji2COXw3QG1qOtpCcBeYWgc5sRUT5pBQbkpJJ3yA28=;
        b=l9JTyKDUhnvbztwvK7UmoG8tHM4fj2XFx6cONZebEOMCoifn+lceSBeVj4OyRIm6FP
         41jm1+ATUOUVMww83vIka+y9I7bcQLbN4oy67TjbpbU/cK7Thi7xYZUZt1u2oku1J2k0
         1E0LIhudzWF0B8x5whYV5DGFXK+mrTAc70Ae0Mh3UMio0ylvpmmaIdY7FIptptcCX2AC
         +6WEJ3SMgZzfWqHObilxOGTjxzS38IHO3DR7jZbRe4yngm/jXpFZUZrDA10vF8C/YKy9
         xL2cvLksQB/ZjDTcCiiKw/qSE9s6DOsdHrmG0PnBKXX+A5mjjojjHoAdnjH8RCiBKRO4
         LAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/Ji2COXw3QG1qOtpCcBeYWgc5sRUT5pBQbkpJJ3yA28=;
        b=nHDmKgjDa0W+1ztc+6xXZpX16pofQe88pMJ69kuRQNtEKbst23+e625+rMgFJ+j55L
         DsAJab9w2uLa1ZEbiPOpfImsd+3Cyq6FK4y1hnIMVBp+NSMDghVGu4oy6oiQmvkXvV/E
         y7KLJakHANdHfQFsGXghg4KDCykcEWchd75i6VHjDku6FogDznZzI7P4t9nxiDfOE+BE
         NVqt9kCNJs/M0L3WjVDKK2CXmmi37QiOjI322tkFXAldt3q/xlX95tljsOomKwV3WJQ1
         Xt98ui1FyLUHkcFUcYPnfh0D/FkOFGpRH7mAg/ikM0nL+a5SSDBcaGWmVxt5blOobtLp
         JkhA==
X-Gm-Message-State: APjAAAX46zJ+NlwYIYEWMbDbKxLUOx9BneEVbtT5sDxshc9yUEH4BwSp
        9KKyGS5lix35SgRBBoX5KUuvTbOb
X-Google-Smtp-Source: APXvYqx3u+KcO6uLxGaP+wxfIT8aLykpGGcm4yLPR3Xf/uCsQE76THJKNjkvebke3tYhQK6EdPXQNQ==
X-Received: by 2002:a7b:ca51:: with SMTP id m17mr37558wml.110.1572973655033;
        Tue, 05 Nov 2019 09:07:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm21323373wrc.73.2019.11.05.09.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 09:07:34 -0800 (PST)
Message-Id: <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
In-Reply-To: <pull.418.git.1571790574.gitgitgadget@gmail.com>
References: <pull.418.git.1571790574.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 17:07:19 +0000
Subject: [PATCH v2 00/11] Thyme two ficks sum Documentaton tyops and speling erors!
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Note: re-rolled the series instead of building on what's already in
en/doc-typofix; I asked separately that it be ejected from next. If folks
don't like that, I can fairly easily undo the squashing I did and base my
new commits on top of the existing en/doc-typofix.)

We have a number of typos and spelling errors that I spotted under
Documentation/ and many more that were reported by Jens Schleusener (
https://public-inbox.org/git/alpine.LSU.2.21.1911041316270.23271@fossies.org/
)

To simplify review, I have broken this into several independent commits,
such as:

 * spelling errors affecting independent modules
 * documentation fixes
 * messages reported to users
 * comment fixes
 * testname updates
 * testcode changes

This should make it easier to spot and/or eject any fixes that folks don't
want (e.g. there's even a separate "uptodate -> up-to-date" commit with
special rationale). This also allowed me to e.g. easily eject the spelling
fixes to the svk dumps when I found the testcases depended on those spelling
errors.

As in v1, it'd be nice if someone could double check in the first commit
that I placed the missing right parenthesis correctly in
Documentation/technical/api-trace2.txt. Also, not sure if folks would be
happy or unhappy with me un-splitting a word in commit-graph.txt (also in
the first commit).

Elijah Newren (11):
  Documentation: fix a bunch of typos, both old and new
  Fix spelling errors in documentation outside of Documentation/
  Prefer 'up-to-date' spelling
  Fix spelling errors in code comments
  Fix spelling errors in comments of testcases
  Fix spelling errors in names of tests
  Fix spelling errors in messages shown to users
  Fix spelling errors in test commands
  sha1dc: fix trivial comment spelling error
  multimail: fix a few simple spelling errors
  Fix spelling errors in no-longer-updated-from-upstream modules

 Documentation/CodingGuidelines                |  4 ++--
 Documentation/RelNotes/1.5.0.txt              |  4 ++--
 Documentation/RelNotes/1.6.5.4.txt            |  2 +-
 Documentation/RelNotes/1.7.0.2.txt            |  2 +-
 Documentation/RelNotes/1.7.10.4.txt           |  2 +-
 Documentation/RelNotes/1.7.12.3.txt           |  2 +-
 Documentation/RelNotes/1.7.5.3.txt            |  2 +-
 Documentation/RelNotes/1.8.0.txt              |  2 +-
 Documentation/RelNotes/1.8.4.1.txt            |  2 +-
 Documentation/RelNotes/2.1.3.txt              |  2 +-
 Documentation/RelNotes/2.10.0.txt             |  2 +-
 Documentation/RelNotes/2.10.2.txt             |  2 +-
 Documentation/RelNotes/2.11.1.txt             |  2 +-
 Documentation/RelNotes/2.12.0.txt             |  2 +-
 Documentation/RelNotes/2.13.0.txt             |  2 +-
 Documentation/RelNotes/2.13.3.txt             |  4 ++--
 Documentation/RelNotes/2.14.0.txt             |  4 ++--
 Documentation/RelNotes/2.16.0.txt             |  2 +-
 Documentation/RelNotes/2.16.3.txt             |  2 +-
 Documentation/RelNotes/2.17.0.txt             |  2 +-
 Documentation/RelNotes/2.18.0.txt             |  2 +-
 Documentation/RelNotes/2.19.0.txt             |  2 +-
 Documentation/RelNotes/2.20.0.txt             |  2 +-
 Documentation/RelNotes/2.3.3.txt              |  2 +-
 Documentation/RelNotes/2.3.7.txt              |  2 +-
 Documentation/RelNotes/2.4.3.txt              |  2 +-
 Documentation/RelNotes/2.7.0.txt              |  2 +-
 Documentation/RelNotes/2.8.0.txt              |  2 +-
 Documentation/RelNotes/2.9.3.txt              |  2 +-
 Documentation/config.txt                      |  2 +-
 Documentation/config/tag.txt                  |  2 +-
 Documentation/git-bisect-lk2009.txt           |  2 +-
 Documentation/git-check-attr.txt              |  2 +-
 Documentation/git-check-ignore.txt            |  2 +-
 Documentation/git-cvsserver.txt               |  2 +-
 Documentation/git-fast-export.txt             |  2 +-
 Documentation/git-filter-branch.txt           |  2 +-
 Documentation/git-range-diff.txt              |  2 +-
 Documentation/git-tag.txt                     |  2 +-
 Documentation/git-update-index.txt            |  2 +-
 Documentation/git.txt                         |  4 ++--
 Documentation/gitattributes.txt               |  6 +++---
 Documentation/gitmodules.txt                  |  2 +-
 .../howto/separating-topic-branches.txt       |  2 +-
 Documentation/merge-options.txt               |  2 +-
 .../technical/api-submodule-config.txt        |  2 +-
 Documentation/technical/api-trace2.txt        | 14 ++++++-------
 Documentation/technical/commit-graph.txt      | 12 +++++------
 .../technical/hash-function-transition.txt    |  4 ++--
 Documentation/technical/index-format.txt      |  4 ++--
 Documentation/technical/pack-protocol.txt     |  2 +-
 Documentation/technical/partial-clone.txt     |  2 +-
 Documentation/technical/protocol-v2.txt       |  2 +-
 Documentation/technical/rerere.txt            |  2 +-
 INSTALL                                       |  2 +-
 apply.c                                       |  4 ++--
 builtin/fetch.c                               |  4 ++--
 builtin/gc.c                                  |  4 ++--
 builtin/pack-objects.c                        |  2 +-
 commit-graph.c                                |  2 +-
 commit.h                                      |  2 +-
 compat/mingw.h                                |  2 +-
 compat/nedmalloc/malloc.c.h                   |  6 +++---
 compat/obstack.h                              |  2 +-
 compat/regex/regcomp.c                        |  2 +-
 compat/regex/regex.h                          |  2 +-
 compat/regex/regex_internal.c                 |  2 +-
 compat/regex/regexec.c                        |  4 ++--
 compat/vcbuild/find_vs_env.bat                |  2 +-
 configure.ac                                  |  2 +-
 contrib/coccinelle/commit.cocci               |  2 +-
 contrib/completion/git-completion.bash        |  4 ++--
 contrib/hooks/multimail/git_multimail.py      |  8 ++++----
 contrib/hooks/multimail/post-receive.example  |  2 +-
 contrib/hooks/post-receive-email              |  2 +-
 contrib/hooks/update-paranoid                 |  2 +-
 contrib/mw-to-git/.perlcriticrc               |  2 +-
 contrib/mw-to-git/git-remote-mediawiki.perl   |  2 +-
 .../mw-to-git/t/install-wiki/db_install.php   |  2 +-
 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh  |  2 +-
 contrib/mw-to-git/t/test-gitmw-lib.sh         |  2 +-
 contrib/svn-fe/svnrdump_sim.py                |  2 +-
 convert.c                                     |  2 +-
 daemon.c                                      |  4 ++--
 diff.c                                        |  4 ++--
 dir.c                                         |  2 +-
 git-cvsimport.perl                            |  2 +-
 git-send-email.perl                           |  2 +-
 gitk-git/gitk                                 |  2 +-
 gitweb/gitweb.perl                            | 18 ++++++++---------
 hashmap.c                                     |  2 +-
 hashmap.h                                     |  2 +-
 help.c                                        |  2 +-
 name-hash.c                                   |  2 +-
 parse-options.c                               |  2 +-
 perl/Git.pm                                   |  2 +-
 range-diff.h                                  |  2 +-
 read-cache.c                                  |  2 +-
 refs/refs-internal.h                          |  2 +-
 repository.c                                  |  4 ++--
 repository.h                                  |  2 +-
 rerere.c                                      |  2 +-
 sequencer.c                                   |  6 +++---
 server-info.c                                 |  2 +-
 sha1dc/sha1.c                                 |  2 +-
 string-list.h                                 |  2 +-
 t/perf/bisect_regression                      |  2 +-
 t/t0000-basic.sh                              |  2 +-
 t/t0027-auto-crlf.sh                          |  2 +-
 t/t0500-progress-display.sh                   |  4 ++--
 t/t1050-large.sh                              |  6 +++---
 t/t1512-rev-parse-disambiguation.sh           |  2 +-
 t/t3210-pack-refs.sh                          |  2 +-
 t/t3905-stash-include-untracked.sh            |  4 ++--
 t/t4041-diff-submodule-option.sh              | 20 +++++++++----------
 t/t4057-diff-combined-paths.sh                |  2 +-
 t/t4100/t-apply-1.patch                       |  4 ++--
 t/t4100/t-apply-3.patch                       |  2 +-
 t/t4100/t-apply-5.patch                       |  4 ++--
 t/t4100/t-apply-7.patch                       |  2 +-
 t/t4205-log-pretty-formats.sh                 |  2 +-
 t/t4213-log-tabexpand.sh                      |  2 +-
 t/t5528-push-default.sh                       |  2 +-
 t/t5535-fetch-push-symref.sh                  |  2 +-
 t/t5545-push-options.sh                       |  2 +-
 t/t5702-protocol-v2.sh                        | 10 +++++-----
 t/t6036-recursive-corner-cases.sh             |  4 ++--
 t/t6043-merge-rename-directories.sh           |  6 +++---
 t/t7004-tag.sh                                |  2 +-
 t/t7030-verify-tag.sh                         | 14 ++++++-------
 t/t7110-reset-merge.sh                        |  4 ++--
 t/t7508-status.sh                             |  2 +-
 t/t7513-interpret-trailers.sh                 |  2 +-
 t/t7519-status-fsmonitor.sh                   |  2 +-
 t/t7609-merge-co-error-msgs.sh                |  2 +-
 t/t9001-send-email.sh                         |  2 +-
 t/t9301-fast-import-notes.sh                  |  2 +-
 t/t9350-fast-export.sh                        |  2 +-
 t/t9809-git-p4-client-view.sh                 |  2 +-
 t/t9902-completion.sh                         |  6 +++---
 trace2/tr2_sid.c                              |  2 +-
 unpack-trees.c                                | 10 +++++-----
 url.c                                         |  2 +-
 xdiff-interface.h                             |  2 +-
 144 files changed, 222 insertions(+), 222 deletions(-)


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-418%2Fnewren%2Ftypo-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-418/newren/typo-fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/418

Range-diff vs v1:

  1:  086a6bb7be !  1:  c5855f8b6b Documentation: fix a bunch of typos, both old and new
     @@ -2,6 +2,7 @@
      
          Documentation: fix a bunch of typos, both old and new
      
     +    Reported-by: Jens Schleusener <Jens.Schleusener@fossies.org>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
     @@ -16,6 +17,50 @@
          is not reliable across platforms.
       
        - We use POSIX compliant parameter substitutions and avoid bashisms;
     +@@
     +    . since early 2012 with e1327023ea, we have been using an enum
     +      definition whose last element is followed by a comma.  This, like
     +      an array initializer that ends with a trailing comma, can be used
     +-     to reduce the patch noise when adding a new identifer at the end.
     ++     to reduce the patch noise when adding a new identifier at the end.
     + 
     +    . since mid 2017 with cbc0f81d, we have been using designated
     +      initializers for struct (e.g. "struct t v = { .val = 'a' };").
     +
     + diff --git a/Documentation/RelNotes/1.5.0.txt b/Documentation/RelNotes/1.5.0.txt
     + --- a/Documentation/RelNotes/1.5.0.txt
     + +++ b/Documentation/RelNotes/1.5.0.txt
     +@@
     +    the repository when that happens.
     + 
     + 
     +-* Crufts removal
     ++* Cruft removal
     + 
     +  - We used to say "old commits are retrievable using reflog and
     +    'master@{yesterday}' syntax as long as you haven't run
     +@@
     +  - The value of i18n.commitencoding in the originating
     +    repository is recorded in the commit object on the "encoding"
     +    header, if it is not UTF-8.  git-log and friends notice this,
     +-   and reencodes the message to the log output encoding when
     ++   and re-encodes the message to the log output encoding when
     +    displaying, if they are different.  The log output encoding
     +    is determined by "git log --encoding=<encoding>",
     +    i18n.logoutputencoding configuration, or i18n.commitencoding
     +
     + diff --git a/Documentation/RelNotes/1.6.5.4.txt b/Documentation/RelNotes/1.6.5.4.txt
     + --- a/Documentation/RelNotes/1.6.5.4.txt
     + +++ b/Documentation/RelNotes/1.6.5.4.txt
     +@@
     + 
     +  * "git prune-packed" gave progress output even when its standard error is
     +    not connected to a terminal; this caused cron jobs that run it to
     +-   produce crufts.
     ++   produce cruft.
     + 
     +  * "git pack-objects --all-progress" is an option to ask progress output
     +    from write-object phase _if_ progress output were to be produced, and
      
       diff --git a/Documentation/RelNotes/1.7.0.2.txt b/Documentation/RelNotes/1.7.0.2.txt
       --- a/Documentation/RelNotes/1.7.0.2.txt
     @@ -82,6 +127,19 @@
       
        * When you misspell the command name you give to the "exec" action in
      
     + diff --git a/Documentation/RelNotes/1.8.4.1.txt b/Documentation/RelNotes/1.8.4.1.txt
     + --- a/Documentation/RelNotes/1.8.4.1.txt
     + +++ b/Documentation/RelNotes/1.8.4.1.txt
     +@@
     +    in 1.8.4-rc1).
     + 
     +  * "git rebase -i" and other scripted commands were feeding a
     +-   random, data dependant error message to 'echo' and expecting it
     ++   random, data dependent error message to 'echo' and expecting it
     +    to come out literally.
     + 
     +  * Setting the "submodule.<name>.path" variable to the empty
     +
       diff --git a/Documentation/RelNotes/2.1.3.txt b/Documentation/RelNotes/2.1.3.txt
       --- a/Documentation/RelNotes/2.1.3.txt
       +++ b/Documentation/RelNotes/2.1.3.txt
     @@ -147,6 +205,19 @@
          by many empty commits.  This has been fixed.
       
      
     + diff --git a/Documentation/RelNotes/2.13.0.txt b/Documentation/RelNotes/2.13.0.txt
     + --- a/Documentation/RelNotes/2.13.0.txt
     + +++ b/Documentation/RelNotes/2.13.0.txt
     +@@
     +    been changed to enable "--decorate".
     + 
     +  * The output from "git status --short" has been extended to show
     +-   various kinds of dirtyness in submodules differently; instead of to
     ++   various kinds of dirtiness in submodules differently; instead of to
     +    "M" for modified, 'm' and '?' can be shown to signal changes only
     +    to the working tree of the submodule but not the commit that is
     +    checked out.
     +
       diff --git a/Documentation/RelNotes/2.13.3.txt b/Documentation/RelNotes/2.13.3.txt
       --- a/Documentation/RelNotes/2.13.3.txt
       +++ b/Documentation/RelNotes/2.13.3.txt
     @@ -256,18 +327,18 @@
          codebase to report the list of configuration variables
          subcommands care about to help complete them.
      
     - diff --git a/Documentation/RelNotes/2.24.0.txt b/Documentation/RelNotes/2.24.0.txt
     - --- a/Documentation/RelNotes/2.24.0.txt
     - +++ b/Documentation/RelNotes/2.24.0.txt
     + diff --git a/Documentation/RelNotes/2.20.0.txt b/Documentation/RelNotes/2.20.0.txt
     + --- a/Documentation/RelNotes/2.20.0.txt
     + +++ b/Documentation/RelNotes/2.20.0.txt
      @@
     -    to access the worktree correctly, which has been corrected.
     -    (merge dfd557c978 js/stash-apply-in-secondary-worktree later to maint).
     +    alias expansion.
     + 
     +  * The documentation of "git gc" has been updated to mention that it
     +-   is no longer limited to "pruning away crufts" but also updates
     ++   is no longer limited to "pruning away cruft" but also updates
     +    ancillary files like commit-graph as a part of repository
     +    optimization.
       
     -- * The merge-recursive machiery is one of the most complex parts of
     -+ * The merge-recursive machinery is one of the most complex parts of
     -    the system that accumulated cruft over time.  This large series
     -    cleans up the implementation quite a bit.
     -    (merge b657047719 en/merge-recursive-cleanup later to maint).
      
       diff --git a/Documentation/RelNotes/2.3.3.txt b/Documentation/RelNotes/2.3.3.txt
       --- a/Documentation/RelNotes/2.3.3.txt
     @@ -308,6 +379,19 @@
          CRLF for their platform.
       
      
     + diff --git a/Documentation/RelNotes/2.7.0.txt b/Documentation/RelNotes/2.7.0.txt
     + --- a/Documentation/RelNotes/2.7.0.txt
     + +++ b/Documentation/RelNotes/2.7.0.txt
     +@@
     + 
     +  * "git interpret-trailers" can now run outside of a Git repository.
     + 
     +- * "git p4" learned to reencode the pathname it uses to communicate
     ++ * "git p4" learned to re-encode the pathname it uses to communicate
     +    with the p4 depot with a new option.
     + 
     +  * Give progress meter to "git filter-branch".
     +
       diff --git a/Documentation/RelNotes/2.8.0.txt b/Documentation/RelNotes/2.8.0.txt
       --- a/Documentation/RelNotes/2.8.0.txt
       +++ b/Documentation/RelNotes/2.8.0.txt
     @@ -334,6 +418,19 @@
       
        * The test framework learned a new helper test_match_signal to
      
     + diff --git a/Documentation/config.txt b/Documentation/config.txt
     + --- a/Documentation/config.txt
     + +++ b/Documentation/config.txt
     +@@
     + 
     + `gitdir/i`::
     + 	This is the same as `gitdir` except that matching is done
     +-	case-insensitively (e.g. on case-insensitive file sytems)
     ++	case-insensitively (e.g. on case-insensitive file systems)
     + 
     + `onbranch`::
     + 	The data that follows the keyword `onbranch:` is taken to be a
     +
       diff --git a/Documentation/config/tag.txt b/Documentation/config/tag.txt
       --- a/Documentation/config/tag.txt
       +++ b/Documentation/config/tag.txt
     @@ -386,6 +483,32 @@
       	with a NUL character instead of a linefeed character.
       
      
     + diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
     + --- a/Documentation/git-cvsserver.txt
     + +++ b/Documentation/git-cvsserver.txt
     +@@
     + 	Git directory name
     + %g::
     + 	Git directory name, where all characters except for
     +-	alpha-numeric ones, `.`, and `-` are replaced with
     ++	alphanumeric ones, `.`, and `-` are replaced with
     + 	`_` (this should make it easier to use the directory
     + 	name in a filename if wanted)
     + %m::
     +
     + diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
     + --- a/Documentation/git-fast-export.txt
     + +++ b/Documentation/git-fast-export.txt
     +@@
     + 	Specify how to handle `encoding` header in commit objects.  When
     + 	asking to 'abort' (which is the default), this program will die
     + 	when encountering such a commit object.  With 'yes', the commit
     +-	message will be reencoded into UTF-8.  With 'no', the original
     ++	message will be re-encoded into UTF-8.  With 'no', the original
     + 	encoding will be preserved.
     + 
     + --refspec::
     +
       diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
       --- a/Documentation/git-filter-branch.txt
       +++ b/Documentation/git-filter-branch.txt
     @@ -425,10 +548,51 @@
       
       --no-sign::
      
     + diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
     + --- a/Documentation/git-update-index.txt
     + +++ b/Documentation/git-update-index.txt
     +@@
     + linkgit:git-config[1]).
     + 
     + To avoid deleting a shared index file that is still used, its
     +-modification time is updated to the current time everytime a new split
     ++modification time is updated to the current time every time a new split
     + index based on the shared index file is either created or read from.
     + 
     + UNTRACKED CACHE
     +
     + diff --git a/Documentation/git.txt b/Documentation/git.txt
     + --- a/Documentation/git.txt
     + +++ b/Documentation/git.txt
     +@@
     + the working tree.
     + 
     + 
     +-Synching repositories
     +-~~~~~~~~~~~~~~~~~~~~~
     ++Syncing repositories
     ++~~~~~~~~~~~~~~~~~~~~
     + 
     + include::cmds-synchingrepositories.txt[]
     + 
     +
       diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
       --- a/Documentation/gitattributes.txt
       +++ b/Documentation/gitattributes.txt
      @@
     + 
     + In these cases you can tell Git the encoding of a file in the working
     + directory with the `working-tree-encoding` attribute. If a file with this
     +-attribute is added to Git, then Git reencodes the content from the
     ++attribute is added to Git, then Git re-encodes the content from the
     + specified encoding to UTF-8. Finally, Git stores the UTF-8 encoded
     + content in its internal data structure (called "the index"). On checkout
     +-the content is reencoded back to the specified encoding.
     ++the content is re-encoded back to the specified encoding.
     + 
     + Please note that using the `working-tree-encoding` attribute may have a
     + number of pitfalls:
     +@@
       When Git encounters the first file that needs to be cleaned or smudged,
       it starts the filter and performs the handshake. In the handshake, the
       welcome message sent by Git is "git-filter-client", only version 2 is
     @@ -451,6 +615,45 @@
       	    shown. This is the default option.
       
      
     + diff --git a/Documentation/howto/separating-topic-branches.txt b/Documentation/howto/separating-topic-branches.txt
     + --- a/Documentation/howto/separating-topic-branches.txt
     + +++ b/Documentation/howto/separating-topic-branches.txt
     +@@
     +               o---o---o---o---o---o
     + 
     + The last diff better not to show anything other than cleanups
     +-for crufts.  Then I can finally clean things up:
     ++for cruft.  Then I can finally clean things up:
     + 
     +         $ git branch -D topic
     +         $ git reset --hard HEAD^ ;# nuke pretend merge
     +
     + diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
     + --- a/Documentation/merge-options.txt
     + +++ b/Documentation/merge-options.txt
     +@@
     + 
     + --cleanup=<mode>::
     + 	This option determines how the merge message will be cleaned up before
     +-	commiting. See linkgit:git-commit[1] for more details. In addition, if
     ++	committing. See linkgit:git-commit[1] for more details. In addition, if
     + 	the '<mode>' is given a value of `scissors`, scissors will be appended
     + 	to `MERGE_MSG` before being passed on to the commit machinery in the
     + 	case of a merge conflict.
     +
     + diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
     + --- a/Documentation/technical/api-submodule-config.txt
     + +++ b/Documentation/technical/api-submodule-config.txt
     +@@
     + 
     + Whenever a submodule configuration is parsed in `parse_submodule_config_option`
     + via e.g. `gitmodules_config()`, it will overwrite the null_sha1 entry.
     +-So in the normal case, when HEAD:.gitmodules is parsed first and then overlayed
     ++So in the normal case, when HEAD:.gitmodules is parsed first and then overlaid
     + with the repository configuration, the null_sha1 entry contains the local
     + configuration of a submodule (e.g. consolidated values from local git
     + configuration and the .gitmodules file in the worktree).
     +
       diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
       --- a/Documentation/technical/api-trace2.txt
       +++ b/Documentation/technical/api-trace2.txt
     @@ -552,6 +755,15 @@
       --- a/Documentation/technical/hash-function-transition.txt
       +++ b/Documentation/technical/hash-function-transition.txt
      @@
     + on public-facing Git servers is strongly discouraged. Once Git
     + protocol gains SHA-256 support, SHA-256 based servers are likely not
     + to support SHA-1 compatibility, to avoid what may be a very expensive
     +-hash reencode during clone and to encourage peers to modernize.
     ++hash re-encode during clone and to encourage peers to modernize.
     + 
     + The design described here allows fetches by SHA-1 clients of a
     + personal SHA-256 repository because it's not much more difficult than
     +@@
       
       Choice of Hash
       --------------
     @@ -583,6 +795,19 @@
       
           - 32-bit count of cache entries in this block
      
     + diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
     + --- a/Documentation/technical/pack-protocol.txt
     + +++ b/Documentation/technical/pack-protocol.txt
     +@@
     +   command-ok        = PKT-LINE("ok" SP refname)
     +   command-fail      = PKT-LINE("ng" SP refname SP error-msg)
     + 
     +-  error-msg         = 1*(OCTECT) ; where not "ok"
     ++  error-msg         = 1*(OCTET) ; where not "ok"
     + ----
     + 
     + Updates can be unsuccessful for a number of reasons.  The reference can have
     +
       diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
       --- a/Documentation/technical/partial-clone.txt
       +++ b/Documentation/technical/partial-clone.txt
  -:  ---------- >  2:  812c36a6d4 Fix spelling errors in documentation outside of Documentation/
  -:  ---------- >  3:  466aead9af Prefer 'up-to-date' spelling
  -:  ---------- >  4:  3f2f8e9a70 Fix spelling errors in code comments
  -:  ---------- >  5:  6e6e5ad549 Fix spelling errors in comments of testcases
  -:  ---------- >  6:  a2e17dbc92 Fix spelling errors in names of tests
  -:  ---------- >  7:  6d8bc116c5 Fix spelling errors in messages shown to users
  -:  ---------- >  8:  e31ef1184e Fix spelling errors in test commands
  -:  ---------- >  9:  f5b8f1cd1c sha1dc: fix trivial comment spelling error
  -:  ---------- > 10:  9767da6f8e multimail: fix a few simple spelling errors
  -:  ---------- > 11:  126faae60f Fix spelling errors in no-longer-updated-from-upstream modules

-- 
gitgitgadget
