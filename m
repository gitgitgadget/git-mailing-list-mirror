From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.7.11.6
Date: Tue, 11 Sep 2012 12:54:02 -0700
Message-ID: <7v8vcggwth.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Sep 11 21:54:23 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1TBWXO-0006ov-6P
	for glk-linux-kernel-3@plane.gmane.org; Tue, 11 Sep 2012 21:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759473Ab2IKTyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 11 Sep 2012 15:54:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63753 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758675Ab2IKTyF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Sep 2012 15:54:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F29C8E48;
	Tue, 11 Sep 2012 15:54:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=7bmYhIgmOJ39QIg5Hgj6Or968
	FU=; b=goxrbj9FpYD2M9X8XnGxVZjWNp3mS1/MObRNFqknz33DLebwrebLpsjWd
	OK+3d3o6SRVJDs5j5i1N6UL4KHmcKkOeNgiF/F5cX6QijNeBrtgjZW3hplBYalgw
	jsDEqbgJjn2EwLfcvf8iicMOhLuyGlKqlPdEIybCircef5GTls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Aa3/NDOVOGTOuZZv4eL
	kZqjggvNOinwwezVPyruH53dvgQ9GHx0j74xaZBiLNuY/9XjFhSrwfWNpk0whxTq
	BGg0h5RpjFfVSl0efEBeBlY7jMKuqigrttQ0Apeu4ZLwjADZrYIpfYpgNjRuwzNU
	WUSs62jfDL1nVtVAOgNOAEOw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDDA08E47;
	Tue, 11 Sep 2012 15:54:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDBEF8E45; Tue, 11 Sep 2012
 15:54:03 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7030B2C8-FC4A-11E1-A341-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205262>

A maintenance release Git v1.7.11.6 is now available at the
usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

f678531535643806733e8c7e87db77386c48738b  git-1.7.11.6.tar.gz
e6ccf6cffa3b69dc5d658f43bb8a10ed70b176f2  git-htmldocs-1.7.11.6.tar.gz
7bbb12429e65184d9462dfc01b104a4780bc67a8  git-manpages-1.7.11.6.tar.gz

Also the following public repositories all have a copy of the v1.7.11.6
tag and the maint-1.7.11 branch that the tag points at:

  ;; url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

[repo seems to be having a problem right now]

Git v1.7.11.6 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

=46ixes since v1.7.11.5
---------------------

 * "ciabot" script (in contrib/) has been updated with extensive
   documentation.

 * "git foo" errored out with "Not a directory" when the user had a
   non-directory on $PATH, and worse yet it masked an alias "foo" from
   running.

 * When the user exports a non-default IFS without HT, scripts that
   rely on being able to parse "ls-files -s | while read a b c..."
   started to fail.  Protect them from such a misconfiguration.

 * When the user gives an argument that can be taken as both a
   revision name and a pathname without disambiguating with "--", we
   used to give a help message "Use '--' to separate".  The message
   has been clarified to show where that '--' goes on the command
   line.

 * Documentation for the configuration file format had a confusing
   example.

 * Older parts of the documentation described as if having a regular
   file in .git/refs/ hierarchy were the only way to have branches and
   tags, which is not true for quite some time.

 * It was generally understood that "--long-option"s to many of our
   subcommands can be abbreviated to the unique prefix, but it was not
   easy to find it described for new readers of the documentation set.

 * The "--topo-order", "--date-order" (and the lack of either means
   the default order) options to "rev-list" and "log" family of
   commands were poorly described in the documentation.

 * "git commit --amend" let the user edit the log message and then
   died when the human-readable committer name was given
   insufficiently by getpwent(3).

 * The exit status code from "git config" was way overspecified while
   being incorrect.  The implementation has been updated to give the
   documented status for a case that was documented, and introduce a
   new code for "all other errors".

 * The output from "git diff -B" for a file that ends with an
   incomplete line did not put "\ No newline..." on a line of its own.

 * "git diff" had a confusion between taking data from a path in the
   working tree and taking data from an object that happens to have
   name 0{40} recorded in a tree.

 * The "--rebase" option to "git pull" can be abbreviated to "-r",
   but we didn't document it.

 * When "git push" triggered the automatic gc on the receiving end, a
   message from "git prune" that said it was removing cruft leaked to
   the standard output, breaking the communication protocol.

 * The reflog entries left by "git rebase" and "git rebase -i" were
   inconsistent (the interactive one gave an abbreviated object name).

 * "git send-email" did not unquote encoded words that appear on the
   header correctly, and lost "_" from strings.

 * "git stash apply/pop" did not trigger "rerere" upon conflicts
   unlike other mergy operations.

 * "git submodule <cmd> path" did not error out when the path to the
   submodule was misspelt.

 * "git submodule update -f" did not update paths in the working tree
   that has local changes.
   (merge 01d4721 sz/submodule-force-update later to maint).

 * "gitweb" when used with PATH_INFO failed to notice directories with
   SP (and other characters that need URL-style quoting) in them.

 * Fallback 'getpass' implementation made unportable use of stdio API.

 * A utility shell function test_seq has been added as a replacement
   for the 'seq' utility found on some platforms.

