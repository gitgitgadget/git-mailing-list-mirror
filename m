Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BFD21F404
	for <e@80x24.org>; Wed, 28 Mar 2018 19:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbeC1T4U (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 15:56:20 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33156 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752831AbeC1T4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 15:56:16 -0400
Received: by mail-wr0-f180.google.com with SMTP id z73so3355359wrb.0;
        Wed, 28 Mar 2018 12:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=wTDpBXcb+ae6eQIIt/aPvzbP9G4GQyfoCQdxNWbZpjQ=;
        b=Sq9feWn9XpSwKRBAOIG5ISa5q7RtG/zUtdAKviW+YdXpqg24hP2QXjBO/Oc0tSq5A6
         2W5MpAreZO0jgRgIyuK40he9o4q6/6qnunLV1rH3B+5r8cuBJqXWUfuBNrm3DMpJy+X4
         sN4bh4qo+RME7tOo9+uzhsrk3K3tPIFmAR1h0e9Lu0e1QHmACUyfyeF4KK56FcGI8X8V
         5MUIkem1X4kHAwKMocNY08IXUp2KuE4SIcs3Ri6LExrxHaMpZ09wroLziA079TxUm+eE
         apzwfrI6d18y/9cgfkIb79MrxFQ5I4snawDzsQfro/CazsvMJ5o6s61BwLz+QbucTQ85
         akYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=wTDpBXcb+ae6eQIIt/aPvzbP9G4GQyfoCQdxNWbZpjQ=;
        b=JyHV2lQPWEb9v5Fl+ODMn3+IUz/V/lQIVq15pf3esn4ent/T1uLU7GyL6IB6HOHy3h
         hdg4F0MAn0pmsVODv2gKQhJDam4MrezYaJjbXCYFGKyGEh66pQNeHdzyaIKqdTdhk1Xa
         apc2dwACEK54h77p5dfT/xrUU/ckEohF4/RGHSFDsz1b6wqaWyWwXK8DBhgAENfnarZt
         qafWKwcxpkQzUdg4Bvffo3r8YJVTcz7Rxl5Fpe+4+vLsFCfwHA4IsfbDwgBL38FxmWjD
         EuA0XyoXlygeAtNyz4S8aPo51J2b5u+z/i52omPZT8nzagU1zB0yZ0pcpu+5U6YMmgbe
         swcQ==
X-Gm-Message-State: AElRT7GfLwVU9kW7YQJmKmGDy6D8uiXB3JdSVckY6h3wC0aeGR3ehD//
        YRXSESdpWBlPwuMeSZmUhcWr51Th
X-Google-Smtp-Source: AIpwx48IrQz4pechz8UDq5oOggxEypuk+v5JnS1lypmD/aphvwrhzTmHQqewmTACkxEyOlwhxgIuRg==
X-Received: by 10.223.173.207 with SMTP id w73mr4342805wrc.234.1522266973248;
        Wed, 28 Mar 2018 12:56:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a11sm5882087wra.50.2018.03.28.12.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 12:56:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.17.0-rc2
Date:   Wed, 28 Mar 2018 12:56:11 -0700
Message-ID: <xmqqwoxw6kkk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A release candidate Git v2.17.0-rc2 is now available for testing
at the usual places.  It is comprised of 499 non-merge commits
since v2.16.0, contributed by 62 people, 19 of which are new faces.

I am hoping that we can have the final version tagged at the end of
coming weekend, before I fly out to Tokyo.  I expect to be offline
most of the next week after the final is tagged.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.17.0-rc2' tag and the 'master' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.16.0 are as follows.
Welcome to the Git development community!

  Adam Borowski, Alban Gruin, Andreas G. Schacker, Bernhard
  M. Wiedemann, Christian Ludwig, Gargi Sharma, Genki Sky,
  Gregory Herrero, Jon Simons, Juan F. Codagnone, Kim Gybels,
  Lucas Werkmeister, Mathias Rav, Michele Locati, Motoki Seki,
  Stefan Moch, Stephen R Guglielmo, Tatyana Krasnukha, and Thomas
  Levesque.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Ævar Arnfjörð Bjarmason, Alexander Shopov, Alex Bennée, Ben
  Peart, Brandon Williams, brian m. carlson, Christian Couder,
  Daniel Knittl-Frank, David Pursehouse, Derrick Stolee, Elijah
  Newren, Eric Sunshine, Eric Wong, Jason Merrill, Jeff Hostetler,
  Jeff King, Johannes Schindelin, Jonathan Nieder, Jonathan Tan,
  Junio C Hamano, Kaartic Sivaraam, Mårten Kongstad, Martin
  Ågren, Matthieu Moy, Michael Haggerty, Nathan Payre, Nguyễn
  Thái Ngọc Duy, Nicolas Morey-Chaisemartin, Olga Telezhnaya,
  Patryk Obara, Phillip Wood, Prathamesh Chavan, Ramsay Jones,
  Randall S. Becker, Rasmus Villemoes, René Scharfe, Robert
  P. J. Day, Stefan Beller, SZEDER Gábor, Thomas Gummerer,
  Todd Zullinger, Torsten Bögershausen, and Yasushi SHOJI.

----------------------------------------------------------------

Git 2.17 Release Notes (draft)
==============================

Updates since v2.16
-------------------

UI, Workflows & Features

 * "diff" family of commands learned "--find-object=<object-id>" option
   to limit the findings to changes that involve the named object.

 * "git format-patch" learned to give 72-cols to diffstat, which is
   consistent with other line length limits the subcommand uses for
   its output meant for e-mails.

 * The log from "git daemon" can be redirected with a new option; one
   relevant use case is to send the log to standard error (instead of
   syslog) when running it from inetd.

 * "git rebase" learned to take "--allow-empty-message" option.

 * "git am" has learned the "--quit" option, in addition to the
   existing "--abort" option; having the pair mirrors a few other
   commands like "rebase" and "cherry-pick".

 * "git worktree add" learned to run the post-checkout hook, just like
   "git clone" runs it upon the initial checkout.

 * "git tag" learned an explicit "--edit" option that allows the
   message given via "-m" and "-F" to be further edited.

 * "git fetch --prune-tags" may be used as a handy short-hand for
   getting rid of stale tags that are locally held.

 * The new "--show-current-patch" option gives an end-user facing way
   to get the diff being applied when "git rebase" (and "git am")
   stops with a conflict.

 * "git add -p" used to offer "/" (look for a matching hunk) as a
   choice, even there was only one hunk, which has been corrected.
   Also the single-key help is now given only for keys that are
   enabled (e.g. help for '/' won't be shown when there is only one
   hunk).

 * Since Git 1.7.9, "git merge" defaulted to --no-ff (i.e. even when
   the side branch being merged is a descendant of the current commit,
   create a merge commit instead of fast-forwarding) when merging a
   tag object.  This was appropriate default for integrators who pull
   signed tags from their downstream contributors, but caused an
   unnecessary merges when used by downstream contributors who
   habitually "catch up" their topic branches with tagged releases
   from the upstream.  Update "git merge" to default to --no-ff only
   when merging a tag object that does *not* sit at its usual place in
   refs/tags/ hierarchy, and allow fast-forwarding otherwise, to
   mitigate the problem.

 * "git status" can spend a lot of cycles to compute the relation
   between the current branch and its upstream, which can now be
   disabled with "--no-ahead-behind" option.

 * "git diff" and friends learned funcname patterns for Go language
   source files.

 * "git send-email" learned "--reply-to=<address>" option.

 * Funcname pattern used for C# now recognizes "async" keyword.

 * In a way similar to how "git tag" learned to honor the pager
   setting only in the list mode, "git config" learned to ignore the
   pager setting when it is used for setting values (i.e. when the
   purpose of the operation is not to "show").


Performance, Internal Implementation, Development Support etc.

 * More perf tests for threaded grep

 * "perf" test output can be sent to codespeed server.

 * The build procedure for perl/ part has been greatly simplified by
   weaning ourselves off of MakeMaker.

 * Perl 5.8 or greater has been required since Git 1.7.4 released in
   2010, but we continued to assume some core modules may not exist and
   used a conditional "eval { require <<module>> }"; we no longer do
   this.  Some platforms (Fedora/RedHat/CentOS, for example) ship Perl
   without all core modules by default (e.g. Digest::MD5, File::Temp,
   File::Spec, Net::Domain, Net::SMTP).  Users on such platforms may
   need to install these additional modules.

 * As a convenience, we install copies of Perl modules we require which
   are not part of the core Perl distribution (e.g. Error and
   Mail::Address).  Users and packagers whose operating system provides
   these modules can set NO_PERL_CPAN_FALLBACKS to avoid installing the
   bundled modules.

 * In preparation for implementing narrow/partial clone, the machinery
   for checking object connectivity used by gc and fsck has been
   taught that a missing object is OK when it is referenced by a
   packfile specially marked as coming from trusted repository that
   promises to make them available on-demand and lazily.

 * The machinery to clone & fetch, which in turn involves packing and
   unpacking objects, has been told how to omit certain objects using
   the filtering mechanism introduced by another topic.  It now knows
   to mark the resulting pack as a promisor pack to tolerate missing
   objects, laying foundation for "narrow" clones.

 * The first step to getting rid of mru API and using the
   doubly-linked list API directly instead.

 * Retire mru API as it does not give enough abstraction over
   underlying list API to be worth it.

 * Rewrite two more "git submodule" subcommands in C.

 * The tracing machinery learned to report tweaking of environment
   variables as well.

 * Update Coccinelle rules to catch and optimize strbuf_addf(&buf, "%s", str)

 * Prevent "clang-format" from breaking line after function return type.

 * The sequencer infrastructure is shared across "git cherry-pick",
   "git rebase -i", etc., and has always spawned "git commit" when it
   needs to create a commit.  It has been taught to do so internally,
   when able, by reusing the codepath "git commit" itself uses, which
   gives performance boost for a few tens of percents in some sample
   scenarios.

 * Push the submodule version of collision-detecting SHA-1 hash
   implementation a bit harder on builders.

 * Avoid mmapping small files while using packed refs (especially ones
   with zero size, which would cause later munmap() to fail).

 * Conversion from uchar[20] to struct object_id continues.

 * More tests for wildmatch functions.

 * The code to binary search starting from a fan-out table (which is
   how the packfile is indexed with object names) has been refactored
   into a reusable helper.

 * We now avoid using identifiers that clash with C++ keywords.  Even
   though it is not a goal to compile Git with C++ compilers, changes
   like this help use of code analysis tools that targets C++ on our
   codebase.

 * The executable is now built in 'script' phase in Travis CI integration,
   to follow the established practice, rather than during 'before_script'
   phase.  This allows the CI categorize the failures better ('failed'
   is project's fault, 'errored' is build environment's).
   (merge 3c93b82920 sg/travis-build-during-script-phase later to maint).

 * Writing out the index file when the only thing that changed in it
   is the untracked cache information is often wasteful, and this has
   been optimized out.

 * Various pieces of Perl code we have have been cleaned up.

 * Internal API clean-up to allow write_locked_index() optionally skip
   writing the in-core index when it is not modified.


Also contains various documentation updates and code clean-ups.


Fixes since v2.16
-----------------

 * An old regression in "git describe --all $annotated_tag^0" has been
   fixed.

 * "git status" after moving a path in the working tree (hence making
   it appear "removed") and then adding with the -N option (hence
   making that appear "added") detected it as a rename, but did not
   report the  old and new pathnames correctly.

 * "git svn dcommit" did not take into account the fact that a
   svn+ssh:// URL with a username@ (typically used for pushing) refers
   to the same SVN repository without the username@ and failed when
   svn.pushmergeinfo option is set.

 * API clean-up around revision traversal.

 * "git merge -Xours/-Xtheirs" learned to use our/their version when
   resolving a conflicting updates to a symbolic link.

 * "git clone $there $here" is allowed even when here directory exists
   as long as it is an empty directory, but the command incorrectly
   removed it upon a failure of the operation.

 * "git commit --fixup" did not allow "-m<message>" option to be used
   at the same time; allow it to annotate resulting commit with more
   text.

 * When resetting the working tree files recursively, the working tree
   of submodules are now also reset to match.

 * "git stash -- <pathspec>" incorrectly blew away untracked files in
   the directory that matched the pathspec, which has been corrected.

 * Instead of maintaining home-grown email address parsing code, ship
   a copy of reasonably recent Mail::Address to be used as a fallback
   in 'git send-email' when the platform lacks it.
   (merge d60be8acab mm/send-email-fallback-to-local-mail-address later to maint).

 * "git add -p" was taught to ignore local changes to submodules as
   they do not interfere with the partial addition of regular changes
   anyway.

 * Avoid showing a warning message in the middle of a line of "git
   diff" output.
   (merge 4e056c989f nd/diff-flush-before-warning later to maint).

 * The http tracing code, often used to debug connection issues,
   learned to redact potentially sensitive information from its output
   so that it can be more safely sharable.
   (merge 8ba18e6fa4 jt/http-redact-cookies later to maint).

 * Crash fix for a corner case where an error codepath tried to unlock
   what it did not acquire lock on.
   (merge 81fcb698e0 mr/packed-ref-store-fix later to maint).

 * The split-index mode had a few corner case bugs fixed.
   (merge ae59a4e44f tg/split-index-fixes later to maint).

 * Assorted fixes to "git daemon".
   (merge ed15e58efe jk/daemon-fixes later to maint).

 * Completion of "git merge -s<strategy>" (in contrib/) did not work
   well in non-C locale.
   (merge 7cc763aaa3 nd/list-merge-strategy later to maint).

 * Workaround for segfault with more recent versions of SVN.
   (merge 7f6f75e97a ew/svn-branch-segfault-fix later to maint).

 * Plug recently introduced leaks in fsck.
   (merge ba3a08ca0e jt/fsck-code-cleanup later to maint).

 * "git pull --rebase" did not pass verbosity setting down when
   recursing into a submodule.
   (merge a56771a668 sb/pull-rebase-submodule later to maint).

 * The way "git reset --hard" reports the commit the updated HEAD
   points at is made consistent with the way how the commit title is
   generated by the other parts of the system.  This matters when the
   title is spread across physically multiple lines.
   (merge 1cf823fb68 tg/reset-hard-show-head-with-pretty later to maint).

 * Test fixes.
   (merge 63b1a175ee sg/test-i18ngrep later to maint).

 * Some bugs around "untracked cache" feature have been fixed.  This
   will notice corrupt data in the untracked cache left by old and
   buggy code and issue a warning---the index can be fixed by clearing
   the untracked cache from it.
   (merge 0cacebf099 nd/fix-untracked-cache-invalidation later to maint).
   (merge 7bf0be7501 ab/untracked-cache-invalidation-docs later to maint).

 * "git blame HEAD COPYING" in a bare repository failed to run, while
   "git blame HEAD -- COPYING" run just fine.  This has been corrected.

 * "git add" files in the same directory, but spelling the directory
   path in different cases on case insensitive filesystem, corrupted
   the name hash data structure and led to unexpected results.  This
   has been corrected.
   (merge c95525e90d bp/name-hash-dirname-fix later to maint).

 * "git rebase -p" mangled log messages of a merge commit, which is
   now fixed.
   (merge ed5144d7eb js/fix-merge-arg-quoting-in-rebase-p later to maint).

 * Some low level protocol codepath could crash when they get an
   unexpected flush packet, which is now fixed.
   (merge bb1356dc64 js/packet-read-line-check-null later to maint).

 * "git check-ignore" with multiple paths got confused when one is a
   file and the other is a directory, which has been fixed.
   (merge d60771e930 rs/check-ignore-multi later to maint).

 * "git describe $garbage" stopped giving any errors when the garbage
   happens to be a string with 40 hexadecimal letters.
   (merge a8e7a2bf0f sb/describe-blob later to maint).

 * Code to unquote single-quoted string (used in the parser for
   configuration files, etc.) did not diagnose bogus input correctly
   and produced bogus results instead.
   (merge ddbbf8eb25 jk/sq-dequote-on-bogus-input later to maint).

 * Many places in "git apply" knew that "/dev/null" that signals
   "there is no such file on this side of the diff" can be followed by
   whitespace and garbage when parsing a patch, except for one, which
   made an otherwise valid patch (e.g. ones from subversion) rejected.
   (merge e454ad4bec tk/apply-dev-null-verify-name-fix later to maint).

 * We no longer create any *.spec file, so "make clean" should not
   remove it.
   (merge 4321bdcabb tz/do-not-clean-spec-file later to maint).

 * "git push" over http transport did not unquote the push-options
   correctly.
   (merge 90dce21eb0 jk/push-options-via-transport-fix later to maint).

 * "git send-email" learned to complain when the batch-size option is
   not defined when the relogin-delay option is, since these two are
   mutually required.
   (merge 9caa70697b xz/send-email-batch-size later to maint).

 * Y2k20 fix ;-) for our perl scripts.
   (merge a40e06ee33 bw/perl-timegm-timelocal-fix later to maint).

 * Threaded "git grep" has been optimized to avoid allocation in code
   section that is covered under a mutex.
   (merge 38ef24dccf rv/grep-cleanup later to maint).

 * "git subtree" script (in contrib/) scripted around "git log", whose
   output got affected by end-user configuration like log.showsignature
   (merge 8841b5222c sg/subtree-signed-commits later to maint).

 * While finding unique object name abbreviation, the code may
   accidentally have read beyond the end of the array of object names
   in a pack.
   (merge 21abed500c ds/find-unique-abbrev-optim later to maint).

 * Micro optimization in revision traversal code.
   (merge ebbed3ba04 ds/mark-parents-uninteresting-optim later to maint).

 * "git commit" used to run "gc --auto" near the end, which was lost
   when the command was reimplemented in C by mistake.
   (merge 095c741edd ab/gc-auto-in-commit later to maint).

 * Allow running a couple of tests with "sh -x".
   (merge c20bf94abc sg/cvs-tests-with-x later to maint).

 * The codepath to replace an existing entry in the index had a bug in
   updating the name hash structure, which has been fixed.
   (merge 0e267b7a24 bp/refresh-cache-ent-rehash-fix later to maint).

 * The transfer.fsckobjects configuration tells "git fetch" to
   validate the data and connected-ness of objects in the received
   pack; the code to perform this check has been taught about the
   narrow clone's convention that missing objects that are reachable
   from objects in a pack that came from a promissor remote is OK.

 * There was an unused file-scope static variable left in http.c when
   building for versions of libCURL that is older than 7.19.4, which
   has been fixed.
   (merge b8fd6008ec rj/http-code-cleanup later to maint).

 * Shell script portability fix.
   (merge 206a6ae013 ml/filter-branch-portability-fix later to maint).

 * Other minor doc, test and build updates and code cleanups.
   (merge e2a5a028c7 bw/oidmap-autoinit later to maint).
   (merge ec3b4b06f8 cl/t9001-cleanup later to maint).
   (merge e1b3f3dd38 ks/submodule-doc-updates later to maint).
   (merge fbac558a9b rs/describe-unique-abbrev later to maint).
   (merge 8462ff43e4 tb/crlf-conv-flags later to maint).
   (merge 7d68bb0766 rb/hashmap-h-compilation-fix later to maint).
   (merge 3449847168 cc/sha1-file-name later to maint).
   (merge ad622a256f ds/use-get-be64 later to maint).
   (merge f919ffebed sg/cocci-move-array later to maint).
   (merge 4e801463c7 jc/mailinfo-cleanup-fix later to maint).
   (merge ef5b3a6c5e nd/shared-index-fix later to maint).
   (merge 9f5258cbb8 tz/doc-show-defaults-to-head later to maint).
   (merge b780e4407d jc/worktree-add-short-help later to maint).
   (merge ae239fc8e5 rs/cocci-strbuf-addf-to-addstr later to maint).
   (merge 2e22a85e5c nd/ignore-glob-doc-update later to maint).
   (merge 3738031581 jk/gettext-poison later to maint).
   (merge 54360a1956 rj/sparse-updates later to maint).
   (merge 12e31a6b12 sg/doc-test-must-fail-args later to maint).
   (merge 760f1ad101 bc/doc-interpret-trailers-grammofix later to maint).
   (merge 4ccf461f56 bp/fsmonitor later to maint).
   (merge a6119f82b1 jk/test-hashmap-updates later to maint).
   (merge 5aea9fe6cc rd/typofix later to maint).
   (merge e4e5da2796 sb/status-doc-fix later to maint).
   (merge 7976e901c8 gs/test-unset-xdg-cache-home later to maint).
   (merge d023df1ee6 tg/worktree-create-tracking later to maint).
   (merge 4cbe92fd41 sm/mv-dry-run-update later to maint).
   (merge 75e5e9c3f7 sb/color-h-cleanup later to maint).
   (merge 2708ef4af6 sg/t6300-modernize later to maint).
   (merge d88e92d4e0 bw/doc-submodule-recurse-config-with-clone later to maint).
   (merge f74bbc8dd2 jk/cached-commit-buffer later to maint).
   (merge 1316416903 ms/non-ascii-ticks later to maint).
   (merge 878056005e rs/strbuf-read-file-or-whine later to maint).
   (merge 79f0ba1547 jk/strbuf-read-file-close-error later to maint).
   (merge edfb8ba068 ot/ref-filter-cleanup later to maint).
   (merge 11395a3b4b jc/test-must-be-empty later to maint).
   (merge 768b9d6db7 mk/doc-pretty-fill later to maint).
   (merge 2caa7b8d27 ab/man-sec-list later to maint).
   (merge 40c17eb184 ks/t3200-typofix later to maint).
   (merge bd9958c358 dp/merge-strategy-doc-fix later to maint).
   (merge 9ee0540a40 js/ming-strftime later to maint).
   (merge 1775e990f7 tz/complete-tag-delete-tagname later to maint).
   (merge 00a4b03501 rj/warning-uninitialized-fix later to maint).
   (merge b635ed97a0 jk/attributes-path-doc later to maint).

