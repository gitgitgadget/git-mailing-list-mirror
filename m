From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.5.0
Date: Mon, 27 Jul 2015 13:47:16 -0700
Message-ID: <xmqqtwspgusf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 23:23:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJpra-0000rl-Rb
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 23:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811AbbG0VWw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jul 2015 17:22:52 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35931 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132AbbG0VWp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 17:22:45 -0400
Received: by pdjr16 with SMTP id r16so59129642pdj.3;
        Mon, 27 Jul 2015 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=ULGIwT6f3EMiiHi7RlUcU7KgjVE3kQ2QLHVwhbh74Kg=;
        b=r/d9TulQRpCyI5pNfkIlyCe/jILjOasex7J48EvBtVTmOjcnwo4u2fqRJNpJJ9p8RT
         +6uhlzoGHM/BCYrqBuVkwjcnCjBqx/opQH5YK+Utx+K1smgwuw/PFi31bEzVITAa978M
         EYr46DbVVWFyIH42wGjuukhZzo57AYhXq+WgDPtTeqHujSOpTY6gWFAJQZ4hzlSdf77G
         39Esc0zofOTs/Hx1nD+rMuhgiDQ4q0fAWT7Xp1nV5GznxTFdFehX4eAUCl3qUgGaBqwx
         5GVfzzJ/MO2ULymT9ssb9k7vgq0aQ23VTwi9stXS+0W+urPxtoevIa3uzSH/r/DaKM6q
         jhow==
X-Received: by 10.70.129.3 with SMTP id ns3mr55914661pdb.166.1438032164279;
        Mon, 27 Jul 2015 14:22:44 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2496:725d:b368:d039])
        by smtp.gmail.com with ESMTPSA id wp5sm31353697pab.22.2015.07.27.14.22.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jul 2015 14:22:43 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274711>

The latest feature release Git v2.5.0 is now available at the
usual places.  It is comprised of 583 non-merge commits since
v2.4.0, contributed by 70 people, 21 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.5.0'
tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.4.0 are as follows.
Welcome to the Git development community!

  Allen Hubbe, Ariel Faigon, Blair Holloway, Christian Neukirchen,
  Danny Lin, Enrique Tobis, Frans Klaver, Fredrik Medley, Joe
  Cridge, Lars Kellogg-Stedman, Lawrence Siebert, Lex Spoon, Luke
  Mewburn, Miguel Torroja, Mike Edgar, Ossi Herrala, Panagiotis
  Astithas, Quentin Neill, Remi Lespinet, S=C3=A9bastien Guimmara,
  and Thomas Schneider.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Alexander Shopov, Alex Henrie, brian m. carlson, Carlos Mart=C3=ADn
  Nieto, Charles Bailey, Clemens Buchacher, David Aguilar,
  David Turner, Dennis Kaarsemaker, Dimitriy Ryazantcev, Elia
  Pinto, Eric Sunshine, Fredrik Gustafsson, Jean-Noel Avila, Jeff
  King, Jiang Xin, Jim Hill, Johannes Schindelin, Johannes Sixt,
  Jonathan Nieder, Junio C Hamano, Karsten Blees, Karthik Nayak,
  Luke Diamand, Matthieu Moy, Max Kirillov, Michael Coleman,
  Michael Haggerty, Michael J Gruber, Mike Hommey, Nguy=E1=BB=85n
  Th=C3=A1i Ng=E1=BB=8Dc Duy, Patrick Steinhardt, Paul Tan, Peter Kreft=
ing,
  Phil Hord, Phillip Sz, Ralf Thielow, Ramsay Allan Jones, Ren=C3=A9
  Scharfe, Richard Hansen, Sebastian Schuberth, Stefan Beller,
  SZEDER G=C3=A1bor, Thomas Braun, Thomas Gummerer, Tony Finch,
  Torsten B=C3=B6gershausen, Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n, and V=
itor Antunes.

----------------------------------------------------------------

Git 2.5 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Updates since v2.4
------------------

UI, Workflows & Features

 * The bash completion script (in contrib/) learned a few options that
   "git revert" takes.

 * Whitespace breakages in deleted and context lines can also be
   painted in the output of "git diff" and friends with the new
   --ws-error-highlight option.

 * List of commands shown by "git help" are grouped along the workflow
   elements to help early learners.

 * "git p4" now detects the filetype (e.g. binary) correctly even when
   the files are opened exclusively.

 * git p4 attempts to better handle branches in Perforce.

 * "git p4" learned "--changes-block-size <n>" to read the changes in
   chunks from Perforce, instead of making one call to "p4 changes"
   that may trigger "too many rows scanned" error from Perforce.

 * More workaround for Perforce's row number limit in "git p4".

 * Unlike "$EDITOR" and "$GIT_EDITOR" that can hold the path to the
   command and initial options (e.g. "/path/to/emacs -nw"), 'git p4'
   did not let the shell interpolate the contents of the environment
   variable that name the editor "$P4EDITOR" (and "$EDITOR", too).
   This release makes it in line with the rest of Git, as well as with
   Perforce.

 * A new short-hand <branch>@{push} denotes the remote-tracking branch
   that tracks the branch at the remote the <branch> would be pushed
   to.

 * "git show-branch --topics HEAD" (with no other arguments) did not
   do anything interesting.  Instead, contrast the given revision
   against all the local branches by default.

 * A replacement for contrib/workdir/git-new-workdir that does not
   rely on symbolic links and make sharing of objects and refs safer
   by making the borrowee and borrowers aware of each other.

   Consider this as still an experimental feature; its UI is still
   likely to change.

 * Tweak the sample "store" backend of the credential helper to honor
   XDG configuration file locations when specified.

 * A heuristic we use to catch mistyped paths on the command line
   "git <cmd> <revs> <pathspec>" is to make sure that all the non-rev
   parameters in the later part of the command line are names of the
   files in the working tree, but that means "git grep $str -- \*.c"
   must always be disambiguated with "--", because nobody sane will
   create a file whose name literally is asterisk-dot-see.  Loosen the
   heuristic to declare that with a wildcard string the user likely
   meant to give us a pathspec.

 * "git merge FETCH_HEAD" learned that the previous "git fetch" could
   be to create an Octopus merge, i.e. recording multiple branches
   that are not marked as "not-for-merge"; this allows us to lose an
   old style invocation "git merge <msg> HEAD $commits..." in the
   implementation of "git pull" script; the old style syntax can now
   be deprecated (but not removed yet).

 * Filter scripts were run with SIGPIPE disabled on the Git side,
   expecting that they may not read what Git feeds them to filter.
   We however treated a filter that does not read its input fully
   before exiting as an error.  We no longer do and ignore EPIPE
   when writing to feed the filter scripts.

   This changes semantics, but arguably in a good way.  If a filter
   can produce its output without fully consuming its input using
   whatever magic, we now let it do so, instead of diagnosing it
   as a programming error.

 * Instead of dying immediately upon failing to obtain a lock, the
   locking (of refs etc) retries after a short while with backoff.

 * Introduce http.<url>.SSLCipherList configuration variable to tweak
   the list of cipher suite to be used with libcURL when talking with
   https:// sites.

 * "git subtree" script (in contrib/) used "echo -n" to produce
   progress messages in a non-portable way.

 * "git subtree" script (in contrib/) does not have --squash option
   when pushing, but the documentation and help text pretended as if
   it did.

 * The Git subcommand completion (in contrib/) no longer lists credenti=
