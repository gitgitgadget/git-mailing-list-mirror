From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.5.2
Date: Tue, 17 Dec 2013 15:57:09 -0800
Message-ID: <xmqqd2kvkp4a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Wed Dec 18 00:57:26 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Vt4Vx-0002RY-Vd
	for glk-linux-kernel-3@plane.gmane.org; Wed, 18 Dec 2013 00:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab3LQX5T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 17 Dec 2013 18:57:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42930 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448Ab3LQX5R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Dec 2013 18:57:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63CED5CA1D;
	Tue, 17 Dec 2013 18:57:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=STpBVYsst8zNm5gESswG0//am
	vs=; b=DbmLLySKquOlWdOnh0GzhBMNqf5Y5+JODK6rT01yhP3OagDhn6FWN4cVt
	UEmT/v4Z9qYf6RHDIK5fqL/+iaIcCfJENYUik6my9OinfUCU6ZWCvTHrcl2HsznO
	t/g8fTS7BQaV79IEMApsjgZgAEdgRx9ElDrcP+tEzQUT1WVRpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=kEcBP7t/sqkw2K2515v
	QK9aWEChjDWtoc4AjfSll2AXWEO4rNdPKi1EaYHBqsMGdUVAFRI65mEQxuyRDiuK
	GpTs4hTzTcc7w5JybgySbm8ccYxtRrulxMoTHqe+0b47ylcrygIVI7lbix8SNyx+
	XDDEzMBxOR29XpzAIdHYIN3Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FEFB5CA1A;
	Tue, 17 Dec 2013 18:57:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45FCB5CA19;
	Tue, 17 Dec 2013 18:57:13 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F31034D2-6776-11E3-8ADD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239412>

The latest maintenance release Git v1.8.5.2 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

3a09d6d5d4e31c702f17e664a527b4c2f6e84faf  git-1.8.5.2.tar.gz
eaf2e3cfd07c1b88eff688fc3ba79dd4f3f2bc43  git-htmldocs-1.8.5.2.tar.gz
54450c09138b8d65c5f9d2b19ca86fd63c645bb5  git-manpages-1.8.5.2.tar.gz

The following public repositories all have a copy of the v1.8.5.2
tag and the maint branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Also, http://www.kernel.org/pub/software/scm/git/ has copies of the
release tarballs (they are recompressed over there and they have
checksums different from the above list).


Git v1.8.5.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.8.5.1
--------------------

 * "git diff -- ':(icase)makefile'" was unnecessarily rejected at the
   command line parser.

 * "git cat-file --batch-check=3Dok" did not check the existence of
   the named object.

 * "git am --abort" sometimes complained about not being able to write
   a tree with an 0{40} object in it.

 * Two processes creating loose objects at the same time could have
   failed unnecessarily when the name of their new objects started
   with the same byte value, due to a race condition.

Also contains typofixes, documentation updates and trivial code clean-u=
ps.

----------------------------------------------------------------

Changes since v1.8.5.1 are as follows:

Jason St. John (6):
      Documentation/git-log: update "--log-size" description
      Documentation/git-log.txt: mark-up fix and minor rephasing
      State correct usage of literal examples in man pages in the codin=
g standards
      Documentation/rev-list-options.txt: fix mark-up
      Documentation/rev-list-options.txt: fix some grammatical issues a=
nd typos
      Documentation/gitcli.txt: fix double quotes

Jeff King (1):
      unpack-trees: fix "read-tree -u --reset A B" with conflicted inde=
x

Johan Herland (1):
      sha1_file.c:create_tmpfile(): Fix race when creating loose object=
 dirs

Junio C Hamano (4):
      t1005: reindent
      t1005: add test for "read-tree --reset -u A B"
      sha1_loose_object_info(): do not return success on missing object
      Git 1.8.5.2

Masanari Iida (3):
      typofixes: fix misspelt comments
      Documentation/technical/http-protocol.txt: typofixes
      contrib: typofixes

Michael Haggerty (1):
      cmd_repack(): remove redundant local variable "nr_packs"

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      diff: restrict pathspec limitations to diff b/f case only
      glossary-content.txt: fix documentation of "**" patterns

Ren=C3=A9 Scharfe (1):
      SubmittingPatches: document how to handle multiple patches

Thomas Rast (1):
      Documentation: revamp git-cherry(1)

Torsten B=C3=B6gershausen (1):
      git-fetch-pack uses URLs like git-fetch