----------------------------------------------------------------

Changes since v2.16.0 are as follows:

Adam Borowski (1):
      hooks/pre-auto-gc-battery: allow gc to run on non-laptops

Alban Gruin (1):
      userdiff: add built-in pattern for golang

Alex Bennée (1):
      send-email: add test for Linux's get_maintainer.pl

Alexander Shopov (1):
      Mark messages for translations

Andreas G. Schacker (1):
      doc/read-tree: remove obsolete remark

Ben Peart (4):
      dir.c: don't flag the index as dirty for changes to the untracked cache
      name-hash: properly fold directory names in adjust_dirname_case()
      fsmonitor: update documentation to remove reference to invalid config settings
      Fix bugs preventing adding updated cache entries to the name hash

Bernhard M. Wiedemann (1):
      perl: call timegm and timelocal with 4-digit year

Brandon Williams (39):
      oidmap: ensure map is initialized
      object_info: change member name from 'typename' to 'type_name'
      object: rename function 'typename' to 'type_name'
      blame: rename 'this' variables
      pack-objects: rename 'this' variables
      rev-parse: rename 'this' variable
      submodule: indicate that 'submodule.recurse' doesn't apply to clone
      diff: rename 'this' variables
      apply: rename 'try' variables
      apply: rename 'new' variables
      checkout: rename 'new' variables
      help: rename 'new' variables
      pack-redundant: rename 'new' variables
      reflog: rename 'new' variables
      remote: rename 'new' variables
      combine-diff: rename 'new' variables
      commit: rename 'new' variables
      diff-lib: rename 'new' variable
      diff: rename 'new' variables
      diffcore-delta: rename 'new' variables
      entry: rename 'new' variables
      http: rename 'new' variables
      imap-send: rename 'new' variables
      line-log: rename 'new' variables
      read-cache: rename 'new' variables
      ref-filter: rename 'new' variables
      remote: rename 'new' variables
      split-index: rename 'new' variables
      submodule: rename 'new' variables
      trailer: rename 'new' variables
      unpack-trees: rename 'new' variables
      init-db: rename 'template' variables
      environment: rename 'template' variables
      diff: rename 'template' variables
      environment: rename 'namespace' variables
      wrapper: rename 'template' variables
      tempfile: rename 'template' variables
      trailer: rename 'template' variables
      replace: rename 'new' variables

