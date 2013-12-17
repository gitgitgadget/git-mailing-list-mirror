From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2013, #04; Tue, 17)
Date: Tue, 17 Dec 2013 15:57:56 -0800
Message-ID: <xmqqbo0fkp2z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 00:58:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt4We-00031T-Dx
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 00:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020Ab3LQX6D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Dec 2013 18:58:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448Ab3LQX57 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Dec 2013 18:57:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31AB05CA55;
	Tue, 17 Dec 2013 18:57:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=sgOwf4bOEXZm2Ple78s8CiDKJ
	ss=; b=nNlqFMlWjZ8AVpXsx+5h+NQK8+UUnt6w0lq5DBTE8pKuAiJUrK1ykztSW
	k0kV/HImwAxFCVDt2aG68uojGrneGu+YaDGkuoKxx0/i4FF5gWMsFoeAbHUy28Ts
	oWGNZRFDn5TUJMEjJ+ey2QWWehZ+GVqaqZxN9WXxjCHczX5+FA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=NG70z/MjAOJlgP9cZpI
	HqmRJz/dzIMPq7nnyAC17rkKEMNnofSGvzvTw6fCiN21svx8FRL5EUTlr0S7lOr4
	+09o1tLAm2hS9exV4We3jQVeUza+vk/sEmU9jjbBZ0ylpmXefMWwVhSS7WIfdqse
	vdPbDxb8nW8kz/zyccJChdoE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DEE25CA54;
	Tue, 17 Dec 2013 18:57:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25C085CA52;
	Tue, 17 Dec 2013 18:57:58 -0500 (EST)
X-master-at: 7794a680e63a2a11b73cb1194653662f2769a792
X-next-at: 3e57c29e689448252d8f77d1a49492e7b4cdbfa4
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0DCDE580-6777-11E3-B756-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239413>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/doc-merge-no-op-revert (2013-12-09) 1 commit
  (merged to 'next' on 2013-12-13 at 6e0ce64)
 + Documentation: document pitfalls with 3-way merge


* cc/starts-n-ends-with (2013-12-05) 4 commits
  (merged to 'next' on 2013-12-12 at 76ee567)
 + replace {pre,suf}fixcmp() with {starts,ends}_with()
 + strbuf: introduce starts_with() and ends_with()
 + builtin/remote: remove postfixcmp() and use suffixcmp() instead
 + environment: normalize use of prefixcmp() by removing " !=3D 0"
 (this branch is used by cc/starts-n-ends-with-endgame.)

 Remove a few duplicate implementations of prefix/suffix comparison
 functions, and rename them to starts_with and ends_with.


* fc/trivial (2013-12-09) 4 commits
  (merged to 'next' on 2013-12-13 at eeead16)
 + remote: fix status with branch...rebase=3Dpreserve
 + fetch: add missing documentation
 + t: trivial whitespace cleanups
 + abspath: trivial style fix


* jk/t5000-gzip-simplify (2013-12-04) 1 commit
  (merged to 'next' on 2013-12-09 at e9010f1)
 + t5000: simplify gzip prerequisite checks

 Test fix.


* jl/commit-v-strip-marker (2013-12-05) 1 commit
  (merged to 'next' on 2013-12-09 at 2b85e9e)
 + commit -v: strip diffs and submodule shortlogs from the commit messa=
ge

 "git commit -v" appends the patch to the log message before
 editing, and then removed the patch when the editor returned
 control. However, the patch was not stripped correctly when the
 first modified path was a submodule.


* kb/doc-exclude-directory-semantics (2013-12-09) 1 commit
  (merged to 'next' on 2013-12-09 at e54b2ec)
 + gitignore.txt: clarify recursive nature of excluded directories


* kn/gitweb-extra-branch-refs (2013-12-12) 4 commits
  (merged to 'next' on 2013-12-12 at ae75b02)
 + gitweb: Denote non-heads, non-remotes branches
 + gitweb: Add a feature for adding more branch refs
 + gitweb: Return 1 on validation success instead of passed input
 + gitweb: Move check-ref-format code into separate function

 Allow gitweb to be configured to show refs out of refs/heads/ as if
 they were branches.


