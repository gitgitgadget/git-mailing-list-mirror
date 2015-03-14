From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.3.3
Date: Sat, 14 Mar 2015 00:11:56 -0700
Message-ID: <xmqqzj7gvyrn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sat Mar 14 08:12:11 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YWgF0-00027Y-C2
	for glk-linux-kernel-3@plane.gmane.org; Sat, 14 Mar 2015 08:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959AbbCNHMD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sat, 14 Mar 2015 03:12:03 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750892AbbCNHL7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Mar 2015 03:11:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DDEA34EA4;
	Sat, 14 Mar 2015 03:11:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=Sc2cRdd80s0Y4kZQS0RDBncQE
	+M=; b=cRSZ6RTRPmgVra3bYhZcP9LoeqE05Ixe+4nXDk0TZVmVZP5irsR7z/2x7
	Yz1LvgHdP1hn7BzOtl9PBaLU5xqbzJVzoae2TKjtODBCbN9SY0e+wMX8jJVCOo30
	xImg+pzmtWjbapa8ONGn+XsAbEaGS4VcVY+dT1ObBGv21858Yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=h9QcZ1UfXLn4vI3irTg
	KH1e0bdr1qv34f7Sa4hwNgLb4wnmom6GsP3pVeeZRJqgqcNO7AtKpnpe3ogsi0lW
	xh8xb0SEwIy8bIiprIUZmFM8cJN6RenYDZTVUlRu+ZMKTbIut3t0h9Eb0p0JInvN
	059DTW1JRCYwLFzMoTI/sTeM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 061D634EA3;
	Sat, 14 Mar 2015 03:11:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6AE8134EA1;
	Sat, 14 Mar 2015 03:11:57 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 66BB6176-CA19-11E4-BD06-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265439>

The latest maintenance release Git v2.3.3 is now available at
the usual places.  It is comprised of 26 non-merge commits since
v2.3.2, contributed by 11 people, 1 of which is a new contributor.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.3.3'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.3.2 are as follows.
Welcome to the Git development community!

  Mikko Rapeli.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Anders Kaseorg, Ben Walton, Jeff King, Johannes Sixt, Junio
  C Hamano, M=C3=A5rten Kongstad, Michael J Gruber, Michal Sojka,
  Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy, and Ren=C3=A9 Scharfe.

----------------------------------------------------------------

Git v2.3.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.3.2
------------------

 * A corrupt input to "git diff -M" used cause us to segfault.

 * The borrowed code in kwset API did not follow our usual convention
   to use "unsigned char" to store values that range from 0-255.

 * Description given by "grep -h" for its --exclude-standard option
   was phrased poorly.

 * Documentaton for "git remote add" mentioned "--tags" and
   "--no-tags" and it was not clear that fetch from the remote in
   the future will use the default behaviour when neither is given
   to override it.

 * "git diff --shortstat --dirstat=3Dchanges" showed a dirstat based on
   lines that was never asked by the end user in addition to the
   dirstat that the user asked for.

 * The interaction between "git submodule update" and the
   submodule.*.update configuration was not clearly documented.

 * "git apply" was not very careful about reading from, removing,
   updating and creating paths outside the working tree (under
   --index/--cached) or the current directory (when used as a
   replacement for GNU patch).

 * "git daemon" looked up the hostname even when "%CH" and "%IP"
   interpolations are not requested, which was unnecessary.

 * The "interpolated-path" option of "git daemon" inserted any string
   client declared on the "host=3D" capability request without checking=
=2E
   Sanitize and limit %H and %CH to a saner and a valid DNS name.

Also contains typofixes, documentation updates and trivial code clean-u=
ps.

----------------------------------------------------------------

Changes since v2.3.2 are as follows:

Anders Kaseorg (1):
      t5516: correct misspelled pushInsteadOf

Ben Walton (1):
      kwset: use unsigned char to store values with high-bit set

Jeff King (5):
      git_connect: let user override virtual-host we send to daemon
      t5570: test git-daemon's --interpolated-path option
      daemon: sanitize incoming virtual hostname
      diffcore-rename: split locate_rename_dst into two functions
      diffcore-rename: avoid processing duplicate destinations

Johannes Sixt (1):
      test_ln_s_add: refresh stat info of fake symbolic links

Junio C Hamano (11):
      apply: reject input that touches outside the working area
      apply: do not read from the filesystem under --index
      apply: do not read from beyond a symbolic link
      apply: do not touch a file beyond a symbolic link
      t4008: correct stale comments
      t9300: correct expected object names
      t4010: correct expected object names
      tests: do not borrow from COPYING and README from the real source
      t/diff-lib: check exact object names in compare_diff_raw
      t4008: modernise style
      Git 2.3.3

Michael J Gruber (1):
      git-remote.txt: describe behavior without --tags and --no-tags

Michal Sojka (1):
      submodule: improve documentation of update subcommand

Mikko Rapeli (1):
      Documentation/git-clean.txt: document that -f may need to be give=
n twice

M=C3=A5rten Kongstad (1):
      diff --shortstat --dirstat: remove duplicate output

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      grep: correct help string for --exclude-standard

Ren=C3=A9 Scharfe (2):
      daemon: look up client-supplied hostname lazily
      daemon: use callback to build interpolated path