Christian Couder (12):
      perf/aggregate: fix checking ENV{GIT_PERF_SUBSECTION}
      perf/aggregate: refactor printing results
      perf/aggregate: implement codespeed JSON output
      perf/run: add conf_opts argument to get_var_from_env_or_config()
      perf/run: learn about perf.codespeedOutput
      perf/run: learn to send output to codespeed server
      perf/run: read GIT_PERF_REPO_NAME from perf.repoName
      sha1_file: remove static strbuf from sha1_file_name()
      sha1_file: improve sha1_file_name() perfs
      perf/aggregate: add --subsection option
      perf/aggregate: add --reponame option
      perf/aggregate: sort JSON fields in output

Christian Ludwig (3):
      t9001: use existing helper in send-email test
      send-email: rename variable for clarity
      send-email: support separate Reply-To address

Daniel Knittl-Frank (1):
      describe: prepend "tags/" when describing tags with embedded name

David Pursehouse (1):
      Documentation/merge-strategies: typofix

Derrick Stolee (3):
      packfile: use get_be64() for large offsets
      sha1_name: fix uninitialized memory errors
      revision.c: reduce object database queries

Elijah Newren (3):
      Tighten and correct a few testcases for merging and cherry-picking
      merge-recursive: fix logic ordering issue
      merge-recursive: add explanation for src_entry and dst_entry

