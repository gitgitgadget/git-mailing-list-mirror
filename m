From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.9-rc0
Date: Tue, 21 Jan 2014 14:14:22 -0800
Message-ID: <xmqqha8xt22p.fsf@gitster.dls.corp.google.com>
References: <xmqq61pjzljn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Jan 21 23:14:46 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1W5jam-00043H-NS
	for glk-linux-kernel-3@plane.gmane.org; Tue, 21 Jan 2014 23:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbaAUWOg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 21 Jan 2014 17:14:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbaAUWO3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jan 2014 17:14:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2477B63C68;
	Tue, 21 Jan 2014 17:14:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ILkUAbfd6yJG
	gqD9JyMIujetKdc=; b=nvKnXr72pRF3JJw694rxUizokr6TMnVLxeiLV5BqSe4j
	rK5fTu3bcHc7yZysoy0xm4q6+NHy6Mp0nhv1zgp+OISL4p7ZaNgZy05xEHa3Mue+
	uf1LWqJh+2k3KIreh+J6OIa/Yencu2RuFCDA201EwzWD8tinC3hzwdWmKeemeT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vFVVEI
	04gUHK01amtCjCFtoqkPiGHguc0gVW8oomEuclzIz4ZyWNFih5pvIjBaZQQp90vk
	0bJvpZpPL+x24UnC56aVFWPGjvn4/Jzg748DtiflMAYQ8E9/ey2fgcUAsS9j7KkP
	AnePI60EopqEXZzUfR9X6Q3/Ofmo5W19FLNa4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14ACF63C67;
	Tue, 21 Jan 2014 17:14:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6242C63C63;
	Tue, 21 Jan 2014 17:14:26 -0500 (EST)
In-Reply-To: <xmqq61pjzljn.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 16 Jan 2014 13:03:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 63C5D05A-82E9-11E3-8E15-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240780>

An early preview release Git v1.9-rc0 is now available for testing
at the usual places.  I tagged this late last week, but forgot to
send out the announcement before I left for the weekend, and then I
wasn't well yesterday, but anyway.  There still may be a few minor
topics not in this preview but should be in the final release, but
otherwise, this should be pretty close to "it".

It has been reported that turning git.rc into git.res does not like
the new 2-dewey-decimal release numbering scheme; packagers of
various distro might find similar issues in their build procedures,
in which case they have about 3 weeks to update them until the final
release.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

495108620f8547ec8e979549857dae96bfabb0f7  git-1.9.rc0.tar.gz
daf964f46acd9ba72ebcdfbd1ef0c668206a0d92  git-htmldocs-1.9.rc0.tar.gz
a3b83356f738d1452bcee1d43ac5267a08986292  git-manpages-1.9.rc0.tar.gz

The following public repositories all have a copy of the v1.9-rc0
tag and the v1.9-rc0 branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v1.9 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Backward compatibility notes
----------------------------

"git submodule foreach $cmd $args" used to treat "$cmd $args" the same
way "ssh" did, concatenating them into a single string and letting the
shell unquote. Careless users who forget to sufficiently quote $args
gets their argument split at $IFS whitespaces by the shell, and got
unexpected results due to this. Starting from this release, the
command line is passed directly to the shell, if it has an argument.

Read-only support for experimental loose-object format, in which users
could optionally choose to write in their loose objects for a short
while between v1.4.3 to v1.5.3 era, has been dropped.

The meanings of "--tags" option to "git fetch" has changed; the
command fetches tags _in addition to_ what are fetched by the same
command line without the option.

The way "git push $there $what" interprets $what part given on the
command line, when it does not have a colon that explicitly tells us
what ref at the $there repository is to be updated, has been enhanced.

A handful of ancient commands that have long been deprecated are
finally gone (repo-config, tar-tree, lost-found, and peek-remote).


Backward compatibility notes (for Git 2.0)
------------------------------------------

When "git push [$there]" does not say what to push, we have used the
traditional "matching" semantics so far (all your branches were sent
to the remote as long as there already are branches of the same name
over there).  In Git 2.0, the default will change to the "simple"
semantics, which pushes:

 - only the current branch to the branch with the same name, and only
   when the current branch is set to integrate with that remote
   branch, if you are pushing to the same remote as you fetch from; or

 - only the current branch to the branch with the same name, if you
   are pushing to a remote that is not where you usually fetch from.

