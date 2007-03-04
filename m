From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Sun, 04 Mar 2007 02:32:38 -0800
Message-ID: <7v8xed5mex.fsf@assigned-by-dhcp.cox.net>
References: <7vbqjp1dyx.fsf@assigned-by-dhcp.cox.net>
	<7v3b4x9sst.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 04 11:33:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNo1S-0006MI-MQ
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 11:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbXCDKcm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Mar 2007 05:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbXCDKcm
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 05:32:42 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:50934 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbXCDKck convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Mar 2007 05:32:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070304103240.VGMH2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 4 Mar 2007 05:32:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WaYe1W00R1kojtg0000000; Sun, 04 Mar 2007 05:32:39 -0500
X-maint-at: 7943b3a94f0f862dc9d7dcec6b5639ae5bf027bd
X-master-at: 102a0a2db14cd7604a8a2b6590ecbd6bf3136394
In-Reply-To: <7v3b4x9sst.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 23 Feb 2007 00:33:54 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41353>

I'll do another maintenance release 1.5.0.3 soonish to flush
accumulated fixes on 'maint' branch.

On the 'master' front, we have

 * a largish git-svn updates.
 * a handful git diff improvements.
 * a beginning of CRLF mangling.
 * improved behaviour of git-apply run in subdirectories.
 * /etc/gitconfig

Soon we will also have these from 'next'.  I think it will be
time to do v1.5.1 after they are in:

 * "fake symlink" work for MinGW port
 * built-in revert/cherry-pick
 * "git diff" that compares stdin and /dev/null
 * make "git fetch" quieter when noninteractive.

----------------------------------------------------------------
* The 'maint' branch has these fixes since v1.5.0.2.

 Alexandre Julliard (1):
  git.el: Set the default commit coding system from the repository conf=
ig.

 Aneesh Kumar K.V (1):
  blameview: Fix the browse behavior in blameview

 Christian Schlotter (1):
  Documentation: Correct minor typo in git-add documentation.

 Eygene Ryabinkin (2):
  http-push.c::lock_remote(): validate all remote refs.
  Another memory overrun in http-push.c

 Gerrit Pape (2):
  git-cvsexportcommit: don't cleanup .msg if not yet committed to cvs.
  Fix quoting in update hook template

 Jim Meyering (1):
  diff --cc: integer overflow given a 2GB-or-larger file

 Johannes Schindelin (3):
  fetch.o depends on the headers, too.
  builtin-archive: use RUN_SETUP
  Document the config variable format.suffix

 Junio C Hamano (4):
  git-apply: do not fix whitespaces on context lines.
  Documentation: git-remote add [-t <branch>] [-m <branch>] [-f] name u=
rl
  Start preparing Release Notes for 1.5.0.3
  git-merge: fail correctly when we cannot fast forward.

 Linus Torvalds (2):
  mailinfo: do not get confused with logical lines that are too long.
  git-show: Reject native ref

 Matthias Kestenholz (1):
  Fix git-gc usage note

 Michael Coleman (2):
  Fix minor typos/grammar in user-manual.txt
  builtin-fmt-merge-msg: fix bugs in --file option

 Michael Poole (1):
  Correct ordering in git-cvsimport's option documentation

 Paolo Bonzini (1):
  git-archimport: support empty summaries, put summary on a single line=
=2E

 Ramsay Allan Jones (5):
  Fix a "label defined but unreferenced" warning.
  Fix an "implicit function definition" warning.
  Fix some "comparison is always true/false" warnings.
  Fix a "pointer type missmatch" warning.
  Unset NO_C99_FORMAT on Cygwin.

 Sergey Vlasov (3):
  Documentation/build-docdep.perl: Fix dependencies for included asciid=
oc files
  Documentation/git-quiltimport.txt: Fix labeled list formatting
  Documentation/git-send-email.txt: Fix labeled list formatting

 Shawn O. Pearce (1):
  index-pack: Loop over pread until data loading is complete.

 Theodore Ts'o (1):
  Fix git-show man page formatting in the EXAMPLES section

 Uwe Kleine-K=C3=B6nig (1):
  Include config.mak in doc/Makefile


