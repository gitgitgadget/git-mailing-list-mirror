Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EE6420401
	for <e@80x24.org>; Sat, 24 Jun 2017 23:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755036AbdFXX14 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 19:27:56 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33707 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754999AbdFXX1y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 19:27:54 -0400
Received: by mail-pf0-f169.google.com with SMTP id e7so38798607pfk.0;
        Sat, 24 Jun 2017 16:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=rfn6rZ5xiuLgYgM13hSD3a+YbsegNVYCHTpCjYkfWxA=;
        b=SW+jjWyXCb677+tzA4cAS/Gt0nFMntD33ISGQmC6AozOx2jsQE/BLNg1QwhOtoClFg
         rGbyhSuLk2wX/jOMzan2YM54fM9h8IdmmEyHUS9ltPRCQ+gogN5uMlG8f3o+FO+cj/eJ
         Yh7sMVvk3ArZ4t54iwT7rzSvPq6DC29a6pwjnt+zCDWhk8Xam4PB7EZaLBnU+yJJRCgD
         wJWnXwbATclJNtFsMC29KJgA16ZAAjAENWakucY5vkJtSNtAU6kslaDxZu9Vi2z0IqmG
         KP2Em73X5dOPUf/zqMtf2UDPQ1Dqn1QCIUMi1T127mx+zQh+6azfxraLLT1kKZdr0SR4
         oKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rfn6rZ5xiuLgYgM13hSD3a+YbsegNVYCHTpCjYkfWxA=;
        b=VIWM8XzvzNIz6LP5VZiqSBj+L0CliS0+AF/zekxhWxTqai9RWhd12Yotkr1ZMHApUt
         ADXPbN/le+kn1n+DExysGSF73CxeHl6NsK02XwSL6H4wPOwRXCxJPj2/otdcHY2eKzgx
         3pOEP+ooEKWJH7op/Qem+7235gaL+Dzl8qqj+NU9+m+H+dsb4tOjp3s3gB5MqciA03SB
         O/DCiAY4TVeH9glhtdIOAZwe3xpvWpUBlc6VvazKvhEROjhktHiXvdG4s3bPkGx0unU8
         Ggz8tptMwlGuHArlvJGVjGdxNH/F/lY9KWhBWplCJV6R9ZmSXQldJaz5N3XJCmx+gNq8
         pcAg==
X-Gm-Message-State: AKS2vOwkD9DkQU+0YYawF91XNLTM50lH+Vq+7RUUh1uvarJXFCPRyaUD
        YX2mGHF434B7txDWdmc=
X-Received: by 10.84.229.77 with SMTP id d13mr16737132pln.239.1498346873748;
        Sat, 24 Jun 2017 16:27:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:c3f:f54c:5646:5c2e])
        by smtp.gmail.com with ESMTPSA id b13sm6025641pfj.126.2017.06.24.16.27.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 24 Jun 2017 16:27:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.13.2
Date:   Sat, 24 Jun 2017 15:44:50 -0700
Message-ID: <xmqqfuep7yq0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.13.2 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.13.2'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.13.2 Release Notes
=========================

Fixes since v2.13.1
-------------------

 * The "collision detecting" SHA-1 implementation shipped with 2.13.1
   was still broken on some platforms.  Update to the upstream code
   again to take their fix.

 * "git checkout --recurse-submodules" did not quite work with a
   submodule that itself has submodules.

 * Introduce the BUG() macro to improve die("BUG: ...").

 * The "run-command" API implementation has been made more robust
   against dead-locking in a threaded environment.

 * A recent update to t5545-push-options.sh started skipping all the
   tests in the script when a web server testing is disabled or
   unavailable, not just the ones that require a web server.  Non HTTP
   tests have been salvaged to always run in this script.

 * "git clean -d" used to clean directories that has ignored files,
   even though the command should not lose ignored ones without "-x".
   "git status --ignored"  did not list ignored and untracked files
   without "-uall".  These have been corrected.

 * The timestamp of the index file is now taken after the file is
   closed, to help Windows, on which a stale timestamp is reported by
   fstat() on a file that is opened for writing and data was written
   but not yet closed.

 * "git pull --rebase --autostash" didn't auto-stash when the local history
   fast-forwards to the upstream.

 * "git describe --contains" penalized light-weight tags so much that
   they were almost never considered.  Instead, give them about the
   same chance to be considered as an annotated tag that is the same
   age as the underlying commit would.

 * The result from "git diff" that compares two blobs, e.g. "git diff
   $commit1:$path $commit2:$path", used to be shown with the full
   object name as given on the command line, but it is more natural to
   use the $path in the output and use it to look up .gitattributes.

 * A flaky test has been corrected.

 * Help contributors that visit us at GitHub.

 * "git stash push <pathspec>" did not work from a subdirectory at all.
   Bugfix for a topic in v2.13