Eric Sunshine (5):
      t5601-clone: test case-conflicting files on case-insensitive filesystem
      worktree: add: fix 'post-checkout' not knowing new worktree location
      git-worktree.txt: fix missing ")" typo
      git-worktree.txt: fix indentation of example and text of 'add' command
      t2028: fix minor error and issues in newly-added "worktree move" tests

Eric Wong (2):
      fsck: fix leak when traversing trees
      git-svn: control destruction order to avoid segfault

Gargi Sharma (1):
      mru: Replace mru.[ch] with list.h implementation

Genki Sky (2):
      rebase: add --allow-empty-message option
      test-lib.sh: unset XDG_CACHE_HOME

Gregory Herrero (1):
      rebase -p: fix incorrect commit message when calling `git merge`.

Jason Merrill (1):
      git-svn: fix svn.pushmergeinfo handling of svn+ssh usernames.

Jeff Hostetler (12):
      upload-pack: add object filtering for partial clone
      fetch-pack, index-pack, transport: partial clone
      fetch-pack: add --no-filter
      fetch: support filters
      partial-clone: define partial clone settings in config
      t5616: end-to-end tests for partial clone
      fetch: inherit filter-spec from partial clone
      t5616: test bulk prefetch after partial fetch
      stat_tracking_info: return +1 when branches not equal
      status: add --[no-]ahead-behind to status and commit for V2 format.
      status: update short status to respect --no-ahead-behind
      status: support --no-ahead-behind in long format

