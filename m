From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.2.1
Date: Sun, 07 Apr 2013 16:56:55 -0700
Message-ID: <7va9p93neg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Apr 08 08:49:07 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1UP5rh-0000sy-Dc
	for glk-linux-kernel-3@plane.gmane.org; Mon, 08 Apr 2013 08:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934686Ab3DGX5A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 7 Apr 2013 19:57:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36953 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934511Ab3DGX47 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Apr 2013 19:56:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F5E7148AE;
	Sun,  7 Apr 2013 23:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=4CeUp+2B1rMnhnA2CKhmjPIEe
	ag=; b=wpYOEIpK9ZdkiWEnLldZS/u5Jcay6XpS6OVTLEgJWRN18VC5w3VvfBpt5
	4UuYo7mBGqWOUYWyKwbJatjgYV/L1U4YfQjhiQ4ikP1G/PFnAxtWBARnpXh1G4av
	r/DE5kO3rsV5b88C3brbddof8V4GWs7TNbo6Qw6lwsj/O8IJOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=AfFHKlBn8/RIlPiRUQq
	ukm0SOJLP9EcqgkUDvuSaDuFJ049+FkQQpAZmNPfTCy96R+C5Z4pqMCmmaLgpuge
	pLK2hFG46QqJ3Y2c8Ee8M8eCuNMKn86bRUFV2dSCYBrZgbKREJ38Utnq5tP73mgS
	yTuPIxNMB8ajlB0X07qXJx5A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81F01148AB;
	Sun,  7 Apr 2013 23:56:58 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C4FD148A9; Sun,  7 Apr
 2013 23:56:57 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4B27316-9FDE-11E2-9881-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220394>

The latest maintenance release Git v1.8.2.1 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

ad9f833e509ba31c83efe336fd3599e89a39394b  git-1.8.2.1.tar.gz
bf4abd0e020d24ee47c64760e9fe4372c596d354  git-htmldocs-1.8.2.1.tar.gz
6c40ace4682188d0c01b1091b37276151bc77a74  git-manpages-1.8.2.1.tar.gz

Also the following public repositories all have a copy of the v1.8.2.1
tag and the maint branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v1.8.2.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.8.2
------------------

 * An earlier change to the attribute system introduced at v1.8.1.2 by
   mistake stopped a pattern "dir" (without trailing slash) from
   matching a directory "dir" (it only wanted to allow pattern "dir/"
   to also match).

 * Verification of signed tags were not done correctly when not in C
   or en/US locale.

 * 'git commit -m "$msg"' used to add an extra newline even when
   $msg already ended with one.

 * The "--match=3D<pattern>" option of "git describe", when used with
   "--all" to allow refs that are not annotated tags to be used as a
   base of description, did not restrict the output from the command
   to those that match the given pattern.

 * An aliased command spawned from a bare repository that does not say
   it is bare with "core.bare =3D yes" is treated as non-bare by mistak=
e.

 * When "format-patch" quoted a non-ascii strings on the header files,
   it incorrectly applied rfc2047 and chopped a single character in
   the middle of it.

 * "git archive" reports a failure when asked to create an archive out
   of an empty tree.  It would be more intuitive to give an empty
   archive back in such a case.

 * "git tag -f <tag>" always said "Updated tag '<tag>'" even when
   creating a new tag (i.e. not overwriting nor updating).

 * "git cmd -- ':(top'" was not diagnosed as an invalid syntax, and
   instead the parser kept reading beyond the end of the string.

 * Annotated tags outside refs/tags/ hierarchy were not advertised
   correctly to the ls-remote and fetch with recent version of Git.

 * The code to keep track of what directory names are known to Git on
   platforms with case insensitive filesystems can get confused upon a
   hash collision between these pathnames and looped forever.

 * The logic used by "git diff -M --stat" to shorten the names of
   files before and after a rename did not work correctly when the
   common prefix and suffix between the two filenames overlapped.

 * "git submodule update", when recursed into sub-submodules, did not
   acccumulate the prefix paths.

 * "git am $maildir/" applied messages in an unexpected order; sort
   filenames read from the maildir/ in a way that is more likely to
   sort messages in the order the writing MUA meant to, by sorting
   numeric segment in numeric order and non-numeric segment in
   alphabetical order.

 * When export-subst is used, "zip" output recorded incorrect
   size of the file.

 * Some platforms and users spell UTF-8 differently; retry with the
   most official "UTF-8" when the system does not understand the
   user-supplied encoding name that are the common alternative
   spellings of UTF-8.

 * "git branch" did not bother to check nonsense command line
   parameters and issue errors in many cases.

 * "git update-index -h" did not do the usual "-h(elp)" thing.

 * perl/Git.pm::cat_blob slurped everything in core only to write it
   out to a file descriptor, which was not a very smart thing to do.

 * The SSL peer verification done by "git imap-send" did not ask for
   Server Name Indication (RFC 4366), failing to connect SSL/TLS
   sites that serve multiple hostnames on a single IP.

 * "git index-pack" had a buffer-overflow while preparing an
   informational message when the translated version of it was too
   long.

 * Clarify in the documentation "what" gets pushed to "where" when the
   command line to "git push" does not say these explicitly.

 * In "git reflog expire", REACHABLE bit was not cleared from the
   correct objects.

 * The "--color=3D<when>" argument to the commands in the diff family
   was described poorly.

 * The arguments given to pre-rebase hook were not documented.

 * The v4 index format was not documented.

 * The "--match=3D<pattern>" argument "git describe" takes uses glob
   pattern but it wasn't obvious from the documentation.

 * Some sources failed to compile on systems that lack NI_MAXHOST in
   their system header (e.g. z/OS).

 * Add an example use of "--env-filter" in "filter-branch"
   documentation.

 * "git bundle verify" did not say "records a complete history" for a
   bundle that does not have any prerequisites.

 * In the v1.8.0 era, we changed symbols that do not have to be global
   to file scope static, but a few functions in graph.c were used by
   CGit from sideways bypassing the entry points of the API the
   in-tree users use.

 * "git merge-tree" had a typo in the logic to detect d/f conflicts,
   which caused it to segfault in some cases.

