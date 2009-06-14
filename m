From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Jun 2009, #01; Sun, 14)
Date: Sun, 14 Jun 2009 00:12:27 -0700
Message-ID: <7vtz2jqof8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 09:12:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFjtM-0002eo-Ky
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 09:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbZFNHM1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jun 2009 03:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbZFNHM0
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 03:12:26 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:53252 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbZFNHMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 03:12:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090614071228.MHXT20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 14 Jun 2009 03:12:28 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3jCT1c0024aMwMQ04jCTvC; Sun, 14 Jun 2009 03:12:27 -0400
X-VR-Score: -80.00
X-Authority-Analysis: v=1.0 c=1 a=KWHYVSmsEd0A:10 a=7dnsAxWBJxYA:10
 a=upk3KiDiwsLC9TpYcxwA:9 a=OvviaRRc6lKYXxJOqLIA:7
 a=BB8VRXJQp-FgpSOlzn_lTyTRwU8A:4
X-CM-Score: 0.00
X-maint-at: 50a991ec46d57ffc4b7fbd0e8a13182dab3cd5de
X-master-at: 4f4fa9c228a1ac2854c0814b5b23df43b8d98203
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121540>

Here is what we have as of tonight.  We'd probably want 1.6.3.2 soon to
flush these accumulated small fixes, and start making noises about -rc
freeze for 1.6.4 soon.

* The 'maint' branch has these fixes since the last announcement.

Charles Bailey (2):
  t6023: merge-file fails to output anything for a degenerate merge
  Change xdl_merge to generate output even for null merges

Johannes Sixt (3):
  t3701: ensure correctly set up repository after skipped tests
  fetch-pack: close output channel after sideband demultiplexer termina=
tes
  diff.c: plug a memory leak in an error path

Junio C Hamano (4):
  Revert "git-add--interactive: remove hunk coalescing"
  Update draft release notes for 1.6.3.2
  blame: correctly handle a path that used to be a directory
  GIT 1.6.3.2

Matt Graham (1):
  Splitting a hunk that adds a line at the top fails in "add -p"

Michael J Gruber (1):
  builtin-remote: Make "remote show" display all urls

Paolo Bonzini (1):
  Documentation: git-send-mail can take rev-list arg to drive format-pa=
tch

Ren=C3=A9 Scharfe (3):
  grep: fix word-regexp at the beginning of lines
  grep: fix colouring of matches with zero length
  grep: fix empty word-regexp matches

Shawn O. Pearce (1):
  daemon: Strictly parse the "extra arg" part of the command

Stephen Boyd (3):
  commit: -F overrides -t
  apply, fmt-merge-msg: use relative filenames
  git-rerere.txt: grammatical fixups and cleanups

Thomas Rast (3):
  Documentation: teach stash/pop workflow instead of stash/apply
  add -i: do not dump patch during application
  Documentation: refer to gitworkflows(7) from tutorial and git(1)

Uwe Kleine-K=C3=B6nig (1):
  rebase--interactive: remote stray closing parenthesis


* The 'master' branch has these since the last announcement
  in addition to the above.

Brandon Casey (9):
  Makefile: use /usr/ucb/install on SunOS platforms rather than ginstal=
l
  Makefile: add NEEDS_RESOLV to optionally add -lresolv to compile
    arguments
  On Solaris choose the OLD_ICONV iconv() declaration based on the UNIX
    spec
  git-compat-util.h: tweak the way _XOPEN_SOURCE is set on Solaris
  Makefile: define __sun__ on SunOS
  Makefile: add section for SunOS 5.7
  git-compat-util.h: avoid using c99 flex array feature with Sun compil=
er
    5.8
  git-send-email.perl: improve detection of MIME encoded-words
  send-email: use UTF-8 rather than utf-8 for consistency

Christian Couder (5):
  bisect: drop unparse_commit() and use clear_commit_marks()
  bisect: display first bad commit without forking a new process
  bisect: add parameters to "filter_skipped"
  bisect: when skipping, choose a commit away from a skipped commit
  t6030: test skipping away from an already skipped commit

Clemens Buchacher (5):
  match_refs: search ref list tail internally
  refuse to merge during a merge
  test-lib: fail if invalid options are passed
  test-lib: allow exit trap to be used for cleanup by tests
  test-lib: fix http exit codes