al
   helpers among candidates; they are not something the end user would
   invoke interactively.

 * The index file can be taught with "update-index --untracked-cache"
   to optionally remember already seen untracked files, in order to
   speed up "git status" in a working tree with tons of cruft.

 * "git mergetool" learned to drive WinMerge as a backend.

 * "git upload-pack" that serves "git fetch" can be told to serve
   commits that are not at the tip of any ref, as long as they are
   reachable from a ref, with uploadpack.allowReachableSHA1InWant
   configuration variable.

 * "git cat-file --batch(-check)" learned the "--follow-symlinks"
   option that follows an in-tree symbolic link when asked about an
   object via extended SHA-1 syntax, e.g. HEAD:RelNotes that points at
   Documentation/RelNotes/2.5.0.txt.  With the new option, the command
   behaves as if HEAD:Documentation/RelNotes/2.5.0.txt was given as
   input instead.

   Consider this as still an experimental and incomplete feature:

    - We may want to do the same for in-index objects, e.g.
      asking for :RelNotes with this option should give
      :Documentation/RelNotes/2.5.0.txt, too

    - "git cat-file --follow-symlinks blob HEAD:RelNotes"
      may also be something we want to allow in the future.

 * "git send-email" learned the alias file format used by the sendmail
   program (in a simplified form; we obviously do not feed pipes).

 * Traditionally, external low-level 3-way merge drivers are expected
   to produce their results based solely on the contents of the three
   variants given in temporary files named by %O, %A and %B on their
   command line.  Additionally allow them to look at the final path
   (given by %P).

 * "git blame" learned blame.showEmail configuration variable.

 * "git apply" cannot diagnose a patch corruption when the breakage is
   to mark the length of the hunk shorter than it really is on the
   hunk header line "@@ -l,k +m,n @@"; one special case it could is
   when the hunk becomes no-op (e.g. k =3D=3D n =3D=3D 2 for two-line c=
ontext
   patch output), and it learned to do so in this special case.

 * Add the "--allow-unknown-type" option to "cat-file" to allow
   inspecting loose objects of an experimental or a broken type.

 * Many long-running operations show progress eye-candy, even when
   they are later backgrounded.  Hide the eye-candy when the process
   is sent to the background instead.
   (merge a4fb76c lm/squelch-bg-progress later to maint).