----------------------------------------------------------------

Changes since v1.8.2 are as follows:

Andrew Wong (2):
      setup.c: stop prefix_pathspec() from looping past the end of stri=
ng
      setup.c: check that the pathspec magic ends with ")"

Antoine Pelisse (3):
      update-index: allow "-h" to also display options
      diff: Fix rename pretty-print when suffix and prefix overlap
      tests: make sure rename pretty print works

Brandon Casey (4):
      t/t7502: compare entire commit message with what was expected
      t7502: demonstrate breakage with a commit message with trailing n=
ewlines
      git-commit: only append a newline to -m mesg if necessary
      Documentation/git-commit.txt: rework the --cleanup section

Christian Helmuth (1):
      git-commit doc: describe use of multiple `-m` options

Dan Bornstein (1):
      Correct the docs about GIT_SSH.

David Aguilar (20):
      git-sh-setup: use a lowercase "usage:" string
      git-svn: use a lowercase "usage:" string
      git-relink: use a lowercase "usage:" string
      git-merge-one-file: use a lowercase "usage:" string
      git-archimport: use a lowercase "usage:" string
      git-cvsexportcommit: use a lowercase "usage:" string
      git-cvsimport: use a lowercase "usage:" string
      git-cvsimport: use a lowercase "usage:" string
      contrib/credential: use a lowercase "usage:" string
      contrib/fast-import: use a lowercase "usage:" string
      contrib/fast-import/import-zips.py: fix broken error message
      contrib/fast-import/import-zips.py: use spaces instead of tabs
      contrib/examples: use a lowercase "usage:" string
      contrib/hooks/setgitperms.perl: use a lowercase "usage:" string
      templates/hooks--update.sample: use a lowercase "usage:" string
      Documentation/user-manual.txt: use a lowercase "usage:" string
      git-svn: use a lowercase "usage:" string
      tests: use a lowercase "usage:" string
      contrib/examples/git-remote.perl: use a lowercase "usage:" string
      contrib/mw-to-git/t/install-wiki.sh: use a lowercase "usage:" str=
ing

David Michael (1):
      git-compat-util.h: Provide missing netdb.h definitions

Greg Price (2):
      Fix ".git/refs" stragglers
      describe: Document --match pattern format

Jeff King (23):
      utf8: accept alternate spellings of UTF-8
      mailsplit: sort maildir filenames more cleverly
      cache.h: drop LOCAL_REPO_ENV_SIZE
      environment: add GIT_PREFIX to local_repo_env
      setup: suppress implicit "." work-tree for bare repos
      test-lib: factor out $GIT_UNZIP setup
      archive: handle commits with an empty tree
      upload-pack: drop lookup-before-parse optimization
      upload-pack: make sure "want" objects are parsed
      upload-pack: load non-tip "want" objects from disk
      avoid segfaults on parse_object failure
      use parse_object_or_die instead of die("bad object")
      pack-refs: write peeled entry for non-tags
      index-pack: always zero-initialize object_entry list
      fast-import: use pointer-to-pointer to keep list tail
      drop some obsolete "x =3D x" compiler warning hacks
      transport: drop "int cmp =3D cmp" hack
      run-command: always set failed_errno in start_command
      fast-import: clarify "inline" logic in file_change_m
      wt-status: fix possible use of uninitialized variable
      dir.c::match_pathname(): adjust patternlen when shifting pattern
      dir.c::match_pathname(): pay attention to the length of string pa=
