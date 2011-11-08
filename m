From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.8.rc1
Date: Mon, 07 Nov 2011 18:56:28 -0800
Message-ID: <7vwrbbz5ib.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 03:56:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNbrs-00009T-5E
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 03:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312Ab1KHC4c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 21:56:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42986 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544Ab1KHC4b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 21:56:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A5C463B7;
	Mon,  7 Nov 2011 21:56:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=lpuJAEhz2zoFPrZN+/RizXIFk
	xw=; b=m+Hpg6zI/MK1Mm5e1TzcDMADAfpr7kA70jVlUZaeHtKesuKwVXQ9Oyy4b
	ZH+vTWLYw42QIZEmomawZz4XNS+1u4is30wOGvLucQPcS0l3zIOHbtMZVg/Ag6sX
	1OwiTI0TkSTpK+eFaYnEjdUpAXV/sduVxFZtbspq4f5uA1ZGvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=o9eef+9SxzwUMosmr58
	PxvLEiGYtmqU9BIEMdqVOut0gBpWV5t3jJe3XrpueZrPZEXTUTxBWrTlTGGoqE2q
	Xj0lSxxeRJSD224fxHR0v9xEZWEDgqbuLUxuFC61tRj17yyVyoj1qhziAI50cK4m
	hNJ6j2pt/Lo5UuM1E3FcftKc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91C7A63B5;
	Mon,  7 Nov 2011 21:56:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB9EC63B3; Mon,  7 Nov 2011
 21:56:29 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41EFB69E-09B5-11E1-B48B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185050>

A release candidate Git 1.7.8.rc1 is available for testing. Since rc0, =
we
killed all known regressions. Because there won't be any more new featu=
re
merged until the 1.7.8 final, it is a good time for the coolest kids on
the block to start using the upcoming release before others do.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

f35e5c4410b21710434cb591f4c89843e75bb793  git-1.7.8.rc1.tar.gz
72e27cd397f5ae7b3c9d8bb030a76d7c99cdbb50  git-htmldocs-1.7.8.rc1.tar.gz
95429858e879df3f9425cf1279e03cdec7832379  git-manpages-1.7.8.rc1.tar.gz

Also the following public repositories all have a copy of the v1.7.8.rc=
1
tag and the master branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Changes since v1.7.8-rc0 are as follows:

Dan McGee (4):
      pack-objects: mark add_to_write_order() as inline
      pack-objects: use unsigned int for counter and offset values
      pack-objects: rewrite add_descendants_to_write_order() iterativel=
y
      pack-objects: don't traverse objects unnecessarily

Erik Faye-Lund (4):
      mingw: move poll out of sys-folder
      compat/win32/poll.c: upgrade from upstream
      upload-archive: use start_command instead of fork
      mingw: poll.h is no longer in sys/

Johannes Sixt (1):
      name-hash.c: always initialize dir_next pointer

Junio C Hamano (5):
      (squash) test for previous
      Git 1.7.7.2
      Update draft release notes to 1.7.8
      receive-pack: do not expect object 0{40} to exist
      Git 1.7.8-rc1

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      pretty.c: free get_header() return value
      pretty.c: use original commit message if reencoding fails

Pat Thoyts (1):
      t7511: avoid use of reserved filename on Windows.

Pete Wyckoff (1):
      git-p4: ignore apple filetype

Sebastian Schuberth (2):
      blame.c: Properly initialize strbuf after calling, textconv_objec=
t()
      blame.c: Properly initialize strbuf after calling textconv_object=
(), again

Stefan Naewe (2):
      t3200: add test case for 'branch -m'
      http: don't always prompt for password

Tay Ray Chuan (1):
      branch -m: handle no arg properly

Ted Percival (1):
      svn: Quote repository root in regex match

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
      t/t6030-bisect-porcelain.sh: use test_i18ngrep
      t/t7508-status.sh: use test_i18ncmp