Performance, Internal Implementation, Development Support etc.

 * "unsigned char [20]" used throughout the code to represent object
   names are being converted into a semi-opaque "struct object_id".
   This effort is expected to interfere with other topics in flight,
   but hopefully will give us one extra level of abstraction in the
   end, when completed.

 * for_each_ref() callback functions were taught to name the objects
   not with "unsigned char sha1[20]" but with "struct object_id".

 * Catch a programmer mistake to feed a pointer not an array to
   ARRAY_SIZE() macro, by using a couple of GCC extensions.

 * Some error messages in "git config" were emitted without calling
   the usual error() facility.

 * When "add--interactive" splits a hunk into two overlapping hunks
   and then let the user choose only one, it sometimes feeds an
   incorrect patch text to "git apply".  Add tests to demonstrate
   this.

   I have a slight suspicion that this may be $gmane/87202 coming back
   and biting us (I seem to have said "let's run with this and see
   what happens" back then).

 * More line-ending tests.

 * An earlier rewrite to use strbuf_getwholeline() instead of fgets(3)
   to read packed-refs file revealed that the former is unacceptably
   inefficient.  It has been optimized by using getdelim(3) when
   available.

 * The refs API uses ref_lock struct which had its own "int fd", even
   though the same file descriptor was in the lock struct it contains.
   Clean-up the code to lose this redundant field.

 * There was a dead code that used to handle "git pull --tags" and
   show special-cased error message, which was made irrelevant when
   the semantics of the option changed back in Git 1.9 days.
   (merge 19d122b pt/pull-tags-error-diag later to maint).

 * Help us to find broken test script that splits the body part of the
   test by mistaken use of wrong kind of quotes.
   (merge d93d5d5 jc/test-prereq-validate later to maint).

 * Developer support to automatically detect broken &&-chain in the
   test scripts is now turned on by default.
   (merge 92b269f jk/test-chain-lint later to maint).

 * Error reporting mechanism used in "refs" API has been made more
   consistent.

 * "git pull" has more test coverage now.

 * "git pull" has become more aware of the options meant for
   underlying "git fetch" and then learned to use parse-options
   parser.

 * Clarify in the Makefile a guideline to decide use of USE_NSEC.

Also contains various documentation updates and code clean-ups.


=46ixes since v2.4
----------------

Unless otherwise noted, all the fixes since v2.4 in the maintenance
track are contained in this release (see the maintenance releases'
notes for details).

 * Git 2.4 broke setting verbosity and progress levels on "git clone"
   with native transports.
   (merge 822f0c4 mh/clone-verbosity-fix later to maint).

 * "git add -e" did not allow the user to abort the operation by
   killing the editor.
   (merge cb64800 jk/add-e-kill-editor later to maint).

 * Memory usage of "git index-pack" has been trimmed by tens of
   per-cent.
   (merge f0e7f11 nd/slim-index-pack-memory-usage later to maint).

 * "git rev-list --objects $old --not --all" to see if everything that
   is reachable from $old is already connected to the existing refs
   was very inefficient.
   (merge b6e8a3b jk/still-interesting later to maint).

 * "hash-object --literally" introduced in v2.2 was not prepared to
   take a really long object type name.
   (merge 1427a7f jc/hash-object later to maint).

 * "git rebase --quiet" was not quite quiet when there is nothing to
   do.
   (merge 22946a9 jk/rebase-quiet-noop later to maint).

 * The completion for "log --decorate=3D" parameter value was incorrect=
=2E
   (merge af16bda sg/complete-decorate-full-not-long later to maint).

 * "filter-branch" corrupted commit log message that ends with an
   incomplete line on platforms with some "sed" implementations that
   munge such a line.  Work it around by avoiding to use "sed".
   (merge df06201 jk/filter-branch-use-of-sed-on-incomplete-line later =
to maint).

 * "git daemon" fails to build from the source under NO_IPV6
   configuration (regression in 2.4).
   (merge d358f77 jc/daemon-no-ipv6-for-2.4.1 later to maint).

 * Some time ago, "git blame" (incorrectly) lost the convert_to_git()
   call when synthesizing a fake "tip" commit that represents the
   state in the working tree, which broke folks who record the history
   with LF line ending to make their project portable across platforms
   while terminating lines in their working tree files with CRLF for
   their platform.
   (merge 4bf256d tb/blame-resurrect-convert-to-git later to maint).

 * We avoid setting core.worktree when the repository location is the
   ".git" directory directly at the top level of the working tree, but
   the code misdetected the case in which the working tree is at the
   root level of the filesystem (which arguably is a silly thing to
   do, but still valid).
   (merge 84ccad8 jk/init-core-worktree-at-root later to maint).

 * "git commit --date=3Dnow" or anything that relies on approxidate los=
t
   the daylight-saving-time offset.
   (merge f6e6362 jc/epochtime-wo-tz later to maint).

 * Access to objects in repositories that borrow from another one on a
   slow NFS server unnecessarily got more expensive due to recent code
   becoming more cautious in a naive way not to lose objects to pruning=
=2E
   (merge ee1c6c3 jk/prune-mtime later to maint).

 * The codepaths that read .gitignore and .gitattributes files have bee=
n
   taught that these files encoded in UTF-8 may have UTF-8 BOM marker a=
t
   the beginning; this makes it in line with what we do for configurati=
on
   files already.
   (merge 27547e5 cn/bom-in-gitignore later to maint).

 * a few helper scripts in the test suite did not report errors
   correctly.
   (merge de248e9 ep/fix-test-lib-functions-report later to maint).

 * The default $HOME/.gitconfig file created upon "git config --global"
   that edits it had incorrectly spelled user.name and user.email
   entries in it.
   (merge 7e11052 oh/fix-config-default-user-name-section later to main=
t).

 * "git cat-file bl $blob" failed to barf even though there is no
   object type that is "bl".
   (merge b7994af jk/type-from-string-gently later to maint).

 * The usual "git diff" when seeing a file turning into a directory
   showed a patchset to remove the file and create all files in the
   directory, but "git diff --no-index" simply refused to work.  Also,
   when asked to compare a file and a directory, imitate POSIX "diff"
   and compare the file with the file with the same name in the
   directory, instead of refusing to run.
   (merge 0615173 jc/diff-no-index-d-f later to maint).

 * "git rebase -i" moved the "current" command from "todo" to "done" a
   bit too prematurely, losing a step when a "pick" did not even start.
   (merge 8cbc57c ph/rebase-i-redo later to maint).

 * The connection initiation code for "ssh" transport tried to absorb
   differences between the stock "ssh" and Putty-supplied "plink" and
   its derivatives, but the logic to tell that we are using "plink"
   variants were too loose and falsely triggered when "plink" appeared
   anywhere in the path (e.g. "/home/me/bin/uplink/ssh").
   (merge baaf233 bc/connect-plink later to maint).

 * We have prepended $GIT_EXEC_PATH and the path "git" is installed in
   (typically "/usr/bin") to $PATH when invoking subprograms and hooks
   for almost eternity, but the original use case the latter tried to
   support was semi-bogus (i.e. install git to /opt/foo/git and run it
   without having /opt/foo on $PATH), and more importantly it has
   become less and less relevant as Git grew more mainstream (i.e. the
   users would _want_ to have it on their $PATH).  Stop prepending the
   path in which "git" is installed to users' $PATH, as that would
   interfere the command search order people depend on (e.g. they may
   not like versions of programs that are unrelated to Git in /usr/bin
   and want to override them by having different ones in /usr/local/bin
   and have the latter directory earlier in their $PATH).
   (merge a0b4507 jk/git-no-more-argv0-path-munging later to maint).

 * core.excludesfile (defaulting to $XDG_HOME/git/ignore) is supposed
   to be overridden by repository-specific .git/info/exclude file, but
   the order was swapped from the beginning. This belatedly fixes it.
   (merge 099d2d8 jc/gitignore-precedence later to maint).

 * There was a commented-out (instead of being marked to expect
   failure) test that documented a breakage that was fixed since the
   test was written; turn it into a proper test.
   (merge 66d2e04 sb/t1020-cleanup later to maint).

 * The "log --decorate" enhancement in Git 2.4 that shows the commit
   at the tip of the current branch e.g. "HEAD -> master", did not
   work with --decorate=3Dfull.
   (merge 429ad20 mg/log-decorate-HEAD later to maint).

 * The ref API did not handle cases where 'refs/heads/xyzzy/frotz' is
   removed at the same time as 'refs/heads/xyzzy' is added (or vice
   versa) very well.
   (merge c628edf mh/ref-directory-file later to maint).

 * Multi-ref transaction support we merged a few releases ago
   unnecessarily kept many file descriptors open, risking to fail with
   resource exhaustion.  This is for 2.4.x track.
   (merge 185ce3a mh/write-refs-sooner-2.4 later to maint).

 * "git bundle verify" did not diagnose extra parameters on the
   command line.
   (merge 7886cfa ps/bundle-verify-arg later to maint).

 * Various documentation mark-up fixes to make the output more
   consistent in general and also make AsciiDoctor (an alternative
   formatter) happier.
   (merge d0258b9 jk/asciidoc-markup-fix later to maint).
   (merge ad3967a jk/stripspace-asciidoctor-fix later to maint).
   (merge 975e382 ja/tutorial-asciidoctor-fix later to maint).

 * The code to read pack-bitmap wanted to allocate a few hundred
   pointers to a structure, but by mistake allocated and leaked memory
   enough to hold that many actual structures.  Correct the allocation
   size and also have it on stack, as it is small enough.
   (merge 599dc76 rs/plug-leak-in-pack-bitmaps later to maint).

 * The pull.ff configuration was supposed to override the merge.ff
   configuration, but it didn't.
   (merge db9bb28 pt/pull-ff-vs-merge-ff later to maint).

 * "git pull --log" and "git pull --no-log" worked as expected, but
   "git pull --log=3D20" did not.
   (merge 5061a44 pt/pull-log-n later to maint).

 * "git rerere forget" in a repository without rerere enabled gave a
   cryptic error message; it should be a silent no-op instead.
   (merge 0544574 jk/rerere-forget-check-enabled later to maint).

 * "git rebase -i" fired post-rewrite hook when it shouldn't (namely,
   when it was told to stop sequencing with 'exec' insn).
   (merge 141ff8f mm/rebase-i-post-rewrite-exec later to maint).

 * Clarify that "log --raw" and "log --format=3Draw" are unrelated
   concepts.
   (merge 92de921 mm/log-format-raw-doc later to maint).

 * Make "git stash something --help" error out, so that users can
   safely say "git stash drop --help".
   (merge 5ba2831 jk/stash-options later to maint).

 * The clean/smudge interface did not work well when filtering an
   empty contents (failed and then passed the empty input through).
   It can be argued that a filter that produces anything but empty for
   an empty input is nonsense, but if the user wants to do strange
   things, then why not?
   (merge f6a1e1e jh/filter-empty-contents later to maint).

 * Communication between the HTTP server and http_backend process can
   lead to a dead-lock when relaying a large ref negotiation request.
   Diagnose the situation better, and mitigate it by reading such a
   request first into core (to a reasonable limit).
   (merge 636614f jk/http-backend-deadlock later to maint).

 * "git clean pathspec..." tried to lstat(2) and complain even for
   paths outside the given pathspec.
   (merge 838d6a9 dt/clean-pathspec-filter-then-lstat later to maint).

 * Recent "git prune" traverses young unreachable objects to safekeep
   old objects in the reachability chain from them, which sometimes
   caused error messages that are unnecessarily alarming.
   (merge ce4e7b2 jk/squelch-missing-link-warning-for-unreachable later=
 to maint).

 * The configuration reader/writer uses mmap(2) interface to access
   the files; when we find a directory, it barfed with "Out of memory?"=
=2E
   (merge 9ca0aaf jk/diagnose-config-mmap-failure later to maint).

 * "color.diff.plain" was a misnomer; give it 'color.diff.context' as
   a more logical synonym.
   (merge 8dbf3eb jk/color-diff-plain-is-context later to maint).

 * The setup code used to die when core.bare and core.worktree are set
   inconsistently, even for commands that do not need working tree.
   (merge fada767 jk/die-on-bogus-worktree-late later to maint).

 * Recent Mac OS X updates breaks the logic to detect that the machine
   is on the AC power in the sample pre-auto-gc script.
   (merge c54c7b3 pa/auto-gc-mac-osx later to maint).

 * "git commit --cleanup=3Dscissors" was not careful enough to protect
   against getting fooled by a line that looked like scissors.
   (merge fbfa097 sg/commit-cleanup-scissors later to maint).

 * "Have we lost a race with competing repack?" check was too
   expensive, especially while receiving a huge object transfer
   that runs index-pack (e.g. "clone" or "fetch").
   (merge 0eeb077 jk/index-pack-reduce-recheck later to maint).

 * The tcsh completion writes a bash scriptlet but that would have
   failed for users with noclobber set.
   (merge 0b1f688 af/tcsh-completion-noclobber later to maint).

 * "git for-each-ref" reported "missing object" for 0{40} when it
   encounters a broken ref.  The lack of object whose name is 0{40} is
   not the problem; the ref being broken is.
   (merge 501cf47 mh/reporting-broken-refs-from-for-each-ref later to m=
aint).

 * Various fixes around "git am" that applies a patch to a history
   that is not there yet.
   (merge 6ea3b67 pt/am-abort-fix later to maint).

 * "git fsck" used to ignore missing or invalid objects recorded in ref=
