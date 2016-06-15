From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2012, #10; Thu, 26)
Date: Thu, 26 Apr 2012 13:38:13 -0700
Message-ID: <xmqqlili6xfu.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 22:38:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNVSI-0007hv-7O
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 22:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758540Ab2DZUiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 16:38:16 -0400
Received: from mail-yw0-f74.google.com ([209.85.213.74]:40940 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757178Ab2DZUiO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 16:38:14 -0400
Received: by yhgm50 with SMTP id m50so3680yhg.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 13:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:subject:x-master-at:x-next-at:date:message-id:user-agent
         :mime-version:content-type:x-gm-message-state;
        bh=4knxfqmAzGvgCAHFhBQ7kGGIbb9Fa1G7infzDymeCWs=;
        b=PyBzfHc/My6St/eFn7R3Otzz+WrK8OuM/Kg3gbM1o6js+kYahurzCdHvtLaz0hbmNy
         jBuojtrQFw/RAPkG+yps7WFWgE9uPPxfM5HdfpXyT1wDtuaYZwrK96FRus97VieGC3Te
         M9/fKyueD9DO0NM3rArl93Ou+ylebmMv4Rdwjcx2yZ1t6xmvsjAfTRlOYFNcVzVEUmjs
         snPP/20xRLGNxMofesE/Crcvf8jb0vRmHMWLAXsdyX9IXrtr+FAv0GUu20EyeqvuLrTF
         mFtTY+dtTCwlDOltP+qhdlfOsnj3cmFP4oJe4CCfqeLLoAI6TpkcHwnlWoC500pfY6kz
         dt8A==
Received: by 10.101.136.30 with SMTP id o30mr3128913ann.14.1335472694180;
        Thu, 26 Apr 2012 13:38:14 -0700 (PDT)
Received: by 10.101.136.30 with SMTP id o30mr3128904ann.14.1335472694072;
        Thu, 26 Apr 2012 13:38:14 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id a33si505507anp.2.2012.04.26.13.38.14
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 26 Apr 2012 13:38:14 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id D07E6100052;
	Thu, 26 Apr 2012 13:38:13 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 7B1E9E125C; Thu, 26 Apr 2012 13:38:13 -0700 (PDT)
X-master-at: 010b260e6f23b8964ef53b989e1c1baa8973edbe
X-next-at: 9919198d495ad46119f57aec159ea212bd584242
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlI2c+F1qb67Pj0bABFlyRqgvyVaVA+AjzF6BumtywVwsV1rvz64E1cytAcu4SA/6403varnwvoASUrwCkP/gosRKFnDR0kuEknchwY6aq6gH9IiTUxc11U7eo9oPA4BNHUjqrhcGTIcoHySBqL33oLHjU8HgmpV9KbLVR+XvuXj7/pFQk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196412>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The fifth batch of topics in this cycle is now in 'master'.  I also
merged accumulated fixes that have been in 'master' since v1.7.10 to
'maint', so that we can issue the first maintenance release sometime
next week.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* cc/fix-missing-va-end-in-revert (2012-04-21) 1 commit
  (merged to 'next' on 2012-04-23 at b90eb70)
 + revert: add missing va_end

* fc/completion-tests (2012-04-21) 7 commits
  (merged to 'next' on 2012-04-23 at 9b42326)
 + completion: fix completion after 'git --option <TAB>'
 + completion: avoid trailing space for --exec-path
 + completion: add missing general options
 + completion: simplify by using $prev
 + completion: simplify __gitcomp_1
 + tests: add tests for the __gitcomp() completion helper function
 + tests: add initial bash completion tests

* hv/submodule-recurse-push (2012-03-30) 3 commits
  (merged to 'next' on 2012-04-20 at fe99e3d)
 + push: teach --recurse-submodules the on-demand option
 + Refactor submodule push check to use string list instead of integer
 + Teach revision walking machinery to walk multiple times sequencially

"git push --recurse-submodules" learns to optionally look into the
histories of submodules bound to the superproject and push them out.

* it/fetch-pack-many-refs (2012-04-10) 4 commits
  (merged to 'next' on 2012-04-20 at e2126d7)
 + remote-curl: main test case for the OS command line overflow
 + fetch-pack: test cases for the new --stdin option
 + remote-curl: send the refs to fetch-pack on stdin
 + fetch-pack: new --stdin option to read refs from stdin

When "git fetch" encounters repositories with too many references, the
command line of "fetch-pack" that is run by a helper e.g. remote-curl,
may fail to hold all of them. Now such an internal invocation can feed
the references through the standard input of "fetch-pack".

* jm/maint-strncpy-diff-no-index (2012-04-16) 1 commit
  (merged to 'next' on 2012-04-20 at 638ed9f)
 + diff: avoid stack-buffer-read-overrun for very long name

* mb/fetch-call-a-non-branch-a-ref (2012-04-17) 2 commits
  (merged to 'next' on 2012-04-20 at df2c57e)
 + fetch: describe new refs based on where it came from
 + fetch: Give remote_ref to update_local_ref() as well

* mh/ref-api (2012-04-10) 13 commits
  (merged to 'next' on 2012-04-20 at 94e9384)
 + do_for_each_ref(): only iterate over the subtree that was requested
 + refs: store references hierarchically
 + sort_ref_dir(): simplify logic
 + refs.c: rename ref_array -> ref_dir
 + struct ref_entry: nest the value part in a union
 + check_refname_component(): return 0 for zero-length components
 + free_ref_entry(): new function
 + names_conflict(): simplify implementation
 + repack_without_ref(): reimplement using do_for_each_ref_in_array()
 + do_for_each_ref_in_arrays(): new function
 + do_for_each_ref_in_array(): new function
 + refs: manage current_ref within do_one_ref()
 + refs.c: reorder definitions more logically

* mk/gitweb-diff-hl (2012-04-11) 8 commits
  (merged to 'next' on 2012-04-20 at 54179a2)
 + gitweb: Refinement highlightning in combined diffs
 + gitweb: Highlight interesting parts of diff
 + gitweb: Push formatting diff lines to print_diff_chunk()
 + gitweb: Use print_diff_chunk() for both side-by-side and inline diffs
 + gitweb: Extract print_sidebyside_diff_lines()
 + gitweb: Pass esc_html_hl_regions() options to esc_html()
 + gitweb: esc_html_hl_regions(): Don't create empty <span> elements
 + gitweb: Use descriptive names in esc_html_hl_regions()

"gitweb" learns to highlight the patch it outputs even more.

* pw/fast-import-dataref-parsing (2012-04-10) 1 commit
  (merged to 'next' on 2012-04-20 at c299a63)
 + fast-import: tighten parsing of datarefs

The parser in "fast-import" did not diagnose ":9" style references
that is not followed by required SP/LF as an error.

* rl/maint-stash-i18n-save-error (2012-04-14) 1 commit
  (merged to 'next' on 2012-04-23 at 3692fec)
 + stash: use eval_gettextln correctly

* zj/upstream-error-message (2012-04-15) 5 commits
  (merged to 'next' on 2012-04-20 at 1ed9682)
 + i18n: mark @{upstream} error messages for translation
 + Be more specific if upstream branch is not tracked
 + Provide better message for barnhc_wiht_tpyo@{u}
 + Provide branch name in error message when using @{u}
 + t1507: add tests to document @{upstream} behaviour

Error messages given when @{u} is used for a branch without its
upstream configured have been clatified.

--------------------------------------------------
[New Topics]

* mm/simple-push (2012-04-24) 7 commits
 - push.default doc: explain simple after upstream
 - push: document the future default change for push.default (matching -> simple)
 - t5570: use explicit push refspec
 - push: introduce new push.default mode "simple"
 - t5528-push-default.sh: add helper functions
 - Undocument deprecated alias 'push.default=tracking'
 - Documentation: explain push.default option a bit more
 (this branch is used by mm/push-default-switch-warning.)

New users tend to work on one branch at a time and push the result
out. The current and upstream modes of push is a more suitable default
mode than matching mode for these people, but neither is surprise-free
depending on how the project is set up. Introduce a "simple" mode that
is a subset of "upstream" but only works when the branch is named the same
between the remote and local repositories.

The plan is to make it the new default when push.default is not
configured.

* mh/ref-api-lazy-loose (2012-04-25) 30 commits
 - refs: read loose references lazily
 - create_dir_entry(): allow the flag value to be passed as an argument
 - read_loose_refs(): access ref_cache via the ref_dir field
 - read_loose_refs(): rename function from get_ref_dir()
 - struct ref_dir: store a reference to the enclosing ref_cache
 - sort_ref_dir(): take (ref_entry *) instead of (ref_dir *)
 - do_for_each_ref_in_dir(): take (ref_entry *) instead of (ref_dir *)
 - do_for_each_ref_in_dirs(): take (ref_entry *) instead of (ref_dir *)
 - add_entry(): take (ref_entry *) instead of (ref_dir *)
 - search_ref_dir(): take (ref_entry *) instead of (ref_dir *)
 - search_for_subdir(): take (ref_entry *) instead of (ref_dir *)
 - get_ref_dir(): remove dirname argument
 - get_ref_dir(): take (ref_entry *) instead of (ref_dir *)
 - find_containing_direntry(): use (ref_entry *) instead of (ref_dir *)
 - add_ref(): take (ref_entry *) instead of (ref_dir *)
 - read_packed_refs(): take (ref_entry *) instead of (ref_dir *)
 - find_ref(): take (ref_entry *) instead of (ref_dir *)
 - is_refname_available(): take (ref_entry *) instead of (ref_dir *)
 - get_loose_refs(): return (ref_entry *) instead of (ref_dir *)
 - get_packed_refs(): return (ref_entry *) instead of (ref_dir *)
 - refs: wrap top-level ref_dirs in ref_entries
 - do_for_each_reflog(): reuse strbuf across recursive function calls
 - do_for_each_reflog(): use a strbuf to hold logfile name
 - do_for_each_reflog(): return early on error
 - get_ref_dir(): take the containing directory as argument
 - refs.c: extract function search_for_subdir()
 - get_ref_dir(): require that the dirname argument ends in '/'
 - get_ref_dir(): rename "base" parameter to "dirname"
 - get_ref_dir(): use a strbuf to hold refname
 - get_ref_dir(): return early if directory cannot be read

Refs API is updated to lazily read sub-hierarchies of refs/ namespace,
so that we do not have to grab everything from the filesystem when we
are only interested in listing branches, for example.

* mm/include-userpath (2012-04-25) 2 commits
  (merged to 'next' on 2012-04-26 at c68e261)
 + fixup! config: expand tildes in include.path variable
 + config: expand tildes in include.path variable

The new "include.path" directive in the configuration files learned
to understand "~/path" and "~user/path".

* rs/commit-list-append (2012-04-25) 3 commits
  (merged to 'next' on 2012-04-26 at 2ba48b3)
 + commit: remove commit_list_reverse()
 + revision: append to list instead of insert and reverse
 + sequencer: export commit_list_append()

* jk/maint-config-bogus-section (2012-04-25) 1 commit
  (merged to 'next' on 2012-04-26 at 9919198)
 + config: reject bogus section names for --rename-section

"git config --rename-section" to rename an existing section into a
bogus one did not check the new name.

* kk/maint-gitweb-missing-owner (2012-04-25) 1 commit
 - gitweb: Don't set owner if got empty value from projects.list
 (this branch is used by kk/gitweb-omit-expensive.)

Will merge to 'next'.

* jk/doc-asciidoc-inline-literal (2012-04-26) 1 commit
 - docs: stop using asciidoc no-inline-literal

Our documentation was written for an ancient version of AsciiDoc,
making the source not very readable.

* kk/gitweb-omit-expensive (2012-04-26) 2 commits
 - gitweb: Option to not display information about owner
 - gitweb: Option to omit column with time of the last change
 (this branch uses kk/maint-gitweb-missing-owner.)

"gitweb" learned to optionally omit output of fields that are expensive
to generate.

Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jc/split-blob (2012-04-03) 7 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - packfile: use varint functions
 + varint: make it available outside the context of pack
 (this branch is tangled with jc/index-v4.)

Not ready.

I finished the streaming checkout codepath, but as explained in
127b177 (bulk-checkin: support chunked-object encoding, 2011-11-30),
these are still early steps of a long and painful journey. At least
pack-objects and fsck need to learn the new encoding for the series
to be usable locally, and then index-pack/unpack-objects needs to
learn it to be used remotely.

Given that I heard a lot of noise that people want large files, and
that I was asked by somebody at GitTogether'11 privately for an
advice on how to pay developers (not me) to help adding necessary
support, I am somewhat dissapointed that the original patch series
that was sent almost two months ago still remains here without much
comments and updates from the developer community. I even made the
interface to the logic that decides where to split chunks easily
replaceable, and I deliberately made the logic in the original patch
extremely stupid to entice others, especially the "bup" fanboys, to
come up with a better logic, thinking that giving people an easy
target to shoot for, they may be encouraged to help out. The plan is
not working :-(.

--------------------------------------------------
[Cooking]

* pw/t5800-import-race-fix (2012-04-24) 1 commit
  (merged to 'next' on 2012-04-24 at e97bb42)
 + git-remote-testgit: fix race when spawning fast-import

Longstanding bug in a test scaffolding that occasionally made t5800
hang was fixed.

* nd/i18n (2012-04-25) 11 commits
 - help: replace underlining "help -a" headers using hyphens with a blank line
  (merged to 'next' on 2012-04-24 at 07965a4)
 + i18n: bundle: mark strings for translation
 + i18n: index-pack: mark strings for translation
 + i18n: apply: update say_patch_name to give translators complete sentence
 + i18n: apply: mark strings for translation
 + i18n: remote: mark strings for translation
 + i18n: make warn_dangling_symref() automatically append \n
 + i18n: help: mark strings for translation
 + i18n: mark relative dates for translation
 + strbuf: convenience format functions with \n automatically appended
 + Makefile: feed all header files to xgettext

More message strings marked for i18n.

* nh/empty-rebase (2012-04-24) 4 commits
  (merged to 'next' on 2012-04-24 at 91d2dfd)
 + git-rebase: add keep_empty flag
 + git-cherry-pick: Add test to validate new options
 + git-cherry-pick: Add keep-redundant-commits option
 + git-cherry-pick: add allow-empty option

"git rebase" learned to optionally keep commits that do not introduce
any change in the original history.

* rt/cherry-revert-conflict-summary (2012-04-19) 1 commit
  (merged to 'next' on 2012-04-23 at e7766c2)
 + sequencer: remove additional blank line

In the older days, the header "Conflicts:" in "cherry-pick" and
"merge" was separated by a blank line from the list of paths that
follow for readability, but when "merge" was rewritten in C, we lost
it by mistake. Remove the newline from "cherry-pick" to make them
match again.

Will merge to 'master'.

* js/fast-import-test-9300 (2012-04-20) 1 commit
  (merged to 'next' on 2012-04-23 at a9bd236)
 + t9300-fast-import: avoid 'exit' in test_expect_success snippets

Will merge to 'master'.

* lp/diffstat-with-graph (2012-04-18) 6 commits
  (merged to 'next' on 2012-04-23 at 8de0747)
 + Prevent graph_width of stat width from falling below min
 + t4052: Test diff-stat output with minimum columns
 + t4052: Adjust --graph --stat output for prefixes
 + Adjust stat width calculations to take --graph output into account
 + Add output_prefix_length to diff_options
 + t4052: test --stat output with --graph

Looked reasonable.
Will merge to 'master'.

* jc/merge-reduce-parents-early (2012-04-18) 5 commits
  (merged to 'next' on 2012-04-23 at 16e7e53)
 + fmt-merge-msg: discard needless merge parents
 + builtin/merge.c: reduce parents early
 + builtin/merge.c: collect other parents early
 + builtin/merge.c: remove "remoteheads" global variable
 + merge tests: octopus with redundant parents

Will merge to 'master'.

* cb/cherry-pick-rev-path-confusion (2012-04-15) 1 commit
  (merged to 'next' on 2012-04-23 at f872ba5)
 + cherry-pick: do not expect file arguments

The command line parser choked "git cherry-pick $name" when $name can be
both revision name and a pathname, even though $name can never be a path
in the context of the command.

The issue the patch addresses is real, but the way it is implemented felt
unnecessarily invasive a bit.  It may be cleaner for this caller to add
the "--" to the end of the argv_array it passes to setup_revisions().

Will merge to 'master'.

* cb/daemon-test-race-fix (2012-04-19) 1 commit
  (merged to 'next' on 2012-04-24 at d5c30be)
 + git-daemon wrapper to wait until daemon is ready

Fix race condition between starting and waiting for git-daemon in the
test.

* cb/maint-report-mount-point-correctly-in-setup (2012-04-15) 1 commit
  (merged to 'next' on 2012-04-23 at 9e0c8b4)
 + properly keep track of current working directory

The filesystem boundary was not correctly reported when .git directory
discovery stopped at a mount point.

Will merge to 'master'.

* nd/columns (2012-04-20) 9 commits
 - tag: add --column
 - column: support piping stdout to external git-column process
 - status: add --column
 - branch: add --column
 - help: reuse print_columns() for help -a
 - column: add dense layout support
 - column: add columnar layout
 - Stop starting pager recursively
 - Add column layout skeleton and git-column

A couple of commands learn --column option to produce columnar output.

* nl/http-proxy-more (2012-04-26) 8 commits
 - http: try an uppercase version of $proto_proxy
 - http: fix proxy password passing
 - http: fix proxy authentication
 - http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
 - http: Avoid limit of retrying request only twice
 - http: handle proxy authentication failure (error 407)
 - http: handle proxy proactive authentication
 - http: try http_proxy env var when http.proxy config option is not set

The code to talk to http proxies learn to use the same credential
API used to talk to the final http destinations.  This still needs
to peek into $ENV{HTTPS_PROXY}.

* jk/repack-no-explode-objects-from-old-pack (2012-04-18) 4 commits
  (merged to 'next' on 2012-04-20 at 4eb2534)
 + gc: use argv-array for sub-commands
 + argv-array: add a new "pushl" method
 + argv-array: refactor empty_argv initialization
  (merged to 'next' on 2012-04-15 at 7586e50)
 + gc: do not explode objects which will be immediately pruned

* ld/git-p4-tags-and-labels (2012-04-25) 7 commits
  (merged to 'next' on 2012-04-25 at 8b959e5)
 + git p4: fix unit tests
  (merged to 'next' on 2012-04-24 at bf55d92)
 + git p4: move verbose to base class
 + git p4: Ignore P4EDITOR if it is empty
 + git p4: Squash P4EDITOR in test harness
 + git p4: fix-up "import/export of labels to/from p4"
  (merged to 'next' on 2012-04-15 at 1b1e9a1)
 + git p4: import/export of labels to/from p4
 + git p4: Fixing script editor checks

* nd/threaded-index-pack (2012-04-19) 4 commits
 - index-pack: disable threading if NO_PREAD is defined
 - index-pack: support multithreaded delta resolving
 - index-pack: split second pass obj handling into own function
 - compat/win32/pthread.h: Add an pthread_key_delete() implementation

* cb/http-multi-curl-auth (2012-04-14) 4 commits
  (merged to 'next' on 2012-04-23 at b0259be)
 + http: use newer curl options for setting credentials
 + http: clean up leak in init_curl_http_auth
 + fix http auth with multiple curl handles
 + http auth fails with multiple curl handles

Fixes http authentication breakage when we keep multiple HTTP requests in
flight using curl-multi.

Will merge to 'master'.

* tr/xdiff-fast-hash (2012-04-09) 1 commit
  (merged to 'next' on 2012-04-24 at ed693cf)
 + xdiff: load full words in the inner loop of xdl_hash_record

* jc/index-v4 (2012-04-04) 10 commits
  (merged to 'next' on 2012-04-19 at 5e4b029)
 + update-index: upgrade/downgrade on-disk index version
 + read-cache.c: write prefix-compressed names in the index
 + read-cache.c: read prefix-compressed names in index on-disk version v4
 + read-cache.c: move code to copy incore to ondisk cache to a helper function
 + read-cache.c: move code to copy ondisk to incore cache to a helper function
 + read-cache.c: report the header version we do not understand
 + read-cache.c: make create_from_disk() report number of bytes it consumed
 + read-cache.c: allow unaligned mapping of the index file
 + cache.h: hide on-disk index details
 + varint: make it available outside the context of pack
 (this branch is tangled with jc/split-blob.)

Trivially shrinks the on-disk size of the index file to save both I/O and
checksum overhead.  The "v4" format represented here may not be what we
eventually want to have, but the preparatory refactoring steps and the way
how backward compatibility is retained should give plenty to learn to GSoC
student-hopefuls.

The bottom one makes use of "varint" encoding from the stalled
jc/split-blob topic.

* th/difftool-diffall (2012-04-23) 8 commits
 - difftool: print list of valid tools with '--tool-help'
 - difftool: teach difftool to handle directory diffs
 - difftool: eliminate setup_environment function
 - difftool: stop appending '.exe' to git
 - difftool: remove explicit change of PATH
 - difftool: exit(0) when usage is printed
 - difftool: add '--no-gui' option
 - difftool: parse options using Getopt::Long

Rolls the two-directory-diff logic from diffall script (in contrib/) into
"git difftool" framework. 

Still being reworked.

* jc/run-hook-env-1 (2012-03-11) 1 commit
 - run_hook(): enhance the interface to pass arbitrary environment

Not urgent.

Updates run_hook() API to be much less specific to "commit".  It would
only be useful if people start doing more interesting things with hooks.

* mm/push-default-switch-warning (2012-04-26) 2 commits
 - t5541: warning message is given even with --quiet
 - push: start warning upcoming default change for push.default
 (this branch uses mm/simple-push.)