Use the user preference configuration variable "push.default" to
change this.  If you are an old-timer who is used to the "matching"
semantics, you can set the variable to "matching" to keep the
traditional behaviour.  If you want to live in the future early, you
can set it to "simple" today without waiting for Git 2.0.

When "git add -u" (and "git add -A") is run inside a subdirectory and
does not specify which paths to add on the command line, it
will operate on the entire tree in Git 2.0 for consistency
with "git commit -a" and other commands.  There will be no
mechanism to make plain "git add -u" behave like "git add -u .".
Current users of "git add -u" (without a pathspec) should start
training their fingers to explicitly say "git add -u ."
before Git 2.0 comes.  A warning is issued when these commands are
run without a pathspec and when you have local changes outside the
current directory, because the behaviour in Git 2.0 will be different
from today's version in such a situation.

In Git 2.0, "git add <path>" will behave as "git add -A <path>", so
that "git add dir/" will notice paths you removed from the directory
and record the removal.  Versions before Git 2.0, including this
release, will keep ignoring removals, but the users who rely on this
behaviour are encouraged to start using "git add --ignore-removal <path=
>"
now before 2.0 is released.

The default prefix for "git svn" will change in Git 2.0.  For a long
time, "git svn" created its remote-tracking branches directly under
refs/remotes, but it will place them under refs/remotes/origin/ unless
it is told otherwise with its --prefix option.


Updates since v1.8.5
--------------------

=46oreign interfaces, subsystems and ports.

 * The HTTP transport, when talking GSS-Negotiate, uses "100
   Continue" response to avoid having to rewind and resend a large
   payload, which may not be always doable.

 * Various bugfixes to remote-bzr and remote-hg (in contrib/).

 * The build procedure is aware of MirBSD now.


UI, Workflows & Features

 * Fetching from a shallowly-cloned repository used to be forbidden,
   primarily because the codepaths involved were not carefully vetted
   and we did not bother supporting such usage. This release attempts
   to allow object transfer out of a shallowly-cloned repository in a
   more controlled way (i.e. the receiver become a shallow repository
   with a truncated history).

 * Just like we give a reasonable default for "less" via the LESS
   environment variable, we now specify a reasonable default for "lv"
   via the "LV" environment variable when spawning the pager.

 * Two-level configuration variable names in "branch.*" and "remote.*"
   hierarchies, whose variables are predominantly three-level, were
   not completed by hitting a <TAB> in bash and zsh completions.

 * Fetching 'frotz' branch with "git fetch", while 'frotz/nitfol'
   remote-tracking branch from an earlier fetch was still there, would
   error out, primarily because the command was not told that it is
   allowed to lose any information on our side.  "git fetch --prune"
   now can be used to remove 'frotz/nitfol' to make room to fetch and
   store 'frotz' remote-tracking branch.

 * "diff.orderfile=3D<file>" configuration variable can be used to
   pretend as if the "-O<file>" option were given from the command
   line of "git diff", etc.

 * The negative pathspec syntax allows "git log -- . ':!dir'" to tell
   us "I am interested in everything but 'dir' directory".

 * "git difftool" shows how many different paths there are in total,
   and how many of them have been shown so far, to indicate progress.

 * "git push origin master" used to push our 'master' branch to update
   the 'master' branch at the 'origin' repository.  This has been
   enhanced to use the same ref mapping "git push origin" would use to
   determine what ref at the 'origin' to be updated with our 'master'.
   For example, with this configuration

   [remote "origin"]
      push =3D refs/heads/*:refs/review/*

   that would cause "git push origin" to push out our local branches
   to corresponding refs under refs/review/ hierarchy at 'origin',
   "git push origin master" would update 'refs/review/master' over
   there.  Alternatively, if push.default is set to 'upstream' and our
   'master' is set to integrate with 'topic' from the 'origin' branch,
   running "git push origin" while on our 'master' would update their
   'topic' branch, and running "git push origin master" while on any
   of our branches does the same.

 * "gitweb" learned to treat ref hierarchies other than refs/heads as
   if they are additional branch namespaces (e.g. refs/changes/ in
   Gerrit).

 * "git for-each-ref --format=3D..." learned a few formatting directive=
s;
   e.g. "%(color:red)%(HEAD)%(color:reset) %(refname:short) %(subject)"=
=2E

 * The command string given to "git submodule foreach" is passed
   directly to the shell, without being eval'ed.  This is a backward
   incompatible change that may break existing users.

 * "git log" and friends learned the "--exclude=3D<glob>" option, to
   allow people to say "list history of all branches except those that
   match this pattern" with "git log --exclude=3D'*/*' --branches".

 * "git rev-parse --parseopt" learned a new "--stuck-long" option to
   help scripts parse options with an optional parameter.

 * The "--tags" option to "git fetch" no longer tells the command to
   fetch _only_ the tags. It instead fetches tags _in addition to_
   what are fetched by the same command line without the option.


