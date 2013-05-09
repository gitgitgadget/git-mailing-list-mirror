From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.2.3
Date: Thu, 09 May 2013 14:53:00 -0700
Message-ID: <7v4neb95xf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu May 09 23:53:24 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1UaYm5-0005Sm-FM
	for glk-linux-kernel-3@plane.gmane.org; Thu, 09 May 2013 23:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014Ab3EIVxG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 9 May 2013 17:53:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752759Ab3EIVxD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 May 2013 17:53:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE3B61D915;
	Thu,  9 May 2013 21:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=jkhmAOkXJv/9noetCJ1yebGux
	jM=; b=BA3qvPMPecMfl7Jmxzv/qH2EDKXUHhIwKkTmNpkAaOaypqIuo7jQNW4ot
	STOfyofAkohUB3YhyDuhIyK51IgWJoUDpzUqznGX8mnqRM8jsf9uq0jyqhGFh56z
	kFK5c5w3zvbSLDdx+iIUWFSEGPMaZUKxb0gjjwEi87+KXQJapg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=fb/19I4vY5tGeeRCA5K
	OgSpdprsdlSmJhXnnTLDauknNeWhXroVYu4jjO1OgVRBIoT8SHdcizoOzJboN+oy
	QRe9A9qAleAmYf2oME7V4+MNIArSXOKHZKMzrN5ntBMMhEcCF3YysfdzZqlQdej0
	pSmfC3FkSwkRvvWPnQ6NHYAA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B06A81D914;
	Thu,  9 May 2013 21:53:02 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04FD41D913;
	Thu,  9 May 2013 21:53:01 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D20E9176-B8F2-11E2-B148-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223786>

The latest maintenance release Git v1.8.2.3 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

2831f7deec472db4d0d0cdffb4d82d91cecdf295  git-1.8.2.3.tar.gz
b8d6b3c4077d37b34bf08b6eb53c4ee5901fa2f9  git-htmldocs-1.8.2.3.tar.gz
eb04a2540ff9998e0887a4b862641ac1db723f3e  git-manpages-1.8.2.3.tar.gz

Also the following public repositories all have a copy of the v1.8.2.3
tag and the maint branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

The original tarball location

    http://www.kernel.org/pub/software/scm/git/

will also have the source tarball, but not the preformatted
documentation tarballs.


Git v1.8.2.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.8.2.2
--------------------

 * "rev-list --stdin" and friends kept bogus pointers into the input
   buffer around as human readable object names.  This was not a
   huge problem but was exposed by a new change that uses these
   names in error output.

 * When "git difftool" drove "kdiff3", it mistakenly passed --auto
   option that was meant while resolving merge conflicts.

 * "git remote add" command did not diagnose extra command line
   arguments as an error and silently ignored them.

Also contains a handful of trivial code clean-ups, documentation
updates, updates to the test suite, etc.

----------------------------------------------------------------

Changes since v1.8.2.2 are as follows:

Anders Granskogen Bj=C3=B8rnstad (1):
      Documentation/git-commit: Typo under --edit

David Aguilar (1):
      mergetools/kdiff3: do not use --auto when diffing

=46elipe Contreras (5):
      documentation: trivial whitespace cleanups
      complete: zsh: trivial simplification
      complete: zsh: use zsh completion for the main cmd
      completion: zsh: don't override suffix on _detault
      transport-helper: trivial style cleanup

John Keeping (1):
      t/Makefile: remove smoke test targets

Jonathan Nieder (1):
      glossary: a revision is just a commit

Junio C Hamano (1):
      Git 1.8.2.3

Ramkumar Ramachandra (3):
      git-completion.bash: lexical sorting for diff.statGraphWidth
      git-completion.bash: add diff.submodule to config list
      git-completion.bash: complete branch.*.rebase as boolean

Ren=C3=A9 Scharfe (2):
      t5004: ignore pax global header file
      t5004: avoid using tar for checking emptiness of archive

Thomas Rast (4):
      read_revisions_from_stdin: make copies for handle_revision_arg
      remote: add a test for extra arguments, according to docs
      remote: check for superfluous arguments in 'git remote add'
      remote: 'show' and 'prune' can take more than one remote
