From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.10-rc1
Date: Wed, 14 Mar 2012 16:17:10 -0700
Message-ID: <7v1uouojrd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Mar 15 00:17:24 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S7xRZ-0001cB-Ct
	for glk-linux-kernel-3@plane.gmane.org; Thu, 15 Mar 2012 00:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313Ab2CNXRP (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 14 Mar 2012 19:17:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33145 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756189Ab2CNXRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Mar 2012 19:17:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE66B6177;
	Wed, 14 Mar 2012 19:17:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=T5hb3xdYN+6P+BayZB673Ql0hb0=; b=McQtSzsFUMLLahP84wRtt8Hg3R3W
	KKDXfZa9YqmqbyEPwuOKbmPO9nVpPuv+MNYHoZGD1Qn+Nr7lLighr6n06ACqxYrJ
	yXtH9/NL5r4pXneh465zfXpU9Z6DjZFlHKziHalcphDHJ10SYF0kkekGn5BrUNRT
	PK1xoCmJXSxvl3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	p/pvmujSWF6nM0+28fjn5cygjylUoC0B3M+R+f8e9BvECQ+NjUS1BcJDksqhgfe9
	yXcRxqD1igxlX36vYehV1L+9PeVMOVoDTyGwJ+vLvm0xEltByQR7raZqQhRLHQfi
	PVFioNuIMwAK3Te9pOQSQrXwNYj2rDw87ZUWFsqfG9A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74FA66176;
	Wed, 14 Mar 2012 19:17:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E03D56175; Wed, 14 Mar 2012
 19:17:11 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D41F2D30-6E2B-11E1-B0C5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193168>

A release candidate Git 1.7.10-rc1 is now available for testing at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

6080456a4410c65d43e79f22b5ea1b1c200b6823  git-1.7.10.rc1.tar.gz
6f5106ee2bfb6d813a8b5a20d9caf069ea0110b4  git-htmldocs-1.7.10.rc1.tar.gz
617a1d178c9736365ef5451d45c6f0a469c071cc  git-manpages-1.7.10.rc1.tar.gz

Also the following public repositories all have a copy of the v1.7.10.rc1
tag and the master branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

----------------------------------------------------------------

Changes since v1.7.10-rc0 are as follows:

Alex Zepeda (1):
      verify-tag: Parse GPG configuration options.

Jakub Narebski (1):
      gitweb: Fix fixed string (non-regexp) project search

Jens Lehmann (3):
      submodules: always use a relative path to gitdir
      submodules: always use a relative path from gitdir to work tree
      submodules: refactor computation of relative gitdir path

Jiang Xin (3):
      l10n: Update zh_CN translation for 1.7.9.2
      l10n: Update git.pot (1 new message)
      l10n: Update zh_CN translation for 1.7.10-rc0

Johannes Sixt (1):
      submodules: fix ambiguous absolute paths under Windows

Junio C Hamano (7):
      Update draft release notes to 1.7.10
      t0204: clarify the "observe undefined behaviour" test
      i18n: fix auto detection of gettext scheme for shell scripts
      Git 1.7.9.4
      Update draft release notes to 1.7.10 before -rc1
      am: officially deprecate -b/--binary option
      Git 1.7.10-rc1

Karsten Blees (1):
      fix deletion of .git/objects sub-directories in git-prune/repack

Martin Stenberg (1):
      config: report errors at the EOL with correct line number

Peter Krefting (2):
      po/sv.po: add Swedish translation
      Update Swedish translation (732t0f0u).

Phil Hord (1):
      rerere: Document 'rerere remaining'

Thomas Rast (4):
      perf: load test-lib-functions from the correct directory
      perf: export some important test-lib variables
      p4000: use -3000 when promising -3000
      git-am: error out when seeing -b/--binary

Thynson (7):
      l10n: Improve zh_CN translation for lines insertion and deletion.
      l10n: Improve zh_CN translation for msg about branch deletion deny
      l10n: Improve zh_CN translation for empty cherry-pick msg.
      l10n: Improve zh_CN translation for msg that make empty commit when amend.
      l10n: Improve commit msg for zh_CN translation
      l10n: Improve zh_CN trans for msg that cannot fast-forward
      l10n: Improve zh_CN translation for msg "not something we can merge"

Vincent van Ravesteijn (3):
      Documentation/git-branch: cleanups
      Documentation/git-branch: fix a typo
      Documentation/git-branch: add default for --contains
