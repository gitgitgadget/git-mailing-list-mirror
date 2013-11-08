From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.4.3
Date: Fri, 08 Nov 2013 13:35:16 -0800
Message-ID: <xmqq61s2o9uz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 08 22:36:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vetiq-0002FM-PM
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 22:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758158Ab3KHVfo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Nov 2013 16:35:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65115 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758140Ab3KHVfW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Nov 2013 16:35:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4666EDA01;
	Fri,  8 Nov 2013 16:35:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=taGeZAKN79LU39O6zKo2w1INu
	WA=; b=mEkxQruv7wBJ6T5Av/cHkAeP7krWBJCaoM2Ka/4t2zhOsSa6fXT3O/jnQ
	ZZMDJN94BtM7LK2QcVd7NbWcu2XPiY84CWaTAqosD+//hNk6y7R2+9M9DsioEace
	yh+9bUOdr9fEv9EPCd3c/Tmjr4I1myg/3AkRH9oVbuV/9S7bWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=TC6GVHdivknOzdZ/MFx
	j3gFY+xfEXU8TQ+LDqZceHuKAgu46cIy5at/WpdqDOgCDDJqY5PEUr5TZfjRoOE6
	OzdkcojYKUo/OoBctL1JC+qYFVHuRi54FfeTYr/3c4zQsmUyU1loBBFBkLoQL5kk
	/D0xv14UlXjoKsHc7e+Cx/Rw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37226DA00;
	Fri,  8 Nov 2013 16:35:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C881D9FF;
	Fri,  8 Nov 2013 16:35:18 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A9B5EDB8-48BD-11E3-AC7A-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237467>

The latest maintenance release Git v1.8.4.3 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

43b1edc95b3ab77f9739d789b906ded0585fe7a2  git-1.8.4.3.tar.gz
eb4eb4991464f44deda19d1435d9721146587661  git-htmldocs-1.8.4.3.tar.gz
3a7e9322a95e0743b902152083366fe97f322ab1  git-manpages-1.8.4.3.tar.gz

The following public repositories all have a copy of the v1.8.4.3
tag and the maint branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Also, http://www.kernel.org/pub/software/scm/git/ has copies of the
release tarballs.

Git v1.8.4.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v1.8.4.2
--------------------

 * The interaction between use of Perl in our test suite and NO_PERL
   has been clarified a bit.

 * A fast-import stream expresses a pathname with funny characters by
   quoting them in C style; remote-hg remote helper (in contrib/)
   forgot to unquote such a path.

 * One long-standing flaw in the pack transfer protocol used by "git
   clone" was that there was no way to tell the other end which branch
   "HEAD" points at, and the receiving end needed to guess.  A new
   capability has been defined in the pack protocol to convey this
   information so that cloning from a repository with more than one
   branches pointing at the same commit where the HEAD is at now
   reliably sets the initial branch in the resulting repository.

 * We did not handle cases where http transport gets redirected during
   the authorization request (e.g. from http:// to https://).

 * "git rev-list --objects ^v1.0^ v1.0" gave v1.0 tag itself in the
   output, but "git rev-list --objects v1.0^..v1.0" did not.

 * The fall-back parsing of commit objects with broken author or
   committer lines were less robust than ideal in picking up the
   timestamps.

 * Bash prompting code to deal with an SVN remote as an upstream
   were coded in a way not supported by older Bash versions (3.x).

 * "git checkout topic", when there is not yet a local "topic" branch
   but there is a unique remote-tracking branch for a remote "topic"
   branch, pretended as if "git checkout -t -b topic remote/$r/topic"
   (for that unique remote $r) was run. This hack however was not
   implemented for "git checkout topic --".

 * Coloring around octopus merges in "log --graph" output was screwy.

 * We did not generate HTML version of documentation to "git subtree"
   in contrib/.

 * The synopsis section of "git unpack-objects" documentation has been
   clarified a bit.

 * An ancient How-To on serving Git repositories on an HTTP server
   lacked a warning that it has been mostly superseded with more
   modern way.

Also contains a handful of trivial code clean-ups, documentation
updates, updates to the test suite, etc.

----------------------------------------------------------------

Changes since v1.8.4.2 are as follows:

Antoine Pelisse (1):
      remote-hg: unquote C-style paths when exporting

Brian Gernhardt (3):
      t5570: Update for symref capability
      t5570: Update for clone-progress-to-stderr branch
      t5570: Update for clone-progress-to-stderr branch

Hemmo Nieminen (1):
      graph: fix coloring around octopus merges

Jeff King (11):
      http_get_file: style fixes
      http_request: factor out curlinfo_strbuf
      http: refactor options to http_get_*
      http: hoist credential request out of handle_curl_result
      http: provide effective url to callers
      http: update base URLs when we see redirects
      remote-curl: make refs_url a strbuf
      remote-curl: store url as a strbuf
      remote-curl: rewrite base url from info/refs redirects
      split_ident: parse timestamp from end of line
      subtree: add makefile target for html docs

Jonathan Nieder (1):
      t/README: tests can use perl even with NO_PERL

Junio C Hamano (10):
      t5505: fix "set-head --auto with ambiguous HEAD" test
      upload-pack.c: do not pass confusing cb_data to mark_our_ref()
      upload-pack: send symbolic ref information as capability
      upload-pack: send non-HEAD symbolic refs
      connect.c: make parse_feature_value() static
      connect: annotate refs with their symref information in get_remot=
e_head()
      clone: test the new HEAD detection logic
      revision: do not peel tags used in range notation
      Start preparing for 1.8.4.3
      Git 1.8.4.3

Karsten Blees (1):
      gitignore.txt: fix documentation of "**" patterns

Matthieu Moy (2):
      checkout: allow dwim for branch creation for "git checkout $branc=
h --"
      checkout: proper error message on 'git checkout foo bar --'

Ramsay Allan Jones (1):
      http.c: Spell the null pointer as NULL

SZEDER G=C3=A1bor (1):
      bash prompt: don't use '+=3D' operator in show upstream code path

Sitaram Chamarty (1):
      doc/howto: warn about (dumb)http server document being too old

Vivien Didelot (2):
      Documentation: restore a space in unpack-objects usage
      Documentation: "pack-file" is not literal in unpack-objects
