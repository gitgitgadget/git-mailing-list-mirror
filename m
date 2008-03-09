From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sun, 09 Mar 2008 03:46:35 -0700
Message-ID: <7vfxv0npis.fsf@gitster.siamese.dyndns.org>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
 <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
 <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org>
 <7vejb7ymep.fsf@gitster.siamese.dyndns.org>
 <7vfxvhjukt.fsf@gitster.siamese.dyndns.org>
 <7vablloqqe.fsf@gitster.siamese.dyndns.org>
 <7vod9wlfx5.fsf@gitster.siamese.dyndns.org>
 <7v8x0wie56.fsf@gitster.siamese.dyndns.org>
 <7v4pbhv87i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 09 11:47:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYJ45-00042t-LR
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 11:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbYCIKqt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Mar 2008 06:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbYCIKqt
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 06:46:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbYCIKqs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Mar 2008 06:46:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7CED424C5;
	Sun,  9 Mar 2008 06:46:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 86DDF24C4; Sun,  9 Mar 2008 06:46:43 -0400 (EDT)
X-maint-at: 56d5fe285583b5177ffc65dbe7df636ed5b8cc6b
X-master-at: 50753d00d691c1ea16bc72446705aee2c128fc2f
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76651>

Maintenance release 1.5.4.4 is out with accumulated fixes.

Except for a few remaining topics ("remote rewritten in C", and "saner
unpack_trees"), 'master' is almost feature complete for 1.5.5 and we wi=
ll
hopefully soon enter -rc freeze.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

Adeodato Sim=C3=B3 (1):
  Really make the LF after reset in fast-import optional

Johannes Schindelin (1):
  cvsexportcommit: be graceful when "cvs status" reorders the arguments

Johannes Sixt (2):
  daemon: send more error messages to the syslog
  daemon: ensure that base-path is an existing directory

John Goerzen (1):
  Fix dcommit, rebase when rewriteRoot is in use

Junio C Hamano (2):
  Fix "git log --merge --left-right"
  GIT 1.5.4.4

Mike Hommey (1):
  Set proxy override with http_init()

Santi B=C3=A9jar (1):
  ident.c: reword error message when the user name cannot be determined

Sebastian Noack (1):
  git-svn: Don't prompt for client cert password everytime.

----------------------------------------------------------------

* The 'master' branch has these since the last announcement
  in addition to the above.

Andy Whitcroft (1):
  shortlog: take the first populated line of the description

Carlos Rica (1):
  Make builtin-reset.c use parse_options.

Charles Bailey (2):
  git-mergetool documentaiton: show toolnames in typewriter font
  merge-tool documentation: describe custom command usage

Dmitry Potapov (2):
  Make private quote_path() in wt-status.c available as
    quote_path_relative()
  git-clean: correct printing relative path

Jakub Narebski (1):
  gitweb: Fix and simplify pickaxe search

Jeff King (1):
  Add a test for read-tree -u --reset with a D/F conflict

Junio C Hamano (10):
  describe --always: fall back to showing an abbreviated object name
  am: read from the right mailbox when started from a subdirectory
  am: remove support for -d .dotest
  am: --rebasing
  get_pathspec(): die when an out-of-tree path is given
  Revert part of 744dacd (builtin-mv: minimum fix to avoid losing files=
)
  Revert part of 1abf095 (git-add: adjust to the get_pathspec() changes=
)
  Revert part of d089eba (setup: sanitize absolute and funny paths in
    get_pathspec())
  git-clean: add tests for relative path
  filter-branch: handle "disappearing tree" case correctly in subdir fi=
lter

Mark Levedahl (1):
  git-submodule - Allow adding a submodule in-place

Michal Rokos (1):
  Add compat/snprintf.c for systems that return bogus

Pierre Habouzit (2):
  parse-opt: bring PARSE_OPT_HIDDEN and NONEG to git-rev-parse --parseo=
pt
  parse-options: new option type to treat an option-like parameter as a=
n
    argument.

Shawn O. Pearce (11):
  Remove unused variable in builtin-fetch find_non_local_tags
  Remove unnecessary delaying of free_refs(ref_map) in builtin-fetch
  Ensure tail pointer gets setup correctly when we fetch HEAD only
  Allow builtin-fetch's find_non_local_tags to append onto a list
  Free the path_lists used to find non-local tags in git-fetch
  Teach upload-pack to log the received need lines to an fd
  Make git-fetch follow tags we already have objects for sooner
  Teach git-fetch to grab a tag at the same time as a commit
  git-pack-objects: Automatically pack annotated tags if object was pac=
ked
  Teach fetch-pack/upload-pack about --include-tag
  Teach git-fetch to exploit server side automatic tag following