Jeff King (35):
      t5600: fix outdated comment about unborn HEAD
      t5600: modernize style
      clone: factor out dir_exists() helper
      clone: do not clean up directories we didn't create
      sq_quote_argv: drop maxlen parameter
      trace: avoid unnecessary quoting
      t5570: use ls-remote instead of clone for interp tests
      t/lib-git-daemon: record daemon log
      daemon: fix off-by-one in logging extended attributes
      daemon: handle NULs in extended attribute string
      t/lib-git-daemon: add network-protocol helpers
      daemon: fix length computation in newline stripping
      t0205: drop redundant test
      git-sh-i18n: check GETTEXT_POISON before USE_GETTEXT_SCHEME
      correct error messages for NULL packet_read_line()
      CodingGuidelines: mention "static" and "extern"
      t0002: simplify error checking
      describe: confirm that blobs actually exist
      test-hashmap: use ALLOC_ARRAY rather than bare malloc
      test-hashmap: check allocation computation for overflow
      test-hashmap: use xsnprintf rather than snprintf
      test-hashmap: use strbuf_getline rather than fgets
      test-hashmap: simplify alloc_test_entry
      test-hashmap: use "unsigned int" for hash storage
      sq_dequote: fix extra consumption of source string
      t5545: factor out http repository setup
      remote-curl: unquote incoming push-options
      commit: drop uses of get_cached_commit_buffer()
      revision: drop --show-all option
      t: send verbose test-helper output to fd 4
      strbuf_read_file(): preserve errno across close() call
      smart-http: document flush after "# service" line
      t3701: add a test for interactive.diffFilter
      add--interactive: detect bogus diffFilter output
      doc/gitattributes: mention non-recursive behavior

Johannes Schindelin (3):
      sequencer: assign only free()able strings to gpg_sign
      apply: demonstrate a problem applying svn diffs
      mingw: abort on invalid strftime formats

Jon Simons (1):
      always check for NULL return from packet_read_line()

Jonathan Nieder (1):
      perl: treat PERLLIB_EXTRA as an extra path again

Jonathan Tan (23):
      extension.partialclone: introduce partial clone extension
      fsck: introduce partialclone extension
      fsck: support refs pointing to promisor objects
      fsck: support referenced promisor objects
      fsck: support promisor objects as CLI argument
      index-pack: refactor writing of .keep files
      introduce fetch-object: fetch one promisor object
      sha1_file: support lazily fetching missing objects
      rev-list: support termination at promisor objects
      gc: do not repack promisor packfiles
      fetch-pack: test support excluding large blobs
      fetch: refactor calculation of remote list
      clone: partial clone
      unpack-trees: batch fetching of missing blobs
      fetch-pack: restore save_commit_buffer after use
      http: support cookie redaction when tracing
      http: support omitting data from traces
      Docs: split out long-running subprocess handshake
      packfile: remove GIT_DEBUG_LOOKUP log statements
      packfile: refactor hash search with fanout table
      sha1_file: restore OBJECT_INFO_QUICK functionality
      index-pack: support checking objects but not links
      fetch-pack: do not check links for partial fetch

Juan F. Codagnone (1):
      mailinfo: avoid segfault when can't open files

Junio C Hamano (22):
      merge: teach -Xours/-Xtheirs to symbolic link merge
      worktree: say that "add" takes an arbitrary commit in short-help
      Start 2.17 cycle
      Git 2.16.1
      First batch after 2.16
      blame: tighten command line parser
      Second batch for 2.17
      Third batch for 2.17
      Git 2.16.2
      merge: allow fast-forward when merging a tracked tag
      Fourth batch for 2.17
      Fifth batch for 2.17
      test_must_be_empty: make sure the file exists, not just empty
      untracked cache: use git_env_bool() not getenv() for customization
      Sixth batch for 2.17
      Seventh batch for 2.17
      Eighth batch for 2.17
      Git 2.17-rc0
      Git 2.17-rc1
      Git 2.16.3
      t9902: disable test on the list of merge-strategies under GETTEXT_POISON
      Git 2.17-rc2