Performance, Internal Implementation, etc.

 * When parsing a 40-hex string into the object name, the string is
   checked to see if it can be interpreted as a ref so that a warning
   can be given for ambiguity. The code kicked in even when the
   core.warnambiguousrefs is set to false to squelch this warning, in
   which case the cycles spent to look at the ref namespace were an
   expensive no-op, as the result was discarded without being used.

 * The naming convention of the packfiles has been updated; it used to
   be based on the enumeration of names of the objects that are
   contained in the pack, but now it also depends on how the packed
   result is represented---packing the same set of objects using
   different settings (or delta order) would produce a pack with
   different name.

 * "git diff --no-index" mode used to unnecessarily attempt to read
   the index when there is one.

 * The deprecated parse-options macro OPT_BOOLEAN has been removed;
   use OPT_BOOL or OPT_COUNTUP in new code.

 * A few duplicate implementations of prefix/suffix string comparison
   functions have been unified to starts_with() and ends_with().

 * The new PERLLIB_EXTRA makefile variable can be used to specify
   additional directories Perl modules (e.g. the ones necessary to run
   git-svn) are installed on the platform when building.

 * "git merge-base" learned the "--fork-point" mode, that implements
   the same logic used in "git pull --rebase" to find a suitable fork
   point out of the reflog entries for the remote-tracking branch the
   work has been based on.  "git rebase" has the same logic that can be
   triggered with the "--fork-point" option.

 * A third-party "receive-pack" (the responder to "git push") can
   advertise the "no-thin" capability to tell "git push" not to use
   the thin-pack optimization. Our receive-pack has always been
   capable of accepting and fattening a thin-pack, and will continue
   not to ask "git push" to use a non-thin pack.


Also contains various documentation updates and code clean-ups.


=46ixes since v1.8.5
------------------

Unless otherwise noted, all the fixes since v1.8.5 in the maintenance
track are contained in this release (see the maintenance releases' note=
s
for details).

 * "submodule.*.update=3Dcheckout", when propagated from .gitmodules to
   .git/config, turned into a "submodule.*.update=3Dnone", which did no=