Daniel Trstenjak (1):
  Show presence of stashed changes in bash prompt.

David Aguilar (4):
  mergetool--lib: add support for araxis merge
  compat: add a mkstemps() compatibility function
  compat: add a basename() compatibility function
  diff: generate pretty filenames in prep_temp_blob()

Edward Z. Yang (1):
  connect.c: Support PuTTY plink and TortoisePlink as SSH on Windows

Johan Herland (1):
  Rename submodule.<name>.rebase to submodule.<name>.update

Johannes Schindelin (6):
  MinGW: GCC >=3D 4 does not need SNPRINTF_SIZE_CORR anymore
  Quiet make: do not leave Windows behind
  Work around a regression in Windows 7, causing erase_in_line() to cra=
sh
    sometimes
  test-chmtime: work around Windows limitation
  MinGW: fix warning about implicit declaration of _getch()
  Fix warnings in nedmalloc when compiling with GCC 4.4.0

Johannes Sixt (4):
  Simplify some instances of run_command() by using run_command_v_opt()=
=2E
  Simplify some 'fprintf(stderr); return -1;' by using 'return error()'
  Fix typo in nedmalloc warning fix
  compat/ has subdirectories: do not omit them in 'make clean'

Junio C Hamano (4):
  Documentation/git.txt: update links to release notes
  Makefile: introduce SANE_TOOL_PATH for prepending required elements t=
o
    PATH
  Makefile: test-parse-options depends on parse-options.h
  Makefile: insert SANE_TOOL_PATH to PATH before /bin or /usr/bin

Kjetil Barvik (1):
  symlinks.c: small style cleanup

Linus Torvalds (1):
  Clean up and simplify rev_compare_tree()

Marius Storm-Olsen (2):
  MinGW readdir reimplementation to support d_type
  Add custom memory allocator to MinGW and MacOS builds

Markus Heidelberg (6):
  add a test for git-send-email for non-threaded mails
  send-email: fix non-threaded mails
  doc/send-email: clarify the behavior of --in-reply-to with --no-threa=
d
  add a test for git-send-email for threaded mails without chain-reply-=
to
  send-email: fix threaded mails without chain-reply-to
  send-email: fix a typo in a comment

Michael J Gruber (1):
  git-repack.txt: Clarify implications of -a for dumb protocols

Mike Hommey (7):
  Don't expect verify_pack() callers to set pack_size
  transport.c::get_refs_via_curl(): do not leak refs_url
  http.c: new functions for the http API
  transport.c::get_refs_via_curl(): use the new http API
  http.c::http_fetch_ref(): use the new http API
  http-push.c::remote_exists(): use the new http API
  http-push.c::fetch_symref(): use the new http API

Nick Woolley (1):
  git-cvsexportcommit can't commit files which have been removed from C=
VS

Pat Thoyts (1):
  git: browsing paths with spaces when using the start command

Peter Hutterer (1):
  git-submodule: add support for --rebase.

Pierre Habouzit (1):
  parse-options: add parse_options_check to validate option specs.

Ralf Wildenhues (1):
  configure: test whether -lresolv is needed

SZEDER G=C3=A1bor (2):
  Documentation: mention 'git stash pop --index' option explicitly
  bash: add support for 'git stash pop --index' option

Steffen Prohaska (1):
  MinGW: Teach Makefile to detect msysgit and apply specific settings

Stephen Boyd (2):
  git-show-branch.txt: document --date-order option
  show-branch: don't use LASTARG_DEFAULT with OPTARG

Tay Ray Chuan (16):
  http*: cleanup slot->local after fclose
  t5540-http-push: test fetching of loose objects
  t5540-http-push: test fetching of packed objects
  http-push: send out fetch requests on queue
  http-push: fix missing "#ifdef USE_CURL_MULTI" around "is_running_que=
ue"
  t5550-http-fetch: test fetching of packed objects
  http-push, http-walker: style fixes
  http-walker: verify remote packs
  http*: copy string returned by sha1_to_hex
  http-push: do not SEGV after fetching a bad pack idx file
  http*: move common variables and macros to http.[ch]
  http: create function end_url_with_slash
  http*: add http_get_info_packs
  http: use new http API in fetch_index()
  http*: add helper methods for fetching packs
  http*: add helper methods for fetching objects (loose)
