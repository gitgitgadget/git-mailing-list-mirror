From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Wed, 18 Jun 2008 00:32:05 -0700
Message-ID: <7vwsknyz9m.fsf@gitster.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 09:33:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8sAG-0005vd-Ez
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 09:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbYFRHcN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jun 2008 03:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752983AbYFRHcM
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 03:32:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50901 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbYFRHcL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 03:32:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E387134C7;
	Wed, 18 Jun 2008 03:32:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6B1D7134C6; Wed, 18 Jun 2008 03:32:08 -0400 (EDT)
X-maint-at: 4afbcab9898ce63ad641dd0de6e9b69deda44330
X-master-at: 8c6b57860d9be5f346c9589a08c9e7c04eeaf99b
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A9898546-3D08-11DD-B414-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85366>

I am sending this out just as the final minute preview before 1.5.6 fin=
al,
hopefully tomorrow night.

* The 'maint' branch has these fixes since the last announcement.

Junio C Hamano (1):
  diff.c: fix emit_line() again not to add extra line

SZEDER G=C3=A1bor (1):
  diff: reset color before printing newline


* The 'master' branch has these since the last announcement
  in addition to the above.

Alejandro Mery (1):
  git-am: head -1 is obsolete and doesn't work on some new systems

Avery Pennarun (2):
  git-svn: don't append extra newlines at the end of commit messages.
  git-svn: test that extra blank lines aren't inserted in commit messag=
es.

Christian Couder (2):
  documentation: bisect: remove bits talking about a bisection branch
  Documentation: RelNotes-1.5.6: talk about renamed HTML files

=46lavio Poletti (1):
  git-instaweb: improve auto-discovery of httpd and call conventions.

Jakub Narebski (2):
  gitweb: Make it work with $GIT containing spaces
  Use 'trash directory' thoroughly in t/test-lib.sh

Johan Herland (3):
  cpio is no longer used by git-clone
  Consistency: Use "libcurl" instead of "cURL library" and "curl"
  The "curl" executable is no longer required

Junio C Hamano (8):
  t4126: fix test that happened to work due to timing
  sha1_file.c: dead code removal
  GIT 1.5.6-rc3
  Makefile: update check-docs target
  Update RPM spec to drop curl executable requirement
  create_tempfile: make sure that leading directories can be accessible=
 by
    peers
  sha1_file.c: simplify parse_pack_index()
  builtin-rerere: fix a small leak

Lea Wiemann (2):
  gitweb: quote commands properly when calling the shell
  gitweb: remove unused parse_ref method

Linus Torvalds (4):
  Avoid cross-directory renames and linking on object creation
  Make loose object file reading more careful
  Simplify and rename find_sha1_file()
  write_loose_object: don't bother trying to read an old object

Mark Levedahl (1):
  git-submodule - Fix errors regarding resolve_relative_url

Mike Hommey (1):
  Don't allocate too much memory in quote_ref_url

Miklos Vajna (2):
  run-command documentation: fix "memset()" parameter
  path-list documentation: document all functions and data structures

Olivier Marin (1):
  Fix approxidate("never") to always return 0

Pierre Habouzit (1):
  Make git reflog expire honour core.sharedRepository.

Ren=C3=A9 Scharfe (1):
  Ignore .gitattributes in bare repositories

SZEDER G=C3=A1bor (2):
  git add: add long equivalents of '-u' and '-f' options
  completion: add more 'git add' options
