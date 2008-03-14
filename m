From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Fri, 14 Mar 2008 02:11:38 -0700
Message-ID: <7vod9hr7p1.fsf@gitster.siamese.dyndns.org>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
 <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
 <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org>
 <7vejb7ymep.fsf@gitster.siamese.dyndns.org>
 <7vfxvhjukt.fsf@gitster.siamese.dyndns.org>
 <7vablloqqe.fsf@gitster.siamese.dyndns.org>
 <7vod9wlfx5.fsf@gitster.siamese.dyndns.org>
 <7v8x0wie56.fsf@gitster.siamese.dyndns.org>
 <7v4pbhv87i.fsf@gitster.siamese.dyndns.org>
 <7vfxv0npis.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 10:12:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja5y9-0003E2-OV
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 10:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbYCNJLt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 05:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbYCNJLt
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 05:11:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbYCNJLr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 05:11:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E81F5228A;
	Fri, 14 Mar 2008 05:11:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id F17192289; Fri, 14 Mar 2008 05:11:40 -0400 (EDT)
X-maint-at: 1b56bc9a1545902db64b8bdce48a499900acfe0b
X-master-at: 1658c6149ac4462c874810c760507040122917e8
In-Reply-To: <7vfxv0npis.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 09 Mar 2008 03:46:35 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77194>

We still have remaining fixes and a handful backports (cherry-picks) fr=
om
'master' to 'maint', and we would probably need v1.5.4.5 shortly.

On the 'master' front, we have git-gui updates, more bash completion, a=
nd
a few recent graduates (rewrite of unpack_trees(), reimplementation of
git-remote).

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

Andy Whitcroft (1):
  shortlog: take the first populated line of the description

Clemens Buchacher (1):
  merge-recursive: handle file mode changes

Jakub Narebski (1):
  gitweb: Fix bug in href(..., -replay=3D>1) when using 'pathinfo' form

Jeff King (1):
  t0021: tr portability fix for Solaris

Johannes Schindelin (3):
  launch_editor(): allow spaces in the filename
  git fetch: Take '-n' to mean '--no-tags'
  merge-file: handle empty files gracefully

Junio C Hamano (3):
  filter-branch: handle "disappearing tree" case correctly in subdir fi=
lter
  git-pull documentation: warn about the option order
  quiltimport: fix misquoting of parsed -p<num> parameter

Marc-Andre Lureau (2):
  git-svn: fix find-rev error message when missing arg
  git-cvsimport: fix merging with remote parent branch

Mike Hommey (1):
  git rebase --abort: always restore the right commit

Pierre Habouzit (1):
  git-quiltimport: better parser to grok "enhanced" series files.

Vineet Kumar (1):
  Minor wording changes in the keyboard descriptions in git-add
    --interactive.

----------------------------------------------------------------

* The 'master' branch has these since the last announcement
  in addition to the above.

Adam Pi=C4=85tyszek (1):
  git-gui: Add option for changing the width of the commit message text=
 box

Christian Couder (2):
  web--browse: use custom commands defined at config time
  Documention: web--browse: add info about "browser.<tool>.cmd" config =
var

Johannes Schindelin (9):
  path-list: add functions to work with unsorted lists
  parseopt: add flag to stop on first non option
  Test "git remote show" and "git remote prune"
  Make git-remote a builtin
  builtin-remote: prune remotes correctly that were added with --mirror
  remote show: Clean up connection correctly if object fetch wasn't don=
e
  remote: fix "update [group...]"
  builtin remote rm: remove symbolic refs, too
  gc: call "prune --expire 2.weeks.ago" by default

Junio C Hamano (6):
  merge-recursive: split low-level merge functions out.
  expose a helper function peel_to_type().
  traverse_trees_recursive(): propagate merge errors up
  git-gui: Simplify MSGFMT setting in Makefile
  Documentation/config: typofix
  read-tree() and unpack_trees(): use consistent limit

Kevin Ballard (1):
  bash: Properly quote the GIT_DIR at all times to fix subdirectory pat=
hs
    with spaces

Linus Torvalds (11):
  Add 'df_name_compare()' helper function
  Make 'traverse_tree()' use linked structure rather than 'const char
    *base'
  Add return value to 'traverse_tree()' callback
  Make 'traverse_trees()' traverse conflicting DF entries in parallel
  Move 'unpack_trees()' over to 'traverse_trees()' interface
  Fix tree-walking compare_entry() in the presense of --prefix
  Add 'const' where appropriate to index handling functions
  Make 'unpack_trees()' take the index to work on as an argument
  Make 'unpack_trees()' have a separate source and destination index
  unpack_trees(): minor memory leak fix in unused destination index
  unpack_trees(): fix diff-index regression.

Michal Rokos (1):
  autoconf: Test FREAD_READS_DIRECTORIES

Nicolas Pitre (1):
  pack-objects: proper pack time stamping with --max-pack-size

Philipp A. Hartmann (1):
  git-gui: if a background colour is set, set foreground colour as well

SZEDER G=C3=A1bor (7):
  bash: remove unnecessary conditions when checking for subcommands
  bash: refactor searching for subcommands on the command line
  bash: add new 'git stash' subcommands
  bash: add 'git svn' subcommands and options
  bash: use __gitdir when completing 'git rebase' options
  bash: fix long option with argument double completion
  update 'git rebase' documentation

Samuel Tardieu (1):
  "remote update": print remote name being fetched from

Shawn O. Pearce (1):
  bash: Remove completion of core.legacyheaders option

Teemu Likonen (1):
  bash: Add more long options to be completed with "git --<TAB>"

eric miao (1):
  git-gui: translate the remaining messages in zh_cn.po to chinese
