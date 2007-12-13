From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable frozen)
Date: Wed, 12 Dec 2007 18:47:13 -0800
Message-ID: <7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
	<7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 03:47:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2e74-0001E8-Nb
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 03:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbXLMCr2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 21:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbXLMCr2
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 21:47:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54209 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbXLMCr1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 21:47:27 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D0C1A6731;
	Wed, 12 Dec 2007 21:47:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D8B766730;
	Wed, 12 Dec 2007 21:47:20 -0500 (EST)
X-maint-at: 6281f394674bf2db861967da6c2215cfc3fc78af
X-master-at: 1e8df762b38e01685f3aa3613e2d61f73346fcbe
In-Reply-To: <7vve78qhtf.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 09 Dec 2007 02:32:44 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68112>

The tip of 'master' is now tagged as 1.5.4-rc0.  Tarballs are found in
the usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.4.rc0.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.4.rc0.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.4.rc0.tar.{gz,bz2}		(preformatted docs)

I've also built a set of preview RPM packages.  They are found in:

  http://www.kernel.org/pub/software/scm/git/testing/

I am not an RPM person.  It would be really appreciated if experts help
out finding and fixing any bug in the packaging.  I do not want to
repeat the firefighting we needed with 1.5.3.1.

----------------------------------------------------------------
* The 'master' branch has these since the last announcement.

Alex Riesen (1):
  Fix git-fast-export for zero-sized blobs

Alexandre Julliard (1):
  git.el: Added a menu for git-status-mode.

Charles Bailey (1):
  Fix clone not to ignore depth when performing a local clone

Christian Couder (5):
  git-help: add -i|--info option to display info page.
  Documentation: describe -i/--info option to "git-help"
  git-help: add -w|--web option to display html man page in a browser.
  Use {web,instaweb,help}.browser config options.
  Documentation: describe -w/--web option to "git-help".

Daniel Barkalow (1):
  Add more checkout tests

Eric Wong (2):
  git-svn: replace .rev_db with a more space-efficient .rev_map format
  git-svn: reinstate old rev_db optimization in new rev_map

Eyvind Bernhardsen (1):
  Fix mis-markup of the -p, --patch option in git-add(1)

Gerrit Pape (1):
  Don't cache DESTDIR in perl/perl.mak.

Jakub Narebski (1):
  autoconf: Check asciidoc version to automatically set ASCIIDOC8

Jeff King (6):
  don't mention index refreshing side effect in git-status docs
  Add git-browse-help to .gitignore
  Support GIT_PAGER_IN_USE environment variable
  git-svn: get color config from --get-colorbool
  shortlog: document -e option
  git-clone: print an error message when trying to clone empty repo

Johannes Sixt (1):
  Fix a typo in checkout.sh and cleanup one-line help messages

Junio C Hamano (18):
  git-shortlog -e: show e-mail address as well
  Re-fix ls-remote
  Update draft Release Notes for 1.5.4
  Documentation: add gitman.info target
  git-help -i: invoke info with document and node name
  git-help -i: show info documentation from matching version of git
  send-email: do not muck with initial-reply-to when unset.
  commit: do not add extra LF at the end of the summary.
  Support a merge with conflicting gitlink change
  blame: drop blob data after passing blame to the parent
  shortlog: default to HEAD when the standard input is a tty
  git-diff --numstat -z: make it machine readable
  disable t9119 for now.
  Documentation: rename git.texi to user-manual.texi
  git.spec.in: remove python_path
  git-help -w: do not require to be in git repository
  RPM spec: Adjust htmldir
  GIT 1.5.4-rc0

Linus Torvalds (1):
  "git tag -u keyname" broken

Mike Hommey (4):
  git-send-email.perl: Really add angle brackets to In-Reply-To if
    necessary
  Cleanup variables in http.[ch]
  Fix small memory leaks induced by diff_tree_setup_paths
  Fix XML parser leaks in http-push

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  Remove repo version check from setup_git_directory

Nicolas Pitre (1):
  pack-objects: more threaded load balancing fix with often changed pat=
hs

Pierre Habouzit (1):
  Invert numbers and names in the git-shortlog summary mode.

Wincent Colaiuta (5):
  Interactive editor tests for commit-msg hook
  Style fixes for pre-commit hook tests
  Use "whitespace" consistently
  Documentation: minor grammar fix for "git apply"
  Fix "diff --check" whitespace detection