* mm/mv-file-to-no-such-dir-with-slash (2013-12-04) 1 commit
  (merged to 'next' on 2013-12-09 at f33bc0b)
 + mv: let 'git mv file no-such-dir/' error out


* nd/gettext-vsnprintf (2013-12-04) 1 commit
  (merged to 'next' on 2013-12-09 at e99106e)
 + gettext.c: detect the vsnprintf bug at runtime


* nd/remove-opt-boolean (2013-12-09) 1 commit
  (merged to 'next' on 2013-12-13 at 26f46cc)
 + parse-options: remove OPT_BOOLEAN


* nd/transport-positive-depth-only (2013-12-06) 1 commit
  (merged to 'next' on 2013-12-12 at f953cb8)
 + clone,fetch: catch non positive --depth option value

 "git fetch --depth=3D0" was a no-op, and was silently
 ignored. Diagnose it as an error.


* tb/clone-ssh-with-colon-for-port (2013-12-09) 10 commits
  (merged to 'next' on 2013-12-12 at ae4ae39)
 + git_connect(): use common return point
 + connect.c: refactor url parsing
 + git_connect(): refactor the port handling for ssh
 + git fetch: support host:/~repo
 + t5500: add test cases for diag-url
 + git fetch-pack: add --diag-url
 + git_connect: factor out discovery of the protocol and its parts
 + git_connect: remove artificial limit of a remote command
 + t5601: add tests for ssh
 + t5601: remove clear_ssh, refactor setup_ssh_wrapper

 Be more careful when parsing remote repository URL given in the
 scp-style host:path notation.


* tr/send-email-ssl (2013-12-04) 3 commits
  (merged to 'next' on 2013-12-09 at facb859)
 + send-email: set SSL options through IO::Socket::SSL::set_client_defa=
ults
 + send-email: --smtp-ssl-cert-path takes an argument
 + send-email: pass Debug to Net::SMTP::SSL::new

 SSL-related options were not passed correctly to underlying socket
 layer in "git send-email".

--------------------------------------------------
[New Topics]

* ap/path-max (2013-12-16) 1 commit
 - Prevent buffer overflows when path is too long

 Will merge to 'next'.


* mh/path-max (2013-12-17) 1 commit
 - prune-packed: use strbuf to avoid having to worry about PATH_MAX

 This is my rewrite of Michael's patch to prune-packed (which still
 had a hardcoded PATH_MAX limitation) using strbuf. Tweaking of the
 other patch in the same series ($gmane/239386) for prune is left as
 an exercise to the readers ;-)

--------------------------------------------------
[Stalled]

* mo/subtree-split-updates (2013-12-10) 3 commits
 - subtree: add --edit option
 - subtree: allow --squash and --message with push
 - subtree: support split --rejoin --squash

 Comments?


* hv/submodule-ignore-fix (2013-12-06) 4 commits
 - disable complete ignorance of submodules for index <-> HEAD diff
 - always show committed submodules in summary after commit
 - teach add -f option for ignored submodules
 - fix 'git add' to skip submodules configured as ignored

 Teach "git add" to be consistent with "git status" when changes to
 submodules are set to be ignored, to avoid surprises after checking
 with "git status" to see there isn't any change to be further added
 and then see that "git add ." adds changes to them.

 I think a reroll is coming, so this may need to be replaced, but I
 needed some practice with heavy conflict resolution.  It conflicts
 with two changes to "git add" that have been scheduled for Git 2.0
 quite badly, and I think I got the resolution right this time (a
 few nights ago I tried and failed and that was why it hasn't been
 merged to 'pu' so far).


* kb/fast-hashmap (2013-12-16) 17 commits
 - hashmap.h: make sure map entries are tightly packed
  (merged to 'next' on 2013-12-16 at bff99b1)
 + Drop unnecessary #includes from test-hashmap
 + Add test-hashmap to .gitignore
  (merged to 'next' on 2013-12-06 at f90be3d)
 + read-cache.c: fix memory leaks caused by removed cache entries
 + builtin/update-index.c: cleanup update_one
 + fix 'git update-index --verbose --again' output
 + remove old hash.[ch] implementation
 + name-hash.c: remove cache entries instead of marking them CE_UNHASHE=
