From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Wed, 31 Oct 2007 22:39:29 -0700
Message-ID: <7vodeecyni.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 06:39:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InSma-0003qy-UL
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 06:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517AbXKAFjf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Nov 2007 01:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbXKAFjf
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 01:39:35 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:42089 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbXKAFje convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Nov 2007 01:39:34 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 68A912EF;
	Thu,  1 Nov 2007 01:39:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 60ACE8DDC5;
	Thu,  1 Nov 2007 01:39:53 -0400 (EDT)
X-maint-at: 3f2a7ae2c84c921e11041a5edc2522964fc1cce5
X-master-at: afc05f9f13beded8caf15d8e58d06fd64e0f7808
In-Reply-To: <20071022061115.GR14735@spearce.org> (Shawn O. Pearce's message
	of "Mon, 22 Oct 2007 02:11:15 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62919>

* The 'maint' branch has just produced the 1.5.3.5 release.

* The 'master' branch has these since the last announcement
  in addition to what's in 1.5.3.5.

  - git-bisect enhancements to support "git bisect skip".
  - git-fetch rewritten in C for performance and portability.
  - git-svnimport is no more --- use git-svn.
  - git-send-pack does not update the tracking ref on the local
    side for failed push (needs cherry-picking to 'maint').
  - git-rebase does not choke when $GIT_DIR has whitespace in it
    (needs cherry-picking to 'maint').
  - optimize rename detection.
  - comes with updated gitk.

  The above list makes me realize that it probably is a good
  time to start freezing things for 1.5.4.  Tonight's "What's
  cooking" will talk about what other topics should graduate to
  'master' before that happens.

Alex Riesen (1):
  Fix a crash in ls-remote when refspec expands into nothing

Alexandre Julliard (4):
  git.el: Fix typo in "Reverted file" message.
  git.el: Fix typo in git-update-saved-file error handling.
  git.el: Refresh only the changed file marks when marking/unmarking
      all.
  git.el: Run git-gc --auto after commits.

Benoit Sigoure (1):
  core-tutorial: Catch up with current Git

Christian Couder (12):
  Test suite: reset TERM to its previous value after testing.
  rev-list: implement --bisect-all
  rev-list documentation: add "--bisect-all".
  Bisect: fix some white spaces and empty lines breakages.
  Bisect: implement "bisect skip" to mark untestable revisions.
  Bisect: refactor "bisect_write_*" functions.
  Bisect: refactor some logging into "bisect_write".
  Bisect: refactor "bisect_{bad,good,skip}" into "bisect_state".
  Bisect: add "bisect skip" to the documentation.
  Bisect: add a "bisect replay" test case.
  Bisect run: "skip" current commit if script exit code is 125.
  Bisect: add "skip" to the short usage string.

Dan McGee (1):
  Remove outdated references to cogito in documentation

Daniel Barkalow (15):
  Refactor http.h USE_CURL_MULTI fill_active_slots().
  Make function to refill http queue a callback
  Remove obsolete commit-walkers
  Modularize commit-walker
  Add uploadpack configuration info to remote.
  Report information on branches from remote.h
  Make fetch-pack a builtin with an internal API
  Push code for transport library
  Add matching and parsing for fetch-side refspec rules
  Add fetch methods to transport library.
  Make fetch a builtin
  Allow abbreviations in the first refspec to be merged
  Restore default verbosity for http fetches.
  Remove duplicate ref matches in fetch
  Correct handling of upload-pack in builtin-fetch-pack

David Symonds (3):
  gitweb: Provide title attributes for abbreviated author names.
  gitweb: Refactor abbreviation-with-title-attribute code.
  gitweb: Use chop_and_escape_str in more places.

Gerrit Pape (1):
  No longer install git-svnimport, move to contrib/examples

Jakub Narebski (1):
  gitweb: Fix and simplify "split patch" detection

Jari Aalto (1):
  On error, do not list all commands, but point to --help option

Jeff King (2):
  send-pack: don't update tracking refs on error
  t5516: test update of local refs on push

Jim Meyering (1):
  hooks-pre-commit: use \t, rather than a literal TAB in regexp

Johannes Schindelin (6):
  Move bundle specific stuff into bundle.[ch]
  Add bundle transport
  Introduce remove_dir_recursively()
  fetch/push: readd rsync support
  Fix compilation when NO_CURL is defined
  fetch: if not fetching from default remote, ignore default merge

Jonathan del Strother (1):
  Fixing path quoting in git-rebase

Junio C Hamano (5):
  bundle transport: fix an alloc_ref() call
  k.org git toppage: Add link to 1.5.3 release notes.
  help: remove extra blank line after "See 'git --help'" message
  git-fetch: do not fail when remote branch disappears
  RelNotes-1.5.4: describe recent updates

Lars Hjemli (1):
  Teach git-pull about --[no-]ff, --no-squash and --commit

Lars Knoll (1):
  Speedup scanning for excluded files.

Linus Torvalds (8):
  Add 'diffcore.h' to LIB_H
  Split out "exact content match" phase of rename detection
  Ref-count the filespecs used by diffcore
  copy vs rename detection: avoid unnecessary O(n*m) loops
  Do linear-time/space rename logic for exact renames
  Do exact rename detection regardless of rename limits
  Fix ugly magic special case in exact rename detection
  Do the fuzzy rename detection limits with the exact renames removed

Miklos Vajna (1):
  git-send-email: add a new sendemail.to configuration variable

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  git-sh-setup.sh: use "git rev-parse --show-cdup" to check for
      SUBDIRECTORY_OK

Paul Mackerras (34):
  gitk: Establish and use global left-to-right ordering for commits
  gitk: Improve the drawing of links to parent lines
  gitk: Eliminate diagonal arrows
  gitk: Get rid of idrowranges and rowrangelist
  gitk: Get rid of idinlist array
  gitk: Fix some problems with the display of ids as links
  gitk: Get rid of the rowchk array
  gitk: Do only the parts of the layout that are needed
  gitk: Fix bug causing incorrect ref list contents when switching
      view
  gitk: Fix bug causing undefined variable error when cherry-picking
  gitk: Add a cache for the topology info
  gitk: Make it possible to lay out all the rows we have received so
      far
  gitk: Fix bugs in setting rowfinal
  gitk: Get rid of lookingforhead, use commitinterest instead
  gitk: Fix bug in generating patches
  gitk: Simplify highlighting interface and combine with Find
      function
  gitk: Fix a couple of bugs
  gitk: Add progress bars for reading in stuff and for finding
  gitk: Fix the tab setting in the diff display window
  gitk: Fix bug causing Tcl error when changing find match type
  gitk: Use named fonts instead of the font specification
  gitk: Keep track of font attributes ourselves instead of using font
      actual
  gitk: Add a font chooser
  gitk: Fix bug where the last few commits would sometimes not be
      visible
  gitk: Get rid of the diffopts variable
  gitk: Fix Tcl error: can't unset findcurline
  gitk: Limit diff display to listed paths by default
  gitk: Ensure tabstop setting gets restored by Cancel button
  gitk: Integrate the reset progress bar in the main frame
  gitk: Use the status window for other functions
  gitk: Fix some bugs with path limiting in the diff display
  gitk: Fix a couple more bugs in the path limiting
  gitk: Simplify the code for finding commits
  gitk: Use the UI font for the diff/old version/new version radio
      buttons

Pierre Habouzit (3):
  Add some fancy colors in the test library when terminal supports
      it.
  Support a --quiet option in the test-suite.
  fast-import.c: fix regression due to strbuf conversion

Shawn O. Pearce (37):
  Correct builtin-fetch to handle + in refspecs
  Fix off by one bug in reflog messages written by builtin-fetch
  Remove unnecessary debugging from builtin-fetch
  Remove unused unpacklimit variable from builtin-fetch
  Replace custom memory growth allocator with ALLOC_GROW
  Simplify fetch transport API to just one function
  Refactor index-pack "keep $sha1" handling for reuse
  Remove pack.keep after ref updates in git-fetch
  Always ensure the pack.keep file is removed by git-fetch
  Fix builtin-fetch memory corruption by not overstepping array
  Backup the array passed to fetch_pack so we can free items
  Properly cleanup in http_cleanup so builtin-fetch does not segfault
  Don't bother passing ref log details to walker in builtin-fetch
  Cleanup duplicate initialization code in transport_get
  Add transport.h to LIB_H as transport.o is in LIB_OBJS
  Remove unnecessary 'fetch' argument from transport_get API
  Allow builtin-fetch to work on a detached HEAD
  Don't configure remote "." to fetch everything to itself
  Remove more debugging from builtin-fetch
  builtin-fetch: Don't segfault on "fetch +foo"
  Don't attempt to merge non-existant remotes in t5515
  Correct handling of branch.$name.merge in builtin-fetch
  Avoid printing unnecessary warnings during fetch and push
  Use 'unsigned:1' when we mean boolean options
  Rename remote.uri to remote.url within remote handling internals
  Refactor struct transport_ops inlined into struct transport
  Always obtain fetch-pack arguments from struct fetch_pack_args
  Ensure builtin-fetch honors {fetch,transfer}.unpackLimit
  Fix memory leaks when disconnecting transport instances
  Cleanup style nit of 'x =3D=3D NULL' in remote.c
  Cleanup unnecessary break in remote.c
  Prevent send-pack from segfaulting when a branch doesn't match
  Fix 'push --all branch...' error handling
  Support 'push --dry-run' for rsync transport
  Support 'push --dry-run' for http transport
  Avoid scary errors about tagged trees/blobs during git-fetch
  Define compat version of mkdtemp for systems lacking it

V=C3=A4in=C3=B6 J=C3=A4rvel=C3=A4 (1):
  Added a test for fetching remote tags when there is not tags.