----------------------------------------------------------------

Changes since v1.7.11.5 are as follows:

Adam Butcher (1):
      Fix '\ No newline...' annotation in rewrite diffs

Ben Walton (1):
      Enable HAVE_DEV_TTY for Solaris

Brandon Casey (1):
      t/t5400: demonstrate breakage caused by informational message fro=
m prune

Eric S. Raymond (3):
      contrib/ciabot: Get ciabot configuration from git variables
      Improved documentation for the ciabot scripts.
      Make the ciabot scripts completely self-configuring in the normal=
 case.

Heiko Voigt (2):
      Let submodule command exit with error status if path does not exi=
st
      Documentation/CodingGuidelines: spell out more shell guidelines

Jay Soffian (1):
      gitweb: URL-decode $my_url/$my_uri when stripping PATH_INFO

Jeff King (6):
      commit: check committer identity more strictly
      diff: do not use null sha1 as a sentinel value
      do not write null sha1s to on-disk index
      fsck: detect null sha1 in tree entries
      terminal: seek when switching between reading and writing
      docs: monospace listings in docbook output

Junio C Hamano (13):
      config: "git config baa" should exit with status 1
      t7406: fix misleading "rev-parse --max-count=3D1 HEAD"
      sane_execvp(): ignore non-directory on $PATH
      Documentation: do not mention .git/refs/* directories
      receive-pack: do not leak output from auto-gc to standard output
      sh-setup: protect from exported IFS
      rev-list docs: clarify --topo-order description
      gitcli: describe abbreviation of long options
      git-config doc: unconfuse an example
      mergetool: style fixes
      Prepare for 1.7.11.6
      Almost 1.7.11.6
      Git 1.7.11.6

Luka Perkov (1):
      builtin.h: remove unused cmd_<foo> declarations

Martin von Zweigbergk (1):
      add tests for 'git rebase --keep-empty'

Matthieu Moy (1):
      setup: clarify error messages for file/revisions ambiguity

Michael Haggerty (1):
      git-config.txt: fix example

Michael J Gruber (1):
      rebase -i: use full onto sha1 in reflog

Micha=C5=82 Kiedrowicz (1):
      tests: Introduce test_seq

Miklos Vajna (1):
      man: git pull -r is a short for --rebase

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      read_index_from: remove bogus errno assignments

Paul Gortmaker (1):
      apply: delete unused deflate_origlen from patch struct

Phil Hord (2):
      test: git-stash conflict sets up rerere
      stash: invoke rerere in case of conflict

Stefan Zager (1):
      Make 'git submodule update --force' always check out submodules.

Thomas Rast (3):
      send-email: improve RFC2047 quote parsing
      diff_setup_done(): return void
      merge-recursive: eliminate flush_buffer() in favor of write_in_fu=
ll()
