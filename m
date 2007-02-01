From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.5.0-rc3
Date: Wed, 31 Jan 2007 16:26:36 -0800
Message-ID: <7v7iv2soxv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 01:26:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCPml-00043E-Uv
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 01:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbXBAA0k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 31 Jan 2007 19:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933382AbXBAA0k
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 19:26:40 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61683 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933379AbXBAA0i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Jan 2007 19:26:38 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070201002637.MOTU15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Wed, 31 Jan 2007 19:26:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id J0Sd1W00T1kojtg0000000; Wed, 31 Jan 2007 19:26:37 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38315>

It's been a week and a half, and here comes the -rc3

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.0-rc3.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.0-rc3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.0-rc3.tar.{gz,bz2}		(preformatted docs)
  testing/git-*-1.5.0-rc3-1.$arch.rpm		(RPM)

Hopefully this will be the last -rc before the final 1.5.0.

This contains the "git user's manual" by J. Bruce Fields.  While
it still has its own "To Do" section, it has already been in a
very good shape for some time, giving information with coherence
and guiding a new user in a carefully chosen order of topics
into much more pleasant git experience than before.

----------------------------------------------------------------

Changes since v1.5.0-rc2 are as follows:

Alex Riesen (5):
  Insert ACTIVESTATE_STRING in Git.pm
  Force Activestate Perl to tie git command pipe handle to a handle cla=
ss
  Cleanup uninitialized value in chomp
  Allow default core.logallrefupdates to be overridden with template's =
config
  Fix git-update-index to work with relative pathnames.

Alexandre Julliard (1):
  vc-git.el: Take into account the destination name in vc-checkout.

Andy Parkins (5):
  New files in git weren't being downloaded during CVS update
  If abbrev is set to zero in git-describe, don't add the unique suffix
  Allow the tag signing key to be specified in the config file
  UNIX reference time of 1970-01-01 00:00 is UTC timezone, not local ti=
me zone
  Heavily expanded update hook to send more useful emails than the old =
hook

Aneesh Kumar K.V (2):
  blameview: Use git-cat-file to read the file content.
  Update git-cat-file documentation

Bill Lear (1):
  Document --check option to git diff.

David K=E5gedal (1):
  Improved error message from git-rebase

Eric Wong (1):
  git-svn: remove leading slash when printing removed directories

J. Bruce Fields (31):
  Documentation: add git user's manual
  Documentation: expand preface and todo's
  Documentation: git-rebase discussion, miscellaneous user-manual updat=
es
  Documentation: more user-manual todo's
  Documentation: reorder development section, todo's
  Documentation: begin discussion of git-remote in user manual
  Documentation: rev-list -> rev-parse, other typos, start examples
  user manual: answer some comments from Junio
  user-manual: replace init-db by init
  user-manual: reindent
  user-manual:  rewrap, fix heading levels
  user-manual: add "quick start" as chapter 1
  user-manual: minor quickstart reorganization
  user-manual: clarify difference between tag and branch
  user-manual: update references discussion
  user-manual: update git-gc discussion
  user-manual: stub discussion of fsck and reflog
  user-manual: reorganize fetch discussion, add internals, etc.
  user-manual: git-fsck, dangling objects
  user-manual: fsck-objects -> fsck
  user-manual: repo-config -> config
  user-manual: add references to git-config man page
  user-manual: typo fix
  user-manual: fix a header level
  user-manual: reflogs, other recovery
  user-manual: rewrap a few long lines
  user-manual: minor "TODO" updates
  user-manual: document git-show-branch example
  user-manual: SHA1 -> object name
  user-manual: point to README for gitweb information
  user-manual: todo's

Jakub Narebski (3):
  Documentation/config.txt: Document config file syntax better
  t/t1300-repo-config.sh: value continued on next line
  Documentation/config.txt: Correct info about subsection name

Jason Riedy (1):
  Use inttypes.h rather than stdint.h.

Jeff King (4):
  format-patch: fix bug with --stdout in a subdirectory
  contrib/vim: update syntax for changed commit template
  diffcore-pickaxe: fix infinite loop on zero-length needle
  Add a sample program 'blameview' to show how to use git-blame --incre=
