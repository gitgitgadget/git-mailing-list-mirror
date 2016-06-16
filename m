From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2016, #03; Thu, 7)
Date: Fri, 8 Apr 2016 02:33:33 +0530
Message-ID: <CAFZEwPP1aphz06Ac4ZrKinaE9uiPF4P69P_b5aNn_AYOpZ3m4g@mail.gmail.com>
References: <xmqqfuuxz1jh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 23:03:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoH5p-0000sp-N0
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 23:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbcDGVDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 17:03:37 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35962 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448AbcDGVDe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 17:03:34 -0400
Received: by mail-yw0-f193.google.com with SMTP id i125so1100082ywe.3
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=GOeutEQn6eaWPBHrnt3AM0R63do7ZuPVOiCBv6R+fh4=;
        b=cQChZZelwGCVJs5ucGxpnC2iZtLY0o0G2lxyhcdM0/lfPH0Jqy4ON3b13/t4XbW0VD
         EacbcUh3W+6At4o2QFnwtkZHqFVe/nvKOSp2GaWK0caAh7586GPHdiL8AOLBcyczjMs8
         VX5PXpuaoB0uaVO/07Ysho+foojs+C1egz02BNLvzdATu+vbeZNH4UPBffDo2ws/O03M
         j8XbYHK0zpLt9ZkVAEQMQ5nVo0bzy+fdz8s1sOq2lGBWF6mIYfCMUvSYBoI31fw1Yd9w
         3+gpIieJ8V7TzZCHiMcyET+5qCh90vYRVa+IYsvfFuxB8h7yRHYFBgQCpkBfY1V2FqSi
         qyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=GOeutEQn6eaWPBHrnt3AM0R63do7ZuPVOiCBv6R+fh4=;
        b=g6ksO6kqzov6xAoQ3TIKBex0VvV8lhStCqlvkywWYmW5guxBlZFObuhw8KAUxe+bpi
         9x63aVSriK/6Wu+OeOlY63rakhdHQQXF5WbAeNReXURK0GpQ5qx9HSUo0d+iRTg8I8Yc
         103UL8RPs1swQCEmP31zaAJTT4Ex5krDSUfaDUKth3jEQmdacj/FoVdjK8TMZZ11PTCj
         R4T41bAOC/UnP+6qt7Jn6cVEzIEgzQlxE8iyES3j3eg8/A2cLYF6/m7dzT51Vj7XaXnM
         yUY5SuZ05JSv+aiYRLW8AKWVfhEL080ScLUseTBkQKvhQJ7mb1Zt3QhcxObtprQvPq7F
         pZrg==
X-Gm-Message-State: AD7BkJKFCvSI9HElGvrJjZbdDBFxFR+NRU0slYNJIFz71ZhSB+4kuhJWMQj6PXVKTXodNRs5rODNdKv2Ogi7Fw==
X-Received: by 10.129.38.2 with SMTP id m2mr2915181ywm.128.1460063013189; Thu,
 07 Apr 2016 14:03:33 -0700 (PDT)
Received: by 10.13.219.81 with HTTP; Thu, 7 Apr 2016 14:03:33 -0700 (PDT)
In-Reply-To: <xmqqfuuxz1jh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290988>

