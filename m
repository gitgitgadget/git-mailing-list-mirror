From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Wed, 20 Feb 2008 20:16:14 -0800
Message-ID: <7vejb7ymep.fsf@gitster.siamese.dyndns.org>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
 <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
 <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 05:17:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS2rk-0000cb-3l
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 05:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbYBUEQZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Feb 2008 23:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbYBUEQZ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 23:16:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38019 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbYBUEQX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Feb 2008 23:16:23 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 696CD4946;
	Wed, 20 Feb 2008 23:16:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 7A97A4945; Wed, 20 Feb 2008 23:16:17 -0500 (EST)
X-maint-at: 0ca15e7217285edaa6c93b53165e1250d25f030b
X-master-at: b23b27eb5dc950081d4f76ae84f10168c4d149bd
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74590>

With a handful of fixes and RPM specfile updates, we would
probably want to do 1.5.4.3 in a week or so from 'maint'.

A handful of new topics are now on 'master', and the ones still
on 'next' are maturing with necessary fixes.  I think we have
enough material for 1.5.5 when they graduate, and I am hoping to
do an rc1 sometime early to mid next month.  We'll see.

* The 'maint' branch has these fixes since the last announcement.

Gerrit Pape (1):
  git-clone.sh: properly configure remote even if remote's head is dang=
ling

Jay Soffian (1):
  send-email: squelch warning due to comparing undefined $_ to ""

Jeff King (3):
  push: indicate partialness of error message
  Documentation/push: clarify matching refspec behavior
  push: document the status output

Junio C Hamano (1):
  GIT 1.5.4.2

Kristian H=C3=B8gsberg (1):
  Rename git-core rpm to just git and rename the meta-pacakge to git-al=
l.

Miklos Vajna (1):
  Documentation/git-stash: document options for git stash list

Pekka Kaitaniemi (1):
  Clarified the meaning of git-add -u in the documentation


* The 'master' branch has these since the last announcement
  in addition to the above.

Brandon Casey (1):
  Add compat/fopen.c which returns NULL on attempt to open directory

Bruno Ribas (1):
  gitweb: Use the config file to set repository owner's name.

Christian Couder (1):
  help.c: use 'git_config_string' to get 'help_default_format'.

Daniel Barkalow (1):
  API documentation for remote.h

David K=C3=A5gedal (1):
  git.el: Set process-environment instead of invoking env

Jakub Narebski (3):
  gitweb: Fix displaying unchopped argument in chop_and_escape_str
  gitweb: Add new option -nohtml to quot_xxx subroutines
  gitweb: Fix bug in href(..., -replay=3D>1) when using 'pathinfo' form

Jay Soffian (1):
  Correct git-pull documentation

Jeff King (2):
  hard-code the empty tree object
  add--interactive: handle initial commit better

Johannes Schindelin (5):
  http-push: avoid invalid memory accesses
  http-push: do not get confused by submodules
  http-push: avoid a needless goto
  bisect view: check for MinGW32 and MacOSX in addition to X11
  cvsexportcommit: be graceful when "cvs status" reorders the arguments

Johannes Sixt (1):
  Technical documentation of the run-command API.

Junio C Hamano (5):
  setup: sanitize absolute and funny paths in get_pathspec()
  git-add: adjust to the get_pathspec() changes.
  builtin-mv: minimum fix to avoid losing files
  Sync with 1.5.4.2 and start 1.5.5 Release Notes
  sending errors to stdout under $PAGER

Lars Hjemli (1):
  Simplify setup of $GIT_DIR in git-sh-setup.sh

Linus Torvalds (1):
  Add "--show-all" revision walker flag for debugging

Marco Costalba (1):
  Avoid a useless prefix lookup in strbuf_expand()

Martin Koegler (15):
  deref_tag: handle return value NULL
  deref_tag: handle tag->tagged =3D NULL
  check return code of prepare_revision_walk
  read_object_with_reference: don't read beyond the buffer
  get_sha1_oneline: check return value of parse_object
  mark_blob/tree_uninteresting: check for NULL
  reachable.c::add_one_tree: handle NULL from lookup_tree
  list-objects.c::process_tree/blob: check for NULL
  check results of parse_commit in merge_bases
  process_tag: handle tag->tagged =3D=3D NULL
  reachable.c::process_tree/blob: check for NULL
  revision.c: handle tag->tagged =3D=3D NULL
  parse_commit: don't fail, if object is NULL
  check return value from parse_commit() in various functions
  peel_onion: handle NULL

Matthias Kestenholz (1):
  Add color.ui variable which globally enables colorization if set

Robin Rosenberg (1):
  Make blame accept absolute paths