* The 'master' branch has these since the last announcement
  in addition to the above.

 Andy Parkins (3):
  cvsserver: Remove trailing "\n" from commithash in checkin function
  cvsserver: Make always-binary mode a config file option
  Sample update hook: typofix and modernization to use "git log"

 Aneesh Kumar K.V (1):
  Documentation: document remote.<name>.tagopt

 Eric Wong (118):
  git-svn: move authentication prompts into their own namespace
  git-svn: cleanup: move process_rm around
  git-svn: cleanup: put SVN workarounds into their own namespace
  git-svn: cleanup: avoid re-use()ing Git.pm in sub-packages
  git-svn: add Git::SVN module (to avoid global variables)
  git-svn: convert 'init' to use Git::SVN
  git-svn: convert multi-init over to using Git::SVN
  git-svn: make multi-init capable of reusing the Ra connection
  git-svn: add a test for show-ignore
  git-svn: convert show-ignore over to Git::SVN
  git-svn: moved the 'log' command into its own namespace
  git-svn: port the 'rebuild' command to use Git::SVN objects
  git-svn: do not let Git.pm warn if we prematurely close pipes
  git-svn: convert the 'commit-diff' command to Git::SVN
  git-svn: get rid of Memoize for now...
  git-svn: fetch/multi-fetch converted over to Git::SVN module
  git-svn: switch dcommit to using Git::SVN code
  git-svn: convert 'set-tree' command to use Git::SVN
  git-svn: remove graft-branches command
  git-svn: add support for metadata in .git/config
  git-svn: fix a regression in dcommit that caused empty log messages
  git-svn: reuse open SVN::Ra connections by URL
  git-svn: enable --minimize to simplify the config and connections
  git-svn: fix --follow-parent to work with Git::SVN
  git-svn: --follow-parent works with svn-remotes multiple branches
  git-svn: disallow ambigious local refspecs
  git-svn: allow --follow-parent on deleted directories
  git-svn: get rid of additional fetch-arguments
  git-svn: allow 'init' to work outside of tests
  git-svn: better error reporting if --follow-parent fails
  git-svn: 'init' attempts to connect to the repository root if possibl=
e
  git-svn: --follow-parent now works on sub-directories of larger branc=
hes
  git-svn: track writes writes to the index in fetch
  git-svn: add an odd test case that seems to cause segfaults over HTTP
  git-svn: avoid tracking change-less revisions
  git-svn: correctly track revisions made to deleted branches
  git-svn: fix segfaults from accessing svn_log_changed_path_t
  git-svn: fix committing to subdirectories, add tests
  git-svn: avoid an extra svn_ra connection during commits
  git-svn: simplify usage of the SVN::Git::Editor interface
  git-svn: cleanup remove unused function
  git-svn: allow multi-fetch to fetch things chronologically
  git-svn: correctly track diff-less copies with do_switch
  git-svn: correctly handle do_{switch,update} in deep directories
  git-svn: stop using path names as refnames with --follow-parent
  git-svn: cleanup: move editor-specific variables into the editor name=
space
  git-svn: just use Digest::MD5 instead of requiring it
  git-svn: reinstate the default SVN error handler after using get_log
  git-svn: don't rely on do_switch + reparenting with svn(+ssh)://
  git-svn: fetch tracks initial change with --follow-parent
  git-svn: remove the 'rebuild' command and make the functionality auto=
matic
  git-svn: fix several fetch bugs related to repeated invocations
  git-svn: reinstate --no-metadata, add --svn-remote=3D, variable clean=
ups
  git-svn: gracefully handle --follow-parent failures
  git-svn: make (multi-)fetch safer but slower
  git-svn: avoid a huge memory spike with high-numbered revisions
  git-svn: re-enable repacking flags
  git-svn: do our best to ensure that our ref and rev_db are consistent
  git-svn: avoid redundant get_log calls between invocations
  git-svn: use sys* IO functions for reading rev_db
  git-svn: don't write to the config file from --follow-parent
  git-svn: save paths to tags/branches with for future reuse
  git-svn: migrations default to [svn-remote "git-svn"]
  git-svn: get rid of revisions_eq check for --follow-parent
  git-svn: avoid extra get_log calls when refspecs are added for fetchi=
ng
  git-svn: just name the default svn-remote "svn" instead of "git-svn"
  git-svn: prepare multi-init for wildcard support
  git-svn: reintroduce using a single get_log() to fetch
  git-svn: run get_log() on a sub-directory if possible
  git-svn: implement auto-discovery of branches/tags
  git-svn: --follow-parent tracks multi-parent paths
  git-svn: remove check_path calls before calling do_update
  git-svn: remove some noisy debugging messages
  git-svn: enable follow-parent functionality by default
  git-svn: fix buggy regular expression usage in several places
  git-svn: correctly handle the -q flag in SVN::Git::Fetcher
  git-svn: correctly handle globs with a right-hand-side path component
  git-svn: remove optimized commit stuff for set-tree
  git-svn: add support for SVN::Mirror/svk using revprops for metadata
  git-svn: add support for per-[svn-remote "..."] options
  git-svn: use private $GIT_DIR/svn/config file more
  git-svn: extra safety for noMetadata and useSvmProps users
  git-svn: use separate, per-repository .rev_db files
  git-svn: write the highest maxRex out for branches and tags
  git-svn: handle multi-init without --trunk, UseSvmProps fixes
  git-svn: make dcommit usable for glob users
  git-svn: include merges when calling rev-list for decommit
  git-svn: usability fixes for the 'git svn log' command
  t910*: s/repo-config/config/g; poke around possible race conditions
  git-svn: hopefully make 'fetch' more user-friendly
  git-svn: allow 'init' to act as multi-init
  git-svn: brown paper bag fixes
  git-svn: simplify the (multi-)init methods of fetching
  git-svn: allow --log-window-size to be specified, default to 100
  git-svn: remember to check for clean indices on globbed refs, too
  git-svn: error checking for invalid [svn-remote "..."] sections
  git-svn: allow dcommit for those who only fetch from SVM with useSvmP=
