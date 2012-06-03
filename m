From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.10.4
Date: Sun, 03 Jun 2012 16:48:29 -0700
Message-ID: <7vvcj8ueej.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Jun 04 02:09:22 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1SbKrE-0006s5-ML
	for glk-linux-kernel-3@plane.gmane.org; Mon, 04 Jun 2012 02:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335Ab2FDAJM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 3 Jun 2012 20:09:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58022 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755271Ab2FDAIy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jun 2012 20:08:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D346841A;
	Sun,  3 Jun 2012 20:08:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=PKcLShyfslcgg3MC9uafgB6BT
	8w=; b=ihglEEf3fS4dbkxxjWO1VU3tWXqF95t41cMU0CdbyXb9gTyrB4hff6kph
	5vKHCqdv5BnqRigcMKwbVyOp/MHvgZGg/FkHT/IkJO9NvRwrYsJAnqqH+G+8ctOG
	1lu5btDvVQvJP8LJFuBucojL+E/QIhtgIgy55WtoVTrvvEOMo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=jl8jViJJuuHFtol/YB+
	LWVu9gaz3xp4SdIgRQdTTlJZk+8VZFM++29Vbn6bkRB9gz27F6BCUeKRYemePCrI
	SlGOEQDdKMYmHsHJjHT6mJaMxYMSIc+axU6rQu9fdr/6rIDTIbKs5SDNw9roFGyW
	HYDSta7+4RbTA8Zxx2FAIEKU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54B7B8419;
	Sun,  3 Jun 2012 20:08:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C740F8418; Sun,  3 Jun 2012
 20:08:53 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7874D85C-ADD9-11E1-AC01-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199116>

The latest maintenance release Git v1.7.10.4 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

ddc305ab520246790faa72bbaab4b9bf5bcf23fa  git-1.7.10.4.tar.gz
951ecda5cbc3e7a5f30b419506ec24b54afa2b93  git-htmldocs-1.7.10.4.tar.gz
0769f6ff48d89df908cfe2af85fb4072b4178746  git-manpages-1.7.10.4.tar.gz

Also the following public repositories all have a copy of the v1.7.10.4
tag and the maint branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v1.7.10.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

=46ixes since v1.7.10.3
---------------------

 * The message file for Swedish translation has been updated a bit.

 * A name taken from mailmap was copied into an internal buffer
   incorrectly and could overun the buffer if it is too long.

 * A malformed commit object that has a header line chomped in the
   middle could kill git with a NULL pointer dereference.

 * An author/committer name that is a single character was mishandled
   as an invalid name by mistake.

 * The progress indicator for a large "git checkout" was sent to
   stderr even if it is not a terminal.

 * "git grep -e '$pattern'", unlike the case where the patterns are
   read from a file, did not treat individual lines in the given
   pattern argument as separate regular expressions as it should.

 * When "git rebase" was given a bad commit to replay the history on,
   its error message did not correctly give the command line argument
   it had trouble parsing.

Also contains minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.10.3 are as follows:

Avery Pennarun (1):
      checkout: no progress messages if !isatty(2).

Erik Faye-Lund (2):
      rebase: report invalid commit correctly
      Makefile: add missing GIT-VERSION-FILE dependency

Jeff King (3):
      fix off-by-one error in split_ident_line
      pretty: avoid buffer overflow in format_person_part
      avoid segfault when reading header of malformed commits

Junio C Hamano (2):
      Start preparing for 1.7.10.4
      Git 1.7.10.4

Peter Krefting (1):
      Update Swedish translation (728t0f0u)

Ren=C3=A9 Scharfe (4):
      grep: factor out create_grep_pat()
      grep: factor out do_append_grep_pat()
      grep: support newline separated pattern list
      grep: stop leaking line strings with -f
