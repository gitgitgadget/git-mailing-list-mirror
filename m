From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.1.2
Date: Mon, 28 Jan 2013 12:41:26 -0800
Message-ID: <7v7gmxvy4p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 21:42:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzvWf-0004vR-G8
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 21:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446Ab3A1Ula convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2013 15:41:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35438 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753040Ab3A1Ul3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2013 15:41:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3D26C5FC;
	Mon, 28 Jan 2013 15:41:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=sgCKwy7J46qybZncm/1pY5pKw
	Lc=; b=iGz/OZrSBsj1dkx8GrxvKlL6tTIB6Uh4475gkwS71ehKRf9YJP4z12fN5
	8STVqZwwokG2Iaxg1FetPxR79A5JM5XIdL4vcduqH41SDtKeJhWMMd5A4Y/dnczy
	M+SpQ60DmuRVIu69aVnp0WYxyq/N+mOfvoVV0LPVlGkIr0sImI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=JBUpCIQ+GRakU56GCNM
	A8/ju9WUHynHLGORU3UsBJrfFUIBqxYnBQvFnPP+aB3ypGloF7JTxvC9m3BaNF3g
	cN5L/PFWMt9Z/YO8xiWCSMmcFOf/WorKY/ZQX5L2DvQ+izI/1uc/TGQpOP/0/kUR
	xY/h8c4dZ2VGppak2tHw0uus=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9026C5FB;
	Mon, 28 Jan 2013 15:41:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19363C5FA; Mon, 28 Jan 2013
 15:41:28 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16F5BD12-698B-11E2-A104-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214867>

The latest maintenance release Git v1.8.1.2 is now available at the
usual places.  This contains a handful of fixes that will also
appear in the next feature release.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

29a2dee568b1f86e9d3d8f9dcc376f24439b6a0c  git-1.8.1.2.tar.gz
3df491003d026b8f4b2de378e57b930a98f0a595  git-htmldocs-1.8.1.2.tar.gz
142222a27dfec52256831f2d0e2ee655f75c1077  git-manpages-1.8.1.2.tar.gz

Also the following public repositories all have a copy of the v1.8.1.2
tag and the maint branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git 1.8.1.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

=46ixes since v1.8.1.1
--------------------

 * An element on GIT_CEILING_DIRECTORIES list that does not name the
   real path to a directory (i.e. a symbolic link) could have caused
   the GIT_DIR discovery logic to escape the ceiling.

 * Command line completion for "tcsh" emitted an unwanted space
   after completing a single directory name.

 * Command line completion leaked an unnecessary error message while
   looking for possible matches with paths in <tree-ish>.

 * "git archive" did not record uncompressed size in the header when
   streaming a zip archive, which confused some implementations of unzi=
p.

 * When users spelled "cc:" in lowercase in the fake "header" in the
   trailer part, "git send-email" failed to pick up the addresses from
   there. As e-mail headers field names are case insensitive, this
   script should follow suit and treat "cc:" and "Cc:" the same way.

Also contains various documentation fixes.

----------------------------------------------------------------

Changes since v1.8.1.1 are as follows:

Antoine Pelisse (3):
      dir.c: Make git-status --ignored more consistent
      git-status: Test --ignored behavior
      status: always report ignored tracked directories

Dylan Smith (1):
      git-completion.bash: silence "not a valid object" errors

Eric S. Raymond (1):
      Remove the suggestion to use parsecvs, which is currently broken.

John Keeping (1):
      git-for-each-ref.txt: 'raw' is a supported date format

Jonathan Nieder (1):
      contrib/vim: simplify instructions for old vim support

Junio C Hamano (2):
      Start preparing for 1.8.1.2
      Git 1.8.1.2

Marc Khouzam (1):
      Prevent space after directories in tcsh completion

Michael Haggerty (8):
      Introduce new static function real_path_internal()
      real_path_internal(): add comment explaining use of cwd
      Introduce new function real_path_if_valid()
      longest_ancestor_length(): use string_list_split()
      longest_ancestor_length(): take a string_list argument for prefix=
es
      longest_ancestor_length(): require prefix list entries to be norm=
alized
      setup_git_directory_gently_1(): resolve symlinks in ceiling paths
      string_list_longest_prefix(): remove function

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      attr: make it build with DEBUG_ATTR again

Nickolai Zeldovich (1):
      git-send-email: treat field names as case-insensitively

Peter Eisentraut (1):
      git-commit-tree(1): correct description of defaults

Ren=C3=A9 Scharfe (5):
      archive-zip: write uncompressed size into header even with stream=
ing
      t0024, t5000: clear variable UNZIP, use GIT_UNZIP instead
      t0024, t5000: use test_lazy_prereq for UNZIP
      t5000, t5003: move ZIP tests into their own script
      t5003: check if unzip supports symlinks

Sebastian Staudt (1):
      config.txt: Document help.htmlpath config parameter
