From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Oct 2008, #05; Wed, 22)
Date: Wed, 22 Oct 2008 22:41:37 -0700
Message-ID: <7v7i7z50mm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 23 07:43:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KssyP-0004H4-05
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 07:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbYJWFlw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Oct 2008 01:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752357AbYJWFlv
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 01:41:51 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46949 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbYJWFlv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Oct 2008 01:41:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E195F90248;
	Thu, 23 Oct 2008 01:41:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 05E0F90247; Thu, 23 Oct 2008 01:41:43 -0400 (EDT)
X-maint-at: 031e6c898f61db1ae0c0be641eac6532c1000d56
X-master-at: 759ad19e772a79a2a5ae6b7377d57eb21d29e6a0
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 49D616CA-A0C5-11DD-85F0-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98942>

The latest maintenance release 1.6.0.3 is out.  'master' has gitk updat=
es
and also quite a lot of topics that have been cooking in 'next'.

* The 'maint' branch has these fixes since the last announcement.

Abhijit Bhopatkar (1):
  Documentation: Clarify '--signoff' for git-commit

Junio C Hamano (2):
  Fix testcase failure when extended attributes are in use
  GIT 1.6.0.3

Nicolas Pitre (1):
  rehabilitate 'git index-pack' inside the object store


* The 'master' branch has these since the last announcement
  in addition to the above.

Alexander Gavrilov (3):
  gitk: Fix a bug in collapsing deeply nested trees
  gitk: Enhance file encoding support
  gitk: Implement batch lookup and caching of encoding attrs

Andreas Ericsson (1):
  rebase: Support preserving merges in non-interactive mode

Brian Gernhardt (1):
  format-patch: autonumber by default

Christian Stimming (1):
  gitk: Add untranslated error messages to translation

Dmitry Potapov (2):
  check-attr: add an internal check_attr() function
  check-attr: Add --stdin option

=46redrik Skolmli (1):
  Documentation: Spelling fix

Giuseppe Bilotta (1):
  gitweb: refactor input parameters parse/validation

Jeff King (8):
  refactor handling of "other" files in ls-files and status
  t4012: use test_cmp instead of cmp
  diff: unify external diff and funcname parsing code
  diff: introduce diff.<driver>.binary
  diff: add filter for converting binary to text
  document "intent to add" option to git-add
  rm: loosen safety valve for empty files
  submodule: fix some non-portable grep invocations

Johannes Schindelin (1):
  Fix fetch/pull when run without --update-head-ok

Johannes Sixt (1):
  git-remote: list branches in vertical lists

Jonas Fonseca (1):
  git-check-attr(1): use 'verse' for multi-line synopsis sections

Junio C Hamano (6):
  pull: allow "git pull origin $something:$current_branch" into an unbo=
rn
    branch
  Fix "checkout --track -b newbranch" on detached HEAD
  reset --hard/read-tree --reset -u: remove unmerged new paths
  demonstrate breakage of detached checkout with symbolic link HEAD
  Enhance hold_lock_file_for_{update,append}() API
  Fix mismerge at cdb22c4 in builtin-checkout.c

Lee Marlow (2):
  bash completion: Add 'workflows' to 'git help'
  workflows documentation: fix link to git-request-pull[1]

Mark Levedahl (1):
  compat/cygwin.c - Use cygwin's stat if core.filemode =3D=3D true

Matt McCutchen (1):
  git-merge-recursive: honor merge.conflictstyle once again

Miklos Vajna (2):
  builtin-commit: use reduce_heads() only when appropriate
  Implement git clone -v

Nanako Shiraishi (2):
  rebase --no-verify
  rebase: Document --no-verify option to bypass pre-rebase hook

Paul Mackerras (6):
  gitk: Use <Button-2> for context menus on OSX
  gitk: Clean up file encoding code and add enable/disable option
  gitk: Fix binding for <Return> in sha1 entry field
  gitk: New way of constructing menus that allows for Alt+letter
    accelerators
  gitk: Regenerate .po files
  gitk: Turn short SHA1 names into links too

Petr Baudis (1):
  Do not rename read-only files during a push

Ren=C3=A9 Scharfe (3):
  add alloc_ref_with_prefix()
  use alloc_ref_from_str() everywhere
  make alloc_ref_from_str() the new alloc_ref()

Richard Quirk (1):
  gitk: Bind Key-Return to create on new branch dialog

Shawn O. Pearce (1):
  describe: Make --tags and --all match lightweight tags more often

Stephen Haberman (1):
  rebase--interactive: fix parent rewriting for dropped commits

Thomas Rast (3):
  Documentation: new upstream rebase recovery section in git-rebase
  Documentation: Refer to git-rebase(1) to warn against rewriting
  Documentation: add manpage about workflows
