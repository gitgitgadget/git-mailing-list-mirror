From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Fri, 30 Nov 2007 18:05:38 -0800
Message-ID: <7v63zjgoel.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
	<7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 03:06:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyHk4-0005sV-IF
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 03:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549AbXLACFo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Nov 2007 21:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756751AbXLACFn
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 21:05:43 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:53546 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756424AbXLACFn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Nov 2007 21:05:43 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id AFC8D2F0;
	Fri, 30 Nov 2007 21:06:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1FAD99B9C2;
	Fri, 30 Nov 2007 21:06:02 -0500 (EST)
X-maint-at: 10455d2a955a29db1809be139177e4e298771eb0
X-master-at: 65c6a4696a760f518c9f262705de030323c11146
In-Reply-To: <7vk5o6jbq9.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 25 Nov 2007 12:45:18 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66674>

* The 'maint' branch has these fixes since the last announcement.

J. Bruce Fields (4):
  user-manual: define "branch" and "working tree" at start
  user-manual: failed push to public repository
  user-manual: clarify language about "modifying" old commits
  user-manual: recovering from corruption

Jan Hudec (1):
  Improve description of git-branch -d and -D in man page.

Jeff King (4):
  Add basic cvsimport tests
  cvsimport: use rev-parse to support packed refs
  cvsimport: miscellaneous packed-ref fixes
  cvsimport: fix usage of cvsimport.module

Johannes Schindelin (1):
  Replace the word 'update-cache' by 'update-index' everywhere

Johannes Sixt (1):
  t7003-filter-branch: Fix test of a failing --msg-filter.

Junio C Hamano (1):
  scripts: do not get confused with HEAD in work tree


* The 'master' branch has these since the last announcement
  in addition to the above.

Andr=C3=A9 Goddard Rosa (2):
  Print the real filename that we failed to open.
  Error out when user doesn't have access permission to the repository

Jakub Narebski (1):
  Add config_int() method to the Git perl module

Jeff King (1):
  Revert "t5516: test update of local refs on push"

Johannes Schindelin (4):
  filter-branch: fix dirty way to provide the helpers to commit filters
  git checkout's reflog: even when detaching the HEAD, say from where
  bash completion: add diff options
  receive-pack: allow deletion of corrupt refs

Junio C Hamano (3):
  revert/cherry-pick: do not mention the original ref
  dir.c: minor clean-up
  per-directory-exclude: lazily read .gitignore files

Linus Torvalds (2):
  Fix a pathological case in git detecting proper renames
  Fix a pathological case in git detecting proper renames

Pascal Obry (1):
  git-stash: do not get fooled with "color.diff =3D true"

Steffen Prohaska (2):
  Use is_absolute_path() in diff-lib.c, lockfile.c, setup.c, trace.c
  sha1_file.c: Fix size_t related printf format warnings

Wincent Colaiuta (1):
  Fix typo in draft 1.5.4 release notes
