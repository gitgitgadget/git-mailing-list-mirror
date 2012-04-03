From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.10.rc4
Date: Tue, 03 Apr 2012 10:12:57 -0700
Message-ID: <7v62dgd9ie.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Apr 03 19:13:15 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1SF7IA-0001MQ-40
	for glk-linux-kernel-3@plane.gmane.org; Tue, 03 Apr 2012 19:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185Ab2DCRNB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 3 Apr 2012 13:13:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45434 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753965Ab2DCRM7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Apr 2012 13:12:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D1027143;
	Tue,  3 Apr 2012 13:12:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=z8ILeqPNzaSv1sVQmnn3g6kFx
	lM=; b=Dq1TzRqAn/3NGAtwRkzfmJmKvTKv/liJonRe2e/dObuQf74NM32zV22td
	eF3RccvfQaAEbQAK4GA1eSjDdKpdhur5ZVbrY957QI6rrh9IPg/943KfF6kqnSB4
	0oPFhYhDHy/5y7E6LHPCQKg+b+b+kNXv3+/I49LurA9PZYYoro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=lf5fHT1qKwt6Jr2QKBt
	5O9PmWFgxDqwDAVaFfSDGYh0PabQmVZ4h1gejgmdrvR6eF+ysetueGjX10ebCqpu
	+OfgqojRwPH0vg61U9wcn2nfdoT07mlyxdRD7xpfjNZjM2c1zvHQlJt8YCvWexMK
	NpodAFixxsF/GoUC30S3vRK8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33D197140;
	Tue,  3 Apr 2012 13:12:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAFEE713E; Tue,  3 Apr 2012
 13:12:58 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42D9D8A4-7DB0-11E1-BEAE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194634>

A release candidate Git 1.7.10-rc4 is now available for testing at
the usual places.

Relative to v1.7.10-rc3, this contains updated l10n (pt_PT added) and
fixes to "font" dialog in gitk running under tcl 8.4.  Also it tones do=
wn
the commitment to switching the default behaviour for an unconfigured "=
git
push" to "upstream" in the future.  We know we will switching away from
"matching", but it seems "current" vs "upstream" hasn't been settled ye=
t.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

665ac967486424ace0007e52b83d8ead3dcfbbd7  git-1.7.10.rc4.tar.gz
b319fe588fc580abdf4c16a1cc6cb56966c43d83  git-htmldocs-1.7.10.rc4.tar.g=
z
6fbe7301f1ae1f701af150462b6df2537fca6cfd  git-manpages-1.7.10.rc4.tar.g=
z

Also the following public repositories all have a copy of the v1.7.10.r=
c4
tag and the master branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Changes since v1.7.10-rc3 are as follows:

Heiko Voigt (1):
      string-list: document that string_list_insert() inserts unique st=
rings

Jiang Xin (1):
      l10n: Improve zh_CN translation for Git 1.7.10-rc3

Junio C Hamano (3):
      merge: backport GIT_MERGE_AUTOEDIT support
      Git 1.7.9.6
      Git 1.7.10-rc4

Marco Sousa (1):
      l10n: Inital Portuguese Portugal language (pt_PT)

Pat Thoyts (2):
      gitk: fix tabbed preferences construction when using tcl 8.4
      gitk: fix setting font display with new tabbed dialog layout.

Ren=C3=A9 Scharfe (1):
      config: remove useless assignment

Vincent van Ravesteijn (1):
      l10n: Add the Dutch translation team and initialize nl.po