rameters
      t: check that a pattern without trailing slash matches a director=
y

Johannes Sixt (1):
      t2003: work around path mangling issue on Windows

John Keeping (4):
      Revert "graph.c: mark private file-scope symbols as static"
      t2003: modernize style
      entry: fix filter lookup
      merge-tree: fix typo in merge-tree.c::unresolved

Joshua Clayton (1):
      Git.pm: fix cat_blob crashes on large files

Junio C Hamano (21):
      imap-send: support Server Name Indication (RFC4366)
      diff-options: unconfuse description of --color
      describe: --match=3D<pattern> must limit the refs even when used =
with --all
      reflog: fix typo in "reflog expire" clean-up codepath
      Documentation/git-push: clarify the description of defaults
      git status: document trade-offs in choosing parameters to the -u =
option
      CodingGuidelines: our documents are in AsciiDoc
      Documentation: merging a tag is a special case
      transport.c: help gcc 4.6.3 users by squelching compiler warning
      Start preparing for 1.8.2.1
      attr.c::path_matches(): the basename is part of the pathname
      More corrections for 1.8.2.1
      More fixes for 1.8.2.1
      attr.c::path_matches(): special case paths that end with a slash
      dir.c::match_basename(): pay attention to the length of string pa=
rameters
      Update draft release notes to 1.8.2.1
      Start preparing for 1.8.1.6
      Update draft release notes to 1.8.2.1
      mailmap: update Pasky's address
      Git 1.8.1.6
      Git 1.8.2.1

Kacper Kornet (3):
      rev-parse: clarify documentation of $name@{upstream} syntax
      t1507: Test that branchname@{upstream} is interpreted as branch
      Fix revision walk for commits with the same dates

Karsten Blees (1):
      name-hash.c: fix endless loop with core.ignorecase=3Dtrue

Kirill Smelkov (1):
      format-patch: RFC 2047 says multi-octet character may not be spli=
t

Lukas Fleischer (2):
      bundle: Fix "verify" output if history is complete
      bundle: Add colons to list headings in "verify"

Matthias Kr=C3=BCger (1):
      git help config: s/insn/instruction/

Matthieu Moy (1):
      git-remote-mediawiki: new wiki URL in documentation

Max Nanasy (1):
      diff.c: diff.renamelimit =3D> diff.renameLimit in message

Michael Haggerty (1):
      pack-refs: add fully-peeled trait

Michael J Gruber (5):
      gpg-interface: check good signature in a reliable way
      log-tree: rely upon the check in the gpg_interface
      gpg_interface: allow to request status return
      pretty: parse the gpg status lines rather than the output
      pretty: make %GK output the signing key for signed commits

Mihai Capot=C4=83 (1):
      git-pull doc: fix grammo ("conflicts" is plural)

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (7):
      index-format.txt: mention of v4 is missing in some places
      read-cache.c: use INDEX_FORMAT_{LB,UB} in verify_hdr()
      branch: segfault fixes and validation
      update-index: list supported idx versions and their features
      status: advise to consider use of -u when read_directory takes to=
o long
      index-pack: fix buffer overflow caused by translations
      index-pack: protect deepest_delta in multithread code

Phil Hord (1):
      tag: --force does not have to warn when creating tags

Ramkumar Ramachandra (1):
      t4018,7810,7811: remove test_config() redefinition

Ramsay Allan Jones (2):
      fast-import: Fix an gcc -Wuninitialized warning
      cat-file: Fix an gcc -Wuninitialized warning

Ren=C3=A9 Scharfe (4):
      archive-zip: fix compressed size for stored export-subst files
      Makefile: keep LIB_H entries together and sorted
      sha1_name: pass object name length to diagnose_invalid_sha1_path(=
)
      submodule summary: support --summary-limit=3D<n>

Tadeusz Andrzej Kad=C5=82ubowski (2):
      git-filter-branch.txt: clarify ident variables usage
      Documentation: filter-branch env-filter example

Thomas Rast (3):
      diff: prevent pprint_rename from underrunning input
      index-pack: guard nr_resolved_deltas reads by lock
      git-tag(1): we tag HEAD by default

Torsten B=C3=B6gershausen (1):
      remote-helpers/test-bzr.sh: do not use "grep '\s'"

W. Trevor King (2):
      Documentation/githooks: Explain pre-rebase parameters
      user-manual: Standardize backtick quoting

William Entriken (1):
      submodule update: when using recursion, show full path