Also contains various documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.13.1 are as follows:

Adam Dinwoodie (1):
      docs: fix formatting and grammar

Brandon Williams (12):
      t5550: use write_script to generate post-update hook
      t0061: run_command executes scripts without a #! line
      run-command: prepare command before forking
      run-command: use the async-signal-safe execv instead of execvp
      string-list: add string_list_remove function
      run-command: prepare child environment before forking
      run-command: don't die in child when duping /dev/null
      run-command: eliminate calls to error handling functions in child
      run-command: handle dup2 and close errors in child
      run-command: add note about forking and threading
      run-command: expose is_executable function
      run-command: restrict PATH search to executable files

Dennis Kaarsemaker (1):
      send-email: Net::SMTP::SSL is obsolete, use only when necessary

Eric Wong (1):
      run-command: block signals between fork and execve

Jeff Hostetler (1):
      read-cache: close index.lock in do_write_index

Jeff King (23):
      usage.c: add BUG() function
      setup_git_env: convert die("BUG") to BUG()
      config: complain about --local outside of a git repo
      usage.c: drop set_error_handle()
      handle_revision_arg: reset "dotdot" consistently
      handle_revision_arg: simplify commit reference lookups
      handle_revision_arg: stop using "dotdot" as a generic pointer
      handle_revision_arg: hoist ".." check out of range parsing
      handle_revision_arg: add handle_dotdot() helper
      sha1_name: consistently refer to object_context as "oc"
      get_sha1_with_context: always initialize oc->symlink_path
      get_sha1_with_context: dynamically allocate oc->path
      t4063: add tests of direct blob diffs
      handle_revision_arg: record modes for "a..b" endpoints
      handle_revision_arg: record paths for pending objects
      diff: pass whole pending entry in blobinfo
      diff: use the word "path" instead of "name" for blobs
      diff: use pending "path" if it is available
      diff: use blob path for blob/file diffs
      connect.c: fix leak in parse_one_symref_info()
      remote: drop free_refspecs() function
      t5313: make extended-table test more deterministic
      sha1dc: ignore indent-with-non-tab whitespace violations

Jonathan Nieder (1):
      send-email: Net::SMTP::starttls was introduced in v2.34

Junio C Hamano (6):
      name-rev: refactor logic to see if a new candidate is a better name
      name-rev: favor describing with tags and use committer date to tiebreak
      test: allow skipping the remainder
      diff-tree: update stale in-code comments
      Prepare for 2.13.2
      Git 2.13.2

Kyle J. McKay (1):
      t5100: add some more mailinfo tests

Lars Schneider (1):
      Configure Git contribution guidelines for github.com

Patrick Steinhardt (1):
      git-stash: fix pushing stash with pathspec from subdir

Ramsay Jones (1):
      usage: add NORETURN to BUG() function definitions

René Scharfe (5):
      p0004: simplify calls of test-lazy-init-name-hash
      p0004: avoid using pipes
      p0004: use test_perf
      p0004: don't abort if multi-threaded is too slow
      p0004: don't error out if test repo is too small

Rikard Falkeborn (1):
      completion: add completions for git config commit

SZEDER Gábor (6):
      revision.h: turn rev_info.early_output back into an unsigned int
      revision.c: stricter parsing of '--no-{min,max}-parents'
      revision.c: stricter parsing of '--early-output'
      revision.c: use skip_prefix() in handle_revision_opt()
      revision.c: use skip_prefix() in handle_revision_pseudo_opt()
      docs/pretty-formats: stress that %- removes all preceding line-feeds

Sahil Dua (1):
      t3200: add test for single parameter passed to -m option

Samuel Lijin (6):
      t7300: clean -d should skip dirs with ignored files
      t7061: status --ignored should search untracked dirs
      dir: recurse into untracked dirs for ignored files
      dir: hide untracked contents of untracked dirs
      dir: expose cmp_name() and check_contains()
      clean: teach clean -d to preserve ignored paths

Stefan Beller (5):
      submodule_move_head: reuse child_process structure for futher commands
      submodule: avoid auto-discovery in new working tree manipulator code
      submodule: properly recurse for read-tree and checkout
      t5545: enhance test coverage when no http server is installed
      Documentation/git-rm: correct submodule description

Tyler Brazier (1):
      pull: ff --rebase --autostash works in dirty repo

Ævar Arnfjörð Bjarmason (2):
      wildmatch test: remove redundant duplicate test
      sha1dc: update from upstream

Štěpán Němec (1):
      doc: git-reset: fix a trivial typo