Kaartic Sivaraam (3):
      Doc/gitsubmodules: make some changes to improve readability and syntax
      Doc/git-submodule: improve readability and grammar of a sentence
      t/t3200: fix a typo in a test description

Kim Gybels (1):
      packed_ref_cache: don't use mmap() for small files

Lucas Werkmeister (1):
      daemon: add --log-destination=(stderr|syslog|none)

Martin Ågren (9):
      t7006: add tests for how git config paginates
      config: respect `pager.config` in list/get-mode only
      config: change default of `pager.config` to "on"
      sequencer: make lockfiles non-static
      sequencer: always roll back lock in `do_recursive_merge()`
      merge-recursive: always roll back lock in `merge_recursive_generic()`
      merge: always roll back lock in `checkout_fast_forward()`
      sequencer: do not roll back lockfile unnecessarily
      write_locked_index(): add flag to avoid writing unchanged index

Mathias Rav (1):
      files_initial_transaction_commit(): only unlock if locked

Matthieu Moy (2):
      send-email: add and use a local copy of Mail::Address
      perl/Git: remove now useless email-address parsing code

Michael Haggerty (5):
      struct snapshot: store `start` rather than `header_len`
      create_snapshot(): use `xmemdupz()` rather than a strbuf
      find_reference_location(): make function safe for empty snapshots
      packed_ref_iterator_begin(): make optimization more general
      load_contents(): don't try to mmap an empty file

Michele Locati (1):
      filter-branch: use printf instead of echo -e

Motoki Seki (1):
      Documentation/gitsubmodules.txt: avoid non-ASCII apostrophes

Mårten Kongstad (1):
      docs/pretty-formats: fix typo '% <(<N>)' -> '%<|(<N>)'

Nathan Payre (1):
      send-email: extract email-parsing code into a subroutine

Nguyễn Thái Ngọc Duy (85):
      t2203: test status output with porcelain v2 format
      Use DIFF_DETECT_RENAME for detect_rename assignments
      wt-status.c: coding style fix
      wt-status.c: catch unhandled diff status codes
      wt-status.c: rename rename-related fields in wt_status_change_data
      wt-status.c: handle worktree renames
      trace.c: move strbuf_release() out of print_trace_line()
      add--interactive: ignore submodule changes except HEAD
      read-cache.c: change type of "temp" in write_shared_index()
      read-cache.c: move tempfile creation/cleanup out of write_shared_index
      diff.c: flush stdout before printing rename warnings
      run-command.c: introduce trace_run_command()
      run-command.c: print program 'git' when tracing git_cmd mode
      run-command.c: print env vars in trace_run_command()
      run-command.c: print new cwd in trace_run_command()
      read-cache: don't write index twice if we can't write shared index
      worktree.c: add validate_worktree()
      dir.c: avoid stat() in valid_cached_dir()
      dir.c: fix missing dir invalidation in untracked code
      format-patch: keep cover-letter diffstat wrapped in 72 columns
      completion: fix completing merge strategies on non-C locales
      dir.c: stop ignoring opendir() error in open_cached_dir()
      format-patch: reduce patch diffstat width to 72
      gitignore.txt: elaborate shell glob syntax
      trace: measure where the time is spent in the index-heavy operations
      diff.c: refactor pprint_rename() to use strbuf
      dir.c: ignore paths containing .git when invalidating untracked cache
      parse-options: support --git-completion-helper
      parse-options: add OPT_xxx_F() variants
      parse-options: let OPT__FORCE take optional flags argument
      git-completion.bash: introduce __gitcomp_builtin
      completion: use __gitcomp_builtin in _git_add
      completion: use __gitcomp_builtin in _git_am
      completion: use __gitcomp_builtin in _git_apply
      completion: use __gitcomp_builtin in _git_branch
      completion: use __gitcomp_builtin in _git_checkout
      completion: use __gitcomp_builtin in _git_cherry_pick
      completion: use __gitcomp_builtin in _git_clean
      completion: use __gitcomp_builtin in _git_clone
      completion: use __gitcomp_builtin in _git_commit
      completion: use __gitcomp_builtin in _git_config
      completion: use __gitcomp_builtin in _git_describe
      completion: use __gitcomp_builtin in _git_difftool
      completion: use __gitcomp_builtin in _git_fetch
      completion: use __gitcomp_builtin in _git_fsck
      completion: use __gitcomp_builtin in _git_gc
      completion: use __gitcomp_builtin in _git_grep
      completion: use __gitcomp_builtin in _git_help
      completion: use __gitcomp_builtin in _git_init
      completion: use __gitcomp_builtin in _git_ls_files
      completion: use __gitcomp_builtin in _git_ls_remote
      completion: use __gitcomp_builtin in _git_merge
      completion: use __gitcomp_builtin in _git_merge_base
      completion: use __gitcomp_builtin in _git_mv
      completion: use __gitcomp_builtin in _git_name_rev
      completion: use __gitcomp_builtin in _git_notes
      completion: use __gitcomp_builtin in _git_pull
      completion: use __gitcomp_builtin in _git_push
      completion: use __gitcomp_builtin in _git_remote
      remote: force completing --mirror= instead of --mirror
      completion: use __gitcomp_builtin in _git_replace
      completion: use __gitcomp_builtin in _git_reset
      completion: use __gitcomp_builtin in _git_revert
      completion: use __gitcomp_builtin in _git_rm
      completion: use __gitcomp_builtin in _git_show_branch
      completion: use __gitcomp_builtin in _git_status
      completion: use __gitcomp_builtin in _git_tag
      completion: use __gitcomp_builtin in _git_worktree
      worktree.c: add update_worktree_location()
      worktree move: new command
      worktree move: accept destination as directory
      worktree move: refuse to move worktrees with submodules
      worktree remove: new command
      worktree remove: allow it when $GIT_WORK_TREE is already gone
      am: add --show-current-patch
      rebase: add --show-current-patch
      rebase: introduce and use pseudo-ref REBASE_HEAD
      am: support --quit
      diff: add --compact-summary
      object.h: update flag allocation comment
      object.h: realign object flag allocation comment
      completion: don't set PARSE_OPT_NOCOMPLETE on --rerere-autoupdate
      completion: simplify _git_notes
      completion: complete --{reuse,reedit}-message= for all notes subcmds
      completion: more subcommands in _git_notes()

