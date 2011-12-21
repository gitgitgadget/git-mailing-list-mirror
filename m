From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.8.1
Date: Wed, 21 Dec 2011 14:34:32 -0800
Message-ID: <7v1urxftaf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 23:34:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdUkD-0000xC-GJ
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 23:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147Ab1LUWeg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Dec 2011 17:34:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752587Ab1LUWef convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Dec 2011 17:34:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 553995C72;
	Wed, 21 Dec 2011 17:34:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=9eBSt2sMZge2NwOn4dOga1xem
	mU=; b=VpJ3nPea8jIeI9Bp5ZTUtKzuNngFZOSqyfaJS1rzrrKDYJ7LLR9z+ey8Z
	ESjKfyQDOFNRLIT+qjSKD9TMf2OPyTy4sNnskPcrO2EGOxXMJyOxr1o7mFyRBmwU
	Hw7f4oTf4ljlVwoVkz7DcVsa5be85DWUsj+mVu/oNuk5QP51Ac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=gl/+ekPjE8J4gZ2J7nw
	zSijwAnsippv3haAGOkRtNd3h7NLYRRgfm4oT16giiVrSn8bEhdiaZPAms8zMkto
	KaW+I0dsMzfrqCVo9lD4xSp4DYwf+dDq5C9qI2heVG9NNKkBUXS3V3xjIOz5mofa
	zFehjYyv3mTroDV1Yo49TazI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D6D65C71;
	Wed, 21 Dec 2011 17:34:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2D395C6F; Wed, 21 Dec 2011
 17:34:33 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4960808-2C23-11E1-98EA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187589>

The latest maintenance release Git 1.7.8.1 is available.  Note that thi=
s
is not a release with new features (upcoming 1.7.9 is expected to be
released late January next year to include the pulling of signed tags a=
nd
other goodies).

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

198e23e6e50245331590a6159ccdbdbe1792422c  git-1.7.8.1.tar.gz
8f674dba39d9ae78928abfe9d924b0855e283e98  git-htmldocs-1.7.8.1.tar.gz
b49ce0b4da4f85671693c9b2c6f6a8b8ee65c809  git-manpages-1.7.8.1.tar.gz

Also the following public repositories all have a copy of the v1.7.8.1
tag and the maint branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git


Git v1.7.8.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.8
------------------

 * In some codepaths (notably, checkout and merge), the ignore patterns
   recorded in $GIT_DIR/info/exclude were not honored. They now are.

 * "git apply --check" did not error out when given an empty input
   without any patch.

 * "git archive" mistakenly allowed remote clients to ask for commits
   that are not at the tip of any ref.

 * "git checkout" and "git merge" treated in-tree .gitignore and exclud=
e
   file in $GIT_DIR/info/ directory inconsistently when deciding which
   untracked files are ignored and expendable.

 * LF-to-CRLF streaming filter used when checking out a large-ish blob
   fell into an infinite loop with a rare input.

 * The function header pattern for files with "diff=3Dcpp" attribute di=
d
   not consider "type *funcname(type param1,..." as the beginning of a
   function.

 * The error message from "git diff" and "git status" when they fail
   to inspect changes in submodules did not report which submodule they
   had trouble with.

 * After fetching from a remote that has very long refname, the reporti=
ng
   output could have corrupted by overrunning a static buffer.

 * "git pack-objects" avoids creating cyclic dependencies among deltas
   when seeing a broken packfile that records the same object in both
   the deflated form and as a delta.

Also contains minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.8 are as follows:

Brandon Casey (2):
      t/t4131-apply-fake-ancestor.sh: fix broken test
      builtin/apply.c: report error on failure to recognize input

Carlos Mart=C3=ADn Nieto (2):
      convert: track state in LF-to-CRLF filter
      clone: the -o option has nothing to do with <branch>

Erik Faye-Lund (1):
      mingw: give waitpid the correct signature

Jack Nagel (1):
      Documentation: fix formatting error in merge-options.txt

Jeff King (5):
      http: drop "local" member from request struct
      archive: don't let remote clients get unreachable commits
      stripspace: fix outdated comment
      fetch: create status table using strbuf
      blame: don't overflow time buffer

Jens Lehmann (1):
      diff/status: print submodule path when looking for changes fails

Junio C Hamano (9):
      get_tree_entry(): do not call find_tree_entry() on an empty tree
      unpack_object_header_buffer(): clear the size field upon error
      receive-pack, fetch-pack: reject bogus pack that records objects =
twice
      pack-object: tolerate broken packs that have duplicated objects
      Git 1.7.6.5
      Git 1.7.7.5
      Update draft release notes for 1.7.8.1
      lf_to_crlf_filter(): tell the caller we added "\n" when draining
      Git 1.7.8.1

Martin von Zweigbergk (1):
      am: don't persist keepcr flag

Michael Haggerty (1):
      git symbolic-ref: documentation fix

Michael Schubert (2):
      builtin/commit: add missing '/' in help message
      builtin/log: remove redundant initialization

Mika Fischer (3):
      http.c: Use curl_multi_fdset to select on curl fds instead of jus=
t sleeping
      http.c: Use timeout suggested by curl instead of fixed 50ms timeo=
ut
      http.c: Rely on select instead of tracking whether data was recei=
ved

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
      tree-walk.c: do not leak internal structure in tree_entry_len()
      read_directory_recursive: reduce one indentation level
      tree_entry_interesting(): give meaningful names to return values
      tree_entry_interesting: make use of local pointer "item"
      checkout,merge: loosen overwriting untracked file check based on =
info/exclude

Sebastian Morr (1):
      Add MYMETA.yml to perl/.gitignore

Thomas Rast (1):
      userdiff: allow * between cpp funcname words

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
      apply: get rid of useless x < 0 comparison on a size_t type
      cast variable in call to free() in builtin/diff.c and submodule.c
      builtin/init-db.c: eliminate -Wformat warning on Solaris
