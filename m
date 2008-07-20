From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sat, 19 Jul 2008 18:59:00 -0700
Message-ID: <7vwsjhgvtn.fsf@gitster.siamese.dyndns.org>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
 <7vwsn75pmv.fsf@gitster.siamese.dyndns.org>
 <7vy77gapkl.fsf@gitster.siamese.dyndns.org>
 <7vmynqfeab.fsf@gitster.siamese.dyndns.org>
 <7vwsmjj0js.fsf@gitster.siamese.dyndns.org>
 <7vhcdchr80.fsf@gitster.siamese.dyndns.org>
 <7vhcd0jyyp.fsf@gitster.siamese.dyndns.org>
 <7vod6wpjvr.fsf@gitster.siamese.dyndns.org>
 <7vod6nikuw.fsf@gitster.siamese.dyndns.org>
 <7viqws6zaz.fsf@gitster.siamese.dyndns.org>
 <7vfxrhwspw.fsf@gitster.siamese.dyndns.org>
 <7vwsknyz9m.fsf@gitster.siamese.dyndns.org>
 <7vlk0z9k5f.fsf@gitster.siamese.dyndns.org>
 <7vej6oipea.fsf@gitster.siamese.dyndns.org>
 <7vabh93lk6.fsf@gitster.siamese.dyndns.org>
 <7vwsk4g5py.fsf@gitster.siamese.dyndns.org>
 <7vr6a7fhwh.fsf@gitster.siamese.dyndns.org>
 <7v1w25xfd6.fsf@gitster.siamese.dyndns.org>
 <7vmykljahl.fsf@gitster.siamese.dyndns.org>
 <7vabgiwlj5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 04:00:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKODd-00014f-Vv
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 04:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053AbYGTB7J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jul 2008 21:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754956AbYGTB7I
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 21:59:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755045AbYGTB7G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jul 2008 21:59:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 943AD3B289;
	Sat, 19 Jul 2008 21:59:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C09D43B286; Sat, 19 Jul 2008 21:59:02 -0400 (EDT)
X-maint-at: a1b6fb04b1c1b581dfac5c13641af8b3ae44810f
X-master-at: 09651dd86eb07d1d6f1a2e88fe7b4860891808c1
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6E43D800-55FF-11DD-BBDA-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89150>

* The 'maint' branch is at 1.5.6.4.

* The 'master' branch has these since the last announcement
  in addition to what is already in 1.5.6.4.

Alexander Gavrilov (3):
  Avoid rescanning unchanged entries in search for copies.
  Do not try to detect move/copy for entries below threshold.
  Support gitlinks in fast-import.

Eric Raible (1):
  Teach lookup_prog not to select directories

Eric Wong (1):
  t/lib-git-svn: fix SVN_HTTPD tests to work with "trash directory"

=46abian Emmes (2):
  Testsuite: Unset CVS_SERVER
  testsuite for cvs co -c

Johannes Sixt (1):
  builtin-clone: rewrite guess_dir_name()

Junio C Hamano (9):
  git-rebase: report checkout failure
  t/aggregate-results: whitespace fix
  Update draft release notes for 1.6.0
  read-cache.c: typofix
  mailinfo: off-by-one fix for [PATCH (foobar)] removal from Subject: l=
ine
  builtin-remote.c: fix earlier "skip_prefix()" conversion
  t9001 (send-email): Do not use hardcoded /bin/sh in test
  .mailmap update
  Getting closer to 1.6.0-rc0

Lars Noschinski (2):
  cvsserver: Add support for packed refs
  cvsserver: Add cvs co -c support

Lukas Sandstr=C3=B6m (3):
  Make some strbuf_*() struct strbuf arguments const.
  Add some useful functions for strbuf manipulation.
  git-mailinfo: use strbuf's instead of fixed buffers

Miklos Vajna (4):
  t0001-init.sh: change confusing directory name
  t1007-hash-object.sh: use quotes for the test description
  git-bisect: use dash-less form on git bisect log
  make remove-dashes: apply to scripts and programs as well, not just t=
o
    builtins

Nanako Shiraishi (3):
  cache-tree.c: make cache_tree_find() static
  builtin-describe.c: make a global variable "pattern" static
  parse-options.c: make check_typos() static

Peter Harris (1):
  Add ANSI control code emulation for the Windows console

Petr Baudis (5):
  Documentation/git-submodule.txt: Add Description section
  Documentation/RelNotes-1.6.0.txt: Expand on the incompatible packfile=
s
  Documentation/git-submodule.txt: Further clarify the description
  Documentation: How to ignore local changes in tracked files
  Documentation/git-merge.txt: Partial rewrite of How Merge Works

Ren=C3=A9 Scharfe (8):
  archive: remove args member from struct archiver
  add context pointer to read_tree_recursive()
  archive: add baselen member to struct archiver_args
  archive: centralize archive entry writing
  archive: unify file attribute handling
  archive: remove extra arguments parsing code
  archive: make zip compression level independent from core git
  archive: remove unused headers

Stephan Beyer (4):
  t/test-lib.sh: exit with small negagive int is ok with test_must_fail
  t/: Use "test_must_fail git" instead of "! git"
  Make usage strings dash-less
  Link git-shell only to a subset of libgit.a

SungHyun Nam (1):
  t/Makefile: use specified shell when running aggregation script
