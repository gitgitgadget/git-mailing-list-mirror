From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.0.1
Date: Sun, 25 Nov 2012 20:54:31 -0800
Message-ID: <7vmwy5vu9k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Nov 26 05:54:56 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Tcqid-0001kC-Rs
	for glk-linux-kernel-3@plane.gmane.org; Mon, 26 Nov 2012 05:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191Ab2KZEyg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 25 Nov 2012 23:54:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53378 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753904Ab2KZEye convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Nov 2012 23:54:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C054AA4E3;
	Sun, 25 Nov 2012 23:54:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=kEpYvyJIxVl6/6J+6iPuDeIl5
	w8=; b=oDdgS7DmxcgmMnHsqOb2aPShrpm5zTHjzhqW9kUj+eR942+/Hp9ai6ADQ
	/ojnJozg4QSUokk+oNL33QamczRJlY+0m9z5oalEWK/102NXsyWlbpbYVHWXLjri
	w/7qdFtJecIFXGWqLQTqJsgPTRb4G11J1MUdU9zykqPXrN9iTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=KGz8PpQ/PJPo+6wgEEc
	b4s2mjvosLCDIsEsXCIGMX/TCrY759OlQ6PFUI+HPeQrtekcXPxJVFlMZbCwUrel
	xaDH9KHFNPcMDJdUXxG2gSs5F+jvqhS/TT4w74ZYo5D3wXBG/RrnIuSYjthpKkhV
	dpxHMXSV8g2bsSS6CgTYyr58=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADF52A4E2;
	Sun, 25 Nov 2012 23:54:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C0A8A4E1; Sun, 25 Nov 2012
 23:54:32 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E47D390-3785-11E2-8827-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210410>

The latest maintenance release Git v1.8.0.1 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

4e7492f7558f3ba2a450c43efa7de3b0b1adc6c1  git-1.8.0.1.tar.gz
6c0e64d53a8543447f595e3bac4966ba9257e783  git-htmldocs-1.8.0.1.tar.gz
cb26eea4ebe53b41cbc5c5f430499f7d76605414  git-manpages-1.8.0.1.tar.gz

Also the following public repositories all have a copy of the v1.8.0.1
tag and the maint branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v1.8.0.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.8.0
------------------

 * The configuration parser had an unnecessary hardcoded limit on
   variable names that was not checked consistently.

 * The "say" function in the test scaffolding incorrectly allowed
   "echo" to interpret "\a" as if it were a C-string asking for a
   BEL output.

 * "git mergetool" feeds /dev/null as a common ancestor when dealing
   with an add/add conflict, but p4merge backend cannot handle
   it. Work it around by passing a temporary empty file.

 * "git log -F -E --grep=3D'<ere>'" failed to use the given <ere>
   pattern as extended regular expression, and instead looked for the
   string literally.

 * "git grep -e pattern <tree>" asked the attribute system to read
   "<tree>:.gitattributes" file in the working tree, which was
   nonsense.

 * A symbolic ref refs/heads/SYM was not correctly removed with "git
   branch -d SYM"; the command removed the ref pointed by SYM
   instead.

 * Earlier we fixed documentation to hyphenate "remote-tracking branch"
   to clarify that these are not a remote entity, but unhyphenated
   spelling snuck in to a few places since then.

 * "git pull --rebase" run while the HEAD is detached tried to find
   the upstream branch of the detached HEAD (which by definition
   does not exist) and emitted unnecessary error messages.

 * The refs/replace hierarchy was not mentioned in the
   repository-layout docs.

 * Sometimes curl_multi_timeout() function suggested a wrong timeout
   value when there is no file descriptors to wait on and the http
   transport ended up sleeping for minutes in select(2) system call.
   A workaround has been added for this.

 * Various rfc2047 quoting issues around a non-ASCII name on the
   From: line in the output from format-patch have been corrected.

 * "git diff -G<pattern>" did not honor textconv filter when looking
   for changes.

 * Bash completion script (in contrib/) did not correctly complete a
   lazy "git checkout $name_of_remote_tracking_branch_that_is_unique"
   command line.

 * RSS feed from "gitweb" had a xss hole in its title output.

 * "git config --path $key" segfaulted on "[section] key" (a boolean
   "true" spelled without "=3D", not "[section] key =3D true").

 * "git checkout -b foo" while on an unborn branch did not say
   "Switched to a new branch 'foo'" like other cases.

Also contains other minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.8.0 are as follows:

Andreas Schwab (1):
      commit: fixup misplacement of --no-post-rewrite description

Ben Walton (1):
      Remove the hard coded length limit on variable names in config fi=
les

Carlos Mart=C3=ADn Nieto (1):
      config: don't segfault when given --path with a missing value

David Aguilar (1):
      mergetools/p4merge: Handle "/dev/null"

Jan H. Sch=C3=B6nherr (7):
      utf8: fix off-by-one wrapping of text
      format-patch: do not wrap non-rfc2047 headers too early
      format-patch: do not wrap rfc2047 encoded headers too late
      format-patch: introduce helper function last_line_length()
      format-patch: make rfc2047 encoding more strict
      format-patch: fix rfc2047 address encoding with respect to rfc822=
 specials
      format-patch tests: check quoting/encoding in To: and Cc: headers

Jeff King (3):
      diff_grep: use textconv buffers for add/deleted files
      gitweb: escape html in rss title
      checkout: print a message when switching unborn branches

Junio C Hamano (9):
      builtin/grep.c: make configuration callback more reusable
      grep: move the configuration parsing logic to grep.[ch]
      grep: move pattern-type bits support to top-level grep.[ch]
      revisions: initialize revs->grep_filter using grep_init()
      log --grep: use the same helper to set -E/-F options as "git grep=
"
      test-lib: Fix say_color () not to interpret \a\b\c in the message
      Start preparing for 1.8.0.1
      Further preparation for 1.8.0.1
      Git 1.8.0.1

Marc Khouzam (1):
      Completion must sort before using uniq

Matthieu Moy (2):
      Documentation: remote tracking branch -> remote-tracking branch
      Document 'git commit --no-edit' explicitly

Michael J Gruber (1):
      push/pull: adjust missing upstream help text to changed interface

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      grep: stop looking at random places for .gitattributes

Phil Hord (1):
      git-pull: Avoid merge-base on detached head

Philip Oakley (1):
      Doc repository-layout: Show refs/replace

Ren=C3=A9 Scharfe (6):
      refs: lock symref that is to be deleted, not its target
      branch: factor out check_branch_commit()
      branch: factor out delete_branch_config()
      branch: delete symref branch, not its target
      branch: skip commit checks when deleting symref branches
      branch: show targets of deleted symrefs, not sha1s

Romain Francoise (1):
      mailmap: avoid out-of-bounds memory access

Stefan Zager (1):
      Fix potential hang in https handshake
