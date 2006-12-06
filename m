X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Wed, 06 Dec 2006 13:18:26 -0800
Message-ID: <7vwt54yb8d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 6 Dec 2006 21:18:50 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-maint-at: 49ed2bc4660c7cd0592cf21cc514080574d06320
X-master-at: de51faf3888505fa3d661d4c35f32ecaf9fa1087
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33521>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs49x-0000Zo-KK for gcvg-git@gmane.org; Wed, 06 Dec
 2006 22:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937154AbWLFVS3 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006 16:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937652AbWLFVS3
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 16:18:29 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:58115 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937154AbWLFVS2 convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 16:18:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206211827.RGYV9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Wed, 6
 Dec 2006 16:18:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vZJd1V00A1kojtg0000000; Wed, 06 Dec 2006
 16:18:37 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

* The 'maint' branch has produced a new release 1.4.4.2

* In the 'master' branch:

  - we now officially favor 'remotes' information to be in
    $GIT_DIR/config, and 'git clone' records origin in there,
    not in $GIT_DIR/remotes/origin (thanks to Andy Parkins).

  - "git send-pack $URL :refs/heads/$branch" can be used to
    delete a remote branch (so does "git push $URL :$ref" over
    git native protocols).

  - built-in shortlog lets you directly say "git shortlog
    v2.6.18..master", instead of piping an output from the
    corresponding "git log v2.6.18..master" into it.

  - git-svn updates
  - gitweb updates
  - gitk updates
  - bash completion updates

The shortlog since the last announcement for 'master' is:

Alex Riesen (2):
      git-blame: fix rev parameter handling.
      Make perl/ build procedure ActiveState friendly.

Andreas Ericsson (2):
      ls-files: Give hints when errors happen.
      git-diff: Introduce --index and deprecate --cached.

Andy Parkins (3):
      Use .git/config for storing "origin" shortcut repository
      Document git-repo-config --bool/--int options.
      De-emphasise the symbolic link documentation.

David Miller (1):
      Pass -M to diff in request-pull

Eric Wong (10):
      git-svn: use ~/.subversion config files when using SVN:: librarie=
s
      git-svn: enable delta transfers during fetches when using SVN:: l=
ibs
      git-svn: update tests for recent changes
      git-svn: error out when the SVN connection fails during a fetch
      git-svn: fix output reporting from the delta fetcher
      git-svn: color support for the log command
      git-svn: documentation updates
      git-svn: fix multi-init
      git-svn: avoid fetching files twice in the same revision
      git-svn: avoid network timeouts for long-running fetches

Han-Wen Nienhuys (1):
      ident.c: Trim hint printed when gecos is empty.

J. Bruce Fields (1):
      cvs-migration: improved section titles, better push/commit explan=
ation

Jakub Narebski (4):
      gitweb: Fix Atom feed <logo>: it is $logo, not $logo_url
      git-clone: Rename --use-immingled-remote option to --no-separate-=
remote
      Document git-diff whitespace flags -b and -w
      gitweb: Allow PNG, GIF, JPEG images to be displayed in "blob" vie=
w

Jim Meyering (1):
      Set permissions of each new file before "cvs add"ing it.

Johannes Schindelin (10):
      Build in shortlog
      shortlog: do not crash on parsing "[PATCH"
      shortlog: read mailmap from ./.mailmap again
      shortlog: handle email addresses case-insensitively
      shortlog: fix "-n"
      shortlog: use pager
      sha1_object_info(): be consistent with read_sha1_file()
      git-mv: search more precisely for source directory in index
      diff -b: ignore whitespace at end of line
      cvs-migration document: make the need for "push" more obvious

Junio C Hamano (24):
      Store peeled refs in packed-refs file.
      remove merge-recursive-old
      git-merge: make it usable as the first class UI
      merge: allow merging into a yet-to-be-born branch.
      Store peeled refs in packed-refs (take 2).
      git-fetch: reuse ls-remote result.
      git-fetch: fix dumb protocol transport to fetch from pack-pruned =
ref
      git-fetch: allow glob pattern in refspec
      Allow git push to delete remote ref.
      git-shortlog: fix common repository prefix abbreviation.
      git-shortlog: make common repository prefix configurable with .ma=
ilmap
      git-fetch: allow forcing glob pattern in refspec
      fetch-pack: do not barf when duplicate re patterns are given
      git-merge: tighten error checking.
      git-merge: do not leak rev-parse output used for checking interna=
lly.
      cvsimport: style fixup.
      git blame -C: fix output format tweaks when crossing file boundar=
y.
      tutorial: talk about user.name early and don't start with commit =
-a
      git-merge: fix confusion between tag and branch
      receive-pack: do not insist on fast-forward outside refs/heads/
      unpack-trees: make sure "df_conflict_entry.name" is NUL terminate=
d.
      git-reset to remove "$GIT_DIR/MERGE_MSG"
      git-merge: squelch needless error message.
      git-merge: fix "fix confusion between tag and branch" for real

Michael Loeffler (1):
      git-fetch: ignore dereferenced tags in expand_refs_wildcard

Nicolas Pitre (2):
      builtin git-shortlog is broken
      pack-objects: remove redundent status information

Paul Mackerras (1):
      gitk: Fix enabling/disabling of menu items on Mac OS X

Ren=E9 Scharfe (1):
      shortlog: remove range check

Sean Estabrooks (1):
      Update documentation to remove incorrect GIT_DIFF_OPTS example.

Shawn O. Pearce (15):
      Teach git-completion.bash how to complete git-merge.
      Hide plumbing/transport commands from bash completion.
      Teach bash how to complete options for git-name-rev.
      Add current branch in PS1 support to git-completion.bash.
      Teach bash how to complete git-format-patch.
      Teach bash how to complete git-cherry-pick.
      Teach bash how to complete git-rebase.
      Teach bash about git log/show/whatchanged options.
      Support bash completion of refs/remote.
      Teach bash about git-repo-config.
      Support --strategy=3Dx completion in addition to --strategy x.
      Cache the list of merge strategies and available commands during =
load.
      Teach bash about git-am/git-apply and their whitespace options.
      Teach bash how to complete long options for git-commit.
      Fix broken bash completion of local refs.

