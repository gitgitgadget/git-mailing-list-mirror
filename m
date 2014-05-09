From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.9.3
Date: Fri, 09 May 2014 13:00:08 -0700
Message-ID: <xmqq38giyb7b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Fri May 09 22:00:31 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Wiqy2-0006w9-85
	for glk-linux-kernel-3@plane.gmane.org; Fri, 09 May 2014 22:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757519AbaEIUAO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 9 May 2014 16:00:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52304 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063AbaEIUAM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2014 16:00:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 55D2C15D62;
	Fri,  9 May 2014 16:00:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=i7MACobG4zcDbBu+j6XMHWCyI
	qM=; b=lRgxL6jzQH1l9r/Wj+cDOCdhfZykhibchF6/5LTbyCA/L0RRDeMtBHMYV
	x/WoagKO1+Gn2Wk0ZnzdZfM3u68BycqWHf0fJxfskbckR1wlWop8+xhCqNmfRVg1
	3MK7icxidI1/0Sx/HupLoLGb0e644qu+OnhOo7wxCLNa8IZXfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Rhl3LbQb8UVIcKW5iap
	xHy5fz+Rkp3wCZXWFGteE9uaAiFinK3XQ6ev3R6fyzltBYcdsIiXHSKPFcX4HBYa
	0gzAdtlDFvXvkeI6Ljfr5y8qH6ES7pUlyq1hNvj6ywoZGdrEwetG5VhwEJQBo0F4
	7GkBzi6uS8hPZUnz28i6vwpE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D29815D61;
	Fri,  9 May 2014 16:00:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D7E3915D60;
	Fri,  9 May 2014 16:00:09 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 86536F54-D7B4-11E3-A6FB-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248636>

The latest maintenance release Git v1.9.3 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories will all have a copy of the
'v1.9.3' tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

but I am cutting 2.0.0-rc3 today, so you may have to wait for a bit
until these repositories are updated.


Git v1.9.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v1.9.2
------------------

 * "git p4" dealing with changes in binary files were broken by a
   change in 1.9 release.

 * The shell prompt script (in contrib/), when using the PROMPT_COMMAND
   interface, used an unsafe construct when showing the branch name in
   $PS1.

 * "git rebase" used a POSIX shell construct FreeBSD /bin/sh does not
   work well with.

 * Some more Unicode codepoints defined in Unicode 6.3 as having
   zero width have been taught to our display column counting logic.

 * Some tests used shell constructs that did not work well on
   FreeBSD.

----------------------------------------------------------------

Changes since v1.9.2 are as follows:

Jonathan Nieder (1):
      shell doc: remove stray "+" in example

Junio C Hamano (2):
      Start preparing for 1.9.3
      Git 1.9.3

Kyle J. McKay (4):
      test: fix t7001 cp to use POSIX options
      test: fix t5560 on FreeBSD
      rebase: avoid non-function use of "return" on FreeBSD
      Revert "rebase: fix run_specific_rebase's use of "return" on Free=
BSD"

Richard Hansen (1):
      git-prompt.sh: don't put unsanitized branch names in $PS1

Tolga Ceylan (1):
      git-p4: format-patch to diff-tree change breaks binary patches

Torsten B=C3=B6gershausen (1):
      utf8.c: partially update to version 6.3