log.
   (merge 19bf6c9 mh/fsck-reflog-entries later to maint).

 * "git format-patch --ignore-if-upstream A..B" did not like to be fed
   tags as boundary commits.
   (merge 9b7a61d jc/do-not-feed-tags-to-clear-commit-marks later to ma=
int).

 * "git fetch --depth=3D<depth>" and "git clone --depth=3D<depth>" issu=
ed
   a shallow transfer request even to an upload-pack that does not
   support the capability.
   (merge eb86a50 me/fetch-into-shallow-safety later to maint).

 * "git rebase" did not exit with failure when format-patch it invoked
   failed for whatever reason.
   (merge 60d708b cb/rebase-am-exit-code later to maint).

 * Fix a small bug in our use of umask() return value.
   (merge 3096b2e jk/fix-refresh-utime later to maint).

 * An ancient test framework enhancement to allow color was not
   entirely correct; this makes it work even when tput needs to read
   from the ~/.terminfo under the user's real HOME directory.
   (merge d5c1b7c rh/test-color-avoid-terminfo-in-original-home later t=
o maint).

 * A minor bugfix when pack bitmap is used with "rev-list --count".
   (merge c8a70d3 jk/rev-list-no-bitmap-while-pruning later to maint).

 * "git config" failed to update the configuration file when the
   underlying filesystem is incapable of renaming a file that is still
   open.
   (merge 7a64592 kb/config-unmap-before-renaming later to maint).

 * Avoid possible ssize_t to int truncation.
   (merge 6c8afe4 mh/strbuf-read-file-returns-ssize-t later to maint).

 * When you say "!<ENTER>" while running say "git log", you'd confuse
   yourself in the resulting shell, that may look as if you took
   control back to the original shell you spawned "git log" from but
   that isn't what is happening.  To that new shell, we leaked
   GIT_PAGER_IN_USE environment variable that was meant as a local
   communication between the original "Git" and subprocesses that was
   spawned by it after we launched the pager, which caused many
   "interesting" things to happen, e.g. "git diff | cat" still paints
   its output in color by default.

   Stop leaking that environment variable to the pager's half of the
   fork; we only need it on "Git" side when we spawn the pager.
   (merge 124b519 jc/unexport-git-pager-in-use-in-pager later to maint)=
=2E

 * Abandoning an already applied change in "git rebase -i" with
   "--continue" left CHERRY_PICK_HEAD and confused later steps.
   (merge 0e0aff4 js/rebase-i-clean-up-upon-continue-to-skip later to m=
aint).

 * We used to ask libCURL to use the most secure authentication method
   available when talking to an HTTP proxy only when we were told to
   talk to one via configuration variables.  We now ask libCURL to
   always use the most secure authentication method, because the user
   can tell libCURL to use an HTTP proxy via an environment variable
   without using configuration variables.
   (merge 5841520 et/http-proxyauth later to maint).

 * A fix to a minor regression to "git fsck" in v2.2 era that started
   complaining about a body-less tag object when it lacks a separator
   empty line after its header to separate it with a non-existent body.
   (merge 84d18c0 jc/fsck-retire-require-eoh later to maint).

 * Code cleanups and documentation updates.
   (merge 0269f96 mm/usage-log-l-can-take-regex later to maint).
   (merge 64f2589 nd/t1509-chroot-test later to maint).
   (merge d201a1e sb/test-bitmap-free-at-end later to maint).
   (merge 05bfc7d sb/line-log-plug-pairdiff-leak later to maint).
   (merge 846e5df pt/xdg-config-path later to maint).
   (merge 1154aa4 jc/plug-fmt-merge-msg-leak later to maint).
   (merge 319b678 jk/sha1-file-reduce-useless-warnings later to maint).
   (merge 9a35c14 fg/document-commit-message-stripping later to maint).
   (merge bbf431c ps/doc-packfile-vs-pack-file later to maint).
   (merge 309a9e3 jk/skip-http-tests-under-no-curl later to maint).
   (merge ccd593c dl/branch-error-message later to maint).
   (merge 22570b6 rs/janitorial later to maint).
   (merge 5c2a581 mc/commit-doc-grammofix later to maint).
   (merge ce41720 ah/usage-strings later to maint).
   (merge e6a268c sb/glossary-submodule later to maint).
   (merge ec48a76 sb/submodule-doc-intro later to maint).
   (merge 14f8b9b jk/clone-dissociate later to maint).
   (merge 055c7e9 sb/pack-protocol-mention-smart-http later to maint).
   (merge 7c37a5d jk/make-fix-dependencies later to maint).
   (merge fc0aa39 sg/merge-summary-config later to maint).
   (merge 329af6c pt/t0302-needs-sanity later to maint).
   (merge d614f07 fk/doc-format-patch-vn later to maint).
   (merge 72dbb36 sg/completion-commit-cleanup later to maint).
   (merge e654eb2 es/utf8-stupid-compiler-workaround later to maint).
   (merge 34b935c es/osx-header-pollutes-mask-macro later to maint).
   (merge ab7fade jc/prompt-document-ps1-state-separator later to maint=
).
   (merge 25f600e mm/describe-doc later to maint).
   (merge 83fe167 mm/branch-doc-updates later to maint).
   (merge 75d2e5a ls/hint-rev-list-count later to maint).
   (merge edc8f71 cb/subtree-tests-update later to maint).
   (merge 5330e6e sb/p5310-and-chain later to maint).
   (merge c4ac525 tb/checkout-doc later to maint).
   (merge e479c5f jk/pretty-encoding-doc later to maint).
   (merge 7e837c6 ss/clone-guess-dir-name-simplify later to maint).

----------------------------------------------------------------

Changes since v2.4.0 are as follows:

Alex Henrie (3):
      blame, log: format usage strings similarly to those in documentat=
ion
      l10n: ca.po: update translation
      l10n: ca.po: update translation

Alexander Shopov (2):
      l10n: Updated Bulgarian translation of git (2355t,0f,0u)
      l10n: Updated Bulgarian translation of git (2359t,0f,0u)

Allen Hubbe (1):
      send-email: add sendmail email aliases format

Ariel Faigon (1):
      git-completion.tcsh: fix redirect with noclobber

Blair Holloway (1):
      git-p4: fix filetype detection on files opened exclusively

Carlos Mart=C3=ADn Nieto (1):
      dir: allow a BOM at the beginning of exclude files

Charles Bailey (4):
      contrib/subtree: use tabs consitently for indentation in tests
      contrib/subtree: fix broken &&-chains and revealed test error
      contrib/subtree: small tidy-up to test
      Fix definition of ARRAY_SIZE for non-gcc builds

Christian Neukirchen (1):
      cvsimport: silence regex warning appearing in Perl 5.22.

Clemens Buchacher (1):
      rebase: return non-zero error code if format-patch fails

Danny Lin (3):
      branch: do not call a "remote-tracking branch" a "remote branch"
      contrib/subtree: there's no push --squash
      contrib/subtree: portability fix for string printing

David Aguilar (2):
      mergetool--lib: set IFS for difftool and mergetool
      mergetools: add winmerge as a builtin tool

David Turner (4):
      clean: only lstat files in pathspec
      tree-walk: learn get_tree_entry_follow_symlinks
      sha1_name: get_sha1_with_context learns to follow symlinks
      cat-file: add --follow-symlinks to --batch

Dennis Kaarsemaker (1):
      checkout: don't require a work tree when checking out into a new =