mental

Johannes Schindelin (2):
  annotate: use pager
  reflog inspection: introduce shortcut "-g"

Johannes Sixt (1):
  Add a missing fork() error check.

Junio C Hamano (43):
  User manual: fix typos in examples
  Documentation/tutorial-2: Fix interesting typo in an example.
  Revert "prune: --grace=3Dtime"
  Make sure git_connect() always give two file descriptors.
  is_repository_shallow(): prototype fix.
  shallow repository: disable unsupported operations for now.
  git-gc: do not run git-prune by default.
  cvsimport: activate -a option, really.
  .mailmap: fix screw-ups in Uwe's name
  honor --author even with --amend, -C, and -c.
  reflog gc: a tag that does not point at a commit is not a crime.
  git-checkout -m: fix merge case
  git-daemon documentation on enabling services.
  ls-remote and clone: accept --upload-pack=3D<path> as well.
  Refactor the pack header reading function out of receive-pack.c
  Allow fetch-pack to decide keeping the fetched pack without exploding
  fetch-pack: remove --keep-auto and make it the default.
  Consolidate {receive,fetch}.unpackLimit
  Allow non-developer to clone, checkout and fetch more easily.
  parse-remote: do not barf on a remote shorthand without any refs to f=
etch.
  show-branch -g: default to HEAD
  Documentation: pack-refs --all vs default behaviour
  Make sure we do not write bogus reflog entries.
  git-merge: leave sensible reflog message when used as the first level=
 UI.
  create_symref: check error return from open().
  write_in_full: size_t is unsigned.
  Don't force everybody to call setup_ident().
  git-blame --porcelain: quote filename in c-style when needed.
  Update describe documentation.
  Document 'git-blame --incremental'
  git-fsck-objects is now synonym to git-fsck
  Two small typofixes.
  lock_any_ref_for_update(): do not accept malformatted refs.
  git-commit -s: no extra space when sign-offs appear at the end alread=
y.
  git-blame: somewhat better commenting.
  git-send-email: remove debugging output.
  Fix git-tag -u
  Documentation: "git-checkout <tree> <path>" takes any tree-ish
  t9200: Re-code non-ascii path test in UTF-8
  t9200: do not test -x bit if the filesystem does not support it.
  git main documentation: point at the user's manual.
  Do not use hardcoded path to xhmtl.xsl to generate user's manual
  GIT v1.5.0-rc3

Linus Torvalds (5):
  fsck-objects: refactor checking for connectivity
  Fix seriously broken "git pack-refs"
  Add dangling objects tips.
  git-blame --incremental
  git-push through git protocol

Mark Wooding (3):
  wt-status: Actually accept `color.status.BLAH' configuration variable=
s.
  Documentation/config.txt: Fix documentation of colour config tweaks.
  Make fsck and fsck-objects be builtins.

Nicolas Pitre (3):
  fix suggested branch creation command when detaching head
  git-log -g --pretty=3Doneline should display the reflog message
  tone down the detached head warning

Peter Eriksen (2):
  sha1_file.c: Avoid multiple calls to find_pack_entry().
  Documentation: --amend cannot be combined with -c/-C/-F.

Ren=E9 Scharfe (1):
  git-blame --incremental: don't use pager

Sam Vilain (1):
  contrib/emacs/vc-git.el: support vc-version-other-window

Santi B=E9jar (1):
  git-fetch: Allow fetching the remote HEAD

Shawn O. Pearce (6):
  Remove unnecessary found variable from describe.
  Teach git-describe to display distances from tags.
  Compute accurate distances in git-describe before output.
  Teach for-each-ref about a little language called Tcl.
  Don't coredump on bad refs in update-server-info.
  Escape --upload-pack from expr.

Simon 'corecode' Schubert (1):
  Replace perl code with pure shell code

Tom Prince (1):
  Rename git-repo-config to git-config.

Uwe Kleine-K=F6nig (2):
  rename --exec to --upload-pack for fetch-pack and peek-remote
  make --upload-pack option to git-fetch configurable