D
 + name-hash.c: use new hash map implementation for cache entries
 + name-hash.c: remove unreferenced directory entries
 + name-hash.c: use new hash map implementation for directories
 + diffcore-rename.c: use new hash map implementation
 + diffcore-rename.c: simplify finding exact renames
 + diffcore-rename.c: move code around to prepare for the next patch
 + buitin/describe.c: use new hash map implementation
 + add a hashtable implementation that supports O(1) removal
 + submodule: don't access the .gitmodules cache entry after removing i=
t

 Improvements to our hash table to get it to meet the needs of the
 msysgit fscache project, with some nice performance improvements.

 The tip one does not seem to have reached concensus (yet).


* jc/create-directories-microopt (2013-11-11) 1 commit
 - checkout: most of the time we have good leading directories

 Of unknown value until tested on non-Linux platforms (especially
 Windows).

 Will hold.


* jt/commit-fixes-footer (2013-10-30) 1 commit
 - commit: Add -f, --fixes <commit> option to add Fixes: line

 There is an ongoing discussion around this topic; in general I am
 fairly negative on a new feature that is too narrow and prefer a
 more generic solution that can be tailored for specific needs, as
 many people stated in the thread.

 It appears that the discussion stalled.


* np/pack-v4 (2013-09-18) 90 commits
 . packv4-parse.c: add tree offset caching
 . t1050: replace one instance of show-index with verify-pack
 . index-pack, pack-objects: allow creating .idx v2 with .pack v4
 . unpack-objects: decode v4 trees
 . unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.

 Temporarily ejected from 'pu', to try out jk/pack-bitmap, which
 this topic conflicts with.


* jk/pack-bitmap (2013-11-18) 22 commits
 - compat/mingw.h: Fix the MinGW and msvc builds
 - pack-bitmap: implement optional name_hash cache
 - t/perf: add tests for pack bitmaps
 - t: add basic bitmap functionality tests
 - count-objects: recognize .bitmap in garbage-checking
 - repack: consider bitmaps when performing repacks
 - repack: handle optional files created by pack-objects
 - repack: turn exts array into array-of-struct
 - repack: stop using magic number for ARRAY_SIZE(exts)
 - pack-objects: implement bitmap writing
 - rev-list: add bitmap mode to speed up object lists
 - pack-objects: use bitmaps when packing objects
 - pack-bitmap: add support for bitmap indexes
 - documentation: add documentation for the bitmap format
 - ewah: compressed bitmap implementation
 - compat: add endianness helpers
 - sha1_file: export `git_open_noatime`
 - revision: allow setting custom limiter function
 - pack-objects: factor out name_hash
 - pack-objects: refactor the packing list
 - revindex: export new APIs
 + sha1write: make buffer const-correct
 (this branch is tangled with jk/name-pack-after-byte-representation.)

 Borrows the bitmap index into packfiles from JGit to speed up
 enumeration of objects involved in a commit range without having to
 fully traverse the history.

 A reroll forthcoming?


* mf/graph-show-root (2013-10-25) 1 commit
 . graph.c: mark root commit differently

 In a repository with multiple-roots, "log --graph", especially with
 "--oneline", does not give the reader enough visual cue to see
 where one line of history ended and a separate history began.

 This is the version that marks the roots 'x' when they would have
 been marked as '*'; Keshav Kini suggested an alternative of giving
 an extra blank line after every root, which I tend to think is a
 better approach to the problem.


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Holding until needed.


* yt/shortened-rename (2013-10-18) 2 commits
 - SQUASH??? style fixes and s/omit/shorten/ where appropriate
 - diff.c: keep arrow(=3D>) on show_stats()'s shortened filename part t=
o make rename visible

 Attempts to give more weight on the fact that a filepair represents
 a rename than showing substring of the actual path when diffstat
 lines are not wide enough.

 I am not sure if that is solving a right problem, though.