one

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Elia Pinto (2):
      test-lib-functions.sh: fix the second argument to some helper fun=
ctions
      git-compat-util.h: implement a different ARRAY_SIZE macro for for=
 safely deriving the size of array

Enrique Tobis (1):
      http: always use any proxy auth method available

Eric Sunshine (44):
      git-hash-object.txt: document --literally option
      hash-object --literally: fix buffer overrun with extra-long objec=
t type
      t1007: add hash-object --literally tests
      command-list: prepare machinery for upcoming "common groups" sect=
ion
      generate-cmdlist: parse common group commands
      send-email: further document missing sendmail aliases functionali=
ty
      send-email: visually distinguish sendmail aliases parser warnings
      send-email: drop noise comments which merely repeat what code say=
s
      send-email: fix style: cuddle 'elsif' and 'else' with closing bra=
ce
      send-email: refactor sendmail aliases parser
      send-email: simplify sendmail aliases comment and blank line reco=
gnizer
      send-email: implement sendmail aliases line continuation support
      t9001: refactor sendmail aliases test infrastructure
      t9001: add sendmail aliases line continuation tests
      send-email: further warn about unsupported sendmail aliases featu=
res
      ewah/bitmap: silence warning about MASK macro redefinition
      config.mak.uname: Darwin: define HAVE_GETDELIM for modern OS X re=
leases
      configure: add getdelim() check
      utf8: NO_ICONV: silence uninitialized variable warning
      Documentation/git-checkout: fix incorrect worktree prune command
      Documentation/git-worktree: associate options with commands
      Documentation: move linked worktree description from checkout to =
worktree
      Documentation/git-worktree: add BUGS section
      Documentation/git-worktree: split technical info from general des=
cription
      Documentation/git-worktree: add high-level 'lock' overview
      Documentation/git-worktree: add EXAMPLES section
      checkout: fix bug with --to and relative HEAD
      checkout: relocate --to's "no branch specified" check
      checkout: prepare_linked_checkout: drop now-unused 'new' argument
      checkout: make --to unconditionally verbose
      checkout: drop 'checkout_opts' dependency from prepare_linked_che=
ckout
      worktree: introduce "add" command
      worktree: add --force option
      worktree: add --detach option
      worktree: add -b/-B options
      tests: worktree: retrofit "checkout --to" tests for "worktree add=
"
      checkout: retire --to option
      checkout: require worktree unconditionally
      worktree: extract basename computation to new function
      worktree: add: make -b/-B default to HEAD when <branch> is omitte=
d
      worktree: add: auto-vivify new branch when <branch> is omitted
      checkout: retire --ignore-other-worktrees in favor of --force
      Documentation/git-worktree: fix stale "git checkout --to" referen=
ces
      Documentation/git: fix stale "MULTIPLE CHECKOUT MODE" reference

=46rans Klaver (1):
      doc: format-patch: fix typo

=46redrik Gustafsson (1):
      Documentation: clarify how "git commit" cleans up the edited log =
message

=46redrik Medley (3):
      config.txt: clarify allowTipSHA1InWant with camelCase
      upload-pack: prepare to extend allow-tip-sha1-in-want
      upload-pack: optionally allow fetching reachable sha1

Jean-Noel Avila (3):
      doc: fix unmatched code fences
      l10n: fr.po v2.5.0-rc0 (2355t)
      l10n: fr v2.5.0 round 2 (2359t)