Nicolas Morey-Chaisemartin (1):
      tag: add --edit option

Olga Telezhnaya (3):
      mru: use double-linked list from list.h
      ref-filter: get rid of duplicate code
      ref-filter: get rid of goto

Patryk Obara (14):
      clang-format: adjust penalty for return type line break
      http-push: improve error log
      sha1_file: convert pretend_sha1_file to object_id
      dir: convert struct sha1_stat to use object_id
      sha1_file: convert hash_sha1_file to object_id
      cache: clear whole hash buffer with oidclr
      match-trees: convert splice_tree to object_id
      commit: convert commit_tree* to object_id
      notes: convert combine_notes_* to object_id
      notes: convert write_notes_tree to object_id
      sha1_file: convert write_sha1_file to object_id
      sha1_file: convert force_object_loose to object_id
      sha1_file: convert write_loose_object to object_id
      sha1_file: rename hash_sha1_file_literally

Phillip Wood (25):
      t3404: check intermediate squash messages
      commit: move empty message checks to libgit
      Add a function to update HEAD after creating a commit
      commit: move post-rewrite code to libgit
      commit: move print_commit_summary() to libgit
      sequencer: simplify adding Signed-off-by: trailer
      sequencer: load commit related config
      sequencer: try to commit without forking 'git commit'
      t3512/t3513: remove KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
      sequencer: improve config handling
      t7505: style fixes
      t7505: add tests for cherry-pick and rebase -i/-p
      sequencer: run 'prepare-commit-msg' hook
      add -p: only display help for active keys
      add -p: only bind search key if there's more than one hunk
      add -p: improve error messages
      add -i: add function to format hunk header
      t3701: indent here documents
      t3701: use test_write_lines and write_script
      t3701: don't hard code sha1 hash values
      t3701: add failing test for pathological context lines
      add -p: adjust offsets of subsequent hunks when one is skipped
      add -p: calculate offset delta for edited patches
      add -p: fix counting when splitting and coalescing
      add -p: don't rely on apply's '--recount' option

Prathamesh Chavan (2):
      submodule: port submodule subcommand 'sync' from shell to C
      submodule: port submodule subcommand 'deinit' from shell to C

Ramsay Jones (6):
      t4151: consolidate multiple calls to test_i18ngrep
      config.mak.uname: remove SPARSE_FLAGS setting for cygwin
      Makefile: suppress a sparse warning for pack-revindex.c
      http: fix an unused variable warning for 'curl_no_proxy'
      -Wuninitialized: remove some 'init-self' workarounds
      read-cache: fix an -Wmaybe-uninitialized warning

Randall S. Becker (1):
      hashmap.h: remove unused variable

Rasmus Villemoes (2):
      grep: move grep_source_init outside critical section
      grep: simplify grep_oid and grep_file

René Scharfe (15):
      commit: avoid allocation in clear_commit_marks_many()
      commit: use clear_commit_marks_many() in remove_redundant()
      ref-filter: use clear_commit_marks_many() in do_merge_filter()
      object: add clear_commit_marks_all()
      bisect: avoid using the rev_info flag leak_pending
      bundle: avoid using the rev_info flag leak_pending
      checkout: avoid using the rev_info flag leak_pending
      revision: remove the unused flag leak_pending
      commit: remove unused function clear_commit_marks_for_object_array()
      describe: use strbuf_add_unique_abbrev() for adding short hashes
      cocci: use format keyword instead of a literal string
      cocci: simplify check for trivial format strings
      check-ignore: fix mix of directories and other file types
      sequencer: factor out strbuf_read_file_or_whine()
      perf: use GIT_PERF_REPEAT_COUNT=3 by default even without config file

Robert P. J. Day (2):
      t/: correct obvious typo "detahced"
      Correct mispellings of ".gitmodule" to ".gitmodules"

SZEDER Gábor (34):
      travis-ci: build Git during the 'script' phase
      Use MOVE_ARRAY
      travis-ci: use 'set -x' for the commands under 'su' in the 32 bit Linux build
      travis-ci: use 'set -e' in the 32 bit Linux build job
      travis-ci: don't repeat the path of the cache directory
      travis-ci: don't run the test suite as root in the 32 bit Linux build
      travis-ci: don't fail if user already exists on 32 bit Linux build job
      t5541: add 'test_i18ngrep's missing filename parameter
      t5812: add 'test_i18ngrep's missing filename parameter
      t6022: don't run 'git merge' upstream of a pipe
      t4001: don't run 'git status' upstream of a pipe
      t5510: consolidate 'grep' and 'test_i18ngrep' patterns
      t5536: let 'test_i18ngrep' read the file without redirection
      t: move 'test_i18ncmp' and 'test_i18ngrep' to 'test-lib-functions.sh'
      t: validate 'test_i18ngrep's parameters
      t: make 'test_i18ngrep' more informative on failure
      t: document 'test_must_fail ok=<signal-name>'
      t6300-for-each-ref: fix "more than one quoting style" tests
      Makefile: generate Git(3pm) as dependency of the 'doc' and 'man' targets
      t: prevent '-x' tracing from interfering with test helpers' stderr
      t: add means to disable '-x' tracing for individual test scripts
      t1507-rev-parse-upstream: don't check the stderr of a shell function
      t5536: simplify checking of messages output to stderr
      t3030-merge-recursive: don't check the stderr of a subshell
      t5500-fetch-pack: don't check the stderr of a subshell
      t5526: use $TRASH_DIRECTORY to specify the path of GIT_TRACE log file
      t5570-git-daemon: don't check the stderr of a subshell
      t9903-bash-prompt: don't check the stderr of __git_ps1()
      t1510-repo-setup: mark as untraceable with '-x'
      t/README: add a note about don't saving stderr of compound commands
      travis-ci: run tests with '-x' tracing
      t9400-git-cvsserver-server: don't rely on the output of 'test_cmp'
      t9402-git-cvsserver-refs: don't check the stderr of a subshell
      completion: clear cached --options when sourcing the completion script

