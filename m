Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DC7920248
	for <e@80x24.org>; Sun, 24 Feb 2019 18:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfBXSRw (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 13:17:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50415 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfBXSRw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 13:17:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id x7so6041926wmj.0;
        Sun, 24 Feb 2019 10:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ncVa0jf8EHoXuGPJuTlM/XX7LrdkNaejKzgNSYn5KhU=;
        b=ZtK4zurnrw6u995iv1tLDgKQFEfDC4pskCUNlhoegIlgwxdmVM+D+LHSrtHjBl4rzN
         QRVlkFPjXfzHPlXs/rRjO6+IhBDlywFiBcSmbnRF6h8pJjakwv6rDgzHw6d1S+dg9G+O
         dzaIN72u89aIZUAuNi+yYKKg3uk3zdDesVPwNxzsaCCwzLYKtG1VmNp9jdOFhLOzTQAE
         sN2fPsn+FTp3eXqqhBvwXX/UogoWJ76bYYxv5cS/3ukIHjsg1v+FeP5bxsyIZ0N4BDrh
         kysZXXYoNV4XNQYH4NM5+KvW5PrFNK8D7JQ6ZiWrwAQ1oxMO/5drF85gZ3WbM/8C5bR1
         IfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ncVa0jf8EHoXuGPJuTlM/XX7LrdkNaejKzgNSYn5KhU=;
        b=UYv3CpkssjqoPdycg7FGLeyM93V1KuYgI5Rpz6A7DCwVlZMW4gGq5Gh8U5gihAN1FR
         2dhBF2g+BGESkW9g/Dy1C7AA926kjuOyLAblcmHivSjnrMU+8kLIeuG8wtwe0xPFEyJh
         aAgL3HFepY3tvqGjvP0ZGt5x4uzmSV81hqMID5fRzHWV2chkhdMKkzOsJK3pd8kgOLrK
         LZZx0RmKB8otmDNAs0NllWIYpJXbioARPSVNG2iPkSvJG8r8Nqg8+KABMAH4MFP3yCyE
         A3Ag8BFjhSQwgXjVJAi12DvB3pusIZUo5Gr3WJo5uBjsOl/9CLeRohE5Im5ddE3PHgmu
         PxKA==
X-Gm-Message-State: AHQUAuboKYAUJUfvXNI0Ikc78wFLaiGmDNuQ6P18PBWuLMt3Kv9s3R6o
        xIe79+8l6aDy3C13NfB3AGromk0k
X-Google-Smtp-Source: AHgI3IYyuDgSeepBZIgzwNpnqKWMfvsiYO5zexACH6dKUw8YbyTRO+HbkryQJCBh2jcBjGJ8aiSu6w==
X-Received: by 2002:a1c:d18a:: with SMTP id i132mr8376960wmg.27.1551032268184;
        Sun, 24 Feb 2019 10:17:48 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e23sm6553274wme.15.2019.02.24.10.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Feb 2019 10:17:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.21.0
Date:   Sun, 24 Feb 2019 10:17:45 -0800
Message-ID: <xmqqtvgtkq46.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest feature release Git v2.21.0 is now available at the
usual places.  It is comprised of 500 non-merge commits since
v2.20.0, contributed by 74 people, 20 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.21.0'
tag and the 'master' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.20.0 are as follows.
Welcome to the Git development community!

  Alessandro Menti, Arti Zirk, Brandon Richardson, Chayoung
  You, Denis Ovsienko, Emilio Cobos Álvarez, Erin Dahlgren,
  Fabien Villepinte, Force Charlie, Frank Dana, Issac Trotts,
  Katrin Leinweber, Laura Abbott, Patrick Hogg, Peter Osterlund,
  Shahzad Lone, Slavica Djukic, Yoichi Nakayama, Zhilei Han, and
  Tanushree Tumane.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Ævar Arnfjörð Bjarmason, Alexander Shopov, Ben Peart,
  Brandon Williams, brian m. carlson, Carlo Marcelo Arenas Belón,
  Christian Couder, Christopher Díaz Riveros, David Turner,
  Derrick Stolee, Elijah Newren, Eric Sunshine, Eric Wong, Fangyi
  Zhou, Jean-Noël Avila, Jeff King, Jiang Xin, Jimmy Angelakos,
  Johannes Schindelin, Jonathan Nieder, Jonathan Tan, Jordi
  Mas, Josh Steadmon, Junio C Hamano, Kevin Daudt, Kim Gybels,
  Kyle Meyer, Linus Torvalds, Luke Diamand, Martin Ågren,
  Masaya Suzuki, Matthew DeVore, Matthieu Moy, Max Kirillov,
  Nguyễn Thái Ngọc Duy, Olga Telezhnaya, Orgad Shaneh, Peter
  Krefting, Phillip Wood, Pranit Bauva, Ralf Thielow, Ramsay Jones,
  Randall S. Becker, René Scharfe, Sebastian Staudt, Sergey
  Organov, Stefan Beller, Stephen P. Smith, Sven van Haastregt,
  SZEDER Gábor, Thomas Braun, Thomas Gummerer, Todd Zullinger,
  and Torsten Bögershausen.

----------------------------------------------------------------

Git 2.21 Release Notes
======================

Backward Compatibility Notes
----------------------------

 * Historically, the "-m" (mainline) option can only be used for "git
   cherry-pick" and "git revert" when working with a merge commit.
   This version of Git no longer warns or errors out when working with
   a single-parent commit, as long as the argument to the "-m" option
   is 1 (i.e. it has only one parent, and the request is to pick or
   revert relative to that first parent).  Scripts that relied on the
   behaviour may get broken with this change.


Updates since v2.20
-------------------

UI, Workflows & Features

 * The "http.version" configuration variable can be used with recent
   enough versions of cURL library to force the version of HTTP used
   to talk when fetching and pushing.

 * Small fixes and features for fast-export and fast-import, mostly on
   the fast-export side has been made.

 * "git push $there $src:$dst" rejects when $dst is not a fully
   qualified refname and it is not clear what the end user meant.  The
   codepath has been taught to give a clearer error message, and also
   guess where the push should go by taking the type of the pushed
   object into account (e.g. a tag object would want to go under
   refs/tags/).

 * "git checkout [<tree-ish>] path..." learned to report the number of
   paths that have been checked out of the index or the tree-ish,
   which gives it the same degree of noisy-ness as the case in which
   the command checks out a branch.  "git checkout -m <pathspec>" to
   undo conflict resolution gives a similar message.

 * "git quiltimport" learned "--keep-non-patch" option.

 * "git worktree remove" and "git worktree move" refused to work when
   there is a submodule involved.  This has been loosened to ignore
   uninitialized submodules.

 * "git cherry-pick -m1" was forbidden when picking a non-merge
   commit, even though there _is_ parent number 1 for such a commit.
   This was done to avoid mistakes back when "cherry-pick" was about
   picking a single commit, but is no longer useful with "cherry-pick"
   that can pick a range of commits.  Now the "-m$num" option is
   allowed when picking any commit, as long as $num names an existing
   parent of the commit.

 * Update "git multimail" from the upstream.

 * "git p4" update.

 * The "--format=<placeholder>" option of for-each-ref, branch and tag
   learned to show a few more traits of objects that can be learned by
   the object_info API.

 * "git rebase -i" learned to re-execute a command given with 'exec'
   to run after it failed the last time.

 * "git diff --color-moved-ws" updates.

 * Custom userformat "log --format" learned %S atom that stands for
   the tip the traversal reached the commit from, i.e. --source.

 * "git instaweb" learned to drive http.server that comes with
   "batteries included" Python installation (both Python2 & 3).

 * A new encoding UTF-16LE-BOM has been invented to force encoding to
   UTF-16 with BOM in little endian byte order, which cannot be directly
   generated by using iconv.

 * A new date format "--date=human" that morphs its output depending
   on how far the time is from the current time has been introduced.
   "--date=auto:human" can be used to use this new format (or any
   existing format) when the output is going to the pager or to the
   terminal, and otherwise the default format.


Performance, Internal Implementation, Development Support etc.

 * Code clean-up with optimization for the codepath that checks
   (non-)existence of loose objects.

 * More codepaths have become aware of working with in-core repository
   instances other than the default "the_repository".

 * The "strncat()" function is now among the banned functions.

 * Portability updates for the HPE NonStop platform.

 * Earlier we added "-Wformat-security" to developer builds, assuming
   that "-Wall" (which includes "-Wformat" which in turn is required
   to use "-Wformat-security") is always in effect.  This is not true
   when config.mak.autogen is in use, unfortunately.  This has been
   fixed by unconditionally adding "-Wall" to developer builds.

 * The loose object cache used to optimize existence look-up has been
   updated.

 * Flaky tests can now be repeatedly run under load with the
   "--stress" option.

 * Documentation/Makefile is getting prepared for manpage
   localization.

 * "git fetch-pack" now can talk the version 2 protocol.

 * sha-256 hash has been added and plumbed through the code to allow
   building Git with the "NewHash".

 * Debugging help for http transport.

 * "git fetch --deepen=<more>" has been corrected to work over v2
   protocol.

 * The code to walk tree objects has been taught that we may be
   working with object names that are not computed with SHA-1.

 * The in-core repository instances are passed through more codepaths.

 * Update the protocol message specification to allow only the limited
   use of scaled quantities.  This is to ensure potential compatibility
   issues will not get out of hand.

 * Micro-optimize the code that prepares commit objects to be walked
   by "git rev-list" when the commit-graph is available.

 * "git fetch" and "git upload-pack" learned to send all exchanges over
   the sideband channel while talking the v2 protocol.

 * The codepath to write out commit-graph has been optimized by
   following the usual pattern of visiting objects in in-pack order.

 * The codepath to show progress meter while writing out commit-graph
   file has been improved.

 * Cocci rules have been updated to encourage use of strbuf_addbuf().

 * "git rebase --merge" has been reimplemented by reusing the internal
   machinery used for "git rebase -i".

 * More code in "git bisect" has been rewritten in C.

 * Instead of going through "git-rebase--am" scriptlet to use the "am"
   backend, the built-in version of "git rebase" learned to drive the
   "am" backend directly.

 * The assumption to work on the single "in-core index" instance has
   been reduced from the library-ish part of the codebase.

 * The test lint learned to catch non-portable "sed" options.

 * "git pack-objects" learned another algorithm to compute the set of
   objects to send, that trades the resulting packfile off to save
   traversal cost to favor small pushes.

 * The travis CI scripts have been corrected to build Git with the
   compiler(s) of our choice.

 * "git submodule update" learned to abort early when core.worktree
   for the submodule is not set correctly to prevent spreading damage.

 * Test suite has been adjusted to run on Azure Pipeline.

 * Running "Documentation/doc-diff x" from anywhere other than the
   top-level of the working tree did not show the usage string
   correctly, which has been fixed.

 * Use of the sparse tool got easier to customize from the command
   line to help developers.

 * A new target "coverage-prove" to run the coverage test under
   "prove" has been added.

 * A flakey "p4" test has been removed.

 * The code and tests assume that the system supplied iconv() would
   always use BOM in its output when asked to encode to UTF-16 (or
   UTF-32), but apparently some implementations output big-endian
   without BOM.  A compile-time knob has been added to help such
   systems (e.g. NonStop) to add BOM to the output to increase
   portability.


Fixes since v2.20
-----------------

 * Updates for corner cases in merge-recursive.
   (merge cc4cb0902c en/merge-path-collision later to maint).

 * "git checkout frotz" (without any double-dash) avoids ambiguity by
   making sure 'frotz' cannot be interpreted as a revision and as a
   path at the same time.  This safety has been updated to check also
   a unique remote-tracking branch 'frotz' in a remote, when dwimming
   to create a local branch 'frotz' out of a remote-tracking branch
   'frotz' from a remote.
   (merge be4908f103 nd/checkout-dwim-fix later to maint).

 * Refspecs configured with "git -c var=val clone" did not propagate
   to the resulting repository, which has been corrected.
   (merge 7eae4a3ac4 sg/clone-initial-fetch-configuration later to maint).

 * A properly configured username/email is required under
   user.useConfigOnly in order to create commits; now "git stash"
   (even though it creates commit objects to represent stash entries)
   command is exempt from the requirement.
   (merge 3bc2111fc2 sd/stash-wo-user-name later to maint).

 * The http-backend CGI process did not correctly clean up the child
   processes it spawns to run upload-pack etc. when it dies itself,
   which has been corrected.
   (merge 02818a98d7 mk/http-backend-kill-children-before-exit later to maint).

 * "git rev-list --exclude-promisor-objects" had to take an object
   that does not exist locally (and is lazily available) from the
   command line without barfing, but the code dereferenced NULL.
   (merge 4cf67869b2 md/list-lazy-objects-fix later to maint).

 * The traversal over tree objects has learned to honor
   ":(attr:label)" pathspec match, which has been implemented only for
   enumerating paths on the filesystem.
   (merge 5a0b97b34c nd/attr-pathspec-in-tree-walk later to maint).

 * BSD port updates.
   (merge 4e3ecbd439 cb/openbsd-allows-reading-directory later to maint).
   (merge b6bdc2a0f5 cb/t5004-empty-tar-archive-fix later to maint).
   (merge 82cbc8cde2 cb/test-lint-cp-a later to maint).

 * Lines that begin with a certain keyword that come over the wire, as
   well as lines that consist only of one of these keywords, ought to
   be painted in color for easier eyeballing, but the latter was
   broken ever since the feature was introduced in 2.19, which has
   been corrected.
   (merge 1f67290450 hn/highlight-sideband-keywords later to maint).

 * "git log -G<regex>" looked for a hunk in the "git log -p" patch
   output that contained a string that matches the given pattern.
   Optimize this code to ignore binary files, which by default will
   not show any hunk that would match any pattern (unless textconv or
   the --text option is in effect, that is).
   (merge e0e7cb8080 tb/log-G-binary later to maint).

 * "git submodule update" ought to use a single job unless asked, but
   by mistake used multiple jobs, which has been fixed.
   (merge e3a9d1aca9 sb/submodule-fetchjobs-default-to-one later to maint).

 * "git stripspace" should be usable outside a git repository, but
   under the "-s" or "-c" mode, it didn't.
   (merge 957da75802 jn/stripspace-wo-repository later to maint).

 * Some of the documentation pages formatted incorrectly with
   Asciidoctor, which have been fixed.
   (merge b62eb1d2f4 ma/asciidoctor later to maint).

 * The core.worktree setting in a submodule repository should not be
   pointing at a directory when the submodule loses its working tree
   (e.g. getting deinit'ed), but the code did not properly maintain
   this invariant.

 * With zsh, "git cmd path<TAB>" was completed to "git cmd path name"
   when the completed path has a special character like SP in it,
   without any attempt to keep "path name" a single filename.  This
   has been fixed to complete it to "git cmd path\ name" just like
   Bash completion does.

 * The test suite tried to see if it is run under bash, but the check
   itself failed under some other implementations of shell (notably
   under NetBSD).  This has been corrected.
   (merge 54ea72f09c sg/test-bash-version-fix later to maint).

 * "git gc" and "git repack" did not close the open packfiles that
   they found unneeded before removing them, which didn't work on a
   platform incapable of removing an open file.  This has been
   corrected.
   (merge 5bdece0d70 js/gc-repack-close-before-remove later to maint).

 * The code to drive GIT_EXTERNAL_DIFF command relied on the string
   returned from getenv() to be non-volatile, which is not true, that
   has been corrected.
   (merge 6776a84dae kg/external-diff-save-env later to maint).

 * There were many places the code relied on the string returned from
   getenv() to be non-volatile, which is not true, that have been
   corrected.
   (merge 0da0e9268b jk/save-getenv-result later to maint).

 * The v2 upload-pack protocol implementation failed to honor
   hidden-ref configuration, which has been corrected.
   (merge e20b4192a3 jk/proto-v2-hidden-refs-fix later to maint).

 * "git fetch --recurse-submodules" may not fetch the necessary commit
   that is bound to the superproject, which is getting corrected.
   (merge be76c21282 sb/submodule-recursive-fetch-gets-the-tip later to maint).

 * "git rebase" internally runs "checkout" to switch between branches,
   and the command used to call the post-checkout hook, but the
   reimplementation stopped doing so, which is getting fixed.

 * "git add -e" got confused when the change it wants to let the user
   edit is smaller than the previous change that was left over in a
   temporary file.
   (merge fa6f225e01 js/add-e-clear-patch-before-stating later to maint).

 * "git p4" failed to update a shelved change when there were moved
   files, which has been corrected.
   (merge 7a10946ab9 ld/git-p4-shelve-update-fix later to maint).

 * The codepath to read from the commit-graph file attempted to read
   past the end of it when the file's table-of-contents was corrupt.

 * The compat/obstack code had casts that -Wcast-function-type
   compilation option found questionable.
   (merge 764473d257 sg/obstack-cast-function-type-fix later to maint).

 * An obvious typo in an assertion error message has been fixed.
   (merge 3c27e2e059 cc/test-ref-store-typofix later to maint).

 * In Git for Windows, "git clone \\server\share\path" etc. that uses
   UNC paths from command line had bad interaction with its shell
   emulation.

 * "git add --ignore-errors" did not work as advertised and instead
   worked as an unintended synonym for "git add --renormalize", which
   has been fixed.
   (merge e2c2a37545 jk/add-ignore-errors-bit-assignment-fix later to maint).

 * On a case-insensitive filesystem, we failed to compare the part of
   the path that is above the worktree directory in an absolute
   pathname, which has been corrected.

 * Asking "git check-attr" about a macro (e.g. "binary") on a specific
   path did not work correctly, even though "git check-attr -a" listed
   such a macro correctly.  This has been corrected.
   (merge 7b95849be4 jk/attr-macro-fix later to maint).

 * "git pack-objects" incorrectly used uninitialized mutex, which has
   been corrected.
   (merge edb673cf10 ph/pack-objects-mutex-fix later to maint).

 * "git checkout -b <new> [HEAD]" to create a new branch from the
   current commit and check it out ought to be a no-op in the index
   and the working tree in normal cases, but there are corner cases
   that do require updates to the index and the working tree.  Running
   it immediately after "git clone --no-checkout" is one of these
   cases that an earlier optimization kicked in incorrectly, which has
   been fixed.
   (merge 8424bfd45b bp/checkout-new-branch-optim later to maint).

 * "git diff --color-moved --cc --stat -p" did not work well due to
   funny interaction between a bug in color-moved and the rest, which
   has been fixed.
   (merge dac03b5518 jk/diff-cc-stat-fixes later to maint).

 * When GIT_SEQUENCE_EDITOR is set, the command was incorrectly
   started when modes of "git rebase" that implicitly uses the
   machinery for the interactive rebase are run, which has been
   corrected.
   (merge 891d4a0313 pw/no-editor-in-rebase-i-implicit later to maint).

 * The commit-graph facility did not work when in-core objects that
   are promoted from unknown type to commit (e.g. a commit that is
   accessed via a tag that refers to it) were involved, which has been
   corrected.
   (merge 4468d4435c sg/object-as-type-commit-graph-fix later to maint).

 * "git fetch" output cleanup.
   (merge dc40b24df4 nd/fetch-compact-update later to maint).

 * "git cat-file --batch" reported a dangling symbolic link by
   mistake, when it wanted to report that a given name is ambiguous.

 * Documentation around core.crlf has been updated.
   (merge c9446f0504 jk/autocrlf-overrides-eol-doc later to maint).

 * The documentation of "git commit-tree" said that the command
   understands "--gpg-sign" in addition to "-S", but the command line
   parser did not know about the longhand, which has been corrected.

 * "git rebase -x $cmd" did not reject multi-line command, even though
   the command is incapable of handling such a command.  It now is
   rejected upfront.
   (merge c762aada1a pw/rebase-x-sanity-check later to maint).

 * Output from "git help" was not correctly aligned, which has been
   fixed.
   (merge 6195a76da4 nd/help-align-command-desc later to maint).

 * The "git submodule summary" subcommand showed shortened commit
   object names by mechanically truncating them at 7-hexdigit, which
   has been improved to let "rev-parse --short" scale the length of
   the abbreviation with the size of the repository.
   (merge 0586a438f6 sh/submodule-summary-abbrev-fix later to maint).

 * The way the OSX build jobs updates its build environment used the
   "--quiet" option to "brew update" command, but it wasn't all that
   quiet to be useful.  The use of the option has been replaced with
   an explicit redirection to the /dev/null (which incidentally would
   have worked around a breakage by recent updates to homebrew, which
   has fixed itself already).
   (merge a1ccaedd62 sg/travis-osx-brew-breakage-workaround later to maint).

 * "git --work-tree=$there --git-dir=$here describe --dirty" did not
   work correctly as it did not pay attention to the location of the
   worktree specified by the user by mistake, which has been
   corrected.
   (merge c801170b0c ss/describe-dirty-in-the-right-directory later to maint).

 * "git fetch" over protocol v2 that needs to make a second connection
   to backfill tags did not clear a variable that holds shallow
   repository information correctly, leading to an access of freed
   piece of memory.

 * Some errors from the other side coming over smart HTTP transport
   were not noticed, which has been corrected.

 * Code cleanup, docfix, build fix, etc.
   (merge 89ba9a79ae hb/t0061-dot-in-path-fix later to maint).
   (merge d173e799ea sb/diff-color-moved-config-option-fixup later to maint).
   (merge a8f5a59067 en/directory-renames-nothanks-doc-update later to maint).
   (merge ec36c42a63 nd/indentation-fix later to maint).
   (merge f116ee21cd do/gitweb-strict-export-conf-doc later to maint).
   (merge 112ea42663 fd/gitweb-snapshot-conf-doc-fix later to maint).
   (merge 1cadad6f65 tb/use-common-win32-pathfuncs-on-cygwin later to maint).
   (merge 57e9dcaa65 km/rebase-doc-typofix later to maint).
   (merge b8b4cb27e6 ds/gc-doc-typofix later to maint).
   (merge 3b3357626e nd/style-opening-brace later to maint).
   (merge b4583d5595 es/doc-worktree-guessremote-config later to maint).
   (merge cce99cd8c6 ds/commit-graph-assert-missing-parents later to maint).
   (merge 0650614982 cy/completion-typofix later to maint).
   (merge 6881925ef5 rs/sha1-file-close-mapped-file-on-error later to maint).
   (merge bd8d6f0def en/show-ref-doc-fix later to maint).
   (merge 1747125e2c cc/partial-clone-doc-typofix later to maint).
   (merge e01378753d cc/fetch-error-message-fix later to maint).
   (merge 54e8c11215 jk/remote-insteadof-cleanup later to maint).
   (merge d609615f48 js/test-git-installed later to maint).
   (merge ba170517be ja/doc-style-fix later to maint).
   (merge 86fb1c4e77 km/init-doc-typofix later to maint).
   (merge 5cfd4a9d10 nd/commit-doc later to maint).
   (merge 9fce19a431 ab/diff-tree-doc-fix later to maint).
   (merge 2e285e7803 tz/gpg-test-fix later to maint).
   (merge 5427de960b kl/pretty-doc-markup-fix later to maint).
   (merge 3815f64b0d js/mingw-host-cpu later to maint).
   (merge 5fe81438b5 rj/sequencer-sign-off-header-static later to maint).
   (merge 18a4f6be6b nd/fileno-may-be-macro later to maint).
   (merge 99e9ab54ab kd/t0028-octal-del-is-377-not-777 later to maint).