rops
  git-svn: documentation updates for new functionality
  git-svn: add support for --stat in the log command
  git-svn: checkout files on new fetches
  git-svn: add a 'rebase' command
  git-svn: fix some issues for people migrating from older versions
  git-svn: hide the private git-svn 'config' file as '.metadata'
  git-svn: add 'clone' command, an alias for init + fetch
  git-svn: allow overriding of the SVN repo root in metadata
  git-svn: add support for using svnsync properties
  git-svn: fix useSvmProps, hopefully for the last time
  git-svn: add test for useSvnsyncProps
  git-svn: documentation updates
  git-svn: allow metadata options to be specified with 'init' and 'clon=
e'
  git-svn: give show-ignore HEAD smarts, like dcommit and log
  git-svn: ensure we're at the top-level and can access $GIT_DIR
  git-svn: fix clone when a target directory has been specified
  git-svn: fix reconnections to different paths of svn:// repositories
  git-svn: fix some potential bugs with --follow-parent
  Add test-chmtime: a utility to change mtime on files
  Update tests to use test-chmtime
  git-svn: fix show-ignore when not connected to the repository root

 Johannes Schindelin (18):
  rev-list --max-age, --max-count: support --boundary
  config: read system-wide defaults from /etc/gitconfig
  apply: make --verbose a little more useful
  Teach git-diff-files the new option `--no-index`
  pretty-formats: add 'format:<string>'
  Make tests independent of global config files
  Add git-bundle: move objects and references by archive
  git-bundle: assorted fixes
  git-bundle: avoid fork() in verify_bundle()
  git-bundle: fix 'create --all'
  git-bundle: record commit summary in the prerequisite data
  object name: introduce ':/<oneline prefix>' notation
  Fix typo: do not show name1 when name2 fails
  diff --no-index: also imitate the exit status of diff(1)
  Actually make print_wrapped_text() useful
  show_date(): rename the "relative" parameter to "mode"
  diff: make more cases implicit --no-index
  print_wrapped_text: fix output for negative indent

 Julian Phillips (2):
  git-branch: improve abbreviation of sha1s in verbose mode
  git-branch: document new --no-abbrev option

 Junio C Hamano (13):
  git-status: do not be totally useless in a read-only repository.
  update-index: do not die too early in a read-only repository.
  run_diff_{files,index}(): update calling convention.
  .mailmap maintenance after pulling from git-svn
  bundle: reword missing prerequisite error message
  diff --cached: give more sensible error message when HEAD is yet to b=
e created.
  Documentation: link in 1.5.0.2 material to the top documentation page=
=2E
  Make 'cvs ci' lockless in git-cvsserver by using git-update-ref
  index_fd(): use enum object_type instead of type name string.
  index_fd(): pass optional path parameter as hint for blob conversion
  index_fd(): convert blob only if it is a regular file.
  Add recent changes to draft 1.5.1 release notes.
  diff-ni: allow running from a subdirectory.

 Michael Coleman (2):
  git-send-email: abort/usage on bad option
  fix various doc typos

 Nicolas Pitre (7):
  sha1_file.c: cleanup hdr usage
  sha1_file.c: cleanup "offset" usage
  sha1_file.c: don't ignore an error condition in sha1_loose_object_inf=
o()
  formalize typename(), and add its reverse type_from_string()
  convert object type handling from a string to a number
  get rid of lookup_object_type()
  make sure enum object_type is signed

 Sam Vilain (3):
  git-svn: make test for SVK mirror path import
  git-svn: don't consider SVN URL usernames significant when comparing
  git-svn: document --username

 Sergey Vlasov (1):
  Documentation/git-svn.txt: Fix formatting errors

 Shawn O. Pearce (1):
  Cleanup check_valid in commit-tree.