* rv/send-email-cache-generated-mid (2013-08-21) 2 commits
 - git-send-email: Cache generated message-ids, use them when prompting
 - git-send-email: add optional 'choices' parameter to the ask sub


* rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
 - ### DONTMERGE: needs better explanation on what config they need
 - pack-refs.c: Add missing call to git_config()
 - show-ref.c: Add missing call to git_config()

 The changes themselves are probably good, but it is unclear what
 basic setting needs to be read for which exact operation.

 Waiting for clarification.
 $gmane/228294


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=3D(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff=
_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this.
 $gmane/226216


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary widt=
h
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it ou=
t.

--------------------------------------------------
[Cooking]

* nv/commit-gpgsign-config (2013-12-17) 3 commits
 - test the commit.gpgsign config option
 - commit-tree: add and document --no-gpg-sign
 - Add the commit.gpgsign option to sign all commits

 Introduce commit.gpgsign configuration variable to force every
 commit to be GPG signed.  The variable cannot be overriden from the
 command line of some of the commands that create commits except for
 "git commit" and "git commit-tree", but I am not convinced that it
 is a good idea to sprinkle support for --no-gpg-sign everywhere.

 Will merge to 'next'.


* cc/replace-object-info (2013-12-12) 10 commits
  (merged to 'next' on 2013-12-17 at aeb9e18)
 + Documentation/git-replace: describe --format option
 + builtin/replace: unset read_replace_refs
 + t6050: add tests for listing with --format
 + builtin/replace: teach listing using short, medium or full formats
 + sha1_file: perform object replacement in sha1_object_info_extended()
 + t6050: show that git cat-file --batch fails with replace objects
 + sha1_object_info_extended(): add an "unsigned flags" parameter
 + sha1_file.c: add lookup_replace_object_extended() to pass flags
 + replace_object: don't check read_replace_refs twice
 + rename READ_SHA1_FILE_REPLACE flag to LOOKUP_REPLACE_OBJECT

 read_sha1_file() that is the workhorse to read the contents given
 an object name honoured object replacements, but there is no
 corresponding mechanism to sha1_object_info() that is used to
 obtain the metainfo (e.g. type & size) about the object, leading
 callers to weird inconsistencies.

 Has this been reviewed sufficiently?

 Will merge to 'next'.


* fc/completion (2013-12-09) 1 commit
 - completion: fix completion of certain aliases

 SZEDER G=C3=A1bor noticed that this breaks "git -c var=3Dval alias" an=
d
 also suggested a better description of the change.

 Will hold.


* fc/remote-helper-fixes (2013-12-09) 4 commits
  (merged to 'next' on 2013-12-17 at aa4dc07)
 + remote-hg: add tests for special filenames
 + remote-hg: fix 'shared path' path
 + remote-helpers: add extra safety checks
 + remote-hg: avoid buggy strftime()

 Expecting follow-up test additions.


* jk/cat-file-regression-fix (2013-12-12) 2 commits
  (merged to 'next' on 2013-12-13 at 3713e01)
 + cat-file: handle --batch format with missing type/size
 + cat-file: pass expand_data to print_object_or_die

 "git cat-file --batch=3D", an admittedly useless command, did not
 behave very well.

 Will merge to 'master'.


* jk/pull-rebase-using-fork-point (2013-12-10) 2 commits
  (merged to 'next' on 2013-12-13 at 1862c12)
 + rebase: use reflog to find common base with upstream
 + pull: use merge-base --fork-point when appropriate

 Will merge to 'master'.


* jk/rev-parse-double-dashes (2013-12-09) 2 commits
  (merged to 'next' on 2013-12-13 at d26bac7)
 + rev-parse: be more careful with munging arguments
 + rev-parse: correctly diagnose revision errors before "--"

 "git rev-parse <revs> -- <paths>" did not implement the usual
 disambiguation rules the commands in the "git log" family used in
 the same way.

 Will merge to 'master'.


* nd/shallow-clone (2013-12-10) 28 commits
 - git-clone.txt: remove shallow clone limitations
 - prune: clean .git/shallow after pruning objects
 - clone: use git protocol for cloning shallow repo locally
 - send-pack: support pushing from a shallow clone via http
 - receive-pack: support pushing to a shallow clone via http
 - smart-http: support shallow fetch/clone
 - remote-curl: pass ref SHA-1 to fetch-pack as well
 - send-pack: support pushing to a shallow clone
 - receive-pack: allow pushes that update .git/shallow
 - connected.c: add new variant that runs with --shallow-file
 - add GIT_SHALLOW_FILE to propagate --shallow-file to subprocesses
 - receive/send-pack: support pushing from a shallow clone
 - receive-pack: reorder some code in unpack()
 - fetch: add --update-shallow to accept refs that update .git/shallow
 - upload-pack: make sure deepening preserves shallow roots
 - fetch: support fetching from a shallow repository
 - clone: support remote shallow repository
 - fetch-pack.h: one statement per bitfield declaration
 - fetch-pack.c: move shallow update code out of fetch_pack()
 - shallow.c: steps 6 and 7 to select new commits for .git/shallow
 - shallow.c: the 8 steps to select new commits for .git/shallow
 - shallow.c: extend setup_*_shallow() to accept extra shallow commits
 - connect.c: teach get_remote_heads to parse "shallow" lines
 - make the sender advertise shallow commits to the receiver
 - clone: prevent --reference to a shallow repository
 - send-pack: forbid pushing from a shallow repository
 - remote.h: replace struct extra_have_objects with struct sha1_array
 - transport.h: remove send_pack prototype, already defined in send-pac=
k.h

 Fetching from a shallow-cloned repository used to be forbidden,
 primarily because the codepaths involved were not carefully vetted
 and we did not bother supporting such usage. This attempts to allow
 object transfer out of a shallow-cloned repository in a controlled
 way (i.e. the receiver become a shallow repository with truncated
 history).

 Will merge to 'next'.


* tg/diff-no-index-refactor (2013-12-16) 4 commits
  (merged to 'next' on 2013-12-17 at 009d8d8)
 + diff: avoid some nesting
 + diff: add test for --no-index executed outside repo
  (merged to 'next' on 2013-12-13 at 523f7c4)
 + diff: don't read index when --no-index is given
 + diff: move no-index detection to builtin/diff.c

 "git diff ../else/where/A ../else/where/B" when ../else/where is
 clearly outside the repository, and "git diff --no-index A B", do
 not have to look at the index at all, but we used to read the index
 unconditionally.

 Will merge to 'master'.


* fc/transport-helper-fixes (2013-12-09) 6 commits
 - remote-bzr: support the new 'force' option
 - test-hg.sh: tests are now expected to pass
 - transport-helper: check for 'forced update' message
 - transport-helper: add 'force' to 'export' helpers
 - transport-helper: don't update refs in dry-run
 - transport-helper: mismerge fix

 Updates transport-helper, fast-import and fast-export to allow the
 ref mapping and ref deletion in a way similar to the natively
 supported transports.

 Will hold. Reported to break t5541.


* jn/git-gui-chmod+x (2013-11-25) 1 commit
 - git-gui: chmod +x po2msg, windows/git-gui.sh

 Parked here until I get the same change back from the upstream
 git-gui tree.


* jn/gitk-chmod+x (2013-11-25) 1 commit
 - gitk: chmod +x po2msg

 Parked here until I get the same change back from the upstream gitk
 tree.


* jk/name-pack-after-byte-representation (2013-12-16) 3 commits
  (merged to 'next' on 2013-12-17 at 0bc385c)
 + pack-objects doc: treat output filename as opaque
  (merged to 'next' on 2013-12-09 at 247b2d0)
 + pack-objects: name pack files after trailer hash
 + sha1write: make buffer const-correct
 (this branch is tangled with jk/pack-bitmap.)

 Two packfiles that contain the same set of objects have
 traditionally been named identically, but that made repacking a
 repository that is already fully packed without any cruft with a
 different packing parameter cumbersome. Update the convention to
 name the packfile after the bytestream representation of the data,
 not after the set of objects in it.

 Will merge to 'master'.


* nd/negative-pathspec (2013-12-06) 3 commits
  (merged to 'next' on 2013-12-12 at 9f340c8)
 + pathspec.c: support adding prefix magic to a pathspec with mnemonic =
magic
 + Support pathspec magic :(exclude) and its short form :!
 + glossary-content.txt: rephrase magic signature part

 Introduce "negative pathspec" magic, to allow "git log -- . ':!dir'" t=
o
 tell us "I am interested in everything but 'dir' directory".

 Will cook in 'next'.


* zk/difftool-counts (2013-12-16) 2 commits
  (merged to 'next' on 2013-12-16 at 0e0d235)
 + diff.c: fix some recent whitespace style violations
  (merged to 'next' on 2013-12-12 at ba35694)
 + difftool: display the number of files in the diff queue in the promp=
t

 Show the total number of paths and the number of paths shown so far
 when "git difftool" prompts to launch an external diff tool, which
 would give users some sense of progress.

 Will merge to 'master'.


* cc/starts-n-ends-with-endgame (2013-12-05) 1 commit
 - strbuf: remove prefixcmp() and suffixcmp()

 Endgame for the cc/starts-n-ends-with topic; this needs to be
 evil-merged with other topics that introduce new uses of
 prefix/suffix-cmp functions.


* jc/push-refmap (2013-12-04) 3 commits
  (merged to 'next' on 2013-12-12 at 71e358f)
 + push: also use "upstream" mapping when pushing a single ref
 + push: use remote.$name.push as a refmap
 + builtin/push.c: use strbuf instead of manual allocation

 Make "git push origin master" update the same ref that would be
 updated by our 'master' when "git push origin" (no refspecs) is run
 while the 'master' branch is checked out, which makes "git push"
 more symmetric to "git fetch" and more usable for the triangular
 workflow.

 Will merge to 'master'.


* js/gnome-keyring (2013-12-16) 1 commit
  (merged to 'next' on 2013-12-17 at 422fd61)
 + contrib/git-credential-gnome-keyring.c: small stylistic cleanups

 Style fix.

 Will merge to 'master'.


* gj/push-more-verbose-advice (2013-11-13) 1 commit
  (merged to 'next' on 2013-12-06 at 574b18a)
 + push: switch default from "matching" to "simple"

 Originally merged to 'next' on 2013-11-21

 Explain 'simple' and 'matching' in "git push" advice message; the
 topmost patch is a rebase of jc/push-2.0-default-to-simple on top
 of it.

 Will cook in 'next' until Git 2.0.


* tr/merge-recursive-index-only (2013-10-28) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()

 Will hold until using script appears.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
  (merged to 'next' on 2013-12-06 at ead2ec8)
 + git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
  (merged to 'next' on 2013-12-06 at ae18007)
 + core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-06-18) 1 commit
  (merged to 'next' on 2013-12-06 at 6fad61c)
 + push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
  (merged to 'next' on 2013-12-06 at fbaa75a)
 + git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.


* jc/hold-diff-remove-q-synonym-for-no-deletion (2013-07-19) 1 commit
  (merged to 'next' on 2013-12-06 at 083d67c)
 + diff: remove "diff-files -q" in a version of Git in a distant future

 Will cook in 'next' until a distant future.

--------------------------------------------------
[Discarded]

* aa/transport-non-positive-depth-only (2013-11-26) 1 commit
 . transport: catch non positive --depth option value


* cc/remote-remove-redundant-postfixcmp (2013-11-06) 2 commits
 . Rename suffixcmp() to has_suffix() and invert its result
 . builtin/remote: remove postfixcmp() and use suffixcmp() instead


* th/reflog-annotated-tag (2013-10-28) 1 commit
 . reflog: handle lightweight and annotated tags equally

 "git log -g $annotated_tag", when there is no reflog history, should
 have produced a single output entry (i.e. the ref creation event),
 but instead showed the history leading to the tag.

 Broken at the design level.  Any reflog entry that points at a non
 commit needs to be handled with new code that does not exist yet,
 and lifting the "this code handles only commits" without adding
 such code does not solve anything.
