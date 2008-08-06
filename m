From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Aug 2008, #01; Tue, 05)
Date: Tue, 05 Aug 2008 23:26:36 -0700
Message-ID: <7vfxpislpf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 08:27:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQcUs-0004nZ-MW
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 08:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbYHFG0p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 02:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493AbYHFG0p
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 02:26:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33095 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbYHFG0o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Aug 2008 02:26:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3394957110;
	Wed,  6 Aug 2008 02:26:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 649CC5710D; Wed,  6 Aug 2008 02:26:39 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-maint-at: 2d0f5f3459278475602394a7165bf8919412f4e4
X-master-at: ddd63e64e4ac7e455dff3e807bf6a6977bb61456
X-Pobox-Relay-ID: A1C4C3F4-6380-11DD-AFDD-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91487>

Thanks to many people, we have accumulated quite a few fixes that are
appropriate for 1.6.0 stabilization effort but at the same time apply
equally well to 1.5.6 series.  We might want to do 1.5.6.5 to flush the=
m
while we are at it.

I am planning to tag 1.6.0-rc2 tomorrow evening.  I noticed that both g=
itk
and git-gui have fixes and many updated translations that I intend to
pull before tagging -rc2.

* The 'maint' branch has these fixes since the last announcement.

Anders Melchiorsen (1):
  Documentation: fix diff.external example

Brandon Casey (1):
  t/t4202-log.sh: add newline at end of file

Ciaran McCreesh (1):
  Make git-add -i accept ranges like 7-

Jeff King (1):
  init: handle empty "template" parameter

Jim Meyering (1):
  git-cvsimport.perl: Print "UNKNOWN LINE..." on stderr, not stdout.

Johannes Schindelin (1):
  sort_in_topological_order(): avoid setting a commit flag

Jonathan Nieder (1):
  git-diff(1): "--c" -> "--cc" typo fix

Junio C Hamano (6):
  make sure parsed wildcard refspec ends with slash
  Documentation: clarify diff --cc
  Update my e-mail address
  Start 1.5.6.5 RelNotes to describe accumulated fixes
  builtin-name-rev.c: split deeply nested part from the main function
  RelNotes 1.5.6.5 updates

Linus Torvalds (1):
  diff.renamelimit is a basic diff configuration

Mike Ralphson (1):
  Documentation: typos / spelling fixes in older RelNotes

Pierre Habouzit (1):
  git-submodule: move ill placed shift.

Pieter de Bie (1):
  git-name-rev: allow --name-only in combination with --stdin

Ren=C3=A9 Scharfe (1):
  git-name-rev: don't use printf without format

Stephan Beyer (1):
  builtin-revert.c: typofix

Steve Haslam (1):
  Propagate -u/--upload-pack option of "git clone" to transport.


* The 'master' branch has these since the last announcement
  in addition to the above.

Abhijit Menon-Sen (4):
  Git.pm: localise $? in command_close_bidi_pipe()
  Fix hash slice syntax error
  Fix typo in perl/Git.pm
  Fix typos in INSTALL

Anders Melchiorsen (2):
  Flush output in start_async
  Add output flushing before fork()

Avery Pennarun (2):
  Teach "git diff -p" Pascal/Delphi funcname pattern
  git-svn: Abort with an error if 'fetch' parameter is invalid.

Brandon Casey (1):
  Teach fsck and prune that tmp_obj_ file names may not be 14 bytes lon=
g

David D. Kilzer (1):
  Fix race condition in t9119-git-svn-info.sh

Dmitry Potapov (1):
  correct access right for git-svn-dcommit test

Eric Wong (2):
  git-svn: properly set path for "info" command
  t9119: conditionally re-enable test depending on svn(1) version

Giuseppe Bilotta (2):
  diff: add ruby funcname pattern
  diff: chapter and part in funcname for tex

Johannes Schindelin (2):
  clone: Add an option to set up a mirror
  clone --bare: Add ".git" suffix to the directory name to clone into

Jon Jensen (1):
  Fix reference to Everyday Git, which is an HTML document and not a ma=
n
    page.

Lee Marlow (11):
  bash completion: remove unused function _git_diff_tree
  bash completion: Add more long options for 'git log'
  bash completion: Add completion for 'git grep'
  bash completion: Add completion for 'git clone'
  bash completion: Add completion for 'git clean'
  bash completion: Add completion for 'git init'
  bash completion: Add completion for 'git revert'
  bash completion: More completions for 'git stash'
  bash completion: Add completion for 'git archive'
  bash completion: Add completion for 'git ls-files'
  bash completion: Add completion for 'git mv'

Mike Ralphson (1):
  Documentation: typos / spelling fixes

Steffen Prohaska (1):
  Modify mingw_main() workaround to avoid link errors

Steven Grimm (1):
  Optimize sha1_object_info for loose objects, not concurrent repacks