On Fri, Apr 8, 2016 at 12:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
> The 'master' branch now has the second batch of topics of this
> cycle.
>
> There are a handful of topics that are stuck; they are marked as
> "Needs review", "Needs an Ack", etc. in the following list.
>
> You can find the changes described here in the integration branches
> of the repositories listed at
>
>     http://git-blame.blogspot.com/p/git-public-repositories.html
>
> --------------------------------------------------
> [Graduated to "master"]
>
> * cc/doc-recommend-performance-trace-to-file (2016-03-07) 1 commit
>   (merged to 'next' on 2016-04-04 at 26f94c0)
>  + Documentation: talk about pager in api-trace.txt
>
>  Originally merged to 'next' on 2016-03-23
>
>  A minor documentation update.
>
>
> * da/mergetool-delete-delete-conflict (2016-03-10) 2 commits
>   (merged to 'next' on 2016-04-04 at 34e645f)
>  + mergetool: honor tempfile configuration when resolving delete conflicts
>  + mergetool: support delete/delete conflicts
>
>  Originally merged to 'next' on 2016-03-15
>
>  "git mergetool" did not work well with conflicts that both sides
>  deleted.
>
>
> * jk/credential-cache-comment-exit (2016-03-18) 1 commit
>   (merged to 'next' on 2016-04-04 at 50427fe)
>  + credential-cache--daemon: clarify "exit" action semantics
>
>  Originally merged to 'next' on 2016-03-23
>
>  A code clarification.
>
>
> * jk/send-email-rtrim-mailrc-alias (2016-03-18) 1 commit
>   (merged to 'next' on 2016-04-04 at 4d54956)
>  + send-email: ignore trailing whitespace in mailrc alias file
>
>  Originally merged to 'next' on 2016-03-23
>
>  "git send-email" had trouble parsing alias file in mailrc format
>  when lines in it had trailing whitespaces on them.
>
>
> * jk/submodule-c-credential (2016-03-23) 7 commits
>   (merged to 'next' on 2016-04-04 at 8de8e8c)
>  + git_config_push_parameter: handle empty GIT_CONFIG_PARAMETERS
>  + git: submodule honor -c credential.* from command line
>  + quote: implement sq_quotef()
>  + submodule: fix segmentation fault in submodule--helper clone
>  + submodule: fix submodule--helper clone usage
>  + submodule: check argc count for git submodule--helper clone
>  + submodule: don't pass empty string arguments to submodule--helper clone
>
>  Originally merged to 'next' on 2016-03-23
>
>  "git -c credential.<var>=<value> submodule" can now be used to
>  propagate configuration variables related to credential helper
>  down to the submodules.
>
>
> * jk/test-httpd-config-nosystem (2016-03-18) 1 commit
>   (merged to 'next' on 2016-04-04 at 5fa6274)
>  + t/lib-httpd: pass through GIT_CONFIG_NOSYSTEM env
>
>  Originally merged to 'next' on 2016-03-23
>
>  The tests that involve running httpd leaked the system-wide
>  configuration in /etc/gitconfig to the tested environment.
>
>
> * jv/merge-nothing-into-void (2016-03-23) 1 commit
>   (merged to 'next' on 2016-04-04 at aa37405)
>  + merge: fix NULL pointer dereference when merging nothing into void
>
>  Originally merged to 'next' on 2016-03-23
>
>  "git merge FETCH_HEAD" dereferenced NULL pointer when merging
>  nothing into an unborn history (which is arguably unusual usage,
>  which perhaps was the reason why nobody noticed it).
>
>
> * la/tag-force-signing-annotated-tags (2016-03-22) 1 commit
>   (merged to 'next' on 2016-04-04 at a49ec4a)
>  + tag: add the option to force signing of annotated tags
>
>  Originally merged to 'next' on 2016-03-24
>
>  "git tag" can create an annotated tag without explicitly given an
>  "-a" (or "-s") option (i.e. when a tag message is given).  A new
>  configuration variable, tag.forceSignAnnotated, can be used to tell
>  the command to create signed tag in such a situation.
>
>
> * ls/p4-map-user (2016-03-15) 1 commit
>   (merged to 'next' on 2016-04-04 at a56b011)
>  + git-p4: map a P4 user to Git author name and email address
>
>  Originally merged to 'next' on 2016-03-23
>
>  "git p4" now allows P4 author names to be mapped to Git author
>  names.
>
>
> * pb/t7502-drop-dup (2016-03-11) 1 commit
>   (merged to 'next' on 2016-04-04 at 4799cad)
>  + t/t7502 : drop duplicate test
>  (this branch is used by pb/commit-verbose-config.)
>
>  Originally merged to 'next' on 2016-03-15
>
>  Code clean-up.
>
>
> * sb/clone-t57-t56 (2016-03-16) 1 commit
>   (merged to 'next' on 2016-04-04 at 5c20247)
>  + clone tests: rename t57* => t56*
>
>  Originally merged to 'next' on 2016-03-23
>
>  Rename bunch of tests on "git clone" for better organization.
>
>
> * sb/rebase-x (2016-03-18) 2 commits
>   (merged to 'next' on 2016-04-04 at feda620)
>  + t3404: cleanup double empty lines between tests
>  + rebase: decouple --exec from --interactive
>
>  Originally merged to 'next' on 2016-03-23
>
>  "git rebase -x" can be used without passing "-i" option.
>
>
> * sb/submodule-parallel-update (2016-03-01) 10 commits
>   (merged to 'next' on 2016-04-04 at a0aea8d)
>  + clone: allow an explicit argument for parallel submodule clones
>  + submodule update: expose parallelism to the user
>  + submodule helper: remove double 'fatal: ' prefix
>  + git submodule update: have a dedicated helper for cloning
>  + run_processes_parallel: rename parameters for the callbacks
>  + run_processes_parallel: treat output of children as byte array
>  + submodule update: direct error message to stderr
>  + fetching submodules: respect `submodule.fetchJobs` config option
>  + submodule-config: drop check against NULL
>  + submodule-config: keep update strategy around
>  (this branch is used by sb/clone-shallow-passthru and sb/submodule-init.)
>
>  Originally merged to 'next' on 2016-03-15
>
>  A major part of "git submodule update" has been ported to C to take
>  advantage of the recently added framework to run download tasks in
>  parallel.
>
>
> * ss/commit-squash-msg (2016-03-21) 1 commit
>   (merged to 'next' on 2016-04-04 at d389f19)
>  + commit: do not lose SQUASH_MSG contents
>
>  Originally merged to 'next' on 2016-03-23
>
>  When "git merge --squash" stopped due to conflict, the concluding
>  "git commit" failed to read in the SQUASH_MSG that shows the log
>  messages from all the squashed commits.
>
>
> * ss/exc-flag-is-a-collection-of-bits (2016-03-01) 1 commit
>   (merged to 'next' on 2016-04-04 at 9f0207e)
>  + dir: store EXC_FLAG_* values in unsigned integers
>
>  Originally merged to 'next' on 2016-03-04
>
>  Code clean-up.
>
>
> * ss/receive-pack-parse-options (2016-03-01) 1 commit
>   (merged to 'next' on 2016-04-04 at fd6ab4c)
>  + builtin/receive-pack.c: use parse_options API
>
>  Originally merged to 'next' on 2016-03-04
>
>  The command line argument parser for "receive-pack" has been
>  rewritten to use parse-options.
>
> --------------------------------------------------
> [New Topics]
>
> * jc/drop-git-spec-in (2016-04-06) 1 commit
>  - Makefile: stop pretending to support rpmbuild
>
>  As nobody maintains our in-tree git.spec.in and distros use their
>  own spec file, we stopped pretending that we support "make rpm".
>
>
> * jc/makefile-redirection-stderr (2016-04-05) 1 commit
>   (merged to 'next' on 2016-04-06 at e3f2ded)
>  + Makefile: fix misdirected redirections
>
>  A minor fix in the Makefile.
>
>  Will merge to 'master'.
>
>
> * js/mingw-tests-2.8 (2016-04-04) 1 commit
>   (merged to 'next' on 2016-04-06 at f85a013)
>  + Windows: shorten code by re-using convert_slashes()
>
>  Code clean-up.
>
>  Will merge to 'master'.
>
>
> * ar/diff-args-osx-precompose (2016-04-05) 1 commit
>  - diff: run arguments through precompose_argv
>
>  Many commands normalize command line arguments from NFD to NFC
>  variant of UTF-8 on OSX, but commands in the "diff" family did
>  not, causing "git diff $path" to complain that no such path is
>  known to Git.  They have been taught to do the normalization.
>
>  Will be rerolled?
>  ($gmane/290724)
>
>
> * ep/trace-doc-sample-fix (2016-04-05) 1 commit
>   (merged to 'next' on 2016-04-06 at 0df7357)
>  + api-trace.txt: fix typo
>
>  Fix a typo in an example in the trace API documentation.
>
>  Will merge to 'master'.
>
>
> * ew/send-email-readable-message-id (2016-04-06) 1 commit
>  - send-email: more meaningful Message-ID
>
>  "git send-email" now uses a more readable timestamps when
>  formulating a message ID.
>
>  Will merge to 'next'.
>
>
> * mg/complete-cherry-mark-to-log (2016-04-05) 1 commit
>   (merged to 'next' on 2016-04-06 at 3002be6)
>  + completion: complete --cherry-mark for git log
>
>  The completion scripts (in contrib/) did not include the
>  "--cherry-mark" option when completing "git log <HT>".
>
>  Will merge to 'master'.
>
>
> * tb/blame-force-read-cache-to-workaround-safe-crlf (2016-04-05) 1 commit
>   (merged to 'next' on 2016-04-06 at 263bba8)
>  + correct blame for files commited with CRLF
>
>  When running "git blame $path" with unnormalized data in the index
>  for the path, the data in the working tree was blamed, even though
>  "git add" would not have changed what is already in the index, due
>  to "safe crlf" that disables the line-end conversion.  It has been
>  corrected.
>
>  Will merge to 'master'.
>
>
> * st/verify-tag (2016-04-06) 3 commits
>  - verify-tag: change variable name for readability
>  - t7030: test verifying multiple tags
>  - builtin/verify-tag.c: ignore SIGPIPE in gpg-interface
>
>  Only the first three patches in a six-patch series.
>
>
> * ew/send-email-drop-data-dumper (2016-04-06) 1 commit
>  - send-email: do not load Data::Dumper
>
>  Code clean-up.
>
>  Will merge to 'next'.
>
> --------------------------------------------------
> [Stalled]
>
> * da/user-useconfigonly (2016-04-01) 2 commits
>  - ident: give "please tell me" message upon useConfigOnly error
>  - ident: check for useConfigOnly before auto-detection of name/email
>
>  The "user.useConfigOnly" configuration variable makes it an error
>  if users do not explicitly set user.name and user.email.  However,
>  its check was not done early enough and allowed another error to
>  trigger, reporting that the default value we guessed from the
>  system setting was unusable.  This was a suboptimal end-user
>  experience as we want the users to set user.name/user.email without
>  relying on the auto-detection at all.
>
>  Waiting for Acks.
>  ($gmane/290340)
>
>
> * sb/clone-shallow-passthru (2016-03-23) 3 commits
>  - clone: add t5614 to test cloning submodules with shallowness involved
>  - submodule clone: pass along `local` option
>  - clone: add `--shallow-submodules` flag
>
>  "git clone" learned "--shallow-submodules" option.
>
>  Needs review.
>
>
> * sg/completion-updates (2016-02-28) 21 commits
>  - completion: cache the path to the repository
>  - completion: extract repository discovery from __gitdir()
>  - completion: don't guard git executions with __gitdir()
>  - completion: consolidate silencing errors from git commands
>  - completion: don't use __gitdir() for git commands
>  - completion: respect 'git -C <path>'
>  - completion: fix completion after 'git -C <path>'
>  - completion: don't offer commands when 'git --opt' needs an argument
>  - rev-parse: add '--absolute-git-dir' option
>  - completion: list short refs from a remote given as a URL
>  - completion: don't list 'HEAD' when trying refs completion outside of a repo
>  - completion: list refs from remote when remote's name matches a directory
>  - completion: respect 'git --git-dir=<path>' when listing remote refs
>  - completion: fix most spots not respecting 'git --git-dir=<path>'
>  - completion: ensure that the repository path given on the command line exists
>  - completion tests: add tests for the __git_refs() helper function
>  - completion tests: check __gitdir()'s output in the error cases
>  - completion tests: consolidate getting path of current working directory
>  - completion tests: make the $cur variable local to the test helper functions
>  - completion tests: don't add test cruft to the test repository
>  - completion: improve __git_refs()'s in-code documentation
>
>  Will be rerolled.
>  ($gmane/287839)
>
>
> * nd/shallow-deepen (2016-02-23) 25 commits
>  - fetch, upload-pack: --deepen=N extends shallow boundary by N commits
>  - upload-pack: add get_reachable_list()
>  - upload-pack: split check_unreachable() in two, prep for get_reachable_list()
>  - t5500, t5539: tests for shallow depth excluding a ref
>  - clone: define shallow clone boundary with --shallow-exclude
>  - fetch: define shallow boundary with --shallow-exclude
>  - upload-pack: support define shallow boundary by excluding revisions
>  - refs: add expand_ref()
>  - t5500, t5539: tests for shallow depth since a specific date
>  - clone: define shallow clone boundary based on time with --shallow-since
>  - fetch: define shallow boundary with --shallow-since
>  - upload-pack: add deepen-since to cut shallow repos based on time
>  - shallow.c: implement a generic shallow boundary finder based on rev-list
>  - fetch-pack: use a separate flag for fetch in deepening mode
>  - fetch-pack: use a common function for verbose printing
>  - fetch-pack: use skip_prefix() instead of starts_with()
>  - upload-pack: move rev-list code out of check_non_tip()
>  - upload-pack: tighten number parsing at "deepen" lines
>  - upload-pack: use skip_prefix() instead of starts_with()
>  - upload-pack: move "unshallow" sending code out of deepen()
>  - upload-pack: remove unused variable "backup"
>  - upload-pack: move "shallow" sending code out of deepen()
>  - upload-pack: move shallow deepen code out of receive_needs()
>  - transport-helper.c: refactor set_helper_option()
>  - remote-curl.c: convert fetch_git() to use argv_array
>
>  The existing "git fetch --depth=<n>" option was hard to use
>  correctly when making the history of an existing shallow clone
>  deeper.  A new option, "--deepen=<n>", has been added to make this
>  easier to use.  "git clone" also learned "--shallow-since=<date>"
>  and "--shallow-exclude=<tag>" options to make it easier to specify
>  "I am interested only in the recent N months worth of history" and
>  "Give me only the history since that version".
>
>  Needs review.
>
>
> * sb/submodule-init (2016-03-15) 2 commits
>  . submodule: port init from shell to C
>  . submodule: port resolve_relative_url from shell to C
>
>  Update of "git submodule" to move pieces of logic to C continues.
>
>  Needs review.
>  ($gmane/288824)
>
>
> * az/p4-bare-no-rebase (2016-02-19) 1 commit
>  - git-p4.py: Don't try to rebase on submit from bare repository
>
>  "git p4 submit" attempts to do a rebase, which would fail if done
>  in a bare repository.  Not doing this rebase would paper over the
>  failure, which is what this patch does, but it is unclear what the
>  side effect of not rebasing is.
>
>  Needs a better explanation.
>
>
> * ss/commit-dry-run-resolve-merge-to-no-op (2016-02-17) 1 commit
>  - wt-status.c: set commitable bit if there is a meaningful merge.
>
>  "git commit --dry-run" reported "No, no, you cannot commit." in one
>  case where "git commit" would have allowed you to commit, and this
>  improves it a little bit ("git commit --dry-run --short" still does
>  not give you the correct answer, for example).
>
>
> * nd/icase (2016-02-15) 12 commits
>  - grep.c: reuse "icase" variable
>  - diffcore-pickaxe: support case insensitive match on non-ascii
>  - diffcore-pickaxe: "share" regex error handling code
>  - grep/pcre: support utf-8
>  - gettext: add is_utf8_locale()
>  - grep/pcre: prepare locale-dependent tables for icase matching
>  - grep/icase: avoid kwsset when -F is specified
>  - grep/icase: avoid kwsset on literal non-ascii strings
>  - test-regex: expose full regcomp() to the command line
>  - test-regex: isolate the bug test code
>  - grep: break down an "if" stmt in preparation for next changes
>  - grep: allow -F -i combination
>
>  "git grep -i" has been taught to fold case in non-ascii locales.
>
>  Needs review.
>  ($gmane/286137)
>
>
> * dt/refs-backend-lmdb (2016-02-25) 45 commits
>  . SQUASH??? Minimum compilation band-aid
>  . tests: add ref-storage argument
>  . refs: tests for lmdb backend
>  . refs: add LMDB refs storage backend
>  . refs: break out resolve_ref_unsafe_submodule
>  . config: read ref storage config on startup
>  . refs: register ref storage backends
>  . svn: learn ref-storage argument
>  . clone: allow ref storage backend to be set for clone
>  . refs: check submodules' ref storage config
>  . init: allow alternate ref strorage to be set for new repos
>  . refs: always handle non-normal refs in files backend
>  . refs: resolve symbolic refs first
>  . refs: on symref reflog expire, lock symref not referrent
>  . refs: don't dereference on rename
>  . refs: allow log-only updates
>  . refs: move duplicate check to common code
>  . refs: make lock generic
>  . refs: handle non-normal ref renames
>  . refs: add method to rename refs
>  . refs: add methods to init refs db
>  . refs: add method for delete_refs
>  . refs: add method for initial ref transaction commit
>  . refs: add methods for reflog
>  . refs: add do_for_each_per_worktree_ref
>  . refs: reduce the visibility of do_for_each_ref()
>  . refs: add method for do_for_each_ref
>  . refs: add methods for misc ref operations
>  . refs: add a backend method structure with transaction functions
>  . refs: move resolve_ref_unsafe into common code
>  . files-backend: break out ref reading
>  . refs: move for_each_*ref* functions into common code
>  . refs: move head_ref{,_submodule} to the common code
>  . Merge branch 'sb/submodule-parallel-update' into dt/refs-backend-lmdb
>  . clone: allow an explicit argument for parallel submodule clones
>  . submodule update: expose parallelism to the user
>  . git submodule update: have a dedicated helper for cloning
>  . run_processes_parallel: correctly terminate callbacks with an LF
>  . run_processes_parallel: rename parameters for the callbacks
>  . run-command: expose default_{start_failure, task_finished}
>  . run_processes_parallel: treat output of children as byte array
>  . submodule update: direct error message to stderr
>  . fetching submodules: respect `submodule.fetchJobs` config option
>  . submodule-config: drop check against NULL
>  . submodule-config: keep update strategy around
>
>  A reroll exists, but it seems that will further be rerolled.
>
>
> * ec/annotate-deleted (2015-11-20) 1 commit
>  - annotate: skip checking working tree if a revision is provided
>
>  Usability fix for annotate-specific "<file> <rev>" syntax with deleted
>  files.
>
>  Waiting for review.
>
>
> * dg/subtree-rebase-test (2016-01-19) 1 commit
>  - contrib/subtree: Add a test for subtree rebase that loses commits
>
>  Reviewed up to v5.
>  Will be rerolled.
>  ($gmane/284426)
>
>
> * js/am-3-merge-recursive-direct (2015-10-12) 2 commits
>  - am: make a direct call to merge_recursive
>  - merge_recursive_options: introduce the "gently" flag
>
>  The merge_recursive_generic() function has been made a bit safer to
>  call from inside a process.  "git am -3" was taught to make a direct
>  call to the function when falling back to three-way merge.
>
>  Being able to make a direct call would be good in general, but as a
>  performance thing, the change needs to be backed up by numbers.
>
>  Needs review.
>
>  I haven't gone through the "gently" change with fine toothed comb;
>  I can see that the change avoids calling die(), but I haven't made
>  sure that the program states (e.g. what's in the in-core index) are
>  adjusted sensibly when it returns to the caller instead of dying,
>  or the codepaths that used to die() are free of resource leaks.
>  The original code certainly did not care the program states at the
>  point of dying exactly because it knew it is going to exit, but now
>  they have to care, and they need to be audited.
>
>
> * dk/gc-more-wo-pack (2016-01-13) 4 commits
>  - gc: clean garbage .bitmap files from pack dir
>  - t5304: ensure non-garbage files are not deleted
>  - t5304: test .bitmap garbage files
>  - prepare_packed_git(): find more garbage
>
>  Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
>  .bitmap and .keep files.
>
>  Waiting for a reroll.
>  ($gmane/284368).
>
>
> * jc/diff-b-m (2015-02-23) 5 commits
>  . WIPWIP
>  . WIP: diff-b-m
>  - diffcore-rename: allow easier debugging
>  - diffcore-rename.c: add locate_rename_src()
>  - diffcore-break: allow debugging
>
>  "git diff -B -M" produced incorrect patch when the postimage of a
>  completely rewritten file is similar to the preimage of a removed
>  file; such a resulting file must not be expressed as a rename from
>  other place.
>
>  The fix in this patch is broken, unfortunately.
>  Will discard.
>
> --------------------------------------------------
> [Cooking]
>
> * es/format-patch-doc-hide-no-patch (2016-04-04) 1 commit
>   (merged to 'next' on 2016-04-06 at 25d79bb)
>  + git-format-patch.txt: don't show -s as shorthand for multiple options
>
>  "git format-patch --help" showed `-s` and `--no-patch` as if these
>  are valid options to the command.  We already hide `--patch` option
>  from the documentation, because format-patch is about showing the
>  diff, and the documentation now hides these options as well.
>
>  Will merge to 'master'.
>
>
> * jk/branch-shortening-funny-symrefs (2016-04-04) 1 commit
>   (merged to 'next' on 2016-04-06 at 1a3f8be)
>  + branch: fix shortening of non-remote symrefs
>
>  A change back in version 2.7 to "git branch" broke display of a
>  symbolic ref in a non-standard place in the refs/ hierarchy (we
>  expect symbolic refs to appear in refs/remotes/*/HEAD to point at
>  the primary branch the remote has, and as .git/HEAD to point at the
>  branch we locally checked out).
>
>  Will merge to 'next' and later down to maint-2.7.
>
>
> * jn/mergetools-examdiff (2016-04-04) 2 commits
>   (merged to 'next' on 2016-04-06 at 819e858)
>  + mergetools: add support for ExamDiff
>  + mergetools: create mergetool_find_win32_cmd() helper function for winmerge
>
>  "git mergetools" learned to drive ExamDiff.
>
>  Will merge to 'master'.
>
>
> * kn/for-each-tag-branch (2016-03-30) 1 commit
>   (merged to 'next' on 2016-04-06 at 4595ad3)
>  + for-each-ref: fix description of '--contains' in manpage
>
>  A minor documentation update.
>
>  Will merge to 'master'.
>
>
> * kn/ref-filter-branch-list (2016-03-30) 16 commits
>  . branch: implement '--format' option
>  . branch: use ref-filter printing APIs
>  . branch, tag: use porcelain output
>  . ref-filter: allow porcelain to translate messages in the output
>  . ref-filter: add support for %(refname:dir) and %(refname:base)
>  . ref-filter: introduce refname_atom_parser()
>  . ref-filter: introduce symref_atom_parser()
>  . ref-filter: make "%(symref)" atom work with the ':short' modifier
>  . ref-filter: add support for %(upstream:track,nobracket)
>  . ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
>  . ref-filter: introduce format_ref_array_item()
>  . ref-filter: move get_head_description() from branch.c
>  . ref-filter: modify "%(objectname:short)" to take length
>  . ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
>  . ref-filter: include reference to 'used_atom' within 'atom_value'
>  . ref-filter: implement %(if), %(then), and %(else) atoms
>
>  The code to list branches in "git branch" has been consolidated
>  with the more generic ref-filter API.
>
>  Will be rerolled.
>
>
> * oa/doc-diff-check (2016-03-29) 1 commit
>   (merged to 'next' on 2016-04-06 at e3d6e8d)
>  + Documentation: git diff --check detects conflict markers
>
>  A minor documentation update.
>
>  Will merge to 'master'.
>
>
> * rz/worktree-no-checkout (2016-03-29) 1 commit
>   (merged to 'next' on 2016-04-06 at e725216)
>  + worktree: add: introduce --checkout option
>
>  "git worktree add" can be given "--no-checkout" option to only
>  create an empty worktree without checking out the files.
>
>  Will merge to 'master'.
>
>
> * sb/misc-cleanups (2016-04-01) 4 commits
>   (merged to 'next' on 2016-04-06 at 4e63691)
>  + credential-cache, send_request: close fd when done
>  + bundle: don't leak an fd in case of early return
>  + abbrev_sha1_in_line: don't leak memory
>  + notes: don't leak memory in git_config_get_notes_strategy
>
>  Assorted minor clean-ups.
>
>  Will merge to 'master'.
>
>
> * sb/submodule-helper-clone-regression-fix (2016-04-01) 6 commits
>  - submodule--helper, module_clone: catch fprintf failure
>  - submodule--helper: do not borrow absolute_path() result for too long
>  - submodule--helper, module_clone: always operate on absolute paths
>  - submodule--helper clone: create the submodule path just once
>  - submodule--helper: fix potential NULL-dereference
>  - recursive submodules: test for relative paths
>
>  A partial rewrite of "git submodule" in the 2.7 timeframe changed
>  the way the gitdir: pointer in the submodules point at the real
>  repository location to use absolute paths by accident.  This has
>  been corrected.
>
>  Any further comments?  Otherwise will merge to 'next'.
>
>
> * sb/submodule-path-misc-bugs (2016-03-30) 6 commits
>  - t7407: make expectation as clear as possible
>  - submodule update: test recursive path reporting from subdirectory
>  - submodule update: align reporting path for custom command execution
>  - submodule status: correct path handling in recursive submodules
>  - submodule update --init: correct path handling in recursive submodules
>  - submodule foreach: correct path display in recursive submodules
>
>  "git submodule" reports the paths of submodules the command
>  recurses into, but this was incorrect when the command was not run
>  from the root level of the superproject.
>
>  Any further comments?  Otherwise will merge to 'next'.
>
>
> * sg/diff-multiple-identical-renames (2016-03-30) 1 commit
>   (merged to 'next' on 2016-04-06 at ac19e48)
>  + diffcore: fix iteration order of identical files during rename detection
>
>  "git diff -M" used to work better when two originally identical
>  files A and B got renamed to X/A and X/B by pairing A to X/A and B
>  to X/B, but this was broken in the 2.0 timeframe.
>
>  Will merge to 'master'.
>
>
> * sk/send-pack-all-fix (2016-03-31) 1 commit
>   (merged to 'next' on 2016-04-06 at 31e1e1b)
>  + git-send-pack: fix --all option when used with directory
>
>  "git send-pack --all <there>" was broken when its command line
>  option parsing was written in the 2.6 timeframe.
>
>  Will merge to 'master'.
>
>
> * ss/msvc (2016-03-30) 2 commits
>   (merged to 'next' on 2016-04-06 at 4b53bce)
>  + MSVC: use shipped headers instead of fallback definitions
>  + MSVC: vsnprintf in Visual Studio 2015 doesn't need SNPRINTF_SIZE_CORR any more
>
>  Build updates for MSVC.
>
>  Will merge to 'master'.
>
>
> * xy/format-patch-base (2016-03-31) 4 commits
>  - format-patch: introduce format.base configuration
>  - format-patch: introduce --base=auto option
>  - format-patch: add '--base' option to record base tree info
>  - patch-ids: make commit_patch_id() a public helper function
>
>  "git format-patch" learned a new "--base" option to record what
>  (public, well-known) commit the original series was built on in
>  its output.
>
>  Will be rerolled.
>  ($gmane/290365)
>
>
> * tb/safe-crlf-output-fix (2016-04-01) 7 commits
>  . convert.c: more safer crlf handling with text attribute
>  . correct blame for files commited with CRLF
>  . convert: unify the "auto" handling of CRLF
>  . t0027: test cases for combined attributes
>  . convert: allow core.autocrlf=input and core.eol=crlf
>  . convert.c: stream and early out
>  . read-cache: factor out get_sha1_from_index() helper
>
>  The "safe CRLF" facility disables line-end conversion from CRLF to
>  LF when checking in if the blob registered to the index already
>  contains CR, but some codepaths like "git blame" did not know this,
>  and instead assumed that only the configuration and attribute
>  settings determined how the data from the working tree is converted.
>
>  Will be rerolled.
>  ($gmane/290637)
>
>
> * ak/use-hashmap-iter-first-in-submodule-config (2016-03-23) 1 commit
>   (merged to 'next' on 2016-04-06 at 2aab890)
>  + submodule-config: use hashmap_iter_first()
>
>  Minor code cleanup.
>
>  Will merge to 'master'.
>
>
> * ky/branch-d-worktree (2016-03-29) 1 commit
>   (merged to 'next' on 2016-04-06 at 00f9bff)
>  + branch -d: refuse deleting a branch which is currently checked out
>
>  When "git worktree" feature is in use, "git branch -d" allowed
>  deletion of a branch that is checked out in another worktree
>
>  Will merge to 'master'.
>
>
> * ky/branch-m-worktree (2016-04-04) 2 commits
>   (merged to 'next' on 2016-04-06 at e7b285c)
>  + branch -m: update all per-worktree HEADs
>  + refs: add a new function set_worktree_head_symref
>
>  When "git worktree" feature is in use, "git branch -m" renamed a
>  branch that is checked out in another worktree without adjusting
>  the HEAD symbolic ref for the worktree.
>
>  Will merge to 'master'.
>
>
> * nd/apply-doc (2016-03-24) 2 commits
>   (merged to 'next' on 2016-04-06 at f9bd355)
>  + git-apply.txt: mention the behavior inside a subdir
>  + git-apply.txt: remove a space
>
>  A minor documentation update.
>
>  Will merge to 'master'.
>
>
> * nd/apply-report-skip (2016-03-24) 1 commit
>   (merged to 'next' on 2016-04-06 at ae2c824)
>  + apply: report patch skipping in verbose mode
>
>  "git apply -v" learned to report paths in the patch that were
>  skipped via --include/--exclude mechanism or being outside the
>  current working directory.
>
>  Will merge to 'master'.
>
>
> * pb/opt-cmdmode-doc (2016-03-25) 1 commit
>   (merged to 'next' on 2016-04-06 at a5f3835)
>  + api-parse-options.txt: document OPT_CMDMODE()
>
>  Minor API documentation update.
>
>  Will merge to 'master'.
>
>
> * rt/completion-help (2016-03-24) 2 commits
>   (merged to 'next' on 2016-04-06 at 8c3ee08)
>  + completion: add 'revisions' and 'everyday' to 'git help'
>  + completion: add option '--guides' to 'git help'
>
>  Shell completion (in contrib/) updates.
>
>  Will merge to 'master'.
>
>
> * rt/rebase-i-shorten-stop-report (2016-03-28) 1 commit
>   (merged to 'next' on 2016-04-06 at 7a766b7)
>  + rebase-i: print an abbreviated hash when stop for editing
>
>  The commit object name reported when "rebase -i" stops has been
>  shortened.
>
>  Will merge to 'master'.
>
>
> * jk/check-repository-format (2016-03-11) 10 commits
>   (merged to 'next' on 2016-04-06 at a0dada0)
>  + verify_repository_format: mark messages for translation
>  + setup: drop repository_format_version global
>  + setup: unify repository version callbacks
>  + init: use setup.c's repo version verification
>  + setup: refactor repo format reading and verification
>  + config: drop git_config_early
>  + check_repository_format_gently: stop using git_config_early
>  + lazily load core.sharedrepository
>  + wrap shared_repository global in get/set accessors
>  + setup: document check_repository_format()
>
>  The repository set-up sequence has been streamlined (the biggest
>  change is that there is no longer git_config_early()), so that we
>  do not attempt to look into refs/* when we know we do not have a
>  Git repository.
>
>  Will merge to 'master'.
>
>
> * mj/pull-rebase-autostash (2016-04-04) 9 commits
>   (merged to 'next' on 2016-04-06 at b4e4f31)
>  + t5520: test --[no-]autostash with pull.rebase=true
>  + t5520: reduce commom lines of code
>  + t5520: factor out common "failing autostash" code
>  + t5520: factor out common "successful autostash" code
>  + t5520: use better test to check stderr output
>  + t5520: ensure consistent test conditions
>  + t5520: use consistent capitalization in test titles
>  + pull --rebase: add --[no-]autostash flag
>  + git-pull.c: introduce git_pull_config()
>
>  "git pull --rebase" learned "--[no-]autostash" option, so that
>  the rebase.autostash configuration variable set to true can be
>  overridden from the command line.
>
>  Will merge to 'master'.
>
>
> * pb/commit-verbose-config (2016-03-14) 1 commit
>   (merged to 'next' on 2016-04-06 at e5c744f)
>  + commit: add a commit.verbose config variable
>
>  "git commit" learned to pay attention to "commit.verbose"
>  configuration variable and act as if "--verbose" option was
>  given from the command line.
>
>  Will merge to 'master'.

Could you delay this a little bit. I am currently working on this.

>
> * jc/merge-refuse-new-root (2016-03-23) 1 commit
>   (merged to 'next' on 2016-04-04 at cd70fd6)
>  + merge: refuse to create too cool a merge by default
>
>  Originally merged to 'next' on 2016-03-23
>
>  "git merge" used to allow merging two branches that have no common
>  base by default, which led to a brand new history of an existing
>  project created and then get pulled by an unsuspecting maintainer,
>  which allowed an unnecessary parallel history merged into the
>  existing project.  The command has been taught not to allow this by
>  default, with an escape hatch "--allow-unrelated-histories" option
>  to be used in a rare event that merges histories of two projects
>  that started their lives independently.
>
>  Will merge to 'master'.
>
>
> * lt/pretty-expand-tabs (2016-04-04) 4 commits
>   (merged to 'next' on 2016-04-06 at 186ac2a)
>  + pretty: test --expand-tabs
>  + pretty: allow tweaking tabwidth in --expand-tabs
>  + pretty: enable --expand-tabs by default for selected pretty formats
>  + pretty: expand tabs in indented logs to make things line up properly
>
>  When "git log" shows the log message indented by 4-spaces, the
>  remainder of a line after a HT does not align in the way the author
>  originally intended.  The command now expands tabs by default in
>  such a case, and allows the users to override it with a new option,
>  '--no-expand-tabs'.
>
>  Will merge to 'master'.
>
>
> * cc/apply (2016-04-01) 4 commits
>   (merged to 'next' on 2016-04-06 at 2e23c44)
>  + builtin/apply: free patch when parse_chunk() fails
>  + builtin/apply: handle parse_binary() failure
>  + apply: remove unused call to free() in gitdiff_{old,new}name()
>  + builtin/apply: get rid of useless 'name' variable
>
>  Minor code clean-up.
>
>  Will merge to 'master'.
>
>
> * dt/index-helper (2016-03-23) 18 commits
>  - SQUASH - minimum compilation fix
>  - read-cache: config for waiting for index-helper
>  - index-helper: optionally automatically run
>  - index-helper: autorun mode
>  - index-helper: don't run if already running
>  - index-helper: kill mode
>  - unpack-trees: preserve index extensions
>  - update-index: enable/disable watchman support
>  - index-helper: use watchman to avoid refreshing index with lstat()
>  - Add watchman support to reduce index refresh cost
>  - read-cache: invalidate untracked cache data when reading WAMA
>  - read-cache: add watchman 'WAMA' extension
>  - index-helper: add --detach
>  - daemonize(): set a flag before exiting the main process
>  - index-helper: add --strict
>  - index-helper: new daemon for caching index and related stuff
>  - read-cache: allow to keep mmap'd memory after reading
>  - read-cache.c: fix constness of verify_hdr()
>
>  Needs review.
>
>
> * jc/bundle (2016-03-03) 6 commits
>  - index-pack: --clone-bundle option
>  - Merge branch 'jc/index-pack' into jc/bundle
>  - bundle v3: the beginning
>  - bundle: keep a copy of bundle file name in the in-core bundle header
>  - bundle: plug resource leak
>  - bundle doc: 'verify' is not about verifying the bundle
>
>  The beginning of "split bundle", which could be one of the
>  ingredients to allow "git clone" traffic off of the core server
>  network to CDN.
>
>
> * ad/cygwin-wants-rename (2015-08-07) 1 commit
>  - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES
>
>  Will hold.
>  ($gmane/275680).
>
>
> * jc/rerere-multi (2016-04-06) 11 commits
>  - rerere: adjust 'forget' to multi-variant world order
>  - rerere: split code to call ll_merge() further
>  - rerere: move code related to "forget" together
>  - rerere: gc and clear
>  - rerere: do use multiple variants
>  - t4200: rerere a merge with two identical conflicts
>  - rerere: allow multiple variants to exist
>  - rerere: delay the recording of preimage
>  - rerere: handle leftover rr-cache/$ID directory and postimage files
>  - rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
>  - rerere: split conflict ID further
>
>  "git rerere" can encounter two or more files with the same conflict
>  signature that have to be resolved in different ways, but there was
>  no way to record these separate resolutions.
>
>  Will merge to 'next'.
>
>
> * jc/merge-drop-old-syntax (2015-04-29) 1 commit
>  - merge: drop 'git merge <message> HEAD <commit>' syntax
>
>  Stop supporting "git merge <message> HEAD <commit>" syntax that has
>  been deprecated since October 2007, and issues a deprecation
>  warning message since v2.5.0.
>
>  It has been reported that git-gui still uses the deprecated syntax,
>  which needs to be fixed before this final step can proceed.
>  ($gmane/282594)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
