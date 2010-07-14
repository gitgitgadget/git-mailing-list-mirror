From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.2.rc3
Date: Wed, 14 Jul 2010 16:14:37 -0700
Message-ID: <7vmxttwt9e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Jul 15 01:15:03 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1OZBAH-0006Qo-MB
	for glk-linux-kernel-3@lo.gmane.org; Thu, 15 Jul 2010 01:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083Ab0GNXOt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 14 Jul 2010 19:14:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786Ab0GNXOs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2010 19:14:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A0B19C4539;
	Wed, 14 Jul 2010 19:14:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=KUEZzPKhdSXN0oBt7ZgEwEwgY
	yU=; b=p2y67yE8hdBlr/R7TkqY6ndp0KJBjcxxO/MIZIUpdHJwdeG3bZec6mLF/
	SCG+KikkNdjIiLOBa4lyyk7dpLWwDFqH0izKhFlGIOruEiuqMQ1+t9HtoQ65QhXA
	FshfE0/ZcVwc8B6xSTqmbkebmIsVwMA+KdHpTpOcGJchIH+mHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=YhpBpw6Q0I8tYRRtW3H
	n41ysizWNICXREXRn+/UvV66Lkfk3ccmPbW4Q5TJSzKvIKHYLO+sd6gZ2/h805H5
	minfYltnol2/RJoR0v2n1BHnrDp9B5L0IzWEdye9CmpF7u8DSYJwPlY2UB2MBjNF
	aMse1Ud/fY0j4elv8xTKgO5I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B22AC4530;
	Wed, 14 Jul 2010 19:14:42 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 938DFC452F; Wed, 14 Jul
 2010 19:14:38 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 956EE828-8F9D-11DF-A8F5-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151041>

A release candidate Git 1.7.2.rc3 is available at the usual places
for testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.2.rc3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.2.rc3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.2.rc3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.7.2.rc3-1.fc11.$arch.rpm	(RPM)

Hopefully this will be the last one before the final I'd like to have b=
y
the end of the week.

----------------------------------------------------------------

Changes since v1.7.2-rc2 are as follows:

Bo Yang (1):
      diff.c: fix a graph output bug

=46redrik Skolmli (1):
      Documentation: Spelling fix in protocol-capabilities.txt

Johannes Sixt (1):
      t0005: work around strange $? in ksh when program terminated by a=
 signal

Jonathan Nieder (1):
      t9118 (git-svn): prevent early failure from taking down later tes=
ts

Junio C Hamano (2):
      Fix "read-tree -m A B" priming the cache-tree
      Git 1.7.2-rc3

Michael J Gruber (3):
      t9118: avoid PEG revision identifier in tests
      test-lib: simplify GIT_SKIP_TESTS loop
      test-lib: TAP compliance for skipping tests on request

Miklos Vajna (1):
      format-patch: document the format.to configuration setting

Nicolas Sebrecht (1):
      checkout: accord documentation to what git does

Oren Held (1):
      git fetch documentation: describe short '-p' synonym to '--prune'=
 option

Raja R Harinath (1):
      Use dev_t for device id (st_dev) from stat in setup_git_directory=
_gently()

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
      tests: Use skip_all=3D* to skip tests
