From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.7.1
Date: Sun, 23 Oct 2011 23:18:29 -0700
Message-ID: <7vr52252ve.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Oct 24 08:18:43 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RIDru-0003Qw-0A
	for glk-linux-kernel-3@lo.gmane.org; Mon, 24 Oct 2011 08:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab1JXGSe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 24 Oct 2011 02:18:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61829 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558Ab1JXGSc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2011 02:18:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4E7D1FBA;
	Mon, 24 Oct 2011 02:18:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=8FnryRhRN1dTydHZfZBONoG72
	EY=; b=BPp6jwz9dtl5sbYjslAjbtOfMtX/LcvbsF7RciIlx8Tg5QB3piiS4/Gh8
	e6zgs8vqxDuYPhgTOiJRCMTn9y5sZtnCHwe117UNt9tszrVmyFXzTC+G4rlBmrGG
	AMLNxO5+SLytFCKVFLUNtwsaV0A/rwPiGw7OFlcA71Swc6Gfww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=GDTmewIr5RyflZevXB2
	QNLl1jh/PN02Emo//XhgTwlwWcRoaOPdM3cSaf/z8f+umLaGTZb2eegQBSR1ScOr
	wZzGkbRtTnIuWX9L/Sijib74pAhUagYEU5sUVWFBP8Mokz58PPB/mxw6z4id8ahe
	0kaH4aftYSl0mIuerqCy8X20=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD7A91FB9;
	Mon, 24 Oct 2011 02:18:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F0091FB8; Mon, 24 Oct 2011
 02:18:31 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FEC01232-FE07-11E0-A18C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184152>

The latest maintenance release Git 1.7.7.1 is available.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

9200e0b8ee543d297952b78aac8f61f8b3693f8e  git-1.7.7.1.tar.gz
b25dacb07ebbfc37e7a90c3d47f76b4c0f0487d9  git-htmldocs-1.7.7.1.tar.gz
419c750617ae0c952e2e43f0357c16de6ebc0a44  git-manpages-1.7.7.1.tar.gz

Also the following public repositories all have a copy of the v1.7.7.1
tag and the maint branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Changes since v1.7.7 are as follows:

Brad King (1):
      rev-list: Demonstrate breakage with --ancestry-path --all

Brandon Casey (1):
      strbuf.c: remove unnecessary strbuf_grow() from strbuf_getwholeli=
ne()

Ilari Liusvaara (1):
      Support ERR in remote archive like in fetch/push

Jay Soffian (1):
      merge-one-file: fix "expr: non-numeric argument"

Jeff King (2):
      fetch: avoid quadratic loop checking for updated submodules
      filter-branch: use require_clean_work_tree

Jim Meyering (1):
      fix "git apply --index ..." not to deref NULL

Jonathan Nieder (2):
      Makefile: do not set setgid bit on directories on GNU/kFreeBSD
      RelNotes/1.7.7.1: setgid bit patch is about fixing "git init" via=
 Makefile setting

Junio C Hamano (14):
      revision: keep track of the end-user input from the command line
      revision: do not include sibling history in --ancestry-path outpu=
t
      rebase -i: notice and warn if "exec $cmd" modifies the index or t=
he working tree
      traverse_trees(): allow pruning with pathspec
      unpack-trees: allow pruning with pathspec
      diff-index: pass pathspec down to unpack-trees machinery
      fsck: do not abort upon finding an empty blob
      Teach progress eye-candy to fetch_refs_from_bundle()
      apply --whitespace=3Derror: correctly report new blank lines at e=
nd
      checkout $tree $path: do not clobber local changes in $path not i=
n $tree
      diff: resurrect XDF_NEED_MINIMAL with --minimal
      Prepare for 1.7.7.1
      Almost ready for 1.7.7.1
      Git 1.7.7.1

Matthieu Moy (2):
      rebase -i: clean error message for --continue after failed exec
      config: display key_delim for config --bool --get-regexp

Michael Schubert (1):
      patch-id.c: use strbuf instead of a fixed buffer

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
      merge: keep stash[] a local variable
      merge: use return value of resolve_ref() to determine if HEAD is =
invalid
      merge: remove global variable head[]
      Accept tags in HEAD or MERGE_HEAD

Nicolas Morey-Chaisemartin (1):
      grep: Fix race condition in delta_base_cache

Ren=C3=A9 Scharfe (2):
      Revert removal of multi-match discard heuristic in 27af01
      t1304: fall back to $USER if $LOGNAME is not defined

Thomas Rast (2):
      Symlink mergetools scriptlets into valgrind wrappers
      t6019: avoid refname collision on case-insensitive systems