t
   make much sense.
   (merge efa8fd7 fp/submodule-checkout-mode later to maint).

 * The implementation of 'git stash $cmd "stash@{...}"' did not quote
   the stash argument properly and left it split at IFS whitespace.
   (merge 2a07e43 ow/stash-with-ifs later to maint).

 * The "--[no-]informative-errors" options to "git daemon" were parsed
   a bit too loosely, allowing any other string after these option
   names.
   (merge 82246b7 nd/daemon-informative-errors-typofix later to maint).

 * There is no reason to have a hardcoded upper limit of the number of
   parents for an octopus merge, created via the graft mechanism, but
   there was.
   (merge e228c17 js/lift-parent-count-limit later to maint).

 * The basic test used to leave unnecessary trash directories in the
   t/ directory.
   (merge 738a8be jk/test-framework-updates later to maint).

 * "git merge-base --octopus" used to leave cleaning up suboptimal
   result to the caller, but now it does the clean-up itself.
   (merge 8f29299 bm/merge-base-octopus-dedup later to maint).

 * A "gc" process running as a different user should be able to stop a
   new "gc" process from starting, but it didn't.
   (merge ed7eda8 km/gc-eperm later to maint).

 * An earlier "clean-up" introduced an unnecessary memory leak.
   (merge e1c1a32 jk/credential-plug-leak later to maint).

 * "git add -A" (no other arguments) in a totally empty working tree
   used to emit an error.
   (merge 64ed07c nd/add-empty-fix later to maint).

 * "git log --decorate" did not handle a tag pointed by another tag
   nicely.
   (merge 5e1361c bc/log-decoration later to maint).

 * When we figure out how many file descriptors to allocate for
   keeping packfiles open, a system with non-working getrlimit() could
   cause us to die(), but because we make this call only to get a
   rough estimate of how many is available and we do not even attempt
   to use up all file descriptors available ourselves, it is nicer to
   fall back to a reasonable low value rather than dying.
   (merge 491a8de jh/rlimit-nofile-fallback later to maint).

 * read_sha1_file(), that is the workhorse to read the contents given
   an object name, honoured object replacements, but there was no
   corresponding mechanism to sha1_object_info() that was used to
   obtain the metainfo (e.g. type & size) about the object.  This led
   callers to weird inconsistencies.
   (merge 663a856 cc/replace-object-info later to maint).

 * "git cat-file --batch=3D", an admittedly useless command, did not
   behave very well.
   (merge 6554dfa jk/cat-file-regression-fix later to maint).

 * "git rev-parse <revs> -- <paths>" did not implement the usual
   disambiguation rules the commands in the "git log" family used in
   the same way.
   (merge 62f162f jk/rev-parse-double-dashes later to maint).

 * "git mv A B/", when B does not exist as a directory, should error
   out, but it didn't.
   (merge c57f628 mm/mv-file-to-no-such-dir-with-slash later to maint).

 * A workaround to an old bug in glibc prior to glibc 2.17 has been
   retired; this would remove a side effect of the workaround that
   corrupts system error messages in non-C locales.

 * SSL-related options were not passed correctly to underlying socket
   layer in "git send-email".
   (merge 5508f3e tr/send-email-ssl later to maint).

 * "git commit -v" appends the patch to the log message before
   editing, and then removes the patch when the editor returned
   control. However, the patch was not stripped correctly when the
   first modified path was a submodule.
   (merge 1a72cfd jl/commit-v-strip-marker later to maint).

 * "git fetch --depth=3D0" was a no-op, and was silently ignored.
   Diagnose it as an error.
   (merge 5594bca nd/transport-positive-depth-only later to maint).

 * Remote repository URL expressed in scp-style host:path notation are
   parsed more carefully (e.g. "foo/bar:baz" is local, "[::1]:/~user" a=
sks
   to connect to user's home directory on host at address ::1.
   (merge a2036d7 tb/clone-ssh-with-colon-for-port later to maint).

 * "git diff -- ':(icase)makefile'" was unnecessarily rejected at the
   command line parser.
   (merge 887c6c1 nd/magic-pathspec later to maint).

 * "git cat-file --batch-check=3Dok" did not check the existence of
   the named object.
   (merge 4ef8d1d sb/sha1-loose-object-info-check-existence later to ma=
int).

 * "git am --abort" sometimes complained about not being able to write
   a tree with an 0{40} object in it.
   (merge 77b43ca jk/two-way-merge-corner-case-fix later to maint).

 * Two processes creating loose objects at the same time could have
   failed unnecessarily when the name of their new objects started
   with the same byte value, due to a race condition.
   (merge b2476a6 jh/loose-object-dirs-creation-race later to maint).

----------------------------------------------------------------

Changes since v1.8.5 are as follows:

Anders Kaseorg (1):
      submodule foreach: skip eval for more than one argument

Antoine Pelisse (2):
      Prevent buffer overflows when path is too long
      remote-hg: test 'shared_path' in a moved clone

Benny Siegert (1):
      Add MirBSD support to the build system.

Brodie Rao (1):
      sha1_name: don't resolve refs when core.warnambiguousrefs is fals=
e

Carlos Mart=C3=ADn Nieto (1):
      send-pack: don't send a thin pack to a server which doesn't suppo=
rt it

Christian Couder (15):
      environment: normalize use of prefixcmp() by removing " !=3D 0"
      builtin/remote: remove postfixcmp() and use suffixcmp() instead
      strbuf: introduce starts_with() and ends_with()
      replace {pre,suf}fixcmp() with {starts,ends}_with()
      rename READ_SHA1_FILE_REPLACE flag to LOOKUP_REPLACE_OBJECT
      replace_object: don't check read_replace_refs twice
      sha1_file.c: add lookup_replace_object_extended() to pass flags
      sha1_object_info_extended(): add an "unsigned flags" parameter
      t6050: show that git cat-file --batch fails with replace objects
      sha1_file: perform object replacement in sha1_object_info_extende=
d()
      builtin/replace: teach listing using short, medium or full format=
s
      t6050: add tests for listing with --format
      builtin/replace: unset read_replace_refs
      Documentation/git-replace: describe --format option
      replace info: rename 'full' to 'long' and clarify in-code symbols

Crestez Dan Leonard (1):
      git p4: Use git diff-tree instead of format-patch

=46elipe Contreras (9):
      test-lib.sh: convert $TEST_DIRECTORY to an absolute path
      test-bzr.sh, test-hg.sh: allow running from any dir
      remote-helpers: add extra safety checks
      remote-hg: fix 'shared path' path
      remote-hg: add tests for special filenames
      abspath: trivial style fix
      t: trivial whitespace cleanups
      fetch: add missing documentation
      remote: fix status with branch...rebase=3Dpreserve

=46rancesco Pretto (1):
      git-submodule.sh: 'checkout' is a valid update mode

Greg Jacobson (1):
      push: enhance unspecified push default warning

Jason St. John (6):
      Documentation/git-log: update "--log-size" description
      Documentation/git-log.txt: mark-up fix and minor rephasing
      State correct usage of literal examples in man pages in the codin=
g standards
      Documentation/rev-list-options.txt: fix mark-up
      Documentation/rev-list-options.txt: fix some grammatical issues a=
nd typos
      Documentation/gitcli.txt: fix double quotes

Jeff King (30):
      log_tree_diff: die when we fail to parse a commit
      assume parse_commit checks commit->object.parsed
      assume parse_commit checks for NULL commit
      use parse_commit_or_die instead of segfaulting
      use parse_commit_or_die instead of custom message
      checkout: do not die when leaving broken detached HEAD
      sha1write: make buffer const-correct
      use @@PERL@@ in built scripts
      http: return curl's AUTHAVAIL via slot_results
      remote-curl: pass curl slot_results back through run_slot
      unpack-trees: fix "read-tree -u --reset A B" with conflicted inde=
x
      drop support for "experimental" loose objects
      t5000: simplify gzip prerequisite checks
      pack-objects: name pack files after trailer hash
      rev-parse: correctly diagnose revision errors before "--"
      rev-parse: be more careful with munging arguments
      cat-file: pass expand_data to print_object_or_die
      cat-file: handle --batch format with missing type/size
      pack-objects doc: treat output filename as opaque
      diff.c: fix some recent whitespace style violations
      builtin/prune.c: use strbuf to avoid having to worry about PATH_M=
AX
      do not pretend sha1write returns errors
      sha1_object_info_extended: provide delta base sha1s
      cat-file: provide %(deltabase) batch format
      Revert "prompt: clean up strbuf usage"
      use distinct username/password for http auth tests
      t0000: set TEST_OUTPUT_DIRECTORY for sub-tests
      t0000: simplify HARNESS_ACTIVE hack
      t0000: drop "known breakage" test
      t5531: further "matching" fixups

Jens Lehmann (4):
      submodule update: remove unnecessary orig_flags variable
      commit -v: strip diffs and submodule shortlogs from the commit me=
ssage
      mv: better document side effects when moving a submodule
      rm: better document side effects when removing a submodule

Johan Herland (1):
      sha1_file.c:create_tmpfile(): Fix race when creating loose object=
 dirs

Johannes Schindelin (1):
      Remove the line length limit for graft files

Johannes Sixt (4):
      document --exclude option
      git_connect: remove artificial limit of a remote command
      git_connect: factor out discovery of the protocol and its parts
      mv: let 'git mv file no-such-dir/' error out on Windows, too

John Keeping (8):
      repo-config: remove deprecated alias for "git config"
      tar-tree: remove deprecated command
      lost-found: remove deprecated command
      peek-remote: remove deprecated alias of ls-remote
      pull: use merge-base --fork-point when appropriate
      rebase: use reflog to find common base with upstream
      rebase: fix fork-point with zero arguments
      pull: suppress error when no remoteref is found

John Murphy (1):
      git-gui: corrected setup of git worktree under cygwin.

John Szakmeister (1):
      contrib/git-credential-gnome-keyring.c: small stylistic cleanups

Jonathan Nieder (16):
      git-remote-mediawiki: do not remove installed files in "clean" ta=
rget
      git-remote-mediawiki: honor DESTDIR in "make install"
      git-remote-mediawiki build: make 'install' command configurable
      git-remote-mediawiki build: handle DESTDIR/INSTLIBDIR with whites=
pace
      Makefile: rebuild perl scripts when perl paths change
      Makefile: add PERLLIB_EXTRA variable that adds to default perl pa=
th
      mark Windows build scripts executable
      mark perl test scripts executable
      mark contributed hooks executable
      contrib: remove git-p4import
      test: make FILEMODE a lazy prereq
      test: replace shebangs with descriptions in shell libraries
      remove #!interpreter line from shell libraries
      stop installing git-tar-tree link
      pager: set LV=3D-c alongside LESS=3DFRSX
      diff test: reading a directory as a file need not error out

Junio C Hamano (28):
      revision: introduce --exclude=3D<glob> to tame wildcards
      merge-base: use OPT_CMDMODE and clarify the command line parsing
      merge-base: teach "--fork-point" mode
      rev-list --exclude: tests
      rev-list --exclude: export add/clear-ref-exclusion and ref-exclud=
ed API
      rev-parse: introduce --exclude=3D<glob> to tame wildcards
      t1005: reindent
      t1005: add test for "read-tree --reset -u A B"
      sha1_loose_object_info(): do not return success on missing object
      bundle: use argv-array
      submodule: do not copy unknown update mode from .gitmodules
      Git 1.8.4.5
      Git 1.8.5.1
      builtin/push.c: use strbuf instead of manual allocation
      push: use remote.$name.push as a refmap
      push: also use "upstream" mapping when pushing a single ref
      Start 1.9 cycle
      Update draft release notes to 1.9
      prune-packed: use strbuf to avoid having to worry about PATH_MAX
      Git 1.8.5.2
      Update draft release notes to 1.9
      get_max_fd_limit(): fall back to OPEN_MAX upon getrlimit/sysconf =
failure
      merge-base: separate "--independent" codepath into its own helper
      merge-base --octopus: reduce the result from get_octopus_merge_ba=
ses()
      Update draft release notes to 1.9
      Git 1.8.5.3
      Update draft release notes to 1.9
      Git 1.9-rc0

Karsten Blees (1):
      gitignore.txt: clarify recursive nature of excluded directories

Krzesimir Nowak (4):
      gitweb: Move check-ref-format code into separate function
      gitweb: Return 1 on validation success instead of passed input
      gitweb: Add a feature for adding more branch refs
      gitweb: Denote non-heads, non-remotes branches

Kyle J. McKay (1):
      gc: notice gc processes run by other users

Mads D=C3=B8rup (1):
      git-gui: Improve font rendering on retina macbooks

Masanari Iida (4):
      typofixes: fix misspelt comments
      Documentation/technical/http-protocol.txt: typofixes
      contrib: typofixes
      git-gui: correct spelling errors in comments

Matthieu Moy (1):
      mv: let 'git mv file no-such-dir/' error out

Max Kirillov (2):
      git-gui: Add gui.displayuntracked option
      git-gui: right half window is paned

Michael Haggerty (27):
      t5510: use the correct tag name in test
      t5510: prepare test refs more straightforwardly
      t5510: check that "git fetch --prune --tags" does not prune branc=
hes
      api-remote.txt: correct section "struct refspec"
      get_ref_map(): rename local variables
      builtin/fetch.c: reorder function definitions
      get_expanded_map(): add docstring
      get_expanded_map(): avoid memory leak
      fetch: only opportunistically update references based on command =
line
      fetch --tags: fetch tags *in addition to* other stuff
      fetch --prune: prune only based on explicit refspecs
      query_refspecs(): move some constants out of the loop
      builtin/remote.c: reorder function definitions
      builtin/remote.c:update(): use struct argv_array
      fetch, remote: properly convey --no-prune options to subprocesses
      fetch-options.txt: simplify ifdef/ifndef/endif usage
      git-fetch.txt: improve description of tag auto-following
      ref_remove_duplicates(): avoid redundant bisection
      t5536: new test of refspec conflicts when fetching
      ref_remove_duplicates(): simplify loop logic
      ref_remote_duplicates(): extract a function handle_duplicate()
      handle_duplicate(): mark error message for translation
      fetch: improve the error messages emitted for conflicting refspec=
s
      cmd_repack(): remove redundant local variable "nr_packs"
      shorten_unambiguous_ref(): introduce a new local variable
      gen_scanf_fmt(): delete function and use snprintf() instead
      shorten_unambiguous_ref(): tighten up pointer arithmetic

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (41):
      wt-status: take the alignment burden off translators
      diff: restrict pathspec limitations to diff b/f case only
      glossary-content.txt: fix documentation of "**" patterns
      gettext.c: detect the vsnprintf bug at runtime
      clone,fetch: catch non positive --depth option value
      glossary-content.txt: rephrase magic signature part
      Support pathspec magic :(exclude) and its short form :!
      pathspec.c: support adding prefix magic to a pathspec with mnemon=
ic magic
      parse-options: remove OPT_BOOLEAN
      transport.h: remove send_pack prototype, already defined in send-=
pack.h
      remote.h: replace struct extra_have_objects with struct sha1_arra=
y
      send-pack: forbid pushing from a shallow repository
      clone: prevent --reference to a shallow repository
      make the sender advertise shallow commits to the receiver
      connect.c: teach get_remote_heads to parse "shallow" lines
      shallow.c: extend setup_*_shallow() to accept extra shallow commi=
ts
      shallow.c: the 8 steps to select new commits for .git/shallow
      shallow.c: steps 6 and 7 to select new commits for .git/shallow
      fetch-pack.c: move shallow update code out of fetch_pack()
      fetch-pack.h: one statement per bitfield declaration
      clone: support remote shallow repository
      fetch: support fetching from a shallow repository
      upload-pack: make sure deepening preserves shallow roots
      fetch: add --update-shallow to accept refs that update .git/shall=
ow
      receive-pack: reorder some code in unpack()
      receive/send-pack: support pushing from a shallow clone
      add GIT_SHALLOW_FILE to propagate --shallow-file to subprocesses
      connected.c: add new variant that runs with --shallow-file
      receive-pack: allow pushes that update .git/shallow
      send-pack: support pushing to a shallow clone
      remote-curl: pass ref SHA-1 to fetch-pack as well
      smart-http: support shallow fetch/clone
      receive-pack: support pushing to a shallow clone via http
      send-pack: support pushing from a shallow clone via http
      clone: use git protocol for cloning shallow repo locally
      prune: clean .git/shallow after pruning objects
      git-clone.txt: remove shallow clone limitations
      daemon: be strict at parsing parameters --[no-]informative-errors
      add: don't complain when adding empty project root
      commit.c: make "tree" a const pointer in commit_tree*()
      t5537: fix incorrect expectation in test case 10

Nick Townsend (1):
      ref-iteration doc: add_submodule_odb() returns 0 for success

Nicolas Vigier (2):
      Use the word 'stuck' instead of 'sticked'
      rev-parse --parseopt: add the --stuck-long mode

Pat Thoyts (3):
      git-gui: added gui.maxrecentrepo to extend the number of remember=
ed repos
      git-gui: show the maxrecentrepo config option in the preferences =
dialog
      git-gui: add menu item to launch a bash shell on Windows.

Paul Mackerras (1):
      gitk: Tag display improvements

Ralf Thielow (1):
      l10n: de.po: fix translation of 'prefix'

Ramkumar Ramachandra (12):
      t6300 (for-each-ref): clearly demarcate setup
      t6300 (for-each-ref): don't hardcode SHA-1 hexes
      for-each-ref: introduce %(HEAD) asterisk marker
      for-each-ref: introduce %(upstream:track[short])
      for-each-ref: introduce %(color:...) for color
      for-each-ref: avoid color leakage
      for-each-ref: remove unused variable
      zsh completion: find matching custom bash completion
      completion: introduce __gitcomp_nl_append ()
      completion: fix branch.autosetup(merge|rebase)
      completion: fix remote.pushdefault
      completion: complete format.coverLetter

Ramsay Allan Jones (2):
      send-pack.c: mark a file-local function static
      shallow: remove unused code

Ren=C3=A9 Scharfe (1):
      SubmittingPatches: document how to handle multiple patches

Richard Hansen (6):
      test-bzr.sh, test-hg.sh: prepare for change to push.default=3Dsim=
ple
      test-hg.sh: eliminate 'local' bashism
      test-hg.sh: avoid obsolete 'test' syntax
      test-hg.sh: fix duplicate content strings in author tests
      test-hg.sh: help user correlate verbose output with email test
      remote-bzr, remote-hg: fix email address regular expression

Roberto Tyley (1):
      docs: add filter-branch notes on The BFG

Roman Kagan (2):
      git-svn: workaround for a bug in svn serf backend
      git-svn: workaround for a bug in svn serf backend

Samuel Bronson (3):
      t4056: add new tests for "git diff -O"
      diff: let "git diff -O" read orderfile from any file and fail pro=
perly
      diff: add diff.orderfile configuration variable

Sebastian Schuberth (3):
      git.c: consistently use the term "builtin" instead of "internal c=
ommand"
      builtin/help.c: call load_command_list() only when it is needed
      builtin/help.c: speed up is_git_command() by checking for builtin=
 commands first

Thomas Ackermann (2):
      user-manual: improve html and pdf formatting
      pack-heuristics.txt: mark up the file header properly

Thomas Gummerer (4):
      diff: move no-index detection to builtin/diff.c
      diff: don't read index when --no-index is given
      diff: add test for --no-index executed outside repo
      diff: avoid some nesting

Thomas Rast (13):
      commit-slab: document clear_$slabname()
      commit-slab: declare functions "static inline"
      Documentation: revamp git-cherry(1)
      gitk: Support -G option from the command line
      gitk: Refactor per-line part of getblobdiffline and its support
      gitk: Split out diff part in $commitinfo
      gitk: Support showing the gathered inline diffs
      gitk: Recognize -L option
      commit-slab: sizeof() the right type in xrealloc
      send-email: pass Debug to Net::SMTP::SSL::new
      send-email: --smtp-ssl-cert-path takes an argument
      send-email: set SSL options through IO::Socket::SSL::set_client_d=
efaults
      config: arbitrary number of matches for --unset and --replace-all

Tom Miller (2):
      fetch --prune: always print header url
      fetch --prune: Run prune before fetching

Torsten B=C3=B6gershausen (9):
      git-fetch-pack uses URLs like git-fetch
      t5601: remove clear_ssh, refactor setup_ssh_wrapper
      t5601: add tests for ssh
      git fetch-pack: add --diag-url
      t5500: add test cases for diag-url
      git fetch: support host:/~repo
      git_connect(): refactor the port handling for ssh
      connect.c: refactor url parsing
      git_connect(): use common return point

Vasily Makarov (1):
      get_octopus_merge_bases(): cleanup redundant variable

W. Trevor King (1):
      Documentation/gitmodules: Only 'update' and 'url' are required

Zoltan Klinger (1):
      difftool: display the number of files in the diff queue in the pr=
ompt

brian m. carlson (3):
      remote-curl: fix large pushes with GSSAPI
      Documentation: document pitfalls with 3-way merge
      log: properly handle decorations with chained tags

jcb91 (1):
      remote-hg: avoid buggy strftime()

=C3=98ystein Walle (1):
      stash: handle specifying stashes with $IFS