Jeff King (83):
      sha1_file: squelch "packfile cannot be accessed" warnings
      init: don't set core.worktree when initializing /.git
      strbuf_getwholeline: use getc macro
      git-compat-util: add fallbacks for unlocked stdio
      strbuf_getwholeline: use getc_unlocked
      config: use getc_unlocked when reading from file
      strbuf_addch: avoid calling strbuf_grow
      strbuf_getwholeline: avoid calling strbuf_grow
      strbuf_getwholeline: use getdelim if it is available
      read_packed_refs: avoid double-checking sane refs
      t1430: add another refs-escape test
      type_from_string_gently: make sure length matches
      limit_list: avoid quadratic behavior from still_interesting
      reachable: only mark local objects as recent
      sha1_file: freshen pack objects before loose
      sha1_file: only freshen packs once per run
      t3903: stop hard-coding commit sha1s
      t3903: avoid applying onto dirty index
      stash: require a clean index to apply
      stop putting argv[0] dirname at front of PATH
      rebase: silence "git checkout" for noop rebase
      test-lib: turn on GIT_TEST_CHAIN_LINT by default
      filter-branch: avoid passing commit message through sed
      remote.c: drop default_remote_name variable
      t/lib-httpd.sh: skip tests if NO_CURL is defined
      add: check return value of launch_editor
      doc: fix unmatched code fences in git-stripspace
      doc: fix misrendering due to `single quote'
      doc: fix unquoted use of "{type}"
      doc: fix hanging "+"-continuation
      doc: fix length of underlined section-title
      doc/add: reformat `--edit` option
      doc: convert \--option to --option
      doc: drop backslash quoting of some curly braces
      doc: put example URLs and emails inside literal backticks
      doc: convert AsciiDoc {?foo} to ifdef::foo[]
      rerere: exit silently on "forget" when rerere is disabled
      http-backend: fix die recursion with custom handler
      progress: treat "no terminal" as being in the foreground
      t5551: factor out tag creation
      stash: complain about unknown flags
      stash: recognize "--help" for subcommands
      remote.c: refactor setup of branch->merge list
      remote.c: drop "remote" pointer from "struct branch"
      remote.c: hoist branch.*.remote lookup out of remote_get_1
      remote.c: provide per-branch pushremote name
      remote.c: hoist read_config into remote_get_1
      remote.c: introduce branch_get_upstream helper
      remote.c: report specific errors from branch_get_upstream
      test_bitmap_walk: free bitmap with bitmap_free
      remote.c: untangle error logic in branch_get_upstream
      remote.c: return upstream name from stat_tracking_info
      remote.c: add branch_get_push
      sha1_name: refactor upstream_mark
      sha1_name: refactor interpret_upstream_mark
      sha1_name: implement @{push} shorthand
      for-each-ref: use skip_prefix instead of starts_with
      for-each-ref: accept "%(push)" format
      http-backend: spool ref negotiation requests to buffer
      clone: use OPT_STRING_LIST for --reference
      clone: reorder --dissociate and --reference options
      t7063: hide stderr from setup inside prereq
      diff: accept color.diff.context as a synonym for "plain"
      diff.h: rename DIFF_PLAIN color slot to DIFF_CONTEXT
      read-cache.c: drop PROT_WRITE from mmap of index
      config.c: fix mmap leak when writing config
      config.c: avoid xmmap error messages
      config.c: rewrite ENODEV into EISDIR when mmap fails
      Makefile: drop dependency between git-instaweb and gitweb
      Makefile: avoid timestamp updates to GIT-BUILD-OPTIONS
      Makefile: silence perl/PM.stamp recipe
      setup_git_directory: delay core.bare/core.worktree errors
      add quieter versions of parse_{tree,commit}
      silence broken link warnings with revs->ignore_missing_links
      suppress errors on missing UNINTERESTING links
      ewah: use less generic macro name
      index-pack: fix truncation of off_t in comparison
      index-pack: avoid excessive re-reading of pack directory
      Revert "stash: require a clean index to apply"
      docs: clarify that --encoding can produce invalid sequences
      for_each_packed_object: automatically open pack index
      rev-list: disable --use-bitmap-index when pruning commits
      check_and_freshen_file: fix reversed success-check

Jiang Xin (4):
      l10n: git.pot: v2.5.0 round 1 (65 new, 15 removed)
      l10n: zh_CN: for git v2.5.0 l10n round 1
      l10n: git.pot: v2.5.0 round 2 (9 new, 5 removed)
      l10n: zh_CN: for git v2.5.0 l10n round 2

Jim Hill (1):
      sha1_file: pass empty buffer to index empty file

Joe Cridge (1):
      git-prompt.sh: document GIT_PS1_STATESEPARATOR

Johannes Schindelin (2):
      t3404: demonstrate CHERRY_PICK_HEAD bug
      rebase -i: do not leave a CHERRY_PICK_HEAD file behind

Johannes Sixt (5):
      compat/mingw: stubs for getpgid() and tcgetpgrp()
      lockfile: replace random() by rand()
      help.c: wrap wait-only poll() invocation in sleep_millisec()
      lockfile: convert retry timeout computations to millisecond
      lockfile: wait using sleep_millisec() instead of select()

Jonathan Nieder (1):
      config: use error() instead of fprintf(stderr, ...)

Junio C Hamano (77):
      t2026: fix broken &&-chain
      t0302: "unreadable" test needs POSIXPERM
      diff-no-index: DWIM "diff D F" into "diff D/F F"
      diff-no-index: align D/F handling with that of normal Git
      parse_date_basic(): return early when given a bogus timestamp
      parse_date_basic(): let the system handle DST conversion
      add_excludes_from_file: clarify the bom skipping logic
      utf8-bom: introduce skip_utf8_bom() helper
      config: use utf8_bom[] from utf.[ch] in git_parse_source()
      attr: skip UTF8 BOM at the beginning of the input file
      fmt-merge-msg: plug small leak of commit buffer
      ignore: info/exclude should trump core.excludesfile
      test: validate prerequistes syntax
      merge: test the top-level merge driver
      merge: simplify code flow
      t5520: style fixes
      t5520: test pulling an octopus into an unborn branch
      merge: clarify "pulling into void" special case
      merge: do not check argc to determine number of remote heads
      merge: small leakfix and code simplification
      merge: clarify collect_parents() logic
      merge: split reduce_parents() out of collect_parents()
      merge: narrow scope of merge_names
      merge: extract prepare_merge_message() logic out
      merge: make collect_parents() auto-generate the merge message
      merge: decide if we auto-generate the message early in collect_pa=
rents()
      merge: handle FETCH_HEAD internally
      merge: deprecate 'git merge <message> HEAD <commit>' syntax
      write_sha1_file(): do not use a separate sha1[] array
      daemon: unbreak NO_IPV6 build regression
      First batch for 2.5 cycle
      tests: skip dav http-push tests under NO_EXPAT=3DNoThanks
      Second batch for 2.5 cycle
      Git 2.3.8
      log: decorate HEAD with branch name under --decorate=3Dfull, too
      log: do not shorten decoration names too early
      Git 2.4.1
      Third batch for 2.5 cycle
      copy.c: make copy_fd() report its status silently
      filter_buffer_or_fd(): ignore EPIPE
      t5407: use <<- to align the expected output
      Fourth batch for 2.5 cycle
      t4015: modernise style
      t4015: separate common setup and per-test expectation
      Fifth batch for 2.5 cycle
      Git 2.4.2
      diff.c: add emit_del_line() and emit_context_line()
      diff.c: --ws-error-highlight=3D<kind> option
      t9001: write $HOME/, not ~/, to help shells without tilde expansi=
on
      xmmap(): drop "Out of memory?"
      apply: reject a hunk that does not do anything
      Sixth batch for 2.5 cycle
      format-patch: do not feed tags to clear_commit_marks()
      ll-merge: pass the original path to external drivers
      The first half of the seventh batch for 2.5
      Git 2.4.3
      Second half of seventh batch
      Git 2.4.4
      Eighth batch for 2.5
      Revert "diff-lib.c: adjust position of i-t-a entries in diff"
      Ninth batch for 2.5
      Git 2.4.5
      Git 2.5.0-rc0
      fsck: it is OK for a tag and a commit to lack the body
      Git 2.5.0-rc1
      pager: do not leak "GIT_PAGER_IN_USE" to the pager
      index-pack: fix allocation of sorted_by_pos array
      The last minute bits of fixes
      Revert "checkout: retire --ignore-other-worktrees in favor of --f=
orce"
      Git 2.5.0-rc2
      Git 2.4.6
      worktree: caution that this is still experimental
      Git 2.5.0-rc3
      Revert "git-am: add am.threeWay config variable"
      RelNotes: am.threeWay does not exist (yet)
      Git 2.4.7
      Git 2.5

Karsten Blees (2):
      config.c: fix writing config files on Windows network shares
      Makefile / racy-git.txt: clarify USE_NSEC prerequisites

Karthik Nayak (4):
      sha1_file: support reading from a loose object of unknown type
      cat-file: make the options mutually exclusive
      cat-file: teach cat-file a '--allow-unknown-type' option
      t1006: add tests for git cat-file --allow-unknown-type

Lars Kellogg-Stedman (1):
      http: add support for specifying an SSL cipher list

Lawrence Siebert (1):
      rev-list: add --count to usage guide

Lex Spoon (1):
      git-p4: use -m when running p4 changes

Luke Diamand (11):
      git-p4: fix small bug in locked test scripts
      git-p4: small fix for locked-file-move-test
      git-p4: t9814: prevent --chain-lint failure
      git-p4: add failing tests for case-folding p4d
      git-p4: add failing test for P4EDITOR handling
      git-p4: fix handling of multi-word P4EDITOR
      git-p4: tests: use test-chmtime in place of touch
      git-p4: additional testing of --changes-block-size
      git-p4: test with limited p4 server results
      git-p4: add tests for non-numeric revision range
      git-p4: fixing --changes-block-size handling

Luke Mewburn (1):
      progress: no progress in background

Matthieu Moy (16):
      t3701-add-interactive: simplify code
      add -p: demonstrate failure when running 'edit' after a split
      t3904-stash-patch: fix test description
      t3904-stash-patch: factor PERL prereq at the top of the file
      stash -p: demonstrate failure of split with mixed y/n
      Documentation: change -L:<regex> to -L:<funcname>
      log -L: improve error message on malformed argument
      Documentation/log: clarify what --raw means
      Documentation/log: clarify sha1 non-abbreviation in log --raw
      rebase -i: demonstrate incorrect behavior of post-rewrite
      rebase -i: fix post-rewrite hook with failed exec command
      Documentation/describe: improve one-line summary
      git-multimail: update to release 1.1.0
      git-multimail: update to release 1.1.1
      Documentation/branch: document -d --force and -m --force
      Documentation/branch: document -M and -D in terms of --force

Max Kirillov (3):
      checkout: do not fail if target is an empty directory
      git-common-dir: make "modules/" per-working-directory directory
      prune --worktrees: fix expire vs worktree existence condition

Michael Coleman (1):
      Documentation/git-commit: grammofix

Michael Haggerty (99):
      t1404: new tests of ref D/F conflicts within transactions
      is_refname_available(): revamp the comments
      is_refname_available(): avoid shadowing "dir" variable
      is_refname_available(): convert local variable "dirname" to strbu=
f
      entry_matches(): inline function
      report_refname_conflict(): inline function
      struct nonmatching_ref_data: store a refname instead of a ref_ent=
ry
      is_refname_available(): use dirname in first loop
      ref_transaction_commit(): use a string_list for detecting duplica=
tes
      refs: check for D/F conflicts among refs created in a transaction
      verify_refname_available(): rename function
      verify_refname_available(): report errors via a "struct strbuf *e=
rr"
      lock_ref_sha1_basic(): report errors via a "struct strbuf *err"
      lock_ref_sha1_basic(): improve diagnostics for ref D/F conflicts
      rename_ref(): integrate lock_ref_sha1_basic() errors into ours
      ref_transaction_commit(): provide better error messages
      ref_transaction_commit(): delete extra "the" from error message
      reflog_expire(): integrate lock_ref_sha1_basic() errors into ours
      write_ref_to_lockfile(): new function, extracted from write_ref_s=
ha1()
      commit_ref_update(): new function, extracted from write_ref_sha1(=
)
      rename_ref(): inline calls to write_ref_sha1() from this function
      ref_transaction_commit(): inline call to write_ref_sha1()
      ref_transaction_commit(): remove the local flags variable
      ref_transaction_commit(): fix atomicity and avoid fd exhaustion
      write_ref_to_lockfile(): new function, extracted from write_ref_s=
ha1()
      commit_ref_update(): new function, extracted from write_ref_sha1(=
)
      rename_ref(): inline calls to write_ref_sha1() from this function
      ref_transaction_commit(): inline call to write_ref_sha1()
      ref_transaction_commit(): remove the local flags variable
      ref_transaction_commit(): fix atomicity and avoid fd exhaustion
      lockfile: allow file locking to be retried with a timeout
      lock_packed_refs(): allow retries when acquiring the packed-refs =
lock
      each_ref_fn: change to take an object_id parameter
      builtin/rev-parse: rewrite to take an object_id argument
      handle_one_ref(): rewrite to take an object_id argument
      register_ref(): rewrite to take an object_id argument
      append_ref(): rewrite to take an object_id argument
      add_pending_uninteresting_ref(): rewrite to take an object_id arg=
ument
      get_name(): rewrite to take an object_id argument
      builtin/fetch: rewrite to take an object_id argument
      grab_single_ref(): rewrite to take an object_id argument
      name_ref(): rewrite to take an object_id argument
      builtin/pack-objects: rewrite to take an object_id argument
      show_ref_cb(): rewrite to take an object_id argument
      builtin/reflog: rewrite ref functions to take an object_id argume=
nt
      add_branch_for_removal(): rewrite to take an object_id argument
      add_branch_for_removal(): don't set "util" field of string_list e=
ntries
      builtin/remote: rewrite functions to take object_id arguments
      show_reference(): rewrite to take an object_id argument
      append_matching_ref(): rewrite to take an object_id argument
      builtin/show-branch: rewrite functions to take object_id argument=
s
      append_one_rev(): rewrite to work with object_id
      builtin/show-branch: rewrite functions to work with object_id
      cmd_show_branch(): fix error message
      fsck: change functions to use object_id
      builtin/show-ref: rewrite to use object_id
      show_ref(): convert local variable peeled to object_id
      builtin/show-ref: rewrite to take an object_id argument
      append_similar_ref(): rewrite to take an object_id argument
      http-backend: rewrite to take an object_id argument
      show_head_ref(): convert local variable "unused" to object_id
      add_ref_decoration(): rewrite to take an object_id argument
      add_ref_decoration(): convert local variable original_sha1 to obj=
ect_id
      string_list_add_one_ref(): rewrite to take an object_id argument
      add_one_ref(): rewrite to take an object_id argument
      remote: rewrite functions to take object_id arguments
      register_replace_ref(): rewrite to take an object_id argument
      handle_one_reflog(): rewrite to take an object_id argument
      add_info_ref(): rewrite to take an object_id argument
      handle_one_ref(): rewrite to take an object_id argument
      shallow: rewrite functions to take object_id arguments
      submodule: rewrite to take an object_id argument
      write_refs_to_temp_dir(): convert local variable sha1 to object_i=
d
      write_one_ref(): rewrite to take an object_id argument
      find_symref(): rewrite to take an object_id argument
      find_symref(): convert local variable "unused" to object_id
      upload-pack: rewrite functions to take object_id arguments
      send_ref(): convert local variable "peeled" to object_id
      mark_complete(): rewrite to take an object_id argument
      clear_marks(): rewrite to take an object_id argument
      mark_complete_oid(): new function, taking an object_oid
      mark_complete(): remove unneeded arguments
      rev_list_insert_ref_oid(): new function, taking an object_oid
      rev_list_insert_ref(): remove unneeded arguments
      each_ref_fn_adapter(): remove adapter
      warn_if_dangling_symref(): convert local variable "junk" to objec=
t_id
      struct ref_lock: convert old_sha1 member to object_id
      verify_lock(): return 0/-1 rather than struct ref_lock *
      verify_lock(): on errors, let the caller unlock the lock
      verify_lock(): report errors via a strbuf
      verify_lock(): do not capitalize error messages
      ref_transaction_commit(): do not capitalize error messages
      t6301: new tests of for-each-ref error handling
      for-each-ref: report broken references correctly
      read_loose_refs(): simplify function logic
      read_loose_refs(): treat NULL_SHA1 loose references as broken
      fsck_handle_reflog_sha1(): new function
      fsck: report errors if reflog entries point at invalid objects
      strbuf: strbuf_read_file() should return ssize_t

Michael J Gruber (4):
      l10n: de.po: grammar fix
      l10n: de.po: punctuation fixes
      l10n: de.po: translation fix for fall-back to 3way merge
      mergetool-lib: fix default tool selection

Miguel Torroja (1):
      p4: retrieve the right revision of the file in UTF-16 codepath

Mike Edgar (1):
      fetch-pack: check for shallow if depth given

Mike Hommey (2):
      show-branch: show all local heads when only giving one rev along =
--topics
      clone: call transport_set_verbosity before anything else on the n=
ewly created transport

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (67):
      path.c: make get_pathname() return strbuf instead of static buffe=
r
      path.c: make get_pathname() call sites return const char *
      git_snpath(): retire and replace with strbuf_git_path()
      path.c: rename vsnpath() to do_git_path()
      path.c: group git_path(), git_pathdup() and strbuf_git_path() tog=
ether
      git_path(): be aware of file relocation in $GIT_DIR
      *.sh: respect $GIT_INDEX_FILE
      reflog: avoid constructing .lock path with git_path
      fast-import: use git_path() for accessing .git dir instead of get=
_git_dir()
      commit: use SEQ_DIR instead of hardcoding "sequencer"
      $GIT_COMMON_DIR: a new environment variable
      git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
      *.sh: avoid hardcoding $GIT_DIR/hooks/...
      git-stash: avoid hardcoding $GIT_DIR/logs/....
      setup.c: convert is_git_directory() to use strbuf
      setup.c: detect $GIT_COMMON_DIR in is_git_directory()
      setup.c: convert check_repository_format_gently to use strbuf
      setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
      setup.c: support multi-checkout repo setup
      wrapper.c: wrapper to open a file, fprintf then close
      use new wrapper write_file() for simple file writing
      checkout: support checking out into a new working directory
      prune: strategies for linked checkouts
      checkout: reject if the branch is already checked out elsewhere
      checkout: clean up half-prepared directories in --to mode
      gc: style change -- no SP before closing parenthesis
      gc: factor out gc.pruneexpire parsing code
      gc: support prune --worktrees
      count-objects: report unused files in $GIT_DIR/worktrees/...
      git_path(): keep "info/sparse-checkout" per work-tree
      t2025: add a test to make sure grafts is working from a linked ch=
eckout
      checkout: pass whole struct to parse_branchname_arg instead of in=
dividual flags
      checkout: add --ignore-other-wortrees
      git-checkout.txt: a note about multiple checkout support for subm=
odules
      index-pack: reduce object_entry size to save memory
      dir.c: optionally compute sha-1 of a .gitignore file
      untracked cache: record .gitignore information and dir hierarchy
      untracked cache: initial untracked cache validation
      untracked cache: invalidate dirs recursively if .gitignore change=
s
      untracked cache: make a wrapper around {open,read,close}dir()
      untracked cache: record/validate dir mtime and reuse cached outpu=
t
      untracked cache: mark what dirs should be recursed/saved
      untracked cache: don't open non-existent .gitignore
      ewah: add convenient wrapper ewah_serialize_strbuf()
      untracked cache: save to an index extension
      untracked cache: load from UNTR index extension
      untracked cache: invalidate at index addition or removal
      read-cache.c: split racy stat test to a separate function
      untracked cache: avoid racy timestamps
      untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
      untracked cache: mark index dirty if untracked cache is updated
      untracked-cache: temporarily disable with $GIT_DISABLE_UNTRACKED_=
CACHE
      status: enable untracked cache
      update-index: manually enable or disable untracked cache
      update-index: test the system before enabling untracked cache
      t7063: tests for untracked cache
      mingw32: add uname()
      untracked cache: guard and disable on system changes
      git-status.txt: advertisement for untracked cache
      diff-lib.c: adjust position of i-t-a entries in diff
      index-pack: kill union delta_base to save memory
      t1509: update prepare script to be able to run t1509 in chroot ag=
ain
      pathspec: avoid the need of "--" when wildcard is used
      read-cache: fix untracked cache invalidation when split-index is =
used
      checkout: don't check worktrees when not necessary
      worktree: new place for "git prune --worktrees"
      Add tests for wildcard "path vs ref" disambiguation

Ossi Herrala (1):
      config: fix settings in default_user_config template

Panagiotis Astithas (1):
      hooks/pre-auto-gc: adjust power checking for newer OS X

Patrick Steinhardt (5):
      bundle: verify arguments more strictly
      git-verify-pack.txt: fix inconsistent spelling of "packfile"
      git-unpack-objects.txt: fix inconsistent spelling of "packfile"
      pack-protocol.txt: fix insconsistent spelling of "packfile"
      doc: fix inconsistent spelling of "packfile"

Paul Tan (31):
      git-credential-store: support multiple credential files
      git-credential-store: support XDG_CONFIG_HOME
      t0302: test credential-store support for XDG_CONFIG_HOME
      path.c: implement xdg_config_home()
      attr.c: replace home_config_paths() with xdg_config_home()
      dir.c: replace home_config_paths() with xdg_config_home()
      credential-store.c: replace home_config_paths() with xdg_config_h=
ome()
      git-commit: replace use of home_config_paths()
      git-config: replace use of home_config_paths()
      path.c: remove home_config_paths()
      pull: remove --tags error in no merge candidates case
      t5520: prevent field splitting in content comparisons
      t5520: test no merge candidates cases
      pull: handle --log=3D<n>
      pull: make pull.ff=3Dtrue override merge.ff
      pull: parse pull.ff as a bool or string
      t5520: test for failure if index has unresolved entries
      t5520: test work tree fast-forward when fetch updates head
      t5520: test --rebase with multiple branches
      t5520: test --rebase failure on unborn branch with index
      t5521: test --dry-run does not make any changes
      t5520: check reflog action in fast-forward merge
      pull: handle git-fetch's options as well
      pull: use git-rev-parse --parseopt for option parsing
      am --skip: revert changes introduced by failed 3way merge
      am -3: support 3way merge on unborn branch
      am --skip: support skipping while on unborn branch
      am --abort: revert changes introduced by failed 3way merge
      am --abort: support aborting to unborn branch
      am --abort: keep unrelated commits on unborn branch
      t0302: "unreadable" test needs SANITY prereq

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (2355t0f0u)
      l10n: sv.po: Update Swedish translation (2359t0f0u)

Phil Hord (1):
      rebase -i: redo tasks that die during cherry-pick

Phillip Sz (1):
      l10n: de.po: change error message from "sagen" to "Meinten Sie"

Quentin Neill (1):
      blame: add blame.showEmail configuration

Ralf Thielow (4):
      l10n: de.po: fix translation of "head nodes"
      l10n: de.po: translate "index" as "Index"
      l10n: de.po: translate 65 new messages
      l10n: de.po: translate 9 new messages

Ramsay Allan Jones (1):
      t7502-commit.sh: fix a broken and-chain

Remi Lespinet (3):
      git-am.sh: fix initialization of the threeway variable
      t4150-am: refactor am -3 tests
      git-am: add am.threeWay config variable

Ren=C3=A9 Scharfe (5):
      pack-bitmaps: plug memory leak, fix allocation size for recent_bi=
tmaps
      use file_exists() to check if a file exists in the worktree
      clean: remove unused variable buf
      dir: remove unused variable sb
      diff: parse ws-error-highlight option more strictly

Richard Hansen (2):
      Revert "test-lib.sh: do tests for color support after changing HO=
ME"
      test-lib.sh: fix color support when tput needs ~/.terminfo

SZEDER G=C3=A1bor (8):
      completion: remove redundant __git_compute_all_commands() call
      completion: fix and update 'git log --decorate=3D' options
      completion: remove credential helpers from porcelain commands
      completion: add a helper function to get config variables
      completion: simplify query for config variables
      Documentation: include 'merge.branchdesc' for merge and config as=
 well
      completion: teach 'scissors' mode to 'git commit --cleanup=3D'
      commit: cope with scissors lines in commit message

Sebastian Schuberth (1):
      clone: simplify string handling in guess_dir_name()

Stefan Beller (14):
      line-log.c: fix a memleak
      pack-bitmap.c: fix a memleak
      prefix_path(): unconditionally free results in the callers
      update-ref: test handling large transactions properly
      refs.c: remove lock_fd from struct ref_lock
      t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
      update-ref: test handling large transactions properly
      t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
      subdirectory tests: code cleanup, uncomment test
      submodule doc: reorder introductory paragraphs
      glossary: add "remote", "submodule", "superproject"
      Documentation/technical/pack-protocol: mention http as possible p=
rotocol
      p5310: Fix broken && chain in performance test
      revision.c: remove unneeded check for NULL

S=C3=A9bastien Guimmara (4):
      command-list.txt: fix whitespace inconsistency
      command-list.txt: add the common groups block
      command-list.txt: drop the "common" tag
      help: respect new common command grouping

Thomas Braun (1):
      completion: suggest sequencer commands for revert

Thomas Gummerer (1):
      t1501: fix test with split index

Thomas Schneider (1):
      checkout: call a single commit "it" intead of "them"

Tony Finch (1):
      gitweb: fix typo in man page

Torsten B=C3=B6gershausen (6):
      t2026 needs procondition SANITY
      t0027: cleanup: rename functions; avoid non-leading TABs
      t0027: support NATIVE_CRLF platforms
      t0027: Add repoMIX and LF_nul
      blame: CRLF in the working tree and LF in the repo
      git-checkout.txt: document "git checkout <pathspec>" better

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (2):
      l10n: Updated Vietnamese translation (2355t)
      l10n: Updated Vietnamese translation (2359t)

Vitor Antunes (2):
      t9801: check git-p4's branch detection with client spec enabled
      git-p4: improve client path detection when branches are used

brian m. carlson (14):
      define a structure for object IDs
      define utility functions for object IDs
      bisect.c: convert leaf functions to use struct object_id
      archive.c: convert to use struct object_id
      zip: use GIT_SHA1_HEXSZ for trailers
      bulk-checkin.c: convert to use struct object_id
      diff: convert struct combine_diff_path to object_id
      commit: convert parts to struct object_id
      patch-id: convert to use struct object_id
      apply: convert threeway_stage to object_id
      connect: simplify SSH connection code path
      t5601: fix quotation error leading to skipped tests
      connect: improve check for plink to reduce false positives
      refs: convert struct ref_entry to use struct object_id
