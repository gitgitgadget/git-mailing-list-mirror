From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.9.2
Date: Wed, 22 Feb 2012 18:38:29 -0800
Message-ID: <7vbooq6zq2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 03:38:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0OZq-0003c9-4A
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 03:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab2BWCid convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 21:38:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35144 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207Ab2BWCic convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 21:38:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1516F7BE5;
	Wed, 22 Feb 2012 21:38:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=IAj1IMHGzxOu9TjPZK3HFV/du
	Vg=; b=x4GRCfrhHL3OWO0nyppC90+2sn2ocwWvAGa3ffqdGcjI62gAMJHzUdHsP
	yt2g7tORntXHrSsRIk5KXwVl2T1vF3TV5fy1xMth6vKldtzrRUp9Y2hlyB4eOnH6
	QZ+kwUMDvFR4jTY75MHoj/RYemYWePxMI7lnTVYy+HuFQiFfYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=kTngOKo3EDk59RSAZw5
	3IFg9NfuOB0LeZ0NJZb1fhbw66R7yhbVmo77Hr5V8jddDT2t+I8m3f8KrC7Q/JeI
	9nTVxbhO5ZNesLX7pMmMRnzj9ydKs4oWW4IhURBrCSWRFQcCg60J6fTiqx7ZXMWY
	MiQbOnCwCxBme/CvHhBPp4+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CA317BE4;
	Wed, 22 Feb 2012 21:38:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 549FC7BE3; Wed, 22 Feb 2012
 21:38:31 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7958E478-5DC7-11E1-84D3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191324>

The latest maintenance release Git 1.7.9.2 is now available at the
usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

7aff1048480a8637de94e8d82744d312c0b5e060  git-1.7.9.2.tar.gz
3cf13b03b2f64d0458212232cc18983231f8251e  git-htmldocs-1.7.9.2.tar.gz
d6992d899fb70e40983f94a2f96ad24b8ee93557  git-manpages-1.7.9.2.tar.gz

Also the following public repositories all have a copy of the v1.7.9.2
tag and the maint branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v1.7.9.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.9.1
--------------------

 * Bash completion script (in contrib/) did not like a pattern that
   begins with a dash to be passed to __git_ps1 helper function.

 * Adaptation of the bash completion script (in contrib/) for zsh
   incorrectly listed all subcommands when "git <TAB><TAB>" was given
   to ask for list of porcelain subcommands.

 * The build procedure for profile-directed optimized binary was not
   working very well.

 * Some systems need to explicitly link -lcharset to get locale_charset=
().

 * t5541 ignored user-supplied port number used for HTTP server testing=
=2E

 * The error message emitted when we see an empty loose object was
   not phrased correctly.

 * The code to ask for password did not fall back to the terminal
   input when GIT_ASKPASS is set but does not work (e.g. lack of X
   with GUI askpass helper).

 * We failed to give the true terminal width to any subcommand when
   they are invoked with the pager, i.e. "git -p cmd".

 * map_user() was not rewriting its output correctly, which resulted
   in the user visible symptom that "git blame -e" sometimes showed
   excess '>' at the end of email addresses.

 * "git checkout -b" did not allow switching out of an unborn branch.

 * When you have both .../foo and .../foo.git, "git clone .../foo" did =
not
   favor the former but the latter.

 * "git commit" refused to create a commit when entries added with
   "add -N" remained in the index, without telling Git what their conte=
nt
   in the next commit should be. We should have created the commit with=
out
   these paths.

 * "git diff --stat" said "files", "insertions", and "deletions" even
   when it is showing one "file", one "insertion" or one "deletion".

 * The output from "git diff --stat" for two paths that have the same
   amount of changes showed graph bars of different length due to the
   way we handled rounding errors.

 * "git grep" did not pay attention to -diff (hence -binary) attribute.

 * The transport programs (fetch, push, clone)ignored --no-progress
   and showed progress when sending their output to a terminal.

 * Sometimes error status detected by a check in an earlier phase of
   "git receive-pack" (the other end of "git push") was lost by later
   checks, resulting in false indication of success.

 * "git rev-list --verify" sometimes skipped verification depending on
   the phase of the moon, which dates back to 1.7.8.x series.

 * Search box in "gitweb" did not accept non-ASCII characters correctly=
=2E

 * Search interface of "gitweb" did not show multiple matches in the sa=
me file
   correctly.

Also contains minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.9.1 are as follows:

Christian Hammerl (1):
      completion: Allow dash as the first character for __git_ps1

Clemens Buchacher (4):
      git rev-list: fix invalid typecast
      push/fetch/clone --no-progress suppresses progress output
      t5541: check error message against the real port number used
      do not override receive-pack errors

=46elipe Contreras (3):
      completion: work around zsh option propagation bug
      completion: use ls -1 instead of rolling a loop to do that oursel=
ves
      completion: simplify __gitcomp and __gitcomp_nl implementations

Jakub Narebski (2):
      gitweb: Allow UTF-8 encoded CGI query parameters and path_info
      gitweb: Fix 'grep' search for multiple matches in file

Jeff King (12):
      grep: make locking flag global
      grep: move sha1-reading mutex into low-level code
      grep: refactor the concept of "grep source" into an object
      convert git-grep to use grep_source interface
      grep: drop grep_buffer's "name" parameter
      grep: cache userdiff_driver in grep_source
      grep: respect diff attributes for binary-ness
      grep: load file data after checking binary-ness
      grep: pre-load userdiff drivers when threaded
      standardize and improve lookup rules for external local repos
      prompt: clean up strbuf usage
      prompt: fall back to terminal if askpass fails

Jiang Xin (2):
      i18n: git-commit whence_s "merge/cherry-pick" message
      i18n: format_tracking_info "Your branch is behind" message

Johannes Sixt (1):
      Makefile: fix syntax for older make

Junio C Hamano (8):
      mailmap: always return a plain mail address from map_user()
      git checkout -b: allow switching out of an unborn branch
      commit: ignore intent-to-add entries instead of refusing
      diff --stat: show bars of same length for paths with same amount =
of changes
      Update draft release notes to 1.7.9.2
      Update draft release notes to 1.7.9.2
      Update draft release notes to 1.7.9.2
      Git 1.7.9.2

Matthieu Moy (1):
      fsck: give accurate error message on empty loose object files

Namhyung Kim (2):
      ctype.c only wants git-compat-util.h
      ctype: implement islower/isupper macro

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
      sha1_file.c: move the core logic of find_pack_entry() into fill_p=
ack_entry()
      find_pack_entry(): do not keep packed_git pointer locally
      Use correct grammar in diffstat summary line

Philip J=C3=A4genstedt (2):
      completion: remove stale "to submit patches" documentation
      completion: use tabs for indentation

Ralf Thielow (2):
      completion: --edit-description option for git-branch
      completion: --list option for git-branch

Theodore Ts'o (1):
      Fix build problems related to profile-directed optimization

Zbigniew J=C4=99drzejewski-Szmek (2):
      pager: find out the terminal width before spawning the pager
      man: rearrange git synopsis to fit in 80 lines

=D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=
=D0=B2 (1):
      Makefile: introduce CHARSET_LIB to link with -lcharset