Stefan Beller (15):
      diff.h: make pickaxe_opts an unsigned bit field
      diff: migrate diff_flags.pickaxe_ignore_case to a pickaxe_opts bit
      diff: introduce DIFF_PICKAXE_KINDS_MASK
      diffcore: add a pickaxe option to find a specific blob
      diff: properly error out when combining multiple pickaxe options
      diff: use HAS_MULTI_BITS instead of counting bits manually
      t/lib-submodule-update.sh: clarify test
      t/lib-submodule-update.sh: fix test ignoring ignored files in submodules
      unpack-trees: oneway_merge to update submodules
      submodule: submodule_move_head omits old argument in forced case
      builtin/pull: respect verbosity settings in submodules
      send-email: error out when relogin delay is missing
      color.h: document and modernize header
      Documentation/git-status: clarify status table for porcelain mode
      submodule deinit: handle non existing pathspecs gracefully

Stefan Moch (2):
      t7001: add test case for --dry-run
      mv: remove unneeded 'if (!show_only)'

Stephen R Guglielmo (1):
      subtree: fix add and pull for GPG-signed commits

Tatyana Krasnukha (1):
      apply: handle Subversion diffs with /dev/null gracefully

Thomas Gummerer (6):
      stash: don't delete untracked files that match pathspec
      read-cache: fix reading the shared index for other repos
      split-index: don't write cache tree with null oid entries
      travis: run tests with GIT_TEST_SPLIT_INDEX
      reset --hard: make use of the pretty machinery
      git-stash.txt: remove extra square bracket

Thomas Levesque (1):
      userdiff.c: add C# async keyword in diff pattern

Todd Zullinger (5):
      doc: mention 'git show' defaults to HEAD
      Makefile: remove *.spec from clean target
      Makefile: add NO_PERL_CPAN_FALLBACKS knob
      RelNotes: add details on Perl module changes
      completion: complete tags with git tag --delete/--verify

Torsten Bögershausen (1):
      convert_to_git(): safe_crlf/checksafe becomes int conv_flags

Yasushi SHOJI (1):
      bisect: debug: convert struct object to object_id

brian m. carlson (15):
      repository: pre-initialize hash algo pointer
      hash: move SHA-1 macros to hash.h
      hash: create union for hash context allocation
      builtin/index-pack: improve hash function abstraction
      builtin/unpack-objects: switch uses of SHA-1 to the_hash_algo
      sha1_file: switch uses of SHA-1 to the_hash_algo
      fast-import: switch various uses of SHA-1 to the_hash_algo
      pack-check: convert various uses of SHA-1 to abstract forms
      pack-write: switch various SHA-1 values to abstract forms
      read-cache: abstract away uses of SHA-1
      csum-file: rename sha1file to hashfile
      csum-file: abstract uses of SHA-1
      bulk-checkin: abstract SHA-1 usage
      hash: update obsolete reference to SHA1_HEADER
      docs/interpret-trailers: fix agreement error

Ævar Arnfjörð Bjarmason (53):
      Makefile: don't error out under DC_SHA1_EXTERNAL if DC_SHA1_SUBMODULE=auto
      Makefile: under "make dist", include the sha1collisiondetection submodule
      sha1dc_git.h: re-arrange an ifdef chain for a subsequent change
      Makefile: replace perl/Makefile.PL with simple make rules
      commit doc: document that -c, -C, -F and --fixup with -m error
      commit: add support for --fixup <commit> -m"<extra message>"
      perl: avoid *.pmc and fix Error.pm further
      perf: amend the grep tests to test grep.threads
      cat-file doc: document that -e will return some output
      status: add a failing test showing a core.untrackedCache bug
      wildmatch test: indent with tabs, not spaces
      wildmatch test: use more standard shell style
      wildmatch test: don't try to vertically align our output
      wildmatch test: use a paranoia pattern from nul_match()
      wildmatch test: remove dead fnmatch() test code
      wildmatch test: use test_must_fail, not ! for test-wildmatch
      wildmatch test: perform all tests under all wildmatch() modes
      wildmatch test: create & test files on disk in addition to in-memory
      test-lib: add an EXPENSIVE_ON_WINDOWS prerequisite
      wildmatch test: mark test as EXPENSIVE_ON_WINDOWS
      fetch: don't redundantly NULL something calloc() gave us
      fetch: trivially refactor assignment to ref_nr
      fetch: stop accessing "remote" variable indirectly
      remote: add a macro for "refs/tags/*:refs/tags/*"
      fetch tests: refactor in preparation for testing tag pruning
      fetch tests: re-arrange arguments for future readability
      fetch tests: add a tag to be deleted to the pruning tests
      fetch tests: test --prune and refspec interaction
      fetch tests: double quote a variable for interpolation
      fetch tests: expand case/esac for later change
      fetch tests: fetch <url> <spec> as well as fetch [<remote>]
      git fetch doc: add a new section to explain the ins & outs of pruning
      git remote doc: correct dangerous lies about what prune does
      git-fetch & config doc: link to the new PRUNING section
      fetch tests: add scaffolding for the new fetch.pruneTags
      fetch: add a --prune-tags option and fetch.pruneTags config
      fetch: make the --prune-tags work with <url>
      update-index doc: note a fixed bug in the untracked cache
      update-index doc: note the caveat with "could not open..."
      perl: *.pm files should not have the executable bit
      Git.pm: remove redundant "use strict" from sub-package
      Git.pm: add the "use warnings" pragma
      commit: run git gc --auto just before the post-commit hook
      gitweb: hard-depend on the Digest::MD5 5.8 module
      Git.pm: hard-depend on the File::{Temp,Spec} modules
      git-send-email: unconditionally use Net::{SMTP,Domain}
      perl: update our ancient copy of Error.pm
      perl: update our copy of Mail::Address
      perl: move CPAN loader wrappers to another namespace
      perl: generalize the Git::LoadCPAN facility
      perl: move the perl/Git/FromCPAN tree to perl/FromCPAN
      perl Git::LoadCPAN: emit better errors under NO_PERL_CPAN_FALLBACKS
      git manpage: note git-security@googlegroups.com

